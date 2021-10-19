Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D49433130
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhJSIkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhJSIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:40:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8ABC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ds8rn2Dfbc1hCIaZDHYlLSIdlPZbNYdISy+4R95C/eU=; b=Pg14htOnOpwvJWJ83//3AqEnmT
        YWzOwaj7p2CdW8LnByHCP+goPL/JXkpKCxOOsxfphC1CGZx0v/lE9CRw3/MTnOgCZ1s2VKA0ze2e4
        aAQHWsmoDJYE/9G5aTRzZX1kgCz6Zja4GGwgQfYDdR9eEQxQESrerb7/VOOFkhwgYv9Q5a3+Jz1QQ
        eY6v8pmKWajl4tEFunaXsfRrZ+D0VmkgDBVXsrNF/NNfoFkxY/qbkD3WTgOji953TzPDj00piuSa7
        L7Xty4viM0SZ4Yb/gNaBx5AohCUQ3DhD9srTKVlEYqC5WWYizuv7AnNibEN4FnLd9mfDfz9LuX+XL
        m+/PpjyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcka5-00Bd5a-PY; Tue, 19 Oct 2021 08:35:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52D5A300221;
        Tue, 19 Oct 2021 10:34:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39C7920098A89; Tue, 19 Oct 2021 10:34:45 +0200 (CEST)
Date:   Tue, 19 Oct 2021 10:34:45 +0200
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
Message-ID: <YW6DJZBLe0eJaQMu@hirez.programming.kicks-ass.net>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
 <20211018153333.8261-3-kirill.shutemov@linux.intel.com>
 <YW2YjRjUg8MzV0rJ@hirez.programming.kicks-ass.net>
 <20211018164941.3nqq73pupep3cejz@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018164941.3nqq73pupep3cejz@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 07:49:41PM +0300, Kirill A. Shutemov wrote:
> On Mon, Oct 18, 2021 at 05:53:49PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 18, 2021 at 06:33:32PM +0300, Kirill A. Shutemov wrote:
> > 
> > > diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> > > index fbaa3fa24bde..2ab29d8d6731 100644
> > > --- a/arch/x86/lib/insn-eval.c
> > > +++ b/arch/x86/lib/insn-eval.c
> > > @@ -1559,3 +1559,85 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
> > >  
> > >  	return true;
> > >  }
> > > +
> > > +/**
> > > + * insn_decode_mmio() - Decode a MMIO instruction
> > > + * @insn:	Structure to store decoded instruction
> > > + * @bytes:	Returns size of memory operand
> > > + *
> > > + * Decodes instruction that used for Memory-mapped I/O.
> > > + *
> > > + * Returns:
> > > + *
> > > + * Type of the instruction. Size of the memory operand is stored in
> > > + * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
> > > + */
> > > +enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
> > > +{
> > > +	int type = MMIO_DECODE_FAILED;
> > > +
> > > +	*bytes = 0;
> > > +
> > > +	insn_get_opcode(insn);
> > 
> > insn_get_opcode() can fail. Either you assume it's already called and
> > don't call it, or you can't assume anything and get to do error
> > handling.
> 
> Fair enough. I will return MMIO_DECODE_FAILED if insn_get_opcode() fails.
> 
> BTW, looks like is_string_insn() suffers from the same issue. Not sure how
> to fix it though.

AFAICT all callers of insn_get_addr_ref() (which is what
is_string_insn() seems to be part of) do a insn_decode_*() call with
error checking before.

So it looks like that insn_get_opcode() in there is superfluous.
probably same for insn_has_rep_prefix() / get_seg_reg_override_idx() /
get_eff_addr_modrm_*(). That all wants cleaning up.

The esaiest way is probably to push those things up the callchains into
the !static function and have it fail early there.
