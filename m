Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD87329CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442529AbhCBCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241626AbhCATlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:41:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E6EA65150;
        Mon,  1 Mar 2021 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614618309;
        bh=PBzJUNwNOjo/WPR9nCD7feykmsnzuCuGOb7tqvWFaWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrmHQKhNt5nE07hK2qHWTmh5C5hhdqMtddNPzDxTtbDW7WwaXMj1voVMrbLGJYroP
         opcZCPqx/D7U29sEVUg0tT+uXcGYHRCzUjHpR1WQJ/tnl3OJGbn6aUtuoN1OQBYR5+
         Tn8vicrHbi7U+3X9BiWdJlTS/+k+8CO64XgKyR4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 041/663] bpf: Add bpf_patch_call_args prototype to include/linux/bpf.h
Date:   Mon,  1 Mar 2021 17:04:49 +0100
Message-Id: <20210301161143.807463242@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
References: <20210301161141.760350206@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit a643bff752dcf72a07e1b2ab2f8587e4f51118be ]

Add bpf_patch_call_args() prototype. This function is called from BPF verifier
and only if CONFIG_BPF_JIT_ALWAYS_ON is not defined. This fixes compiler
warning about missing prototype in some kernel configurations.

Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20210112075520.4103414-2-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b16bf48aab61..642ce03f19c4c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1371,7 +1371,10 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 /* verify correctness of eBPF program */
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr,
 	      union bpf_attr __user *uattr);
+
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
+#endif
 
 struct btf *bpf_get_btf_vmlinux(void);
 
-- 
2.27.0



