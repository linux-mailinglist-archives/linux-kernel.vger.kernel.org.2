Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245303FA5A2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhH1MZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhH1MZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:25:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C8C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 05:24:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so6913596pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eDSaIJBqh+izHPHHriK0NAbuzPQM6rniHf8ccvF9oRs=;
        b=BVmFAl20QChh3w25z5aDgoAKDDnhhkARn6uI4phpX6GDyw622uxGX2KjOTbiDs5fsP
         opqrJCD3yhDboc1OrxRpiH2EP8V2D11O83tpY52YhBV1UQM8QrhCX5xaBg6etjO0XaIi
         nJjS9CCLJJ8QMcG7O4qBf9+SPEGKCGRG8PV4n1bpkAKwUD1iryhvUZboJcND5rKZsyn8
         B2D3vBYKUqk1zZdEcMf3LLmf7vHA3T4P09OOC7ngADHOm22lrQnzF5IPpBuXlHk14ZHK
         WNY3GJhrMpQ0GamhEvokcCBce1ANBS/RnJY5pQxLtzWMaClUpHaWHN+mt7rpI7SAm25q
         hJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDSaIJBqh+izHPHHriK0NAbuzPQM6rniHf8ccvF9oRs=;
        b=j+NcjsWBb8JiPHGnavDr9g7b8Zr/UNMjPGC/rqEdIIIM7POLNcGcpJF2o/AKnRlzHP
         VHgo2rqpZjidtGjPdo54vj2rqt96+heSY3upVDGWlj+9GRwIN1yMYc1vd1hYeagUWMJ1
         xueFaDIP3Gde0VCJyyifQDwGkxbpPnwRE5IuVj9de26oOYxEQvId3HuqgUMFJ6Ihqthx
         LslgRUvV6pT/MnejH2wyTucUs6NOyM8NHdXyT5z8VglbIdt62o/Rf/wmZuIbjwWkkSCH
         VCrgDRPXZKZRVMMAvxy9VBi5wU6NdYLEaAWXrQ1V5uYklCNh5UtZhUhFkyp3IV67Sa8N
         GxHw==
X-Gm-Message-State: AOAM531RAwZ8zWWMsxHoxi3exuUO7rjUIwNqJxfyLtmfokNi4tUPCUfs
        c0099En8++YIv7LhTSJacyw=
X-Google-Smtp-Source: ABdhPJz/o8n/4ad+NPvZNYaUzA9JcQz/YeHan0RbJDRnNWXh1T3Oshas5k5zn67kbuyR+RvSDa/LFg==
X-Received: by 2002:a17:90b:388f:: with SMTP id mu15mr15814347pjb.41.1630153457491;
        Sat, 28 Aug 2021 05:24:17 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id l75sm4167671pga.19.2021.08.28.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 05:24:17 -0700 (PDT)
Date:   Sat, 28 Aug 2021 17:54:11 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
Message-ID: <YSoq6wRQYneYI6N1@user>
References: <YSFgrLUfXzgcT6k4@user>
 <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
 <1821445.fzUCeO1EU3@localhost.localdomain>
 <YSJEu3sbnR6uIach@kroah.com>
 <YSduG401BA80Xnsb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSduG401BA80Xnsb@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Aug 2021 12:34, Greg KH wrote:
> On Sun, Aug 22, 2021 at 02:36:11PM +0200, Greg KH wrote:
> > On Sun, Aug 22, 2021 at 01:06:09PM +0200, Fabio M. De Francesco wrote:
> > > On Sunday, August 22, 2021 1:58:10 AM CEST Phillip Potter wrote:
> > > > On Sat, 21 Aug 2021 at 21:23, Saurav Girepunje
> > > >
> > > > <saurav.girepunje@gmail.com> wrote:
> > > > > Remove the condition with no effect (if == else) in rtw_led.c
> > > > > file.
> > > > >
> > > > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > > > ---
> > > > >
> > > > >  drivers/staging/r8188eu/core/rtw_led.c | 5 +----
> > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > >
> > > > Thanks for this, looks good.
> > > >
> > > > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> > > >
> > > > Regards,
> > > > Phil
> > >
> > > Dear Philip,
> > >
> > > Before acking, please check at least if it applies to the current version of
> > > the tree and check if it compiles without adding warnings and / or errors. :-)
> >
> > That is not necessary or needed here, I can do that when I apply the
> > patch.
>
> As proof of that, this patch applied just fine to my tree right now...
>
> thanks,
>
> greg k-h

Thanks greg
