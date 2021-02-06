Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04023119D7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhBFDVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhBFClz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:41:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EE2865019
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 01:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612573529;
        bh=JgcmMVWvEGcDw3NtlQt9NygLnMi7B0C8q+7WPIkqBRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pKnq2Z27SFm0vbIQnb16/r8EBZn/EzV+o+NicdyqfmTgeTsz3V+2YJUkGKu8jKFRX
         SYTzHzglddwaxBSe3GwHs8tghPcEx3xI2s/jKlEsFHXYEy8/TRsf0BFyVilqSvO6xa
         nri37CH1hkV32q1SuJ24CE0k9G8Vqiz1T/PZ8Uj7KnR/h26y5g/7dRQacKo6OnHAOW
         /+JlPKFA2vjw+uy/9csXw4SReLCtJfvMADlyZm6GnqIdBha+tI++WqFgGsgYf4t1OP
         T4kxg6xs443L07i3Vn24tPJfkMw4S/NXGm6AP3KrMdgdgO8j+R6epAXL0Sp6qIFQ22
         10ouZ9MJlXX7Q==
Received: by mail-ej1-f43.google.com with SMTP id r12so15103386ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 17:05:29 -0800 (PST)
X-Gm-Message-State: AOAM532lXOD++NYTzWW8sAG2kUxKLDvnADNXbLJhBjuGqi+mpShkanYX
        gXgwriBwyWSI9iXu28X27AHsKnZQIYDQNwiNMiCWvw==
X-Google-Smtp-Source: ABdhPJyo/qyFMt5e195Y3wLB2dVQnsZZVyne/5Em8m4HKx6tf2ly/WNEEhKqXeAJJz8XUBX2ebjKcFbG9gWKPBPHgS0=
X-Received: by 2002:a17:906:17d3:: with SMTP id u19mr6879969eje.316.1612573528113;
 Fri, 05 Feb 2021 17:05:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <f443f4a2d80ea3717bd1865ae61cec2a100805c3.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWQm+4ocEjDM2e1z=ewmjf4r--6UeqnTwKEtKRa_o-mNg@mail.gmail.com> <64109360-c45b-2a2f-b5c0-956386fc7168@linux.intel.com>
In-Reply-To: <64109360-c45b-2a2f-b5c0-956386fc7168@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Feb 2021 17:05:16 -0800
X-Gmail-Original-Message-ID: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
Message-ID: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
Subject: Re: [RFC v1 13/26] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:54 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Andy,
>
> On 2/5/21 3:43 PM, Andy Lutomirski wrote:
> > MWAIT turning into NOP is no good.  How about suppressing
> > X86_FEATURE_MWAIT instead?
> Yes, we can suppress it in tdx_early_init().
>
>   + setup_clear_cpu_cap(X86_FEATURE_MWAIT);
>
> But do you want to leave the MWAIT #VE handler as it as
> (just in case)?
>

I would suggest decoding the error, printing a useful message, and
oopsing or at least warning.

>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
