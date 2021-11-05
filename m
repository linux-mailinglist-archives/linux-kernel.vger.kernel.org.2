Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582FF44667B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhKEPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhKEPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:53:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF37C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:50:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso6765379wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOD7Y2410y/Fc9bTsFrd7I5AS+YA3tpntzf1Tt05UQk=;
        b=kyGIEHX8TXiJw6jyVMAVnmkOr4VdFTYb9Kmu43YBiXi0TLwY8aW3eEP1Pp7w6baWf5
         6ZUxovrgZAA1CbOSt6Aa/znKzlMz9BsoatdLd9VQRlm7DvqXNKVJz13J71hSCjLJM7X0
         tpd7OqCWa/bZHlB8ztBAvGCQhLL6Dre8LeMOPjCultip3zxqX4s9OT7syLgjPZcZkeyr
         T3yFdwr/FO1RlXnwp70JQjDNZCYOd4zUCW6oYFfb/KMbDMwnS9o2UGodtBSOsoYYbZYE
         CvABqlB9sjRPKJlfyuob1KxAMmk15AWcneWsu30WvaIEsqOA3j5GAfBnfc8t4SUWStt7
         WCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOD7Y2410y/Fc9bTsFrd7I5AS+YA3tpntzf1Tt05UQk=;
        b=xVua0bNpaG6Z4bZruH/tuYN3+f42JZsm0dAwRfDUQdAg9oxnmyS3ws25M2JhsZBRa7
         s7swDr0MQ8lgv4Z2XIveLBDH6pFY3tBhYDLLQf6ie4cM8JJrmjUdQTB76KDnKUbothPS
         vuCxxuJIi7Em51Gs56NJpwdKr7gntbSmS3lhJKb16xMLHWiJng1N9AIk5JJJ+guphCxy
         ZcS41Xn9HXOXonMQknvengeIhHvC5FcH4qlk6Cjeky/MyHPvqiuaassSTSk0/lLDGGvl
         idzUHcNl/MQW5wVZETOBwfWWkDIls1wMmR4bPFfUdel6y5ZMn+t/G0SQh9TMY/TC6G0r
         PZhQ==
X-Gm-Message-State: AOAM530iP+dfdvPRZpU5+uGh47pxEmZsrxOqLv06m0EHv5KZ3jtv6oZE
        qK3Ay7T+5y8utMhO+1cDhvKg5oOJc87x7u55A1EiEHsqbuo=
X-Google-Smtp-Source: ABdhPJyiRrVttFrE4OXzOldOF0kAa2dIRH71diDKk/5qaY1vfsiboKL6akDyqQVNV5ch5Ynw/dTrm4IXY3y4XXQGiFM=
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr14414269wmq.109.1636127444480;
 Fri, 05 Nov 2021 08:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211103152234.GA23295@pc>
In-Reply-To: <20211103152234.GA23295@pc>
From:   Zackary Liu <zackary.liu.pro@gmail.com>
Date:   Fri, 5 Nov 2021 23:50:33 +0800
Message-ID: <CAOk_PdOsSjPHogrYJ9Nd7GdnZYw1G4zbaZFGUrK1rQ0dSq101A@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags: add space regexs to all regex_c
To:     gregkh@linuxfoundation.org, ripxorip@gmail.com,
        maennich@google.com, matthieu.baerts@tessares.net,
        masahiroy@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
    Excuse me, everybody.
    I submitted a patch yesterday. Now I have a question why the
maintainer's mailbox was not found during "get_maintainer.pl".
    It outputs the following information:
    ---
    linux-next$ scripts/get_maintainer.pl -f scripts/tags.sh
        Zhaoyu Liu <zackary.liu.pro@gmail.com>
(commit_signer:2/4=50%,authored:2/4=50%,added_lines:68/74=92%,removed_lines:72/74=97%)
        Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/4=50%)
        "Philip K. Gisslow" <ripxorip@gmail.com>
(commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/74=7%)
        Matthias Maennich <maennich@google.com> (commit_signer:1/4=25%)
        Michael Ellerman <mpe@ellerman.id.au> (commit_signer:1/4=25%)
        Masahiro Yamada <masahiroy@kernel.org> (authored:1/4=25%)
        linux-kernel@vger.kernel.org (open list)
    ---
    Is it a bug in "get_maintainer.pl"?
    Is it correct for me to send patch to all "commit_signer"? Who
