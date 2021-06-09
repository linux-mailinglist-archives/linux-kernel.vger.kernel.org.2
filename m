Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4773E3A2070
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFIW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:57:14 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:45967 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhFIW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:57:10 -0400
Received: by mail-yb1-f177.google.com with SMTP id g38so37796921ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZBw4seN/uDk7Yq4vwAfnRw1lvG+8DAJe0IFY4xw8iw=;
        b=SNMeNLAWCy+4o9WJQIdCW6GI6FA/sKubFjkzsRQMl4XIV5T+AJ645WZpDmT+J9VdEm
         oylkyspzkQPU7zVo8QGOmoJGi/F3XUhZf+17iZWSpquM3NCV+o+XJOt2XWTs+/b9mbgl
         8bWQtICXxgeTJ4TbCAPIDgUV4QSOKQ6JIq9hr8PICnvf9cGbHrUQz832UiXR8Q1IEsKQ
         SQa2+PEZdrLS1Tivk9WMywQAPStx3Q20uKLWsABiDpewtomrjjqX3GjlsjBzY1kYR8xu
         yD8NWFh567Qh1pv7vbi1CSP1rrofr4fb2u+MF48pHa8YFSdmT9VORFAGtMNuJR8cjMtp
         OgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZBw4seN/uDk7Yq4vwAfnRw1lvG+8DAJe0IFY4xw8iw=;
        b=mOCiXM9W6rBWMrpazo3jYzV0N85dIMsQwvFCrlDkzVBEDDTKaG8LqWHeb9NmNuY380
         xTJpaM+hzOzrAjxnzJEZ/u1uvA3nWcX77mref2EL53cB4AdCZRHJpr/xen74+GbNl5KJ
         KHcZW7Zy99emenF8cnjMSeqXA4QVmXc2kyyQefX3DIoUpcotPbirPMJ5+1PWojRdozk/
         iBtSzJ3tePhQ4vNkLmK2mTmUV+I4vXefVI50Ef5GjmxbjyaJUD1oPfdBYLRsDx1dH0CA
         WdPqTPHNqoFjUZqVHAIY0XidtvEVepP3vOmr0yNXfU+XUiZ1gArngR2DIdvPBUI2b4iT
         NeCg==
X-Gm-Message-State: AOAM533julgWZEKQ3CC6gVPEIPi5OsxGtRxXK+TcusTU5FPijj/kM9mA
        18L8bEANgJLRH+rqafFsjtk1rVJnwRoqxziJsEg=
X-Google-Smtp-Source: ABdhPJwcOE4kLnxQHt/eCz3TJYPRsWmpHTwIPtVPollhBKgFbSOe72BJEo/PDOLLx//2NNY+rBtceAXmGFLdlCJWPvE=
X-Received: by 2002:a25:d008:: with SMTP id h8mr3437465ybg.436.1623279242508;
 Wed, 09 Jun 2021 15:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <YMDX3Ly91OQUxEge@zn.tnic> <20210609194137.1949436-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210609194137.1949436-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Date:   Wed, 9 Jun 2021 15:53:51 -0700
Message-ID: <CAC41dw-0dcJRy5Q+Me-LkQjQNf7oCtXpj3L9phiicYMGDgRb1Q@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86: Introduce generic protected guest abstraction
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Wed, Jun 9, 2021 at 12:42 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Add a generic way to check if we run with an encrypted guest,
> without requiring x86 specific ifdefs. This can then be used in
> non architecture specific code.
>
> prot_guest_has() is used to check for protected guest feature
> flags.
>
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

I have sent a non RFC version of this patch for x86 review. Please use
it for further
discussion.

https://lore.kernel.org/patchwork/patch/1444184/

> Changes since RFC v2-fix-v3:
>  * Introduced ARCH_HAS_PROTECTED_GUEST and moved arch specific checks to
>    asm/protected_guest.h
>
> Changes since RFC v2-fix-v2:
>  * Renamed protected_guest_has() to prot_guest_has().
>  * Changed flag prefix from VM_ to PR_GUEST_
>  * Merged Borislav AMD implementation fix.




-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
