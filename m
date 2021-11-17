Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF78454B44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhKQQri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhKQQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:47:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5F4C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:44:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so13892064edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mk3EQIQlc769iqF40WF3/rES8RREP3zrgFFWj+6hSiI=;
        b=RgTmEIalg6v0Bmq8xYKdGWPG70YJJ60v3Z2MwhHUBE08nlXk3BwGXx5vU1nh3Ua7WF
         J9/1jdQLH5iFcxUurmvSRvKSRTNgAwFTg+9XXxG6SNUMZddXBA7Ld/CPAe/UW+b036oF
         EiaMYBpO8+d5QNuFs5N80udBePkVNGMM90kVJs4ZMWMTkBgDQvNZYCMdpaEKI4bkGwW8
         SnslfEl71dYywRKd1gmj0JCtXkWRPmhNEGb/QzsPVWBQbLOR2FAVScOXLuLFZSqEg2QT
         xBE/3DJesZREbjfjPZmq8ew46H8XCj9uGulm7YJKuY8Xft1ZYPIFePqERG41ewYkfJAi
         FRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mk3EQIQlc769iqF40WF3/rES8RREP3zrgFFWj+6hSiI=;
        b=G2nlGm+AaZoUMuaT4ZmG+3vuBR0Cs0CulyHoZyXnVUxUNxeBzzqWkcnHm0DFNAaK1J
         zh8IvEqXAfqVN+yBxQf83QyJ31/Tu6PGAAOZIwRo303bEaIaJY0lUiX9WUAlMavZHeGl
         Iyg5s2KdX/HeyXiuThWFtEjtoOJSrDsAn4H92ezJEcQYp0tZ33UrwRojGVkzcywwqdDw
         YgttojLYaxwHqzkaN/+FxrM8Mx423FdsblrhVYmqWvNkCX6QwJL0IbirTQBy+GGHcvbU
         JHl64RqTp/nCCPxJTc0C8WUn5yCunOWJae48k9I8f0pFGzoO6iex613UiUuG2g3h3Uuv
         R6oQ==
X-Gm-Message-State: AOAM530XpGjjq3YInFMjjIFqGttflItfzmq2VJIoEON/PQKMcc3ytXx1
        2HqQ/fTyscwNBAWufNflmTvHi+6WuUBzSs0CKItmDw==
X-Google-Smtp-Source: ABdhPJx0MbyNR612auC3mvloK/yYL0PaX5BeexgnzrhLnlbOYQHqtK/fT8+qzfBrH/s4b0DEQ/KqFm24q5GriqDCi9I=
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr9414edz.43.1637167471649;
 Wed, 17 Nov 2021 08:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20211116220038.116484-1-pasha.tatashin@soleen.com>
 <20211116220038.116484-2-pasha.tatashin@soleen.com> <e461ba08-0aa8-e405-6383-5d921443135a@arm.com>
In-Reply-To: <e461ba08-0aa8-e405-6383-5d921443135a@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 17 Nov 2021 11:43:55 -0500
Message-ID: <CA+CK2bDCApyAB2X9v8LH8Z2v18Fk19RYJ_qiucFUrX07N5g3hg@mail.gmail.com>
Subject: Re: [RFC 1/3] mm: ptep_clear() page table helper
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 3:52 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/17/21 3:30 AM, Pasha Tatashin wrote:
> > diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
> > index 552567d863b8..fbe06ec75370 100644
> > --- a/Documentation/vm/arch_pgtable_helpers.rst
> > +++ b/Documentation/vm/arch_pgtable_helpers.rst
> > @@ -66,9 +66,11 @@ PTE Page Table Helpers
> >  +---------------------------+--------------------------------------------------+
> >  | pte_mknotpresent          | Invalidates a mapped PTE                         |
> >  +---------------------------+--------------------------------------------------+
> > -| ptep_get_and_clear        | Clears a PTE                                     |
> > +| ptep_clear                | Clears a PTE                                     |
> >  +---------------------------+--------------------------------------------------+
> > -| ptep_get_and_clear_full   | Clears a PTE                                     |
> > +| ptep_get_and_clear        | Clears and returns PTE                           |
> > ++---------------------------+--------------------------------------------------+
> > +| ptep_get_and_clear_full   | Clears and returns PTE (batched PTE unmap)       |
> >  +---------------------------+--------------------------------------------------+
> >  | ptep_test_and_clear_young | Clears young from a PTE                          |
> >  +---------------------------+--------------------------------------------------+
>
> Just curious. This does not have a corresponding change in mm/debug_vm_pgtable.c ?

You are right, I need to replace it in mm/debug_vm_pgtable.c as well.
I will do it in the next version.

Thanks,
Pasha
