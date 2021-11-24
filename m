Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE07045D153
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhKXXoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbhKXXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:44:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAFFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:40:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637797250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wc9Sdqvb+i4yREP1f/XB7cgF5TEqu0V+h0LlejHvhDs=;
        b=Dn1PT+QTutKoQAh4WDgzfZAGtAw110Xrbb71urrj59VWkR8yzlsQLZ3qHdrr2cCrjuzikp
        cW3eM/CffDojskw4s5RxycnpZKZgI+MUDFHXl5nEmg9huhTjPhit8uEfI+iLuoZPJFsB01
        VJvnLEOz+YyAIoeJg0CPDxDxLBb9TCmfuz8GZQKQsY6nxv9JQ44NOkJQ7lPTV/btg1gqQU
        87GKYgxBePcyerUF3RZhd25pVLIdDALPYizDLx3bVT3P0CGI0UkW3SyRVNDTyDhEALnSOn
        jSrOEoaI33YUe8LH73m4J280Y4CEbIvrfBhqPJxIhXmiMfWIDXEFAB1ooyJjTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637797250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wc9Sdqvb+i4yREP1f/XB7cgF5TEqu0V+h0LlejHvhDs=;
        b=T2W78KwtnPZjZ7nGnjZ/ntG8V05CnFPifacyI+Prs2GflyPzii/L6M7O9U6ScBoxBTKNhr
        Q5CTvzraVCb4leAw==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/tdx: Don't write CSTAR MSR on Intel
In-Reply-To: <20211119035803.4012145-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <878rxl41p3.ffs@tglx>
 <20211119035803.4012145-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 25 Nov 2021 00:40:49 +0100
Message-ID: <87sfvljf5q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kuppuswamy,

On Thu, Nov 18 2021 at 19:58, Kuppuswamy Sathyanarayanan wrote:

almost. The subject line is bogus:

        x86/tdx: Don't write CSTAR MSR on Intel

This has nothing to do with TDX in the first place as the actual check
is for CPU vendor == Intel. It's absolutely no requirement to remove
this for TDX. TDX could just handle the #VE and ignore the write.

It's an obvious optimization without TDX because the write is pointless
independent of TDX. There is no value to slap TDX on everything just
because.

Also 'write on Intel' should be 'write on Intel CPUs' to make sense.
  
> +/* Don't write CSTAR MSR on Intel platforms */

How is this comment useful? The proper explanation is below.

> +static void wrmsrl_cstar(unsigned long val)
> +{
> +	/*
> +	 * Intel CPUs do not support 32-bit SYSCALL. Writing to MSR_CSTAR
> +	 * is normally ignored by the CPU, but raises a #VE trap in a TDX
> +	 * guest.
> +	 */
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +		wrmsrl(MSR_CSTAR, val);
> +}

I fixed it up for you because of Thanksgiving.

Thanks,

        tglx
