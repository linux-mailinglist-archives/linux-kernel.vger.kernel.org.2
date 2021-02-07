Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBD312552
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBGP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:28:20 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:34147 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhBGPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:25:36 -0500
Received: by mail-pl1-f177.google.com with SMTP id u15so6508177plf.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03TyJ5KVF/x1aNwDz5a1nMAIlPKwQUH2D24fRznCL74=;
        b=hG5LbDyhku2Pe3L1IXBM00JtlBWwSDwQdjDii5LSiV5nNq9UAFlokeVVhcDzhuBSUs
         caVEI04Dj6IRhK+RMU2YhwCMtp+Ndse5SX540GaPxPZkIGZaRxEhj9i+uZzVn7DqhMtE
         Mf3z05ZpWCVLsrCAJM3mOvHE64KOaY3GiDZIupv5sqqNfEAUkEdY8opQLrg1tdzmOF64
         o+Mqd/lAv3tKeg7465y8hvI+em2uy0QxByLWx4dHJJw+yvKNdnUyuVJw7RTBlS8gAvdF
         4bFQ+eI+QUf81se9IhUNwlQ0i2CuX8hXED9VeYvedDgLV0MHb5kkORzR6NQyykkZ6J39
         H/qw==
X-Gm-Message-State: AOAM533tpxZ5mLM5naDqkQJrU4jx1Y1CbzBuRLxW6AgT8yBI7JxXJT8a
        LXYUPDQQG3iWy/VFVsc8ZyY=
X-Google-Smtp-Source: ABdhPJygoT6MEb84dN4R7bT/4jrz6kpFbuqc4oEjabtOfoYcegxs8DdO3QV7zlKNZqA8ch/BOw9ZKg==
X-Received: by 2002:a17:902:e9c4:b029:e1:805d:7965 with SMTP id 4-20020a170902e9c4b02900e1805d7965mr12452125plk.53.1612711494178;
        Sun, 07 Feb 2021 07:24:54 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.2])
        by smtp.gmail.com with ESMTPSA id k9sm12907351pji.8.2021.02.07.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:24:53 -0800 (PST)
Date:   Sun, 7 Feb 2021 20:54:49 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
 <YCAFeSw//h8JYpFk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCAFeSw//h8JYpFk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 04:21:29PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> > On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > For some reason you sent this only to me, which is a bit rude to
> > > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > > resend it to everyone.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > i> greg k-h
> > > > 
> > > > ok anyway
> > > > 
> > > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > > with them?
> > > 
> > > I don't see the context here...
> > are you real greg or bot?
> 
> All too real :)
> 
> > > Anyway, if you do sign documents with just "karthek" (lowercase and
> > > all), that's fine, but I do have to ask, right?
> > I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> > signature
> 
> Ok, that's good to know, however I have an application here from you
> with a different name on it.  Odd...
Ofcourse thats my legal name(Karthik Alapati) and this is my legal
signature(karthek)
FYI this is the first time i used my legal name on internet application
> 
> greg k-h
