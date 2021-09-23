Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4C44158EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhIWHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhIWHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:18:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wiTqtJ6sksxlMa3WLP5zy8iX0qeEG49ono78xA+0et0=; b=McpsbcT3Fqx+WK3yjJcovN6ZlR
        54WeOwpZBhEq9CWctYQaLbYB3uj/0LiX0f8rpBoFqR6kG+ZXmMHSDyJVs61KfLSyD7M22BULUIE/T
        95d/NWPFB+Bc/bYJTI16yApIL5fITZbTKv08c8ACw9BbJtU0ngiM/7LpC9W2lvpIXyIT10ltVQOSd
        8HUwwrmP7Nz9YsQ+NPJwBG2iVmyUA8eDQVJbIASqLU4DZ+PmADSMLwbDYCqivS0Q37PSJG7GZOiAD
        h5InkYL8Y4cmgQ/6HBXo+b1z1OMhGmpL3HE5rkZXJP5+OzdvkCvEhp+0NzsD3rsq3GT8lz2tC80Ov
        hVJHiJzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTIyc-005AeP-Tr; Thu, 23 Sep 2021 07:17:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1754A300250;
        Thu, 23 Sep 2021 09:17:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2BDA2133B1A2; Thu, 23 Sep 2021 09:17:01 +0200 (CEST)
Date:   Thu, 23 Sep 2021 09:17:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:44:41PM +0000, Fenghua Yu wrote:

> > Since you're making it a fatal error, before doing much of anything
> > else, you might at well fail decode and keep it all in the x86/decode.c
> > file, no need to spread this 'knowledge' any further.

> Is the following updated patch a right one?

Yes, that's what I was thinking of.

> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index bc821056aba9..3e0f928e28a5 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -110,7 +110,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  {
>  	struct insn insn;
>  	int x86_64, ret;
> -	unsigned char op1, op2,
> +	unsigned char op1, op2, op3,
>  		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
>  		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
>  		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
> @@ -137,6 +137,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  
>  	op1 = insn.opcode.bytes[0];
>  	op2 = insn.opcode.bytes[1];
> +	op3 = insn.opcode.bytes[2];
>  
>  	if (insn.rex_prefix.nbytes) {
>  		rex = insn.rex_prefix.bytes[0];
> @@ -489,6 +490,16 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  			/* nopl/nopw */
>  			*type = INSN_NOP;
>  
> +		} else if (op2 == 0x38 && op3 == 0xf8) {
> +			if (insn.prefixes.nbytes == 1 &&
> +			    insn.prefixes.bytes[0] == 0xf2) {
> +				/* ENQCMD cannot be used in the kernel. */
> +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> +				     offset);
> +
> +				return -1;
> +			}

The only concern here is if we want it to be fatal or not. But otherwise
this seems to be all that's required.

> +
>  		} else if (op2 == 0xa0 || op2 == 0xa8) {
>  
>  			/* push fs/gs */
