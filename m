Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A932078D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBTWz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhBTWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 17:54:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436A2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 14:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJ01E2gMnBxCtj7F8Ii7el3nVdfMhpvlABpO5v8Qf1s=; b=DBmd/JBVcvHyHemZQVUA3TdpkY
        fvmXq51ieI9wzHnM/dcGMlOSBCZnDuofxQ2DEi8iAmXYyh6dlX6atP78qH7Lq3ecI28eZb62jVl3k
        QuE0KSuRzVH4cs2ls6F63R9oDl7WsHp9J/n1H9tHSvOgDwlrchU6DGBsTUB7Bhq7fRj9DFdUmi+Ps
        n1rrwQrlDiMxRKwYrgjZtRzBPJmsPVXwv8OFvJxdoKDS3/Y0xJ0OJ2txxEs2V7Zr+U2iOjCakwGx4
        iGFQD/M/RN3/Ui/ZuL2Fsbfe9KxsH0iFeqBMwgTdWpV31eJgaw99QMS7V0NMGCNlDnqid/RPD2TwR
        xwFHj45Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lDb5a-004Ydo-BG; Sat, 20 Feb 2021 22:51:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032219864D6; Sat, 20 Feb 2021 23:51:00 +0100 (CET)
Date:   Sat, 20 Feb 2021 23:51:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210220225100.GA5208@worktop.programming.kicks-ass.net>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
 <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
 <20210220174101.GA29905@zn.tnic>
 <20210220222802.GA4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220222802.GA4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 11:28:02PM +0100, Peter Zijlstra wrote:
> On Sat, Feb 20, 2021 at 06:41:01PM +0100, Borislav Petkov wrote:
> > >  - I have more cases for objtool to rewrite code (I'll see if I can
> > >    rebase and post that this weekend -- no promises).
> > 
> > Oh noes.
> 
> 11 patches and one beer later, it even boots :-)
> 
> Saves more than 6k on a defconfig build.
> 
> I'll push it out to git in a bit.

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=locking/jump_label
