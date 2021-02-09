Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D781931569E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhBITPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:15:55 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:37100 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhBIR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:57:02 -0500
Received: by mail-pf1-f178.google.com with SMTP id b145so12390055pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GAauaOLQTj3c8nRYUUQhduh69N5CfwBgAIRRE27OkqA=;
        b=WFkhsbeZbCuydXzmC0MbTU/eeE6tWvwWhm3hp5wHYclIJE+MICSvRZdOljmfFvQzlw
         VxvnO8n/0xe6Sk1N87ld8NznyyZGRqVMrDSRQLx0xsEcrJqLv9AB5pgOr9f/QGWKJQ46
         +Oz8e3FpoYguS0MReC/IUbcWfpQC6eH0hXUNJcfw8wmXqprdEMM/OBRi5NY8l6kI8v67
         ZCjSWcf2UvihgJ6PBqyVbzXxUBFbP3jbaESZX7Ft4zRyicIM9V/MVV0yJHbS4JClLuwA
         L/lET3fthLBHG5QK+8ER4mK8FSs6TCJKrr/t96gG3bFTlWcN0yf2MoyYq4gKfz/V+gt5
         UCsw==
X-Gm-Message-State: AOAM531tpG4gstC++ketVoj51E8jJ+RKyLjQAazxF1PESyxKoRa4UXZe
        cWl8lM0dcpU3qQChtTwfrbE=
X-Google-Smtp-Source: ABdhPJyv6buka+ojkCapY3PV4MNu2ee/a9PL0UaAOwA7ouyxiykHpua/L3RVr5HtE3q/5XuJ0B1nMg==
X-Received: by 2002:a62:a11c:0:b029:1ba:bab6:6b02 with SMTP id b28-20020a62a11c0000b02901babab66b02mr23802011pff.51.1612893381322;
        Tue, 09 Feb 2021 09:56:21 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id n1sm8297350pgn.94.2021.02.09.09.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:56:20 -0800 (PST)
Date:   Tue, 9 Feb 2021 23:26:17 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLMwZvLjhVd7Z4a@karthik-strix-linux.karthek.com>
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
Ok ignore that previous mail i forgot to cc lkml
requirements?
my name issue?
i told you thats my legal *alias
> 
> thanks,
> 
> greg k-h


