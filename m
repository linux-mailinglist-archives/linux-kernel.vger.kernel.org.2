Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334CB3A07AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhFHXRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:17:22 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:36495 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhFHXRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:17:12 -0400
Received: by mail-pg1-f174.google.com with SMTP id 27so17831659pgy.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXUtjhMOh+0tg+IRns9ha7x4hEaYHHewg4eF1b76BTA=;
        b=Z1MP8S1pfzMA8xMDMkJ5kzsJH1/PDvSAB4/58RPh3nnbT52KqmXdh/x+q5YOrNJHnd
         sUTLuttECdbp+qbwuq3A4rykvwg3aHm69p9kgjVcD5UPQ/gNbgBdgpcEfQMsWHo0aH8f
         MiGCrD8ztrLVo6jb9Ixckjpy9aeXUXP71FyjJKJYlNBi8Lv/HDYww2/SWSXlv9geO1lQ
         DbLrH4Q4Pw/nMpo97TYzirpvXODI/xmq802IwLJZC0XpJm7sW+53Wiv/LQz3MdTx9uY5
         FkIfOV2djjIathafSAPdud4/bG6Vouhl7k++3ZYljElu+GZZ39SYL1Fw8N/YehBuUTIy
         iEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXUtjhMOh+0tg+IRns9ha7x4hEaYHHewg4eF1b76BTA=;
        b=kDampliyz+Gsgj6wuZjOxgIctlafCcVpVZizPz1AaKd3EooVOS/LIIRa1GOGe9Zr09
         lgyG38BnY2TPEXSU0lsnbQiCDyh/W40ZtgkCRQeXR/5h6rS2oZibnFXeKFaO6fuvKQOC
         99zLPKoaGXzbvlgpEHIyd+aF2JNsTz/cZHyLCDaQ/b/PIWYsZE7L8LYC9X4Y1O0NXdAm
         GyW9NEp0efdERLGchWOOrFggh1CSYo7FgGQfz8SSAuzF5s4FmFMIjKRET7AYAdArQSpj
         NoLNXk6e5P4LHUzB3Ht+GcNKgy2k53mN4UjHHvKQH8ScVxZq1YuWOVGEfYqQyQEeB1iV
         GtLw==
X-Gm-Message-State: AOAM532aQWHEAiuJve2VpjroDdvsXducVP361tQvDiFHQfoPD6sRxPmo
        DdmJj/mnlEI9dxHZqxh2S5X6yjbUdIZD6+ZxGNB6EQ==
X-Google-Smtp-Source: ABdhPJzIFMsqky9VUawt+T04QUpjzybOyiLohId2ziaPmX/FsIKltRrhCKmFwTy69/FkjApW3I4TA0TCkecLtHB82tE=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr640993pgm.279.1623194059104;
 Tue, 08 Jun 2021 16:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210524232735.801740-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210527212502.1061857-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210527212502.1061857-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 16:14:08 -0700
Message-ID: <CAPcyv4gQ6jpphiLn_q3g8c5_bwfywa1P+UfPRibTTzaWAGkBtA@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86/boot: Avoid #VE during boot for TDX platforms
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 2:25 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> There are a few MSRs and control register bits which the kernel
> normally needs to modify during boot. But, TDX disallows
> modification of these registers to help provide consistent
> security guarantees. Fortunately, TDX ensures that these are all
> in the correct state before the kernel loads, which means the
> kernel has no need to modify them.
>
> The conditions to avoid are:
>
>   * Any writes to the EFER MSR
>   * Clearing CR0.NE
>   * Clearing CR3.MCE
>
> This theoretically makes guest boot more fragile. If, for
> instance, EFER was set up incorrectly and a WRMSR was performed,
> it will trigger early exception panic or a triple fault, if it's
> before early exceptions are set up. However, this is likely to
> trip up the guest BIOS long before control reaches the kernel. In
> any case, these kinds of problems are unlikely to occur in
> production environments, and developers have good debug
> tools to fix them quickly.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
