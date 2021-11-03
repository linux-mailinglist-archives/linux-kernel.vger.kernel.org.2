Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B0444496
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhKCPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKCPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:25:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15095C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:22:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 75so2680376pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2Er4KQZETRaY5TPONePNFD6aAR9v7RcmPetc9lhdRdU=;
        b=T3jasLuhM4nqqtHtqkH6wl+6poxLJd0KPuAt+q4K1xpkOMAwXKGORyXXwhHU3fl7aM
         UCG6okVBAiNq186inkZGRdQdWqYiA+fk5/yn8jdDPEMP6DqFNmHAJ2YK1oQwmh3MNZp8
         pmAhP8UJXwxOCLW7AsppuJIZ3JYjJZtVAdFQPhJxcdlpajhp8z8FedwIOE76GCLU0TO3
         dlbKtdfLhbZ77IQ/JB7w0dyDi1N2/OsfTuA7wHZ23UpkrNeIsSP+/lAgo+4tdp+NU4st
         JrVz3auseW/GvO8Cu5UzwbwWW2uyZGlJyP7yetHyZYLhXav8xOmzhhVgXVGFsY6XniY/
         87GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2Er4KQZETRaY5TPONePNFD6aAR9v7RcmPetc9lhdRdU=;
        b=37gUwnRIt9JwknZA6l3Zan45RLCnoRQLpQkrEdV8FbkWgBTuLbWwlKBKrtvYi2Q2z5
         pZCePX+/S4zI0B6WSqFQSpcYdpZariYaQmZEf5KEyq1KUS94wWjtKRNK3fWqdzOvzQLA
         Dw1Df3qm1aKL8OQBE+ZSuOTsnriVMeH0VDXLIAQEBTe0ZF2j2sTJcQFv7k9mBPtopge0
         IsfX5lhkaITSiqC/kBaTBnrT8ThY1yEicb0q9dG3Ozmif5aAypgpI/zRd6gvgCgZnsOB
         n/r4YWCEgIdXzys+x8bCYGdYCcbPBasEPUZnzU9Qig7nbyyZxQY4VC76mDHiId22kI1r
         4pVw==
X-Gm-Message-State: AOAM533Q7/CVwUk//tdKYaO+vQ57D8NTAiJliMOm+pioswEu7j8KkiGW
        fiPv/v1BXzMiS6wJZv0kxCY=
X-Google-Smtp-Source: ABdhPJztnBVdYVmY1r+WBqO4sWqlOFltacsIOrkhXCJQ/i/HHLh59IaU4Ujs2VXKSC4M5fihjVdloQ==
X-Received: by 2002:a05:6a00:170e:b0:480:5cfa:ad88 with SMTP id h14-20020a056a00170e00b004805cfaad88mr32229337pfc.2.1635952974572;
        Wed, 03 Nov 2021 08:22:54 -0700 (PDT)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id 1sm2698440pfz.219.2021.11.03.08.22.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Nov 2021 08:22:53 -0700 (PDT)
Date:   Wed, 3 Nov 2021 23:22:42 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     gregkh@linuxfoundation.org, ripxorip@gmail.com,
        maennich@google.com, matthieu.baerts@tessares.net,
        masahiroy@kernel.org
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags: add space regexs to all regex_c
Message-ID: <20211103152234.GA23295@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "make tags", it prompts a warning:

    ctags: Warning: drivers/pci/controller/pcie-apple.c:150:
    null expansion of name pattern "\1"

The reason is that there is an indentation beside arguments of
DECLARE_BITMAP, but it can parsed normally by gtags. It's also
allowed in C.

