Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD7E43234E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhJRPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhJRPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OXhW+5RnrFYOlyPfWgjjNoff+OyuMBiPHUuJ9caaB2o=; b=JlzvxbjZX5PB4AYfSSF8zuXERS
        EPhy4Jqz/R1TO4sKVefjZIa5RczzVLEJd7HiDUByWXJ8y/sKbQsKVT+Q8uwt5hFG+Tpl2Us7MkQmr
        a9cLQoU8NKsZ1NZxl+FytkHqUmzPnnVJABRPgrKE+pvvgFQzfJYq8rjH4Cu4szpouhmRM1OwvfFLq
        FsUwLjO7lXtmTCYjeNrqpQ2IR2+43TqOOmnyVYgEEMyKNJ/Hi5VmykkD4nBq4/s9FUt5aMnV1aTZY
        BxDSNF1OP4e/6lZ486lVDzP9yLvtu53nnHyfaTi+17oPoCSNUzJa+LhJxPxam2dAoK0TW+FwRivZq
        46Q3Hc/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcUr8-00B5Bp-PT; Mon, 18 Oct 2021 15:47:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 140C2300242;
        Mon, 18 Oct 2021 17:47:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F4040286E09E9; Mon, 18 Oct 2021 17:47:17 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:47:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/3] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Message-ID: <YW2XBV2uHHDI2vq0@hirez.programming.kicks-ass.net>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
 <20211018153333.8261-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018153333.8261-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 06:33:31PM +0300, Kirill A. Shutemov wrote:
> +/**
> + * insn_get_modrm_reg_ptr() - Obtain register pointer based on ModRM byte
> + * @insn:	Instruction containing the ModRM byte
> + * @regs:	Register values as seen when entering kernel mode
> + *
> + * Returns:
> + *
> + * The register indicated by the reg part of the ModRM byte.
> + * The register is obtained as a pointer within pt_regs.
> + */
> +void *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)

Doesn't that return type want to be 'unsigned long *'?

> +{
> +	int offset;
> +
> +	offset = insn_get_modrm_reg_off(insn, regs);
> +	if (offset < 0)
> +		return NULL;
> +	return (void *)regs + offset;
> +}
> +
>  /**
>   * get_seg_base_limit() - obtain base address and limit of a segment
>   * @insn:	Instruction. Must be valid.
> -- 
> 2.32.0
> 
