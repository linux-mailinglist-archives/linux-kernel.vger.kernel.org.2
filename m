Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8D382353
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 06:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhEQEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 00:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhEQEXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 00:23:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD7C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:21:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k19so4024600qta.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xb34FPi7cF+OIAodLJ7j5vSLf2bUONJcOXJTLDUg2DQ=;
        b=L147CuVkKjMBD7J166MsIYSxw529dKPyYMY7ugJ3qWBdZ2qIymXujkiALbmh7tnLhj
         OXJfCvIzd84Xvd/PLwE+i8XdnbJJ1Z89FUv9O60njnVgg74EUtcy7CH7YY+HSiU+n03t
         XiONVlF13nxWS08ShdXeVm1uR6zYEXsygsoJ2vVNWouVkxxKuPMPGvQpRMQCGynTnLfu
         Q09Kt4HRIxAfVpw5uRNozCNO7+zU2wYmsIak9PYKatqqjjRpOksNe1aWD5ryAUrJ6kP8
         K2Mgm2hteErUgv6cciq0qwvlV6ZMH4D1FobR7ZMQlymiwt1pmisEXGuO2LgcD+vBX7J2
         TJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xb34FPi7cF+OIAodLJ7j5vSLf2bUONJcOXJTLDUg2DQ=;
        b=WkUtOETFc5fyqp+2KdHcwclcEOj+qH+4Kgm1XzNMY52DVgIZD4mf1dQ6Bjfcr2KNwZ
         O5i3JdaeblBgcMZcsg1jVlsBlW4NVY3iRS6LAXfYWpw64dPG8i4CE9Xws5QiAlsBhqmi
         vlZkMJU7ApvkEyddfsApU01kctflqtAyQv70Lv2IWSMKdJxROdD0eafM+pRClrN7XZZ8
         0hHxlNfEmWDV69PjmaRqB+PFJOir+ux7Vyz+3/hJ727ozFipH3dU5V0P9rfUqypcPNOG
         yKfG5YkiW+7hWxfeEWcexfsWuN8Oit3UToeVr1dmpzD6fi6MsJZOPpaLgQxMY49VQYcI
         UhWw==
X-Gm-Message-State: AOAM530uG6HJtVhcPkXDuB7x2jAe3KxU9Htmyphe8I1v30v6lZlnv6cW
        tfCpkuD/o+/gTdk5ZihAM4o=
X-Google-Smtp-Source: ABdhPJxAdHYHFd7qXInHiMe8WY3p9PZI6QxmJZLk1pf7cmJIVJK5XwXbPQX6iECVZxniAP9PLl/QdA==
X-Received: by 2002:ac8:5dce:: with SMTP id e14mr17669292qtx.183.1621225315947;
        Sun, 16 May 2021 21:21:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n15sm9687358qti.51.2021.05.16.21.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 21:21:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A17B927C0054;
        Mon, 17 May 2021 00:21:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 May 2021 00:21:54 -0400
X-ME-Sender: <xms:Ye-hYNXfaSYBGImgxmvdDWAsF9ad9YHnfjOH7gFY-RIV4oKf10ia7Q>
    <xme:Ye-hYNnHf9Aw-S6b2o8qy0djQMoR3r-j6D0dueqeG3iMAHRVbzTS3wj-fsPxq28J6
    v_8AKRxnv-IgpjZlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeigedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepleetkefhgfehveetveettdetleefveehveefuefgleevtdfgteegkedvgeet
    ieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhkmhhlrdhorhhgnecukfhppe
    dufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhm
    rghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ye-hYJZlYfUmHZSi32KW5XtSSykfnwYdol4EvtcHv6lvVYRpcb3Tzw>
    <xmx:Ye-hYAVx6PqPKTyNCDMZz6XVoowaQ6u2hrdGDxh2WCT0lFHL9ZXCdg>
    <xmx:Ye-hYHlhYm3X0PP4tgIa91y0PzUtVZ1k96IJ2wNc_o8L9jCPWto_5g>
    <xmx:Yu-hYCsjAa0df9TOt5sJee5tLqHY5u5PdMWVd7EIhTiSXKjdCdsvw7WFrzk>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 17 May 2021 00:21:53 -0400 (EDT)
Date:   Mon, 17 May 2021 12:21:38 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Silencing false lockdep warning related to seq lock
Message-ID: <YKHvUkxpytzSewEC@boqun-archlinux>
References: <CAJWu+orW9PA7m_s5LHhQv-bEO0xFq7n+9-fznd79boKkmQUR6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+orW9PA7m_s5LHhQv-bEO0xFq7n+9-fznd79boKkmQUR6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 14, 2021 at 10:52:31AM -0400, Joel Fernandes wrote:
> Hi Boqun,
> You might have worked on such issues so I thought you're a good person to ask.
> 
> After apply Laurent's SPF patchset [1] , we're facing a large number
> of (seemingly false positive) lockdep reports which are related to
> circular dependencies with seq locks.
> 
>  lock(A); write_seqcount(B)
>   vs.
> write_seqcount(B); lock(A)
> 

Two questions here:

*	Could you provide the lockdep splats you saw? I wonder whether
	it's similar to the one mentioned in patch #9[1].

*	What keeps write_seqcount(vm_seqcount) serialized? If it's only
	one lock that serializes the writers, we probably can make it
	as the nest_lock argument for seqcount_acquire(), and that will
	help prevent the false positives.

Regards,
Boqun

[1]: https://lore.kernel.org/lkml/20190416134522.17540-10-ldufour@linux.ibm.com/

> This cannot deadlock obviously. My current strategy which I hate is to
> make it a raw seqcount write which bypasses lockdep. That's horrible
> for obvious reasons. Do you have any tricks/patches up your sleeve to
> silence these?
> 
> I suppose we still want to catch lockdep issues of the form (which
> peterz chatted to me about):
> 
>  lock(A); write_seqcount(B)
>   vs.
> read_seqcount(B); lock(A)
> 
> which seems like it can deadlock.
> 
> I would rather make lockdep useful to catch these and not miss out on
> them. Let me know what you think?
> 
> Cheers,
> -Joel
> 
> [1] https://lkml.org/lkml/2019/4/16/615
