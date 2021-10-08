Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3356C426FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhJHSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJHSBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:01:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C872DC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:59:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d56005271a08b055a2ed3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:5271:a08b:55a:2ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49C131EC04BF;
        Fri,  8 Oct 2021 19:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633715986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZZMTo+qBT6VYeI+pvdbzUUz7nkXxSCvagxQ3P3Mfw08=;
        b=YKu20P67MvmuVcqwjFHCCtxevAk0uaoELvYmat0JWOrdp7y008Sz94EQoiWA2WJurmWx90
        XNk0bBIBjEQ15aF+vtWDqhKvDCz0A0jCVfwX86kIiXzDKTearK791N5i5ZWEDms4nRGIxc
        UDcOEIJzy9XoBZoQZr3wsyU9qZFkEZ8=
Date:   Fri, 8 Oct 2021 19:59:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/11] x86/tdx: Add HLT support for TDX guest
Message-ID: <YWCHDzatoa3S+lFh@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWCAeCIYovTnqvbd@zn.tnic>
 <bb0c91bf-2b10-e177-90f1-d9af506f7c74@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb0c91bf-2b10-e177-90f1-d9af506f7c74@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:38:22AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Yes. As per ABI, I don't need to clear it. It will not be used by VMM.
> But since that register content is shared with VMM, I tried to keep the
> unused register values to '0' (consistent with other hypercall use cases).
> 
> I am fine with removing it if you think it is unnecessary.

Yeah, you probably wanna clear it after all, just in case, as Dirk says.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
