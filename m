Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE13B4DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFZIVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 04:21:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vwVyjVuZDLq7eykpKBvO8M67kULOyIrzylMDKI5H34o=; b=tWWyrG5K2AhpcKEULF5Mr33Tfr
        PoIun19f3SzDd+WN4kxJ0xFh0vpGapOBOTGNfrfgfmE7nBv2jxi5BaKDDwyP96xbCNeF/CcMvWdLt
        /nLTjQKK8J7Ki8ZudveH9sZBffHED0rWWdxDQVuhuyUsAauJ1Ze15vC3od5UQTsqI6KL5i1L76V59
        GdXcOFkJ0bNZwGbzGEjj3TUp7aXpQB3jjCrX9ARgG87kO9VV12BKQy+5rYrerTrX3Xn30PiCFiMUI
        TtOaqMwgdwqts5ijX+sxCS7hQnn874M2bqg+LPDhiYoCGlBcB1qDvoEkBzOTn/dax4urADZ7LXDXW
        JnStbuvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lx3W2-000rja-TL; Sat, 26 Jun 2021 08:18:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 924BA30020C;
        Sat, 26 Jun 2021 10:18:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 716882BC35BC0; Sat, 26 Jun 2021 10:18:12 +0200 (CEST)
Date:   Sat, 26 Jun 2021 10:18:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, dvyukov@google.com, elver@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <YNbixBy+s4ca6PU+@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.818783799@infradead.org>
 <20210625093824.03eb3cf7@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625093824.03eb3cf7@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:38:24AM -0400, Steven Rostedt wrote:
> On Thu, 24 Jun 2021 11:41:02 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +static void add_call_dest(struct objtool_file *file, struct instruction *insn,
> > +			  struct symbol *dest, bool sibling)
> > +{
> > +	struct reloc *reloc = insn_reloc(file, insn);
> > +
> > +	insn->call_dest = dest;
> > +	if (!dest)
> > +		return;
> > +
> > +	if (insn->call_dest->static_call_tramp) {
> > +		list_add_tail(&insn->call_node,
> > +			      &file->static_call_list);
> > +	}
> > +
> > +	if (insn->sec->noinstr &&
> > +	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> > +		if (reloc) {
> > +			reloc->type = R_NONE;
> > +			elf_write_reloc(file->elf, reloc);
> > +		}
> > +
> > +		elf_write_insn(file->elf, insn->sec,
> > +			       insn->offset, insn->len,
> > +			       sibling ? arch_ret_insn(insn->len)
> > +			               : arch_nop_insn(insn->len));
> > +
> > +		insn->type = sibling ? INSN_RETURN : INSN_NOP;
> > +	}
> > +
> > +	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
> > +		if (sibling)
> > +			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
> 
> Have you ever triggered the above?

No, that would be really daft. But since this function is to be called
for both regular and tail calls, I figured I'd at least pretend to
handle the case.
