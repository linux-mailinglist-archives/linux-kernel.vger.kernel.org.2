Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB096432367
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhJRP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhJRP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:58:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832BC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9qiswIL103TKnHH+yJlLo4cGn7/XynTMlm7c1GFcn7s=; b=U1PUyJanSOINKeGYuB1JvcLlNy
        h+gZLeTm//0kVtbG7sv1vQGtit1M8EGD3gB6Ek6FFk//W0m9QBPkZao31TLxz9e8a8eUdwp5NRKR9
        S1SZB9HhxHrkrUvvWm9Smqhd/Bm0rT9BKfHV6BRJzQsaFUxNh5V00AuTp5XT78uCFOBjCojITxkce
        ETSFJxooa8sD/Cp17k8Nq0UmcdWTf3AjGO79hZXQRzqWaQvlNERQ03VFPdQv1ex1TSWMa3x4fue5Y
        QfVA2AkYN48S8BAn3kdAbnZ85ojDTmKjwTl6xDhe7DZwgD0ySrJjeQP+GRG+AVg8JVW0pIJuFkRZ1
        63JrDCbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcUxS-00B5NF-8c; Mon, 18 Oct 2021 15:54:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1015300242;
        Mon, 18 Oct 2021 17:53:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3CAA2C219894; Mon, 18 Oct 2021 17:53:49 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:53:49 +0200
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
Subject: Re: [PATCH 2/3] x86/insn-eval: Introduce insn_decode_mmio()
Message-ID: <YW2YjRjUg8MzV0rJ@hirez.programming.kicks-ass.net>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
 <20211018153333.8261-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018153333.8261-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 06:33:32PM +0300, Kirill A. Shutemov wrote:

> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index fbaa3fa24bde..2ab29d8d6731 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -1559,3 +1559,85 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
>  
>  	return true;
>  }
> +
> +/**
> + * insn_decode_mmio() - Decode a MMIO instruction
> + * @insn:	Structure to store decoded instruction
> + * @bytes:	Returns size of memory operand
> + *
> + * Decodes instruction that used for Memory-mapped I/O.
> + *
> + * Returns:
> + *
> + * Type of the instruction. Size of the memory operand is stored in
> + * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
> + */
> +enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
> +{
> +	int type = MMIO_DECODE_FAILED;
> +
> +	*bytes = 0;
> +
> +	insn_get_opcode(insn);

insn_get_opcode() can fail. Either you assume it's already called and
don't call it, or you can't assume anything and get to do error
handling.

> +	switch (insn->opcode.bytes[0]) {
...
> +	}
> +
> +	return type;
> +}
> -- 
> 2.32.0
> 
