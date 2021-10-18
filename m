Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713EB430E15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhJRDVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhJRDVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:21:44 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D0C06161C;
        Sun, 17 Oct 2021 20:19:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m20so14545357iol.4;
        Sun, 17 Oct 2021 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IT45eotjgiHjva+DxOhnrokvEdfb/gwjEwDU0MZ42pk=;
        b=OI5JiwqQGukSY3vsAefuH/jb/rP+t/WhUj3yegFxxHMpRPVhpFQonLy0nnuFWAH0Ol
         EsAGMt3RUArdMzGgisa2xrV0S9esqy/yljOyG03O2QIn9JLCCBt8ymaH4I+P7mJ2H5F1
         pA8pwqXN8WR1REV6SQFp9+IqY/XXi78sTJk8WfRn9iPDN0QYUErxrtrOZI79gaAEM4Ku
         g02CPEp8qZD5qgIe/tElJJiV7jYKbCMqWvlaWdpSFdz5ZrO7GcpKuvhp/JQSsjNSIoNn
         jU51eDteRQ63QZSyVmVABTBrotdJMf10n552GWtVZMMERAcrosXU3EblRG9CTNOosQB/
         +YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IT45eotjgiHjva+DxOhnrokvEdfb/gwjEwDU0MZ42pk=;
        b=Uq7Mi55ftLBCtJWaTWD/XANvSHRdrWxNlu14fcqBnYH1d1tIgHaXOLkwpp4WwVkDw1
         7p9+sMNOeaQLaItd2A3cFRFDB7bIUk39CQ/CQc3tdXr6LBelmSe86Jai697/geVrDmPB
         Z7roGlUJ/knqh5UIhIOmQdKqpe5tra8X0hIzV2JWqBQqz1n6vqrreVmdefOcPkwNoYlK
         uP4UsPWDpG+dKKrlRBjYgY3sa0ypB7Cy4SbiHsZ6V8z0paUJyIZ4QHTcw3eUDp8hlVmb
         ijFoUmE/rQGPbs3F4Nd8WgkjWNRoLk6eILZYBTkHkgrork3gpoYvXLFijubJa3PbLl1Q
         //+A==
X-Gm-Message-State: AOAM533uMVtUspit2qSHbZOGRfCwERVqon+YKjBJIxTu3odOtDkGoEgf
        5LWgpziWRKvtKu3L7hPOWd0cLjdfLPE=
X-Google-Smtp-Source: ABdhPJxuF+e8/yKhUZ7nPlRa3HAeDRJHFbFY/h24aCZpIG/EYQGYyoxgLqmkQA9L0vO7JS9mNsE/Pg==
X-Received: by 2002:a02:2b06:: with SMTP id h6mr16656318jaa.144.1634527172781;
        Sun, 17 Oct 2021 20:19:32 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y11sm6302926ior.4.2021.10.17.20.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 20:19:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id C33D427C0054;
        Sun, 17 Oct 2021 23:19:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 17 Oct 2021 23:19:30 -0400
X-ME-Sender: <xms:wedsYUJVUvlDwRoQnuJjfPVavaNXRFy2rgzF30h0YJf03cXrIM7AZg>
    <xme:wedsYUK1dT1AdONv-ODmyDg1NInl0XsarBre_F01kaK-PkxVh2lqD9ZzBA1hQ8UlZ
    uZmuKtjMwO0MViY3Q>
X-ME-Received: <xmr:wedsYUvRLzhQtAHXwXR5K6ex3IJfXuEsR-h3ECOzmfoI41vxbT3Viiw3upBFsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduledgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:wedsYRbrbCLt1BLtgRobKEp9EC81GxnnNWMIeEe0zEWMAmbEyRv2BQ>
    <xmx:wedsYbagIYxIwzdaVXGkBjvYBEiuNHDLQCUs1VixQCTgjxc-uODXsQ>
    <xmx:wedsYdCNY13ODy-mfJ9WMaRsFxKzthbNIUmTCHFsjk3QWfwEU-ivGQ>
    <xmx:wudsYVn9inr_gyRcQbzYyJbGCra8uvrLyK7cEAbFVjg1vrd3pfJndxoTGys>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Oct 2021 23:19:29 -0400 (EDT)
Date:   Mon, 18 Oct 2021 11:19:14 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] workqueue: doc: Call out the non-reentrance conditions
Message-ID: <YWznsr6qnCpErKJi@boqun-archlinux>
References: <20211018013117.256284-1-boqun.feng@gmail.com>
 <YWzZUZILdhAGba8I@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWzZUZILdhAGba8I@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 03:17:53AM +0100, Matthew Wilcox wrote:
> On Mon, Oct 18, 2021 at 09:31:17AM +0800, Boqun Feng wrote:
> > @@ -391,6 +387,23 @@ the stack trace of the offending worker thread. ::
> >  The work item's function should be trivially visible in the stack
> >  trace.
> >  
> > +Non-reentrance Conditions
> > +=========================
> > +
> > +Workqueue guarantees that a work item cannot be re-entrant if the following
> > +conditions hold after a work item gets queued:
> > +
> > +        1. The work function hasn't been changed.
> > +        2. No one queues the work item to another workqueue.
> > +        3. The work item hasn't been reinitiated.
> > +
> > +In other words, if the above conditions hold, the work item is guaranteed to be
> > +executed by at most one worker system-wide at any given time.
> > +
> > +Note that requeuing the work item (to the same queue) in the self function
> > +doesn't break these conditions, so it's safe to do. Otherwise, caution is
> > +required when breaking the conditions inside a work function.
> > +
> 
> I'd like to suggest that this be added to the Guidelines section

Good idea, Guidelines section is a better place to put these, since it's
for users.

> instead:
> 
> * A work item will not normally be processed on multiple CPUs at the

Precisely speaking, it should be "by mutliple workers" instead of "on
multiple CPUs", because two workers of tw unbound workqueue may process
the same work item on the same CPU, and that's problematic since
processing work is preemptible.

>   same time.  It can happen if the work function is changed, the work
>   item is queued to multiple queues or the work function is
>   reinitialised after being queued.

I end up with something like below, I still want to keep the keyword
"reentrant" for searching, because sometimes one may forget this
particular aspect after reading the whole doc for a while, the keyword
can help locate the lines faster (Ok, the fact is that "one" was me
;-)).

* A work item will not normally be processed by multiple workers at the
  same time, i.e. it's non-reentrant.  However it can happen if the work
  function is changed, the work item is queued to multiple queues or the
  work item is reinitialised after being queued.

Thoughts? Thank for the suggestion!

Regards,
Boqun
