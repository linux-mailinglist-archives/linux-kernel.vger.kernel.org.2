Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6D38F82C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhEYC1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhEYC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:27:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E885C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:26:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y15so11012265pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bd/aixUu9hpwumclvDAK4EJj/hPrV/y2+Drdwtrgvlw=;
        b=nmqPnBbBmXh2PPfkSEwFth4fcOArZSWczOiD2FWtb0auBxrRC/UaZ4g4EmZQgWB12P
         wYpI/oIeYwR4sP13sJtWUyw8Cd7n+dlb8RkPuheVGG7EV57zETc/lMhfSt+i0+rI4ol0
         TFUlFuLEz+9P+UuCPhVqhnVoknAQJ933ambfER3UKIbccyHNeAhKVEq0zHUQyaL31KGk
         WBFwGysdEq82Td2VISlpyLlrl2aXO0fb1SwPf9iTz2E5TdrelvOWg6oiiMC9f+Cn4Ll8
         tKvypSB956iNHUsO/l3iuB2B/v9kUogeB8z6HF/qP3QXMJ1ZTDOZYmrv4lLF3Kl6JmIS
         bKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bd/aixUu9hpwumclvDAK4EJj/hPrV/y2+Drdwtrgvlw=;
        b=HSMD/JmewmrfthzFF5Q2qZF9Of0VyaO6/d6vJdfqsxGlA04ii1y11/Q7CCu7GGm0Vg
         KqxjvoVQsh8T8UBvB492qYrXF6Kz2kP9KVfsKfrnBLfgZoyCnGuo9oO+0MerDxCmi3W8
         LapJyeQY5RTM1ff4MYrLCv1Ea8RJLwNUhI+z7XMuXtQ5gN4f2F4FPNFnnClAk9ugqaym
         We1jSBTiQDuyNzBic/BnE7WFQXkirSGbNvTkN93AFhEOXDwUXdk3xnKvrZDXzSDJGgTW
         X7I9xDl70+TiGR+KluyR41ZgIkr6QWHoo+OO/ifYnRaAHvBhgdzpa5x8e+aTnu0DjLop
         zLaA==
X-Gm-Message-State: AOAM533AUl3gPzNNWOoqVaKbtIkz7kIvDlz/q6arxLKgQDgCQvjT7cm4
        egSoZAZGozj1Bkc1CpJF3TR5tUCZcJwdtYDfOJ4e9A==
X-Google-Smtp-Source: ABdhPJzBT+DE3d5Jlni87pcVERVwS36cMzAE0W1tSoMWIX00HvpRLW75roMZiLbMTXAKC5iMndOQWmn3BIwfl2W21PQ=
X-Received: by 2002:a63:1e1a:: with SMTP id e26mr16321299pge.240.1621909569971;
 Mon, 24 May 2021 19:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com> <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 19:26:03 -0700
Message-ID: <CAPcyv4idVP7fzdAcsz_9dqGm7Cmzu441hk692XqcMx3+v1Xwiw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 1/2] x86/tdx: Handle MWAIT and MONITOR
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 4:32 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> When running as a TDX guest, there are a number of existing,
> privileged instructions that do not work. If the guest kernel
> uses these instructions, the hardware generates a #VE.
>
> You can find the list of unsupported instructions in Intel
> Trust Domain Extensions (Intel=C2=AE TDX) Module specification,
> sec 9.2.2 and in Guest-Host Communication Interface (GHCI)
> Specification for Intel TDX, sec 2.4.1.
>
> To prevent TD guests from using MWAIT/MONITOR instructions,
> the CPUID flags for these instructions are already disabled
> by the TDX module.
>
> After the above mentioned preventive measures, if TD guests
> still execute these instructions, add appropriate warning
> message (WARN_ONCE()) in #VE handler. This handling behavior
> is same as KVM (which also treats MWAIT/MONITOR as nops with
> warning once in unsupported platforms).
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>
> Changes since RFC v2:
>  * Moved WBINVD related changes to a new patch.
>  * Fixed commit log as per review comments.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
