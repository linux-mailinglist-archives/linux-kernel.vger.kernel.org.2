Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2A3446BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCVOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCVOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:07:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qxtJ7diB0tR2FAXTes+upzfZuzt5kGzcUNJOQzpCjwI=; b=Vaqaqmc4Oh0L8c6SRLKnmG2hZB
        bcUQ3jq8ELCIqU7R4nwon3ggrKdW2xQT482xV7pRMyvT4YDNEnTVEniyJ6eIuS0bYDjUXrPcl9uy8
        jzkZVEm7UyE77l62KGbK/a5APvaA5fkanjbZnmHsAqwoKH4IThr+2qafXskEZBMgYdPq8j+/ltG9N
        K+EX1gkLpYut/dxZZfmd8Ikt1JtPMHgCVaqaMfcsBpa9ab7piNwCgoiE1Ia0AvTFrcus67/Z08Y+i
        sKp8oWtQ00Ycx1EfGnCix8GFcde8nLTcewwJfbJETfgCB5Tuql7XMJA79WcaVA7lRulKD2198chvo
        d0Hrm3Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOLCY-008c70-AI; Mon, 22 Mar 2021 14:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24CC53003E1;
        Mon, 22 Mar 2021 15:06:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03C532BE591E5; Mon, 22 Mar 2021 15:06:36 +0100 (CET)
Date:   Mon, 22 Mar 2021 15:06:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFikbJfytBSqBPDU@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
 <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
 <20210319140005.7ececb11@gandalf.local.home>
 <YFiWqvEsswDHBDPX@gunter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFiWqvEsswDHBDPX@gunter>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:07:54PM +0100, Jessica Yu wrote:
> +++ Steven Rostedt [19/03/21 14:00 -0400]:
> > On Fri, 19 Mar 2021 13:57:38 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Jessica, can you explain how !MODULE_UNLOAD is supposed to work?
> > > Alternatives, jump_labels and static_call all can have relocations into
> > > __exit code. Not loading it at all would be BAD.
> > 
> > According to the description:
> > 
> > " Without this option you will not be able to unload any
> >  modules (note that some modules may not be unloadable anyway), which
> >  makes your kernel smaller, faster and simpler.
> >  If unsure, say Y."
> > 
> > Seems there's no reason to load the "exit" portion, as that's what makes it
> > "smaller".
> 
> Exactly. If you disable MODULE_UNLOAD, then you don't intend to ever
> unload any modules, and so you'll never end up calling the module's
> cleanup/exit function. That code would basically be never used, so
> that's why it's not loaded in the first place.

As explained, that's broken. Has always been for as long as we've had
alternatives.
