Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC83B8F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhGAI4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:56:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbhGAI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:56:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42A071FF89;
        Thu,  1 Jul 2021 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625129633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vF2/tUeigGHShFzpwWnyhn7/519y4b+MZEDcnfKWyk=;
        b=pdygm30JjyW50AuQxLQcCxCaOpXnX4AjOkPrbJ9da+LTne0nA5V6Oz1jLu190Ts5Lb5sfr
        JFd4zb2WCDpobzmi/45XdD0NPpI82fhdcyS013gH61nrBl6HJOlNgHsa7ZShOt6s4o2jIC
        GuSHsiw/jOANYSvOIl246jzKverxMSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625129633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vF2/tUeigGHShFzpwWnyhn7/519y4b+MZEDcnfKWyk=;
        b=PkBX/Ues/1hYa+jmjKAaV0aZ5hZsURjYXGu8azsVVDc7WquohTQCfDL6UvHwZEeVI4zKks
        Zwd0MfALwYXmR4AQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3C2FA3B8A;
        Thu,  1 Jul 2021 08:53:52 +0000 (UTC)
Date:   Thu, 1 Jul 2021 10:53:52 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
In-Reply-To: <YN1+VkWmKyIk4zlo@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2107011041240.3003@pobox.suse.cz>
References: <20210624094059.886075998@infradead.org> <20210624095147.756759107@infradead.org> <alpine.LSU.2.21.2106301431120.32505@pobox.suse.cz> <YN1+VkWmKyIk4zlo@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +++ b/tools/objtool/orc_gen.c
> > > @@ -13,13 +13,19 @@
> > >  #include <objtool/warn.h>
> > >  #include <objtool/endianness.h>
> > >  
> > > -static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
> > > +static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
> > > +			  struct instruction *insn)
> > >  {
> > > -	struct instruction *insn = container_of(cfi, struct instruction, cfi);
> > >  	struct cfi_reg *bp = &cfi->regs[CFI_BP];
> > >  
> > >  	memset(orc, 0, sizeof(*orc));
> > >  
> > > +	if (!cfi) {
> > > +		orc->end = 0;
> > > +		orc->sp_reg = ORC_REG_UNDEFINED;
> > > +		return 0;
> > > +	}
> > > +
> > 
> > This looks strange. You access cfi a couple of lines earlier (bp cfi_reg 
> > initialization).
> 
> That's a relative address compute, it doesn't actually dereference the
> pointer.

Right, I misread the line.
 
> > Is it even possible to have cfi == NULL here? The second call site below 
> > has a check and the first one should not happen (insn->cfip should be 
> > always set if I am not missing something).
> 
> I can happen for instructions that are not visited, like NOP fillers
> between functions. Remove the check and try to build a file :-)

Doh, I should have done that. Of course there must be unvisited 
instructions. Sorry for the noise.

Miroslav