will review my patch and merge it?

    I look forward to your reply. Thank you very much.

    Best Regards

On Wed, Nov 3, 2021 at 11:22 PM Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
>
> When "make tags", it prompts a warning:
>
>     ctags: Warning: drivers/pci/controller/pcie-apple.c:150:
>     null expansion of name pattern "\1"
>
> The reason is that there is an indentation beside arguments of
> DECLARE_BITMAP, but it can parsed normally by gtags. It's also
> allowed in C.
>
> Regex [:space:] can match any white space character, so it's a
> better approach to add it to each item in regex_c.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
> ---
>  scripts/tags.sh | 126 ++++++++++++++++++++++++------------------------
>  1 file changed, 63 insertions(+), 63 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index b24bfaec6290..16d475b3e203 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -140,71 +140,71 @@ dogtags()
>  # - etags regular expressions have to match at the start of a line;
>  #   a ^[^#] is prepended by setup_regex unless an anchor is already present
>  regex_asm=(
> -       '/^\(ENTRY\|_GLOBAL\)(\([[:alnum:]_\\]*\)).*/\2/'
> +       '/^\(ENTRY\|_GLOBAL\)([[:space:]]*\([[:alnum:]_\\]*\)).*/\2/'
>  )
>  regex_c=(
> -       '/^SYSCALL_DEFINE[0-9](\([[:alnum:]_]*\).*/sys_\1/'
> -       '/^BPF_CALL_[0-9](\([[:alnum:]_]*\).*/\1/'
> -       '/^COMPAT_SYSCALL_DEFINE[0-9](\([[:alnum:]_]*\).*/compat_sys_\1/'
> -       '/^TRACE_EVENT(\([[:alnum:]_]*\).*/trace_\1/'
> -       '/^TRACE_EVENT(\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
> -       '/^DEFINE_EVENT([^,)]*, *\([[:alnum:]_]*\).*/trace_\1/'
> -       '/^DEFINE_EVENT([^,)]*, *\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
> -       '/^DEFINE_INSN_CACHE_OPS(\([[:alnum:]_]*\).*/get_\1_slot/'
> -       '/^DEFINE_INSN_CACHE_OPS(\([[:alnum:]_]*\).*/free_\1_slot/'
> -       '/^PAGEFLAG(\([[:alnum:]_]*\).*/Page\1/'
> -       '/^PAGEFLAG(\([[:alnum:]_]*\).*/SetPage\1/'
> -       '/^PAGEFLAG(\([[:alnum:]_]*\).*/ClearPage\1/'
> -       '/^TESTSETFLAG(\([[:alnum:]_]*\).*/TestSetPage\1/'
> -       '/^TESTPAGEFLAG(\([[:alnum:]_]*\).*/Page\1/'
> -       '/^SETPAGEFLAG(\([[:alnum:]_]*\).*/SetPage\1/'
> -       '/\<__SETPAGEFLAG(\([[:alnum:]_]*\).*/__SetPage\1/'
> -       '/\<TESTCLEARFLAG(\([[:alnum:]_]*\).*/TestClearPage\1/'
> -       '/\<__TESTCLEARFLAG(\([[:alnum:]_]*\).*/TestClearPage\1/'
> -       '/\<CLEARPAGEFLAG(\([[:alnum:]_]*\).*/ClearPage\1/'
> -       '/\<__CLEARPAGEFLAG(\([[:alnum:]_]*\).*/__ClearPage\1/'
> -       '/^__PAGEFLAG(\([[:alnum:]_]*\).*/__SetPage\1/'
> -       '/^__PAGEFLAG(\([[:alnum:]_]*\).*/__ClearPage\1/'
> -       '/^PAGEFLAG_FALSE(\([[:alnum:]_]*\).*/Page\1/'
> -       '/\<TESTSCFLAG(\([[:alnum:]_]*\).*/TestSetPage\1/'
> -       '/\<TESTSCFLAG(\([[:alnum:]_]*\).*/TestClearPage\1/'
> -       '/\<SETPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/SetPage\1/'
> -       '/\<CLEARPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/ClearPage\1/'
> -       '/\<__CLEARPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/__ClearPage\1/'
> -       '/\<TESTCLEARFLAG_FALSE(\([[:alnum:]_]*\).*/TestClearPage\1/'
> -       '/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/Page\1/'
> -       '/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/__SetPage\1/'
> -       '/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/__ClearPage\1/'
> -       '/^TASK_PFA_TEST([^,]*, *\([[:alnum:]_]*\))/task_\1/'
> -       '/^TASK_PFA_SET([^,]*, *\([[:alnum:]_]*\))/task_set_\1/'
> -       '/^TASK_PFA_CLEAR([^,]*, *\([[:alnum:]_]*\))/task_clear_\1/'
> -       '/^DEF_MMIO_\(IN\|OUT\)_[XD](\([[:alnum:]_]*\),[^)]*)/\2/'
> -       '/^DEBUGGER_BOILERPLATE(\([[:alnum:]_]*\))/\1/'
> -       '/^DEF_PCI_AC_\(\|NO\)RET(\([[:alnum:]_]*\).*/\2/'
> -       '/^PCI_OP_READ(\(\w*\).*[1-4])/pci_bus_read_config_\1/'
> -       '/^PCI_OP_WRITE(\(\w*\).*[1-4])/pci_bus_write_config_\1/'
> -       '/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
> -       '/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'
> -       '/\<DECLARE_\(RWSEM\|COMPLETION\)(\([[:alnum:]_]\+\)/\2/v/'
> -       '/\<DECLARE_BITMAP(\([[:alnum:]_]*\)/\1/v/'
> -       '/\(^\|\s\)\(\|L\|H\)LIST_HEAD(\([[:alnum:]_]*\)/\3/v/'
> -       '/\(^\|\s\)RADIX_TREE(\([[:alnum:]_]*\)/\2/v/'
> -       '/\<DEFINE_PER_CPU([^,]*, *\([[:alnum:]_]*\)/\1/v/'
> -       '/\<DEFINE_PER_CPU_SHARED_ALIGNED([^,]*, *\([[:alnum:]_]*\)/\1/v/'
> -       '/\<DECLARE_WAIT_QUEUE_HEAD(\([[:alnum:]_]*\)/\1/v/'
> -       '/\<DECLARE_\(TASKLET\|WORK\|DELAYED_WORK\)(\([[:alnum:]_]*\)/\2/v/'
> -       '/\(^\s\)OFFSET(\([[:alnum:]_]*\)/\2/v/'
> -       '/\(^\s\)DEFINE(\([[:alnum:]_]*\)/\2/v/'
> -       '/\<\(DEFINE\|DECLARE\)_HASHTABLE(\([[:alnum:]_]*\)/\2/v/'
> -       '/\<DEFINE_ID\(R\|A\)(\([[:alnum:]_]\+\)/\2/'
> -       '/\<DEFINE_WD_CLASS(\([[:alnum:]_]\+\)/\1/'
> -       '/\<ATOMIC_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
> -       '/\<RAW_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
> -       '/\<DECLARE_FAULT_ATTR(\([[:alnum:]_]\+\)/\1/'
> -       '/\<BLOCKING_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
> -       '/\<DEVICE_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/dev_attr_\2/'
> -       '/\<DRIVER_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/driver_attr_\2/'
> -       '/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)(\([[:alnum:]_]\+\)/\4/'
> +       '/^SYSCALL_DEFINE[0-9]([[:space:]]*\([[:alnum:]_]*\).*/sys_\1/'
> +       '/^BPF_CALL_[0-9]([[:space:]]*\([[:alnum:]_]*\).*/\1/'
> +       '/^COMPAT_SYSCALL_DEFINE[0-9]([[:space:]]*\([[:alnum:]_]*\).*/compat_sys_\1/'
> +       '/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
> +       '/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
> +       '/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
> +       '/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
> +       '/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/get_\1_slot/'
> +       '/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/free_\1_slot/'
> +       '/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
> +       '/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/SetPage\1/'
> +       '/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/ClearPage\1/'
> +       '/^TESTSETFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestSetPage\1/'
> +       '/^TESTPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
> +       '/^SETPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/SetPage\1/'
> +       '/\<__SETPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__SetPage\1/'
> +       '/\<TESTCLEARFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
> +       '/\<__TESTCLEARFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
> +       '/\<CLEARPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/ClearPage\1/'
> +       '/\<__CLEARPAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
> +       '/^__PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__SetPage\1/'
> +       '/^__PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
> +       '/^PAGEFLAG_FALSE([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
> +       '/\<TESTSCFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestSetPage\1/'
> +       '/\<TESTSCFLAG([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
> +       '/\<SETPAGEFLAG_NOOP([[:space:]]*\([[:alnum:]_]*\).*/SetPage\1/'
> +       '/\<CLEARPAGEFLAG_NOOP([[:space:]]*\([[:alnum:]_]*\).*/ClearPage\1/'
> +       '/\<__CLEARPAGEFLAG_NOOP([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
> +       '/\<TESTCLEARFLAG_FALSE([[:space:]]*\([[:alnum:]_]*\).*/TestClearPage\1/'
> +       '/^PAGE_TYPE_OPS([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
> +       '/^PAGE_TYPE_OPS([[:space:]]*\([[:alnum:]_]*\).*/__SetPage\1/'
> +       '/^PAGE_TYPE_OPS([[:space:]]*\([[:alnum:]_]*\).*/__ClearPage\1/'
> +       '/^TASK_PFA_TEST([^,]*,[[:space:]]*\([[:alnum:]_]*\))/task_\1/'
> +       '/^TASK_PFA_SET([^,]*,[[:space:]]*\([[:alnum:]_]*\))/task_set_\1/'
> +       '/^TASK_PFA_CLEAR([^,]*,[[:space:]]*\([[:alnum:]_]*\))/task_clear_\1/'
> +       '/^DEF_MMIO_\(IN\|OUT\)_[XD]([[:space:]]*\([[:alnum:]_]*\),[^)]*)/\2/'
> +       '/^DEBUGGER_BOILERPLATE([[:space:]]*\([[:alnum:]_]*\))/\1/'
> +       '/^DEF_PCI_AC_\(\|NO\)RET([[:space:]]*\([[:alnum:]_]*\).*/\2/'
> +       '/^PCI_OP_READ([[:space:]]*\(\w*\).*[1-4])/pci_bus_read_config_\1/'
> +       '/^PCI_OP_WRITE([[:space:]]*\(\w*\).*[1-4])/pci_bus_write_config_\1/'
> +       '/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\<DECLARE_\(RWSEM\|COMPLETION\)([[:space:]]*\([[:alnum:]_]\+\)/\2/v/'
> +       '/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
> +       '/\(^\|\s\)\(\|L\|H\)LIST_HEAD([[:space:]]*\([[:alnum:]_]*\)/\3/v/'
> +       '/\(^\|\s\)RADIX_TREE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\<DEFINE_PER_CPU([^,]*,[[:space:]]*\([[:alnum:]_]*\)/\1/v/'
> +       '/\<DEFINE_PER_CPU_SHARED_ALIGNED([^,]*,[[:space:]]*\([[:alnum:]_]*\)/\1/v/'
> +       '/\<DECLARE_WAIT_QUEUE_HEAD([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
> +       '/\<DECLARE_\(TASKLET\|WORK\|DELAYED_WORK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\(^\s\)OFFSET([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\(^\s\)DEFINE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\<\(DEFINE\|DECLARE\)_HASHTABLE([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
> +       '/\<DEFINE_ID\(R\|A\)([[:space:]]*\([[:alnum:]_]\+\)/\2/'
> +       '/\<DEFINE_WD_CLASS([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +       '/\<ATOMIC_NOTIFIER_HEAD([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +       '/\<RAW_NOTIFIER_HEAD([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +       '/\<DECLARE_FAULT_ATTR([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +       '/\<BLOCKING_NOTIFIER_HEAD([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +       '/\<DEVICE_ATTR_\(RW\|RO\|WO\)([[:space:]]*\([[:alnum:]_]\+\)/dev_attr_\2/'
> +       '/\<DRIVER_ATTR_\(RW\|RO\|WO\)([[:space:]]*\([[:alnum:]_]\+\)/driver_attr_\2/'
> +       '/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)([[:space:]]*\([[:alnum:]_]\+\)/\4/'
>         '/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_t/'
>         '/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
>  )
> --
> 2.17.1
>
>
