Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC64344BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 07:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJTFnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 01:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTFm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 01:42:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354BC06161C;
        Tue, 19 Oct 2021 22:40:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e144so23150328iof.3;
        Tue, 19 Oct 2021 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h3w11PLmztdGwQ0ZmbGQX6HIc5lAFNXxwT8B93XIC+Q=;
        b=FThkfrTYMDZwumWOtZGQF2nJFOrBSRmCaNDAdr3vHnRygu5Ynb6MC1ofMne1sW1fnK
         fKJQAmSn/85GwX5gCWL1kd8O5Y57oMEr1MbrNQq2Cnrd5k0N1C0Ql3B9Voba9xwa6y5g
         DRMyoHZvU1UKfenV1HNOeY6yBGvzmzSDCDRUWbGOGf+jhI0aDhO3sRPD1ml5kES9xssg
         cOEIBf7kI7+2Egq+C7zKzykecJNSmI9/gFX5yn8PHlHlW+irRw9ZJG4oPU6ns2POHc2X
         SKOO2uX3L2DPZrf+Zar7I21k2E+MpAINAiedsHGURolX8vWGMdhtOXhbcnRGn9IDVfsr
         Mkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h3w11PLmztdGwQ0ZmbGQX6HIc5lAFNXxwT8B93XIC+Q=;
        b=rCBpcGH5tobXhmt4szDkOtLZCB+foCDhCxC8zWx3bwGK0pQRhExYmVr5EhmvFHjqup
         jB07iQ2xD5qKwap8s3FVQF1JoFYsxwcfouJSx44XKbGDDSfXQlCXY6PJp/KkSnkZRZA/
         wCE+xM9DktwAYVTmMhn0lkaSp9WKZYowx2n4JZSLbLTrS+twlgFOm8Td/lGBh5cqjSwW
         w1X9Tn+5wNHxvvUxz+x/vt9ReQF78/U79Q5obiPK0Jd0+Rvs5Tnm9reHHph6WSvIkBO/
         In4aIzSOs+7x8zBC5ftAt0bN7KdR648PGzmJoUwW/E5+448rcAwzQAUQxUB/z5PPnQbd
         F/wg==
X-Gm-Message-State: AOAM533lg1miEYxSCxmNyMOWMh5X+0VWFDRHkYlnUztGAAEfLJpXiHSa
        T2KW4ZIaRm6pbCIWYMSpa3gqeMuPb9WmHg==
X-Google-Smtp-Source: ABdhPJwL1KMV5qn2UpGjSAscT7Qbmppwa0uJ1bYcnHvOTcYNW5GJAOfNBdCCLwt3yhipipUzocj9vw==
X-Received: by 2002:a02:6064:: with SMTP id d36mr7430202jaf.80.1634708445265;
        Tue, 19 Oct 2021 22:40:45 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u20sm621908ilb.2.2021.10.19.22.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 22:40:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 54FEC27C005A;
        Wed, 20 Oct 2021 01:40:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Oct 2021 01:40:43 -0400
X-ME-Sender: <xms:2qtvYcV7twVhaj35ylvI5pqnCEj1PGdnYPRoe1IXTfhTfXkXlQeSvg>
    <xme:2qtvYQnN5H_Vn9fcX5I-pAR1OYkGjZ2tt7znktQwpRrmRcOPLfBMC70DXu-hz1849
    R0gpY3WShaFB7q67Q>
X-ME-Received: <xmr:2qtvYQa7Tc7mmmwrnjlieZ-bI7xRmFXvg7mbLOr_RDk4AScRF8bc1tRH-FcZkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:2qtvYbVxi49V6WTCCDMR4eJnjFdSGm5ktPNhT1v6uWSByWm6cQmCWQ>
    <xmx:2qtvYWnMp2uVBDaELxDTK7ANyHqbNFOKxnbytn3k7OCjHRDQ0e9fXg>
    <xmx:2qtvYQf7ypf61RMrQUIvzThbbw94_jQXF-bBug5jfA-rVL08sCT9Rw>
    <xmx:26tvYbhpZAy7XrMH5y5j9f8kHgNGZfRUcJn2YzjFVZf9twC_zIFSQ4mlSi0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Oct 2021 01:40:42 -0400 (EDT)
Date:   Wed, 20 Oct 2021 13:40:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] workqueue: doc: Call out the non-reentrance conditions
Message-ID: <YW+rxfMof4QcGSrq@boqun-archlinux>
References: <20211018013117.256284-1-boqun.feng@gmail.com>
 <YW8EzNmq/bde5VTa@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW8EzNmq/bde5VTa@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 07:47:56AM -1000, Tejun Heo wrote:
> On Mon, Oct 18, 2021 at 09:31:17AM +0800, Boqun Feng wrote:
> > +Workqueue guarantees that a work item cannot be re-entrant if the following
> > +conditions hold after a work item gets queued:
> > +
> > +        1. The work function hasn't been changed.
> > +        2. No one queues the work item to another workqueue.
> > +        3. The work item hasn't been reinitiated.
> 
> Maybe phrasing it so that the above are the conditions defining a work item
> to be the same instance would be clearer?
> 

Hmm.. that would mean queue_work_on() may change the work item to
another instance? For example:

	struct work_struct w;

	INIT_WORK_ONSTACK(w, some_f);

	queue_work_on(&w, system_wq, 1); // queue a work and create
					 // an instance

	queue_work_on(&w, system_long_wq, 2); // queue the same work
					      // item but it means
					      // changing it to another
					      // instance.

Looks a little counter-intuitive to me, but let me try (combined with
Matthew's suggestion)

<in Guidelines section>

* A work item instance will not be processed by multiple workers at the
  same time, i.e. it's non-reentrant, so requeuing the same instance of
  a work item is safe and not racy.  Operations considered as changing
  the work item to a different instance are: 1) change the work
  function, 2) queue the work item to a different workqueue, or 3)
  reinitiate the work item.  The non-reentrance guarantee doesn't hold
  for different work item instances.

Regards,
Boqun

> Thanks.
> 
> -- 
> tejun
