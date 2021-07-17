Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE67C3CC3DC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhGQOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 10:44:08 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60950 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234234AbhGQOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:44:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ug2qc6w_1626532863;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Ug2qc6w_1626532863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 17 Jul 2021 22:41:08 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jessica Yu <jeyu@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] params:  fix a race condition between rmmod and module_attr_store
Date:   Sat, 17 Jul 2021 22:40:49 +0800
Message-Id: <20210717144049.99640-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rmmod, the resource of the module may have been released, but its
sysfs have not been destroyed. And at this time, if another process
manipulates the module through sysfs, it may cause kernel panic.
This may occasionally occur during stress testing, as follows:

PID: 36427  TASK: ffff88ed08044300  CPU: 6   COMMAND: "rmmod"

 #0 [ffff9d21888c7ca8] __schedule at ffffffff93871dd8
 #1 [ffff9d21888c7d40] schedule at ffffffff93872113
 #2 [ffff9d21888c7d58] schedule_timeout at ffffffff93876492
 #3 [ffff9d21888c7de0] wait_for_completion at ffffffff93872b83
 #4 [ffff9d21888c7e40] __wait_rcu_gp at ffffffff93117aac
 #5 [ffff9d21888c7e80] synchronize_sched at ffffffff9311c179
 #6 [ffff9d21888c7ec8] cleanup_module at ffffffffc04a282f [aprof]
 #7 [ffff9d21888c7ee0] __x64_sys_delete_module at ffffffff931453e0
 #8 [ffff9d21888c7f38] do_syscall_64 at ffffffff9300437b

PID: 19120  TASK: ffff88f0b34ad3c0  CPU: 3   COMMAND: "bash"

 #0 [ffff9d219406bad8] machine_kexec at ffffffff9306242e
 #1 [ffff9d219406bb30] __crash_kexec at ffffffff9314b541
 #2 [ffff9d219406bbf0] crash_kexec at ffffffff9314c398
 #3 [ffff9d219406bc08] oops_end at ffffffff9302ace4
 #4 [ffff9d219406bc28] no_context at ffffffff93071331
 #5 [ffff9d219406bc80] __do_page_fault at ffffffff93071f06
 #6 [ffff9d219406bcf0] do_page_fault at ffffffff93072322
 #7 [ffff9d219406bd20] async_page_fault at ffffffff93a0119e
    [exception RIP: __list_add_valid]
......
 #10 [ffff9d219406be48] param_set_buffer_grow at ffffffffc04a1408 [aprof]
 #11 [ffff9d219406be60] param_attr_store at ffffffff930bf0ac
 #12 [ffff9d219406be88] module_attr_store at ffffffff930be69a
 #13 [ffff9d219406be90] kernfs_fop_write at ffffffff9334f56f
 #14 [ffff9d219406bec8] vfs_write at ffffffff932ad740
 #15 [ffff9d219406bef8] ksys_write at ffffffff932ad9ca

It is fixed by making sure that the module is alive in param_attr_store.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/params.c b/kernel/params.c
index 2daa2780..3ff3efc 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -562,12 +562,16 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 	if (!attribute->param->ops->set)
 		return -EPERM;
 
+	if (!try_module_get(mk->mod))
+		return -ENODEV;
+
 	kernel_param_lock(mk->mod);
 	if (param_check_unsafe(attribute->param))
 		err = attribute->param->ops->set(buf, attribute->param);
 	else
 		err = -EPERM;
 	kernel_param_unlock(mk->mod);
+	module_put(mk->mod);
 	if (!err)
 		return len;
 	return err;
-- 
1.8.3.1

