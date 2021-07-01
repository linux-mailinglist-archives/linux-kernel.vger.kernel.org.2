Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450933B8EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhGAIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhGAIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:40:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9204C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cQxlyDyxtoCEWGuybJ1x4hTTLxLUG1+K49GP1+7l/+A=; b=t03GmX2BZXb9vtQsXAjJ0CdKDr
        Niwi+XcSad/2+ruHEHweZ0BaprBbEoV7Ae/jxcond7wXRFiN6budo2YRup18ACBK4HCEIEXBi540I
        7mFa2/6Js8mWof8n87TLcUh6nG60CrDPLm9bGbOc9zpcc/CbuHHwVM8FSmgiCxV//E3JnloSFzd4l
        txR5q173wBDr/w74g8+WWtv07YpM5gqr3APaDg/mFkYI3ccnLz9gw4hWqQfv0qCJrT5PqqTPQasJ9
        8RZtoGQIMGSHUaAhp3l6uuyt8fbCo0vuOwvZboIfTIoly8hDicjcVtVWPfSMtaLx4+GLW5dsTn9RX
        XZAtYqrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lysAa-006Lkw-KC; Thu, 01 Jul 2021 08:35:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67C7C3001DC;
        Thu,  1 Jul 2021 10:35:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22ABE2041E842; Thu,  1 Jul 2021 10:35:34 +0200 (CEST)
Date:   Thu, 1 Jul 2021 10:35:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
Message-ID: <YN1+VkWmKyIk4zlo@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.756759107@infradead.org>
 <alpine.LSU.2.21.2106301431120.32505@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2106301431120.32505@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 02:45:57PM +0200, Miroslav Benes wrote:
> > @@ -2725,15 +2820,24 @@ static int validate_branch(struct objtoo
> >  
> >  			if (insn->visited & visited)
> >  				return 0;
> > -		}
> > +		} else
> > +			nr_visited++;
> 
> just a coding style
> 
> 	} else {
> 		nr_visited++;
> 	}
> 
> > @@ -3192,6 +3304,13 @@ int check(struct objtool_file *file)
> >  		warnings += ret;
> >  	}
> >  
> > +	if (stats) {
> > +		printf("nr_visited: %ld\n", nr_visited);
> 
> Could we make this nr_insns_visited?

Both done.

> > +		printf("nr_cfi: %ld\n", nr_cfi);
> > +		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
> > +		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
> > +	}
> > +
> > +++ b/tools/objtool/orc_gen.c
> > @@ -13,13 +13,19 @@
> >  #include <objtool/warn.h>
> >  #include <objtool/endianness.h>
> >  
> > -static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
> > +static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
> > +			  struct instruction *insn)
> >  {
> > -	struct instruction *insn = container_of(cfi, struct instruction, cfi);
> >  	struct cfi_reg *bp = &cfi->regs[CFI_BP];
> >  
> >  	memset(orc, 0, sizeof(*orc));
> >  
> > +	if (!cfi) {
> > +		orc->end = 0;
> > +		orc->sp_reg = ORC_REG_UNDEFINED;
> > +		return 0;
> > +	}
> > +
> 
> This looks strange. You access cfi a couple of lines earlier (bp cfi_reg 
> initialization).

That's a relative address compute, it doesn't actually dereference the
pointer.

> Is it even possible to have cfi == NULL here? The second call site below 
> has a check and the first one should not happen (insn->cfip should be 
> always set if I am not missing something).

I can happen for instructions that are not visited, like NOP fillers
between functions. Remove the check and try to build a file :-)
