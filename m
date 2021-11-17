Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4554F454269
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhKQILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhKQIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:11:26 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FEDC061570;
        Wed, 17 Nov 2021 00:08:28 -0800 (PST)
Received: from localhost (unknown [151.44.20.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E0064A6;
        Wed, 17 Nov 2021 08:08:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9E0064A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1637136507; bh=WI3l1gDO1ckeyM/rewn4fHkluluKgnQPmxGdZIQcBv8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=TslcnkXRHAjwl9HngGVriKBHCOgNyEMq5Ti0C7Bj0sujObew6iXXhL18psJXdYasx
         Msvq9ITuU9Qu/9OHDnoRjV/R002NgCxj63ExgA/eZBfce+aW+JVws3opwiEf/1gGAI
         b/ntpmDQMM6w0CMcbWh2aRcX4UaomljPO5QJR81asd9wNtS/6hZGnvRxyT1H97Fi0s
         np2Qsnnyd1vihZefSA/RlkJsUIw0gBHH3hTJDP4AcZD6QQ9MnAch70xy/km4ZRI2cc
         pV8c8XUdxsPcYaA5kLXw0nHipwGnVSEozEq3c60EOmMCCR19icPwrpnrxSzbCBcOGw
         tFF1hL/tJauXA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        will@kernel.org, rppt@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, masahiroy@kernel.org,
        samitolvanen@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, frederic@kernel.org, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: [RFC 2/3] mm: page table check
In-Reply-To: <20211116220038.116484-3-pasha.tatashin@soleen.com>
References: <20211116220038.116484-1-pasha.tatashin@soleen.com>
 <20211116220038.116484-3-pasha.tatashin@soleen.com>
Date:   Wed, 17 Nov 2021 01:08:23 -0700
Message-ID: <878rxngq6g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> Check user page table entries at the time they are added and removed.
>
> Allows to synchronously catch memory corruption issues related to
> double mapping.
>
> When a pte for an anonymous page is added into page table, we verify
> that this pte does not already point to a file backed page, and vice
> versa if this is a file backed page that is being added we verify that
> this page does not have an anonymous mapping
>
> We also enforce that read-only sharing for anonymous pages is allowed
> (i.e. cow after fork). All other sharing must be for file pages.
>
> Page table check allows to protect and debug cases where "struct page"
> metadata became corrupted for some reason. For example, when refcnt or
> mapcount become invalid.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/vm/page_table_check.rst |  53 ++++++

Thanks for documenting this feature!  When you add a new RST file,
though, you need to add it to the index.rst file as well so that it is
included in the docs build.

>  MAINTAINERS                           |   9 +
>  arch/Kconfig                          |   3 +
>  include/linux/page_table_check.h      | 147 ++++++++++++++
>  mm/Kconfig.debug                      |  24 +++
>  mm/Makefile                           |   1 +
>  mm/page_alloc.c                       |   4 +
>  mm/page_ext.c                         |   4 +
>  mm/page_table_check.c                 | 264 ++++++++++++++++++++++++++
>  9 files changed, 509 insertions(+)
>  create mode 100644 Documentation/vm/page_table_check.rst
>  create mode 100644 include/linux/page_table_check.h
>  create mode 100644 mm/page_table_check.c
>
> diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
> new file mode 100644
> index 000000000000..41435a45869f
> --- /dev/null
> +++ b/Documentation/vm/page_table_check.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _page_table_check:

Do you need this label for anything?  As-is it's just added visual
clutter and could come out.

> +================
> +Page Table Check
> +================
> +
> +Page table check allows to hardern the kernel by ensuring that some types of
> +memory corruptions are prevented.
> +
> +Page table check performs extra verifications at the time when new pages become
> +accessible from userspace by getting their page table entries (PTEs PMDs etc.)
> +added into the table.
> +
> +In case of detected corruption, the kernel is crashed. There is a small
> +performance and memory overhead associated with page table check. Thereofre, it
> +is disabled by default but can be optionally enabled on systems where extra
> +hardening outweighs the costs. Also, because page table check is synchronous, it
> +can help with debugging double map memory corruption issues, by crashing kernel
> +at the time wrong mapping occurs instead of later which is often the case with
> +memory corruptions bugs.
> +
> +==============================
> +Double mapping detection logic
> +==============================

I'd use subsection markup (single "==========" line underneath) for the
subsections.

> ++-------------------+-------------------+-------------------+------------------+
> +| Current Mapping   | New mapping       | Permissions       | Rule             |
> ++===================+===================+===================+==================+
> +| Anonymous         | Anonymous         | Read              | Allow            |
> ++-------------------+-------------------+-------------------+------------------+
> +| Anonymous         | Anonymous         | Read / Write      | Prohibit         |
> ++-------------------+-------------------+-------------------+------------------+
> +| Anonymous         | Named             | Any               | Prohibit         |
> ++-------------------+-------------------+-------------------+------------------+
> +| Named             | Anonymous         | Any               | Prohibit         |
> ++-------------------+-------------------+-------------------+------------------+
> +| Named             | Named             | Any               | Allow            |
> ++-------------------+-------------------+-------------------+------------------+
> +
> +=========================
> +Enabling Page Table Check
> +=========================
> +
> +Build kernel with:
> +
> +- PAGE_TABLE_CHECK=y
> +Note, it can only be enabled on platforms where ARCH_SUPPORTS_PAGE_TABLE_CHECK
> +is available.
> +- Boot with 'page_table_check=on' kernel parameter.
> +
> +Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
> +table support without extra kernel parameter.

Thanks,

jon
