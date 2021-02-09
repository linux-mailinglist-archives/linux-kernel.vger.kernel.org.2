Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A0C315818
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhBIUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:52:53 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:38393 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhBIStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:49:24 -0500
Received: by mail-pj1-f50.google.com with SMTP id l18so2205166pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 10:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fAvxxCnQZJJ7gajYHjeMqP64TjNCSQj9gLy3huPstC4=;
        b=nery+AccDvYRn5yqrq49ZG3GHqYJJIOraB4qDkBj12Rn54geLQTCwxKpMFiuwcxn65
         ID/tUf4pLMhiB1N22lcPkPBA66fZnxPUfeuS2svtlFlv+mnTO9j5nqhwffOMHzFN4psW
         nuSmVY9bYwU6NpYRVAavz7lx0Wvp3ZRdkNHRB3318E2vsc0G8qN1JljXFXXg+3aj0gz9
         YoE2sBuCK8ApbEvvJBhZpStnT1s+es/YDwzP/jwYk+F2GA9Gypo1DgNcgNrGtcYXnmFz
         kItlIDmnPL7QBsr3qHoB0xdoG2EMJUvFFGl5gK7AlVdvGrXDcSxJUDacNJkOfU3qhy48
         u0vg==
X-Gm-Message-State: AOAM533FEmZUr1+2XkvlBMqr/0CYIaVB20gkJXo0qUHLBZn+U753tWqs
        GxYtyqN7mJGpuivZ3VhNK2M=
X-Google-Smtp-Source: ABdhPJztex7YcTHtC7ZbcXjvYN1m2cvYWp5DfHTT+ab1RAelKr6CX7NHyPhZ6C1s6CpT7vJQUiJB1w==
X-Received: by 2002:a17:90a:a897:: with SMTP id h23mr5481687pjq.224.1612896486561;
        Tue, 09 Feb 2021 10:48:06 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id s18sm3129217pjr.14.2021.02.09.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 10:48:05 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:18:02 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLY4mB84ISa8U90@karthik-strix-linux.karthek.com>
References: <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
 <YCAFeSw//h8JYpFk@kroah.com>
 <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
 <YCAGsKf6fEqYEv9p@kroah.com>
 <YCK2YgaM5u++djnl@karthik-strix-linux.karthek.com>
 <YCLFG03glpl76Haq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCLFG03glpl76Haq@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 06:23:39PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 09, 2021 at 09:50:50PM +0530, karthek wrote:
> > On Sun, Feb 07, 2021 at 04:26:40PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 07, 2021 at 08:54:49PM +0530, karthek wrote:
> > > > On Sun, Feb 07, 2021 at 04:21:29PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> > > > > > On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > > > > > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > > > > > > 
> > > > > > > > > <snip>
> > > > > > > > > 
> > > > > > > > > For some reason you sent this only to me, which is a bit rude to
> > > > > > > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > > > > > > resend it to everyone.
> > > > > > > > > 
> > > > > > > > > thanks,
> > > > > > > > > 
> > > > > > > > i> greg k-h
> > > > > > > > 
> > > > > > > > ok anyway
> > > > > > > > 
> > > > > > > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > > > > > > with them?
> > > > > > > 
> > > > > > > I don't see the context here...
> > > > > > are you real greg or bot?
> > > > > 
> > > > > All too real :)
> > > > > 
> > > > > > > Anyway, if you do sign documents with just "karthek" (lowercase and
> > > > > > > all), that's fine, but I do have to ask, right?
> > > > > > I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> > > > > > signature
> > > > > 
> > > > > Ok, that's good to know, however I have an application here from you
> > > > > with a different name on it.  Odd...
> > > > Ofcourse thats my legal name(Karthik Alapati) and this is my legal
> > > > signature(karthek)
> > > > FYI this is the first time i used my legal name on internet application
> > > 
> > > Great, please use your legal name on a signed-off-by: line, as it is a
> > > legal statement.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > pinging?
> > 
> > iam aware of how many patches you get everyday.im not expecting your
> > immediate attention but just pinging...
> 
> Ping on what?  I was waiting for a new patch to be sent that met the
> above requirements.  My pending queue for staging patches is empty at
> the moment.
requirements?
my name issue?
i told you thats my legal alias
> 
> thanks,
> 
> greg k-h