Regex [:space:] can match any white space character, so it's a
better approach to add it to each item in regex_c.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 scripts/tags.sh | 126 ++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index b24bfaec6290..16d475b3e203 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -140,71 +140,71 @@ dogtags()
 # - etags regular expressions have to match at the start of a line;
 #   a ^[^#] is prepended by setup_regex unless an anchor is already present
 regex_asm=(
-	'/^\(ENTRY\|_GLOBAL\)(\([[:alnum:]_\\]*\)).*/\2/'
+	'/^\(ENTRY\|_GLOBAL\)([[:space:]]*\([[:alnum:]_\\]*\)).*/\2/'
 )
 regex_c=(
-	'/^SYSCALL_DEFINE[0-9](\([[:alnum:]_]*\).*/sys_\1/'
-	'/^BPF_CALL_[0-9](\([[:alnum:]_]*\).*/\1/'
-	'/^COMPAT_SYSCALL_DEFINE[0-9](\([[:alnum:]_]*\).*/compat_sys_\1/'
-	'/^TRACE_EVENT(\([[:alnum:]_]*\).*/trace_\1/'
-	'/^TRACE_EVENT(\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
-	'/^DEFINE_EVENT([^,)]*, *\([[:alnum:]_]*\).*/trace_\1/'
-	'/^DEFINE_EVENT([^,)]*, *\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
-	'/^DEFINE_INSN_CACHE_OPS(\([[:alnum:]_]*\).*/get_\1_slot/'
-	'/^DEFINE_INSN_CACHE_OPS(\([[:alnum:]_]*\).*/free_\1_slot/'
-	'/^PAGEFLAG(\([[:alnum:]_]*\).*/Page\1/'
-	'/^PAGEFLAG(\([[:alnum:]_]*\).*/SetPage\1/'
-	'/^PAGEFLAG(\([[:alnum:]_]*\).*/ClearPage\1/'
-	'/^TESTSETFLAG(\([[:alnum:]_]*\).*/TestSetPage\1/'
-	'/^TESTPAGEFLAG(\([[:alnum:]_]*\).*/Page\1/'
-	'/^SETPAGEFLAG(\([[:alnum:]_]*\).*/SetPage\1/'
-	'/\<__SETPAGEFLAG(\([[:alnum:]_]*\).*/__SetPage\1/'
-	'/\<TESTCLEARFLAG(\([[:alnum:]_]*\).*/TestClearPage\1/'
-	'/\<__TESTCLEARFLAG(\([[:alnum:]_]*\).*/TestClearPage\1/'
-	'/\<CLEARPAGEFLAG(\([[:alnum:]_]*\).*/ClearPage\1/'
-	'/\<__CLEARPAGEFLAG(\([[:alnum:]_]*\).*/__ClearPage\1/'
-	'/^__PAGEFLAG(\([[:alnum:]_]*\).*/__SetPage\1/'
-	'/^__PAGEFLAG(\([[:alnum:]_]*\).*/__ClearPage\1/'
-	'/^PAGEFLAG_FALSE(\([[:alnum:]_]*\).*/Page\1/'
-	'/\<TESTSCFLAG(\([[:alnum:]_]*\).*/TestSetPage\1/'
-	'/\<TESTSCFLAG(\([[:alnum:]_]*\).*/TestClearPage\1/'
-	'/\<SETPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/SetPage\1/'
-	'/\<CLEARPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/ClearPage\1/'
-	'/\<__CLEARPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/__ClearPage\1/'
-	'/\<TESTCLEARFLAG_FALSE(\([[:alnum:]_]*\).*/TestClearPage\1/'
-	'/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/Page\1/'
-	'/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/__SetPage\1/'
-	'/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/__ClearPage\1/'
-	'/^TASK_PFA_TEST([^,]*, *\([[:alnum:]_]*\))/task_\1/'
-	'/^TASK_PFA_SET([^,]*, *\([[:alnum:]_]*\))/task_set_\1/'
-	'/^TASK_PFA_CLEAR([^,]*, *\([[:alnum:]_]*\))/task_clear_\1/'
-	'/^DEF_MMIO_\(IN\|OUT\)_[XD](\([[:alnum:]_]*\),[^)]*)/\2/'
-	'/^DEBUGGER_BOILERPLATE(\([[:alnum:]_]*\))/\1/'
-	'/^DEF_PCI_AC_\(\|NO\)RET(\([[:alnum:]_]*\).*/\2/'
-	'/^PCI_OP_READ(\(\w*\).*[1-4])/pci_bus_read_config_\1/'
-	'/^PCI_OP_WRITE(\(\w*\).*[1-4])/pci_bus_write_config_\1/'
-	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
-	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'
-	'/\<DECLARE_\(RWSEM\|COMPLETION\)(\([[:alnum:]_]\+\)/\2/v/'
-	'/\<DECLARE_BITMAP(\([[:alnum:]_]*\)/\1/v/'
-	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD(\([[:alnum:]_]*\)/\3/v/'
-	'/\(^\|\s\)RADIX_TREE(\([[:alnum:]_]*\)/\2/v/'
-	'/\<DEFINE_PER_CPU([^,]*, *\([[:alnum:]_]*\)/\1/v/'
-	'/\<DEFINE_PER_CPU_SHARED_ALIGNED([^,]*, *\([[:alnum:]_]*\)/\1/v/'
-	'/\<DECLARE_WAIT_QUEUE_HEAD(\([[:alnum:]_]*\)/\1/v/'
-	'/\<DECLARE_\(TASKLET\|WORK\|DELAYED_WORK\)(\([[:alnum:]_]*\)/\2/v/'
-	'/\(^\s\)OFFSET(\([[:alnum:]_]*\)/\2/v/'
-	'/\(^\s\)DEFINE(\([[:alnum:]_]*\)/\2/v/'
-	'/\<\(DEFINE\|DECLARE\)_HASHTABLE(\([[:alnum:]_]*\)/\2/v/'
-	'/\<DEFINE_ID\(R\|A\)(\([[:alnum:]_]\+\)/\2/'
-	'/\<DEFINE_WD_CLASS(\([[:alnum:]_]\+\)/\1/'
-	'/\<ATOMIC_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
-	'/\<RAW_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
-	'/\<DECLARE_FAULT_ATTR(\([[:alnum:]_]\+\)/\1/'
-	'/\<BLOCKING_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
-	'/\<DEVICE_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/dev_attr_\2/'
-	'/\<DRIVER_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/driver_attr_\2/'
-	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)(\([[:alnum:]_]\+\)/\4/'
+	'/^SYSCALL_DEFINE[0-9]([[:space:]]*\([[:alnum:]_]*\).*/sys_\1/'
+	'/^BPF_CALL_[0-9]([[:space:]]*\([[:alnum:]_]*\).*/\1/'
+	'/^COMPAT_SYSCALL_DEFINE[0-9]([[:space:]]*\([[:alnum:]_]*\).*/compat_sys_\1/'
+	'/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
+	'/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
+	'/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
+	'/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
+	'/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/get_\1_slot/'
+	'/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/free_\1_slot/'
+	'/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
+	'/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/SetPage\1/'
+	'/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/ClearPage\1/'
+	'/^TESTSETFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestSetPage\1/'
+	'/^TESTPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
+	'/^SETPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/SetPage\1/'
+	'/\<__SETPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__SetPage\1/'
+	'/\<TESTCLEARFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
+	'/\<__TESTCLEARFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
+	'/\<CLEARPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/ClearPage\1/'
+	'/\<__CLEARPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
+	'/^__PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__SetPage\1/'
+	'/^__PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
+	'/^PAGEFLAG_FALSE([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
+	'/\<TESTSCFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestSetPage\1/'
+	'/\<TESTSCFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
+	'/\<SETPAGEFLAG_NOOP([[:space:]]*\([[:alnum:]_]*\).*/SetPage\1/'
+	'/\<CLEARPAGEFLAG_NOOP([[:space:]]*\([[:alnum:]_]*\).*/ClearPage\1/'
+	'/\<__CLEARPAGEFLAG_NOOP([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
+	'/\<TESTCLEARFLAG_FALSE([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
+	'/^PAGE_TYPE_OPS([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
+	'/^PAGE_TYPE_OPS([[:space:]]*\([[:alnum:]_]*\).*/__SetPage\1/'
+	'/^PAGE_TYPE_OPS([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
+	'/^TASK_PFA_TEST([^,]*,[[:space:]]*\([[:alnum:]_]*\))/task_\1/'
+	'/^TASK_PFA_SET([^,]*,[[:space:]]*\([[:alnum:]_]*\))/task_set_\1/'
+	'/^TASK_PFA_CLEAR([^,]*,[[:space:]]*\([[:alnum:]_]*\))/task_clear_\1/'
+	'/^DEF_MMIO_\(IN\|OUT\)_[XD]([[:space:]]*\([[:alnum:]_]*\),[^)]*)/\2/'
+	'/^DEBUGGER_BOILERPLATE([[:space:]]*\([[:alnum:]_]*\))/\1/'
+	'/^DEF_PCI_AC_\(\|NO\)RET([[:space:]]*\([[:alnum:]_]*\).*/\2/'
+	'/^PCI_OP_READ([[:space:]]*\(\w*\).*[1-4])/pci_bus_read_config_\1/'
+	'/^PCI_OP_WRITE([[:space:]]*\(\w*\).*[1-4])/pci_bus_write_config_\1/'
+	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<DECLARE_\(RWSEM\|COMPLETION\)([[:space:]]*\([[:alnum:]_]\+\)/\2/v/'
+	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
+	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD([[:space:]]*\([[:alnum:]_]*\)/\3/v/'
+	'/\(^\|\s\)RADIX_TREE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_PER_CPU([^,]*,[[:space:]]*\([[:alnum:]_]*\)/\1/v/'
+	'/\<DEFINE_PER_CPU_SHARED_ALIGNED([^,]*,[[:space:]]*\([[:alnum:]_]*\)/\1/v/'
+	'/\<DECLARE_WAIT_QUEUE_HEAD([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
+	'/\<DECLARE_\(TASKLET\|WORK\|DELAYED_WORK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\(^\s\)OFFSET([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\(^\s\)DEFINE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<\(DEFINE\|DECLARE\)_HASHTABLE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_ID\(R\|A\)([[:space:]]*\([[:alnum:]_]\+\)/\2/'
+	'/\<DEFINE_WD_CLASS([[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/\<ATOMIC_NOTIFIER_HEAD([[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/\<RAW_NOTIFIER_HEAD([[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/\<DECLARE_FAULT_ATTR([[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/\<BLOCKING_NOTIFIER_HEAD([[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/\<DEVICE_ATTR_\(RW\|RO\|WO\)([[:space:]]*\([[:alnum:]_]\+\)/dev_attr_\2/'
+	'/\<DRIVER_ATTR_\(RW\|RO\|WO\)([[:space:]]*\([[:alnum:]_]\+\)/driver_attr_\2/'
+	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)([[:space:]]*\([[:alnum:]_]\+\)/\4/'
 	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_t/'
 	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
 )
-- 
2.17.1


