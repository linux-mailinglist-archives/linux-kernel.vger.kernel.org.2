Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF53A07A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhFHXPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:15:24 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45860 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhFHXPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:15:23 -0400
Received: by mail-pg1-f177.google.com with SMTP id q15so17801978pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVHHsZmgnQE4FoIRlh0tnAp+GCRu+pvT2NaDwu+6pyA=;
        b=A2+gkPmEOqrQW2pFugLSrb30IoeUDdcGr8dIbngT/4xp0aEmVg/PghppWc56VS68aR
         dpaUosF0QuVyrTuJ5+14RRCkabMvwxSuORRfTWvN1LoJM8RXxjsCV8JLvp47hONUCbNv
         4rHmF7XWPwmi9/P9KtpR55iOVnKg2y2WIb8XxQKrefIsTl219SZ5pzHG+hDFqBRSEv9C
         xXzx02CHBW40cIRcYsK79amKtk61L2xpSVlPILWH5iF683I7emfT9by2MxbYonlnZGMc
         OPI+sWnz+MnRpT8BEwXJh6p64YWOR4fypV2WwQVc5GmcmhAVgtNEGY8vwBtbqbJl1pcl
         Gx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVHHsZmgnQE4FoIRlh0tnAp+GCRu+pvT2NaDwu+6pyA=;
        b=XLtIcDKCm6Sdfyr1zS8Yeou0tAsAxGrFx3STP//rAvwXS7dpZpGzyytwhQ4L2kts0A
         9BiLdeWVxhnNc8QHE7FYzWPmLcKNi76VMnKYBguntJZVc8yKPDrL2q7+1ATrmAViNjRj
         8tWb4J6H5BSVvawqgt0nxOsoI3b3ZYUPqc3msh8T+w4Jf2whlAXD4ehqzhpOSZw6lrSb
         8YUcTVaarCXxWvG/uEmOPMeqIXDD3V8T4XPj4fk0vdIewjId3AGHSQbY9vrofqaOxxFf
         /i+VEhgnP0lFmiuOwlJt0KKqDdpmzCCD1VkFiXENnqGqGrGO4EO7Aj8CTvwlCHGqRVqn
         9pEA==
X-Gm-Message-State: AOAM532rj5FpHeoga110l86zSj2SDs7GgEwni81jIXaLjORFMpb08WTh
        Z59Loi9AExdS5GUSOtAWAfz3V1Tc7YphpqDroqjGgA==
X-Google-Smtp-Source: ABdhPJxRMoCoF9acdRFORcVr382jATjSwADMNX63HpjC/b5SSfyl7EizlUdBTm0k8HgwwtSEiIP8angDew2NteFFbp8=
X-Received: by 2002:aa7:952b:0:b029:2e9:eef1:8e17 with SMTP id
 c11-20020aa7952b0000b02902e9eef18e17mr2290787pfp.70.1623193949671; Tue, 08
 Jun 2021 16:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com> <e743d11960f58f1694ced91edd1b262ce7eb82db.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e743d11960f58f1694ced91edd1b262ce7eb82db.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 16:12:18 -0700
Message-ID: <CAPcyv4hHhDQxYG=jEJoQqVq5DeuQQAmpd8k5LkOwOkUz4EieYQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 1/3] x86/tdx: Handle port I/O in decompression code
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

On Tue, Jun 8, 2021 at 8:40 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Add support to replace in/out instructions in
> decompression code with TDX IO hypercalls.
>
> TDX cannot do port IO directly. The TDX module triggers
> a #VE exception to let the guest kernel to emulate port
> I/O, by converting them into TDX hypercalls to call the
> host.
>
> But for the really early code in the decompressor, #VE
> cannot be used because the IDT needed for handling the
> exception is not set-up, and some other infrastructure
> needed by the handler is missing. So to support port IO
> in decompressor code, directly replace in/out instructions
> with TDX IO hypercalls. This can beeasily achieved by
> modifying __in/__out macros.
>
> Also, since TDX IO hypercall requires an IO size parameter,
> modify __in/__out macros to accept size as input parameter.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
