Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8923F31CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhHTQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhHTQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:59:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764B6C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:58:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f107b0070f9113f083a3500.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:70f9:113f:83a:3500])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67ECF1EC0589;
        Fri, 20 Aug 2021 18:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629478716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5KF+B+VqtfGsGaq/lw/UPH0YzDuR0oJkfB4Tm2QXWvE=;
        b=ASJFtWZaTbxmtJpbZRKpfEukM3vlQ2FESAAP7D1YKaNfDdq26E1vPiuBHATvzymyn5oc5r
        XsVw+LQ5kkpZp0hyeWkxA8KxxM0nr3ILnh6SjO8eDgfoa610328fQmTX0bdhbGFz6MHXol
        ZyjMF/gRSfED2OdXHniwYmbU2LGP2Ag=
Date:   Fri, 20 Aug 2021 18:59:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
Message-ID: <YR/fYu6kn7DKpOCi@zn.tnic>
References: <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
 <YQsX54MPVYFuLmFr@google.com>
 <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
 <YRTTZU3Pzm/1tH9M@zn.tnic>
 <486afc0e-0396-e57b-63fe-31a8433bd603@linux.intel.com>
 <YR+78mxnKW0T9Vdv@zn.tnic>
 <d419406e-749a-f851-f65e-a6582462c8a2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d419406e-749a-f851-f65e-a6582462c8a2@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 09:42:55AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Reason for suggesting seperate function for tdx_* specific protected guest
> check is, we will be adding some exceptions for TDX features (like command
> line option used to override the default flags or when device filter
> support is disabled). Our current final version looks like below. Such
> customization are not good in generic intel_* function right?

Err, why?

TDX is Intel technology. That's like asking to have

sev_prot_guest_has() and amd_prot_guest_has() on AMD.

Maybe I still don't get what you're trying to achieve but from where I'm
standing that sounds wrong.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
