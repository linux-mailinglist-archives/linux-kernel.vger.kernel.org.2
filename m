Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588BA3153B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhBIQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:21:47 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:38931 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhBIQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:21:40 -0500
Received: by mail-pj1-f53.google.com with SMTP id d2so1943628pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqYfCPuCk1vaTDI6PRJs8TZC802bXP3nLLoPQfnccV8=;
        b=gW4D5mTvvAjZvgWasO8IbA0Cuqmqqiietq3T2yfeMZhdDlXrRSGMIHqbdy2at4gf5A
         NxKnDP3X696Hsz8JXyyaI7e42a7KwsS5PWojb4N53UrBIuzylETc5I4h0LPU9jnTckBC
         t/JE5PZxqEMUCFQd9ziTbM+rmQk9rww44ypBAFXrotQhAWvj7PDGyYaynaWHii13O+MA
         jFHyPYXJkTxRRu/PjSqidPnbimK2MUsJroj6qxkjvCTx9hG4hwQ1P2lRU+73TrxXNMUb
         4Vst6685N29YPiggOVwruffzRmXBudnJwtewjr1a/QQIT3T6HYRibk0vyW83VZ50ih2h
         aqGg==
X-Gm-Message-State: AOAM531//4CyTnSlfiVgnTd3X9SAw7ibMP6t3WnfJDRMezCLHIRu1GSJ
        Ouxwe3WXv/e5kWZSsU29RVEOVl5YTutgcxGM
X-Google-Smtp-Source: ABdhPJzxB54QUWngBTtTfaBmF+sLl97ei6/EewxK2nuUa4kyvFlUbNCENp5Lvr+IAVnQw5sc3cuVWA==
X-Received: by 2002:a17:90b:4844:: with SMTP id lf4mr4736477pjb.23.1612887660244;
        Tue, 09 Feb 2021 08:21:00 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id h188sm7981332pfg.68.2021.02.09.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:20:59 -0800 (PST)
Date:   Tue, 9 Feb 2021 21:50:50 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCK2YgaM5u++djnl@karthik-strix-linux.karthek.com>
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
> 
> thanks,
> 
> greg k-h

pinging?

iam aware of how many patches you get everyday.im not expecting your
immediate attention but just pinging...
