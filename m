Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E755D37BDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhELNUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:20:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kM8Gv4a7if6FOAGYpIP4H4G5ELTL9yP0j2wunmulU+g=; b=IxkLR8bNVFnsDosV3gjfPgggNa
        1zh6QH/LgbpHoi480Ij82xCBQAnWc5KtCeK4JpZ26xHB15CP1luAkUovYhCcfCDc4LxpINJ2rWVUJ
        Karqtz3BHWU6pBpxdyrBM9PJCJb3LUV4qLTYT7ozpXTk8bW8mcp1VtRf45dq4kcdcKhvInMDbfFf9
        Gi6FdogMnOjwiHnQKKbWnc6FqTXjfcGcMArKgcHvfYvUQljm3UPNBhV9MmCsbnyJ7PCjbXRhm4uDG
        2JxaO8B0lU0OuHL5BL45JLE65lbvnzR4pyP6i5tBEXvFeLN2TVDWFQWWUx003LIimpxYW3bJbFfsG
        8Qsw3dew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgolT-002sBN-Hy; Wed, 12 May 2021 13:19:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22EED300242;
        Wed, 12 May 2021 15:18:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 088162870D488; Wed, 12 May 2021 15:18:58 +0200 (CEST)
Date:   Wed, 12 May 2021 15:18:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
Message-ID: <YJvVwXqGZWrXWPvP@hirez.programming.kicks-ass.net>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic>
 <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
 <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
 <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:56:05PM +0200, Juergen Gross wrote:

> No. We have PARAVIRT_XXL for Xen PV guests, and we have PARAVIRT for
> other hypervisor's guests, supporting basically the TLB flush operations
> and time related operations only. Adding the halt related operations to
> PARAVIRT wouldn't break anything.

Also, I don't think anything modern should actually ever hit any of the
HLT instructions, most everything should end up at an MWAIT.

Still, do we wants to give arch_safe_halt() and halt() the
PVOP_ALT_VCALL0() treatment?
