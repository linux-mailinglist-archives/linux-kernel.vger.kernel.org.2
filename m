Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7A3F689C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbhHXSCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhHXSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:02:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA0C0363E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:50:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f114400ce3b938495d443bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:ce3b:9384:95d4:43bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADF891EC01FC;
        Tue, 24 Aug 2021 19:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629827406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x6kMnBnYAQ1onlDR/PwEEWYr/kh4xuIO8/rUqK4QT2s=;
        b=qQw1k51B047IfaEfHUijZr2KtnyVn6QYBpruoALaDFNfP02csF2n5jw4Eu4i/AxztMKu27
        qkyhO/5agpRc4BU0AYsLQBDUg+/wM5sTIbMfc/mPt0aADTc7CtVaA0H3v/Bsj5GAirKSQO
        6/wTIneDrd6M9EJghTzrrpkHvUwxexA=
Date:   Tue, 24 Aug 2021 19:50:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
Message-ID: <YSUxeabIb30oibG5@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic>
 <YSUnDQUrGYc8aY9j@google.com>
 <YSUsBVx2DD7MCyn/@zn.tnic>
 <YSUwrSidivC87lBC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSUwrSidivC87lBC@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 05:47:25PM +0000, Sean Christopherson wrote:
> It's passed to the (untrusted) VMM.  The TDX Module has direct access to the guest's
> entire FLAGS via the VMCS.
> 
> The VMM uses the "IRQs enabled" param to understand whether or not it should
> schedule the halted vCPU if an IRQ becomes pending.  E.g. if IRQs are disabled
> the VMM can keep the vCPU in virtual HLT, even if an IRQ is pending, without
> hanging/breaking the guest.

See, explanations like that need to be over those _tdx_hypercall()
wrappers. Otherwise it is just random magic.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
