Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A2315B17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhBJAZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:25:54 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:38949 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhBIUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:53:01 -0500
Received: by mail-pj1-f47.google.com with SMTP id d2so2395890pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 12:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YpAO5w4rpUVyjbDs+g8SH78+pEnr7YQqg1UsjEIU008=;
        b=fe/clj4GZtSFSPx8qDwmIXCtg76+I+dbJSfxoRhse7HeZR81CB9V/TW30PvSZGztSU
         XtyDkzFhYvgzOZS1FrArvinY2TWzLRcXWUI4peZjTbXdoFYyYYnu3MLNbSZcQU8jP8N/
         YK75USN1wP1kcD/oIDqZTXiDrgqVhf3rEtyv+cl9FjyogUrYQO2bL5NNg5O3uHCPWJXU
         5uxgjWMJLlLYcgdJOFhNWKPfru2uOl643uu7JIUtoo7pzYypyZyK6k/MglJ2vKFpoYwl
         jNLm5W4xR0AyuCWhyL+VBDYiQX6zevpTaqf0RIgYsp6dr8uaqtt8CzkAp+hB7CsjCK3+
         jqhw==
X-Gm-Message-State: AOAM53375E2Nu2CISK7C6ViXauuh/ukWF2RVh36NII6BUHG4qd7+3jOz
        oCBDlSDw8rZ/Y85LEbGnfK1f4MfAMGAnJCYY
X-Google-Smtp-Source: ABdhPJwIbQbUa6RfdtWnQYegl+ZJvOQ5f7N+m33cHQB3Ep17I5Rsa5Q10lYJYuNYxK80DotS6U2Ydw==
X-Received: by 2002:a62:2702:0:b029:1d1:b92a:ef2a with SMTP id n2-20020a6227020000b02901d1b92aef2amr23760732pfn.5.1612896758810;
        Tue, 09 Feb 2021 10:52:38 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id l4sm2993645pgk.71.2021.02.09.10.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 10:52:38 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:22:34 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLZ8j9LXcVfEMw5@karthik-strix-linux.karthek.com>
References: <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
 <YCAFeSw//h8JYpFk@kroah.com>
 <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
 <YCAGsKf6fEqYEv9p@kroah.com>
 <YCK2YgaM5u++djnl@karthik-strix-linux.karthek.com>
 <YCLFG03glpl76Haq@kroah.com>
 <YCLMwZvLjhVd7Z4a@karthik-strix-linux.karthek.com>
 <YCLZOavcY0uEBhNZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCLZOavcY0uEBhNZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:49:29PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 09, 2021 at 11:26:17PM +0530, karthek wrote:
> > On Tue, Feb 09, 2021 at 06:23:39PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 09, 2021 at 09:50:50PM +0530, karthek wrote:
> > > > On Sun, Feb 07, 2021 at 04:26:40PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Sun, Feb 07, 2021 at 08:54:49PM +0530, karthek wrote:
> > > > > > On Sun, Feb 07, 2021 at 04:21:29PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> > > > > > > > On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > > > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > > > > > > > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > > > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > > > > > > > > 
> > > > > > > > > > > <snip>
> > > > > > > > > > > 
> > > > > > > > > > > For some reason you sent this only to me, which is a bit rude to
> > > > > > > > > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > > > > > > > > resend it to everyone.
> > > > > > > > > > > 
> > > > > > > > > > > thanks,
> > > > > > > > > > > 
> > > > > > > > > > i> greg k-h
> > > > > > > > > > 
> > > > > > > > > > ok anyway
> > > > > > > > > > 
> > > > > > > > > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > > > > > > > > with them?
> > > > > > > > > 
> > > > > > > > > I don't see the context here...
> > > > > > > > are you real greg or bot?
> > > > > > > 
> > > > > > > All too real :)
> > > > > > > 
> > > > > > > > > Anyway, if you do sign documents with just "karthek" (lowercase and
> > > > > > > > > all), that's fine, but I do have to ask, right?
> > > > > > > > I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> > > > > > > > signature
> > > > > > > 
> > > > > > > Ok, that's good to know, however I have an application here from you
> > > > > > > with a different name on it.  Odd...
> > > > > > Ofcourse thats my legal name(Karthik Alapati) and this is my legal
> > > > > > signature(karthek)
> > > > > > FYI this is the first time i used my legal name on internet application
> > > > > 
> > > > > Great, please use your legal name on a signed-off-by: line, as it is a
> > > > > legal statement.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > pinging?
> > > > 
> > > > iam aware of how many patches you get everyday.im not expecting your
> > > > immediate attention but just pinging...
> > > 
> > > Ping on what?  I was waiting for a new patch to be sent that met the
> > > above requirements.  My pending queue for staging patches is empty at
> > > the moment.
> > Ok ignore that previous mail i forgot to cc lkml
> > requirements?
> > my name issue?
> > i told you thats my legal *alias
> 
> Please read the rules for what a Signed-off-by: means, it's in our
> documentation.
> 
> thanks,
> 
> greg k-h

I read them a week ago
ok i will send the patch again with that name on appl
