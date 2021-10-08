Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107D426759
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbhJHKGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbhJHKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D778C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iMx07sxMhcPwXYjQoP0WkUCRraloIW2C9/p6HTD4Uco=; b=kX+PwXRCRCJjrA9HJ7DimYvXV7
        f+rHZ9IUuGSEQIiN55vscPNTdEkdozs9qJji1GUdWzmjp+mA/ZBmGZMdWcLkDdV9V1Nqq3IXki1RB
        I7jzC4TMhhbrOLNX3EuZTkBsQnGzC0Vem3qVdeg9TAs/3FbgstTnuwandrEjTWkaJ8RmSJzGzAGrX
        0abWrEaN3/Wq2CXI3U3JSKUBhXvLIMIZX1oA+C65mOpyBF1nxJ6BrvxUCkuk0q04I8CvcXGgkRgAv
        wdGauWeh0oXorfP3vMXx1R7FzkirHIUfQBLITHrPuELrBI65lrhhCEKSIo2lucLtLvzDEO2Kkx0GC
        8OPSc7jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYmiy-002yae-GI; Fri, 08 Oct 2021 10:03:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0479F300347;
        Fri,  8 Oct 2021 12:03:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD5B42CFD3AED; Fri,  8 Oct 2021 12:03:31 +0200 (CEST)
Date:   Fri, 8 Oct 2021 12:03:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 1/2] objtool: Optimize re-writing jump_label
Message-ID: <YWAXc2bhu/iTI4pv@hirez.programming.kicks-ass.net>
References: <20211007212211.366874577@infradead.org>
 <20211007212626.950220936@infradead.org>
 <20211008065550.zge5zkbfrki5osv2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008065550.zge5zkbfrki5osv2@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:55:50PM -0700, Josh Poimboeuf wrote:
> On Thu, Oct 07, 2021 at 11:22:12PM +0200, Peter Zijlstra wrote:
> > There's no point to re-write the jump_label NOP when it's already a NOP.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/check.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -1397,7 +1397,7 @@ static int handle_jump_alt(struct objtoo
> >  		return -1;
> >  	}
> >  
> > -	if (special_alt->key_addend & 2) {
> > +	if ((special_alt->key_addend & 2) && orig_insn->type != INSN_NOP) {
> >  		struct reloc *reloc = insn_reloc(file, orig_insn);
> >  
> >  		if (reloc) {
> 
> While you're at it, a comment would be very helpful for that whole
> clause.

Like so?

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1397,7 +1397,16 @@ static int handle_jump_alt(struct objtoo
 		return -1;
 	}
 
-	if (special_alt->key_addend & 2) {
+	/*
+	 * When, for whatever reason, the jump-label site cannot emit a right
+	 * sized NOP, then it can use Bit-1 of the struct static_key pointer to
+	 * indicate this instruction should be NOP'ed by objtool.
+	 *
+	 * Also see arch/x86/include/asm/jump_label.h:arch_static_branch(),
+	 * where we leave the assembler to pick between jmp.d8 and jmp.d32
+	 * based on destination offset.
+	 */
+	if ((special_alt->key_addend & 2) && orig_insn->type != INSN_NOP) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
