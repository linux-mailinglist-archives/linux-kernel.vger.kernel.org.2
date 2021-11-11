Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDAB44D331
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhKKIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhKKIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:31:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79790C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P5R7U2/6VD+fOZHpIxquns80hKyNWlKs9N6UR30rQqk=; b=dgSZzJqA/SC6c62EYopPYT+w+m
        xBxkZTz9DimSbwGfiFOOOuXTstnt3BAk94EJrdSh1KLjrq64M0J/QAhrG8VxwCnt+jbMu4SjaWIwA
        HxzTjFfJNRkAw06WH2GyHiOJfN1PJppNLqZKJgxP5T9hT71bIGEkoaTPq5FD4rqs8lal8lKk6wDRb
        3wC5mT493RdRihbfuwHB7GZ/R5IgfcHKyIgA/a2rCJXnEQXey73EtLYrekzsRMcZB9StDunX9+cQS
        EKIEDbkXyjkJtIXn1nVjfmqe8dPIIoKQTTy+5H69haNFKP/so/YdgXN7AIgQwbHpn5KGeDFmqXKvy
        HtA/tDAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ml5RQ-002ZSq-Lr; Thu, 11 Nov 2021 08:28:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D9073000DD;
        Thu, 11 Nov 2021 09:28:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 221F12133E6FD; Thu, 11 Nov 2021 09:28:16 +0100 (CET)
Date:   Thu, 11 Nov 2021 09:28:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH v2 20/23] x86,usercopy: Remove .fixup usage
Message-ID: <YYzUIPxguCTuYKqL@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101326.081701085@infradead.org>
 <20211111075143.td3fickblsvl3hau@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111075143.td3fickblsvl3hau@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:51:43PM -0800, Josh Poimboeuf wrote:
> On Wed, Nov 10, 2021 at 11:01:22AM +0100, Peter Zijlstra wrote:
> > +static bool ex_handler_ucopy_leng(const struct exception_table_entry *fixup,
> > +				   struct pt_regs *regs, int trapnr, int reg, int imm)
> > +{
> > +	regs->cx = imm * regs->cx + *pt_regs_nr(regs, reg);
> > +	return ex_handler_uaccess(fixup, regs, trapnr);
> > +}
> > +
> >  int ex_get_fixup_type(unsigned long ip)
> >  {
> >  	const struct exception_table_entry *e = search_exception_tables(ip);
> > @@ -217,6 +224,8 @@ int fixup_exception(struct pt_regs *regs
> >  		return ex_handler_imm_reg(e, regs, reg, imm);
> >  	case EX_TYPE_FAULT_SGX:
> >  		return ex_handler_sgx(e, regs, trapnr);
> > +	case EX_TYPE_UCOPY_LEN:
> > +		return ex_handler_ucopy_leng(e, regs, trapnr, reg, imm);
> 
> "leng"?

OMG, I really should just take a break or something :/ I'll go fix.
