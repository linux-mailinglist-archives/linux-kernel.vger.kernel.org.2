Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4933F25A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCQOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:14:10 -0400
Received: from casper.infradead.org ([90.155.50.34]:37716 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhCQOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hwo4fRcceoA7yasnPeqHWHouraSshHS/o6zBtOBTCtA=; b=HQrsqbtyMKl/YbC6XqqfsXd7sM
        HpS5ZPLrdC2PuvWTW2Ff+9pR1Im2A/PaF5GQJl5jh13T7MPdHWHRuBVgeT1CTrsDQ9skv5WuH7Y8I
        MM/0sKgA3wT8cfSqvok42ZMv1422s0IqJHYH6VwpBR+nR35ZmKqfb8+x5+eOh8QMzsUHmgAZeODUv
        vTU5mCx6/5NztU3Ryt8hYJjaLqNOMcRp29z9Jcv5rUfU8f8hkMC7f+y+A8TboH9gFf4wVW0m5VO2c
        uoEBeBXVGytKhtbLFmnPlAdAfzm7YNL8oxopsjUMIhyXFaW1CEPHpPwZqWQWouLfRG+gEviXYr6ak
        NEX9huVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMWvg-001Y4s-Nj; Wed, 17 Mar 2021 14:13:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC699300130;
        Wed, 17 Mar 2021 15:13:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9478203D90D0; Wed, 17 Mar 2021 15:13:43 +0100 (CET)
Date:   Wed, 17 Mar 2021 15:13:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
Message-ID: <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.710872453@infradead.org>
 <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:52:23PM +0100, Miroslav Benes wrote:

> > +	if (!elf_symbol_add(elf, sym, SHN_XINDEX)) {
> > +		WARN("elf_symbol_add");
> > +		return NULL;
> > +	}
> 
> SHN_XINDEX means that the extended section index is used. Above you seem 
> to use it in the opposite sense too (assigning to shndx when shndx_data is 
> NULL). While it makes the code easier to handle, it is a bit confusing 
> (and maybe I am just confused now). Could you add a comment about that, 
> please? elf_symbol_add() seems like a good place.

Yes, that was a horrible thing to do :/ And you understood it right.

Looking at it again, I'm not sure it is actually correct tho; shouldn't
elf_create_undef_symbol() also look at gelf_getsymshndx() of symtab ?

What toolchain generates these extended sections and how? That is, how
do I test this crud..


