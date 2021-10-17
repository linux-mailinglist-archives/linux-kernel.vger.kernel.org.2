Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5801430BC0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbhJQTay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbhJQTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:30:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71688C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 12:28:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634498919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RPNmtrIF8arN45udbVeaoyAnwTpFXPnM4MVTCWf1ug=;
        b=fqCI6gpvGMN/pYwPc4NOwzHwtZZHi56l1iXcudUdLgsdPyTaowQ2D/uM5o5WzCdkR7uYKW
        qK7yQam9YVow4hruWPNIELrhLN5gzT65Vo478b1qk99/T06Bc95vqL07QETgjG5ZjYg+6q
        R3NtoE19u3+N8NvZu1MqtJCS7I9jHjri+Q2GsJrrS6+SrXo4UkAfAsR+/sLcT6I/CGo3WP
        S37RcJwKvpOWHyZQXYdnM5U2AXI+XNmlvjzEDQsp1evkEDzR1CRZdrbyALKz58C1FmEYF3
        Y0uYJnS4cJsMkLgnF6TICOu/YCCA6Ifu9Xge4yt9E0gZtM/aUEh9v9F1ZkT6JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634498919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RPNmtrIF8arN45udbVeaoyAnwTpFXPnM4MVTCWf1ug=;
        b=kvOdQE1mnNKoZGQ7knDo73rrEbwkOpq/1ofPITqnItj0FwRkD7xPuC9cKpxYmbHNjyk9db
        27cjHAAQOn0vWWCQ==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] x86/tdx: Add early_is_tdx_guest() interface
In-Reply-To: <20211005204136.1812078-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Sun, 17 Oct 2021 21:28:38 +0200
Message-ID: <871r4j4fix.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
> +
> +#define TDX_CPUID_LEAF_ID                       0x21
> +
> +static int tdx_guest = -1;
> +
> +static inline bool early_cpuid_has_tdx_guest(void)
> +{
> +	u32 eax = TDX_CPUID_LEAF_ID, sig[3] = {0};
> +
> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
> +		return false;
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
> +
> +	return !memcmp("IntelTDX    ", sig, 12);
> +}
> +
> +bool early_is_tdx_guest(void)
> +{
> +	if (tdx_guest < 0)
> +		tdx_guest = early_cpuid_has_tdx_guest();
> +
> +	return !!tdx_guest;
> +}

Sigh.
