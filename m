Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D507312561
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBGPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:34:02 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38690 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:33:59 -0500
Received: by mail-pg1-f178.google.com with SMTP id m2so1901034pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Zb7TZgqoJau8sqcaJ84Q4j7WG+VP4moZQwREbMTTQQ=;
        b=j7xmAX8WSGvT2DU79OQd4g9VPuH5dbmc9AodHH5zNDrzg8LERzht0EzWoi9IYZz16k
         WgzIHSgmZoBWF9ATaKASdEIp0uAF/5Vz2MSTGWwqo2wKfqcgNhq4KQr/FLYpnq40ZYI2
         t2mTycIutc7yx51kcgeSvTic4iHme94C9YJJIFXicV6+8VJYDtdI8VgqlXpiP9npw0wQ
         EsSihgbm8sMlMXDDJ4wKH//Itt/0nxM0PKgV7caAiGFTXYl1UdfKWftKOEoYdJO3wP8P
         V2DoWY0fHniBEw1/NhqXDVhyodMwU3HNfzMlLxyzR7Gc1R8d/WcUiEa755dRxXw+9nId
         pL5A==
X-Gm-Message-State: AOAM531uO/wyPj1YCorD+JhPEP4HHx1fmsixlhEVGca8fitZtdjTUNu+
        fvpQU/NDDfcpB9tq8uOZVqM=
X-Google-Smtp-Source: ABdhPJw6yukAWeAhD5tO1veugoplGptvbDujrBkTtmYKSo0djs8ygJ4D5NlW222OO8cODdHiS2ZOBA==
X-Received: by 2002:a65:62d3:: with SMTP id m19mr13855705pgv.180.1612711998366;
        Sun, 07 Feb 2021 07:33:18 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.2])
        by smtp.gmail.com with ESMTPSA id d14sm15852145pfo.156.2021.02.07.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:33:17 -0800 (PST)
Date:   Sun, 7 Feb 2021 21:03:14 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCAIOoOC2cjtRYSs@karthik-strix-linux.karthek.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
 <YCAFeSw//h8JYpFk@kroah.com>
 <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
 <YCAGsKf6fEqYEv9p@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCAGsKf6fEqYEv9p@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 04:26:40PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 07, 2021 at 08:54:49PM +0530, karthek wrote:
> > On Sun, Feb 07, 2021 at 04:21:29PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> > > > On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > > > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > > > > 
> > > > > > > <snip>
> > > > > > > 
> > > > > > > For some reason you sent this only to me, which is a bit rude to
> > > > > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > > > > resend it to everyone.
> > > > > > > 
> > > > > > > thanks,
> > > > > > > 
> > > > > > i> greg k-h
> > > > > > 
> > > > > > ok anyway
> > > > > > 
> > > > > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > > > > with them?
> > > > > 
> > > > > I don't see the context here...
> > > > are you real greg or bot?
> > > 
> > > All too real :)
> > > 
> > > > > Anyway, if you do sign documents with just "karthek" (lowercase and
> > > > > all), that's fine, but I do have to ask, right?
> > > > I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> > > > signature
> > > 
> > > Ok, that's good to know, however I have an application here from you
> > > with a different name on it.  Odd...
> > Ofcourse thats my legal name(Karthik Alapati) and this is my legal
> > signature(karthek)
> > FYI this is the first time i used my legal name on internet application
> 
> Great, please use your legal name on a signed-off-by: line, as it is a
> legal statement.
Yeah i understand but thats not a problem as its my legal alias that is
why i sent as it even though i know im agreeing DCO 
> 
> thanks,
> 
> greg k-h
