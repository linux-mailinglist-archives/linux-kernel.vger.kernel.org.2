Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA223E0129
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhHDM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhHDM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:28:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDCC0613D5;
        Wed,  4 Aug 2021 05:27:53 -0700 (PDT)
Date:   Wed, 4 Aug 2021 14:27:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628080071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wge5H3ohVu9KXZ7XjLIwa/xxD3n3Ba0yHl81R3u0frA=;
        b=MOh7k18uhCf+MgMnNnUIHRYL5O8XUW5VqzJ8lNWxFnJN11YbJBaMGSiiJwiCA7o2e30sLR
        tMR69cRX1CZL312mDITZuGx/j8EoB14c8PMB1CO23kblozN06AcR0ZcrX070tuTy5ud9Yf
        mBpAhZBtCLZPK/PVHMNm+gmaevz9hSkwZJzDZATZBx0mv03/6Xr9RkKxgFG7fjXY+c6Pf0
        HdY0YO2EXNi7hsUUCgGDtCgp+vLzWJBjNub6RZMcL2oWDYfBJsWLlhBoNGGywF2apsxaA1
        RU3kqSRbChkznr23W6u8imITLNQRX8DLD7oNo4lamfiwfZPz9IgfywWMW+Dr2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628080071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wge5H3ohVu9KXZ7XjLIwa/xxD3n3Ba0yHl81R3u0frA=;
        b=HLf7HfrLeP6rzmVeqro9DbhiKXsH2RvNuNcn93Kb8lcfxBtaEasCaOEARSTvn1rz4bR8UB
        EI1HBnpOqGOg7oDQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 17/17] libtracefs: Add man page for tracefs_sql()
Message-ID: <YQqHxQ5XH/ZN5yUq@lx-t490>
References: <20210730221824.595597-1-rostedt@goodmis.org>
 <20210730221824.595597-18-rostedt@goodmis.org>
 <YQakDYRnId+bK+ue@lx-t490>
 <20210801182916.689a84a8@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801182916.689a84a8@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021, Steven Rostedt wrote:
> On Sun, 1 Aug 2021 15:39:25 +0200
> "Ahmed S. Darwish" <a.darwish@linutronix.de> wrote:
>
> > On Fri, Jul 30, 2021, Steven Rostedt wrote:
> > > +
> > > +The SQL format is as follows:
> > > +
> > > +*SELECT* <fields> FROM <start-event> JOIN <end-event> ON <matching-fields> WHERE <filter>
> > > +
> > > +Note, although the examples show the SQL commands in uppercase, they are not required to
> > > +be so. That is, you can use "SELECT" or "select" or "sElEct".
> > > +
> >
> > Maybe it would be helpful to mention that, unlike normal SELECT queries,
> > the JOIN and ON parts above are _not_ optional?
> >
> > That is, generic "one event source" queries:
> >
> >   SELECT common_pid,msr,val FROM write_msr WHERE msr=72
> >
> > are not supported. (I wish they were though ;-))
>
> Actually, the sql parser should support it, but it will fail on the
> creation of events. That's because I started trying to make this create
> normal histograms. The problem is, that it can't really do a 1 to 1 on
> histograms and selects, so I gave up. But perhaps for the subset it can
> create, maybe I can still have it do so. That may require changing the
> API slightly.
>
> I'm not a big SQL person, so I don't know all the magic and I have no
> idea how to add the "values" part of the hist trigger.
>

Thanks! I've replied at the v2 thread.

(Discovered after-the-fact that a v3 was already sent, sorry..)

--
Ahmed S. Darwish
Linutronix GmbH
