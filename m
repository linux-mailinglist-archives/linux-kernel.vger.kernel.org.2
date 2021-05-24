Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D414438E416
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhEXKek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhEXKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:34:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0BC061574;
        Mon, 24 May 2021 03:33:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a8so19202170ioa.12;
        Mon, 24 May 2021 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nBhj/2ZkPLyc9vfqldjnaDjPl5196Tg+6nl0Q2SX0RY=;
        b=kSc65os7x9Zx5XJ3IQbSw/NUXAYvevZqSCEIfScyObou6NNoxwmWEfF5S7aEK5AGPQ
         hIh2mQ+K3mHbCb6+mGVbt82NoZStaaNZIbe3ApU6RkGdti07YCS4WwCrsaTS5nILzDiw
         spzY66m0FYxNqJY2fvM0spesTNgEaUOD3ypyuo1VvQh48XukukDnBZBa0TjZj6ZuLSrm
         SwJC8WiQ5oii8MzKLcWj8Il0lUMjtdCzfi1FuGsWAJwQh1nRSjN5RzyEp+8s03PYFelo
         ydcwvXeStjXT7THo7VLVFSFGNZNAps2nO7ZcRsUUcdAxlyfRGyPl2sduCYGI8Qx2noo/
         +0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nBhj/2ZkPLyc9vfqldjnaDjPl5196Tg+6nl0Q2SX0RY=;
        b=d0H/e/y1hJ1QA7WYr4aHDFkLtWSZJNjKf6Ljz69FTvgfGpaeY+v70Md5Od8abZl6AC
         8380CkPnJTRHXUe0Qa/amXUltk0gUkX6px5d6TRqtV5K3XGxGAYB9iruFgtyl5Q31KqG
         gTTHhJo30kAt2rJziZPysXk+rUqjlDJxGqZJg+znLg6wf6kLWAlIOtOnvyI9bHlikssF
         TMfZ+d2SilfPwMhdivxayvkFOclovvpocG8/xKc4B/IkOmHiPb34S3xCNRLrEszm99uO
         FHw3nM9lup8J5czAw98lylwoJt+dZ0h76nKkge1wRhYIFQrOdA3Jfxtb69jgyAaWIWIz
         54uA==
X-Gm-Message-State: AOAM530IKk0k6YtnLGTA+Ums7ZvPXHSwVZ88cLAz8Hz26FR5KpyIa22n
        /Ue5WKdzsaHtAI8ghmeGVqc=
X-Google-Smtp-Source: ABdhPJy2XuBKUeWq1GgXBNi6IU8ZtkoeYQIPdl3LGDBc2ekJkJfKmF7vbn5/z4bEdumjLrgbKZ5Efg==
X-Received: by 2002:a6b:690c:: with SMTP id e12mr15202854ioc.69.1621852388720;
        Mon, 24 May 2021 03:33:08 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y202sm10751692iof.4.2021.05.24.03.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:33:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3927727C0054;
        Mon, 24 May 2021 06:33:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 24 May 2021 06:33:07 -0400
X-ME-Sender: <xms:4oCrYPDHb_jQaX74N7GSBI2L9bG4drxNdkuF29_CrRW9fnLBN_wZyA>
    <xme:4oCrYFjdb-6LfCKVNMs-z2qof7_PH8zw-6ZRNwCEnzMAVGZ-xmOvYTsBpmyzb1iJh
    HKR84ku1UAXiusCoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4oCrYKmm_lp3k8VQN8RE95HzBPw4NBTR9_vAGyUk4cSYlLxpuBA0tA>
    <xmx:4oCrYBw42P67_ENxefFMaju3BsdCy7cFcqNBvLQbJhDT7kKYTz6xFg>
    <xmx:4oCrYETQjAL5GkQ9Adp2aCotVA_9M7V0ZNJ2rEQ28y-JEW732l1-5g>
    <xmx:4oCrYJRta6i6jMtulkDEERsxnc6vgiAak3bhjNws5k-H8hIRFy-cKIJAVrY>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 06:33:05 -0400 (EDT)
Date:   Mon, 24 May 2021 18:32:30 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Waiman Long <llong@redhat.com>, Xiongwei Song <sxwjean@me.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
Message-ID: <YKuAvt3WXBVASuhY@boqun-archlinux>
References: <1621578594-13237-1-git-send-email-sxwjean@me.com>
 <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com>
 <CAEVVKH9nwPmQo8L-eRsWST+gPaJ73MSHZfJ-mM8qWvPaiejdrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH9nwPmQo8L-eRsWST+gPaJ73MSHZfJ-mM8qWvPaiejdrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 12:24:00PM +0800, Xiongwei Song wrote:
> On Fri, May 21, 2021 at 11:17 PM Waiman Long <llong@redhat.com> wrote:
> >
> > On 5/21/21 2:29 AM, Xiongwei Song wrote:
> > > From: Xiongwei Song <sxwjean@gmail.com>
> > >
> > > The block condition matrix is using 'E' as the writer noation here, so it
> > > would be better to use 'E' as the reminder rather than 'W'.
> > >
> > > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > > ---
> > >   Documentation/locking/lockdep-design.rst | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> > > index 9f3cfca..c3b923a 100644
> > > --- a/Documentation/locking/lockdep-design.rst
> > > +++ b/Documentation/locking/lockdep-design.rst
> > > @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
> > >       | R | Y | Y | N |
> > >       +---+---+---+---+
> > >
> > > -     (W: writers, r: non-recursive readers, R: recursive readers)
> > > +     (E: writers, r: non-recursive readers, R: recursive readers)
> > >
> > >
> > >   acquired recursively. Unlike non-recursive read locks, recursive read locks
> >
> > I would say it should be the other way around. Both W and E refer to the
> > same type of lockers. W emphasizes writer aspect of it and E for
> > exclusive. I think we should change the block condition matrix to use W
> > instead of E.
> 
> The doc uses 'E'  to describe dependency egdes too. Should we change them
> to 'W'? Personally,  both 'W' and 'E' are fine.
> 

I also think Waiman's suggestion is solid, there are two ways to
classify locks:

1.	W (Writers), R (Recursive Readers), r (Non-recursive Readers)

2.	E (Exclusive locks), S (Shared locks), R (Recursive Readers),
	N (Non-recursive locks)

And the relations between them are as follow:

	E = W
	R = R
	N = W \/ r
	S = R \/ r 

, where "\/" is the set union.

The story is that I used the way #1 at first, and later on realized way
#2 is better for BFS implementation, also for reasoning, so here came
this leftover..

If you are interested, go ahead sending a patch fixing this, otherwise,
I will fix this.

Regards,
Boqun

> Thanks,
> Xiongwei
> >
> > Cheers,
> > Longman
> >
