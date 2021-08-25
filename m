Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7343F7563
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbhHYMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhHYMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:51:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1393C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fvPUxBqSyA0eWk5r01Jg4i3YeX4mhHz1yFpSpJ4vuBY=; b=n+9S4+dal3uqeljvdJY8Gk5UEJ
        BvDgVR7jZCVkRvQBr4/BEAVvUZGrpo20wQS7Mns7EbWdtYkLp7kUtmCdmd/MI5oj5v7jjTTGwXJEw
        w7H3Q6LyCcBpllDujIfrdDizjsnlIFkoMJNCNaCtXkzUxYh/Ci6nJIBFvz8Y45YOedNAf2actzx98
        /0fTT0QVvSxCMnw/u+4UCINMigLCsZPV467TxUKguwgTH8UrfUhf7Jspv3Xwuzw5S4cXfNikSAbZ0
        tidBazEuFvsfAEEhelEIwJ86GlLA0EuPTp4Ukt+RhkRDkGWlx06gk1JOUX1xQWyFqJ2MZ5dAZak7J
        03jseKjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIsLH-00CIxE-0W; Wed, 25 Aug 2021 12:49:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65AA33005AD;
        Wed, 25 Aug 2021 14:49:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 420AD21A9ACC4; Wed, 25 Aug 2021 14:49:17 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:49:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
Message-ID: <YSY8TQMTo5Pord78@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.756759107@infradead.org>
 <20210820222755.sqtlzframoz7k5cb@treble>
 <YSYX18wjVceB2iPJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSYX18wjVceB2iPJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:13:43PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 20, 2021 at 03:27:55PM -0700, Josh Poimboeuf wrote:
> > > +static struct cfi_state *cfi_alloc(void)
> > > +{
> > > +	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
> > > +	if (!cfi) {
> > > +		WARN("calloc failed");
> > > +		exit(1);
> > > +	}
> > > +	nr_cfi++;
> > > +	init_cfi_state(cfi);
> > > +	return cfi;
> > > +}
> > 
> > I'm thinking this should also add it to the hash.  i.e. I don't think
> > there's a scenario where you'd alloc a cfi and not want to add it to the
> > hash.  The more sharing the better.
> 

> @@ -1666,9 +1666,8 @@ static int read_unwind_hints(struct objt
>  			continue;
>  		}
>  
> -		cfi = insn->cfip;
> -		if (!cfi)
> -			cfi = insn->cfip = cfi_alloc();

Urgh, the problem is that this runs before we allocate the hash-table!
Lemme try and re-order thing.
