Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5536BA97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbhDZUL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:11:59 -0400
Received: from mailproxy01.manitu.net ([217.11.48.65]:51468 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhDZUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:11:57 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Apr 2021 16:11:57 EDT
Received: from [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be] (p200300f7f70f8e007457087a58db74be.dip0.t-ipconnect.de [IPv6:2003:f7:f70f:8e00:7457:87a:58db:74be])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: alexander@sosna.de)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id C8655126002E;
        Mon, 26 Apr 2021 22:04:56 +0200 (CEST)
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Alexander Sosna <alexander@sosna.de>
Subject: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
Date:   Mon, 26 Apr 2021 22:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this commit memory cgroup limits were not enforced during
allocation.  If a process within a cgroup tries to allocates more
memory than allowed, the kernel will not prevent the allocation even if
OVERCOMMIT_NEVER is set.  Than the OOM killer is activated to kill
processes in the corresponding cgroup.  This behavior is not to be expected
when setting OVERCOMMIT_NEVER (vm.overcommit_memory = 2) and it is a huge
problem for applications assuming that the kernel will deny an allocation
if not enough memory is available, like PostgreSQL.  To prevent this a
check is implemented to not allow a process to allocate more memory than
limited by it's cgroup.  This means a process will not be killed while
accessing pages but will receive errors on memory allocation as
appropriate.  This gives programs a chance to handle memory allocation
failures gracefully instead of being reaped.

Signed-off-by: Alexander Sosna <alexander@sosna.de>

diff --git a/mm/util.c b/mm/util.c
index a8bf17f18a81..c84b83c532c6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -853,6 +853,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  *
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
+ * Code to enforce memory cgroup limits added 2021 by Alexander Sosna.
  *
  * cap_sys_admin is 1 if the process has admin privileges, 0 otherwise.
  *
@@ -891,6 +892,34 @@ int __vm_enough_memory(struct mm_struct *mm, long
pages, int cap_sys_admin)
 		long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);

 		allowed -= min_t(long, mm->total_vm / 32, reserve);
+
+#ifdef CONFIG_MEMCG
+		/*
+		 * If we are in a memory cgroup we also evaluate if the cgroup
+		 * has enough memory to allocate a new virtual mapping.
+		 * This is how we can keep processes from exceeding their
+		 * limits and also prevent that the OOM killer must be
+		 * awakened.  This gives programs a chance to handle memory
+		 * allocation failures gracefully and not being reaped.
+		 * In the current version mem_cgroup_get_max() is used which
+		 * allows the processes to exceeded their memory limits if
+		 * enough SWAP is available.  If this is not intended we could
+		 * use READ_ONCE(memcg->memory.max) instead.
+		 *
+		 * This code is only reached if sysctl_overcommit_memory equals
+		 * OVERCOMMIT_NEVER, both other options are handled above.
+		 */
+		{
+			struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
+
+			if (memcg) {
+				long available = mem_cgroup_get_max(memcg)
+						- mem_cgroup_size(memcg);
+
+				allowed = min_t(long, available, allowed);
+			}
+		}
+#endif
 	}

 	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
