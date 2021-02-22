Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E25321A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhBVOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBVOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:01:36 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 06:00:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e15so9234651qte.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HA3GKOGorULqJ9zOscJLMbtGbrtN/SqWQvqLlzI6tz8=;
        b=Ze3yohCevrSiwjuZedC7tnZp4jFlgosfELUXLjAy1O+h1Uc6iEoI4Kc6AByOFom6u4
         4VooOdpmTSg3HuEXFZa0yY4t+SDVP1bs3BtluHFuKYrtccmyFcFeg0rTprJbWNroEfOf
         NTpl5ZKDLn5Re0tO8TcVDf60sD0lf0apZT6yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HA3GKOGorULqJ9zOscJLMbtGbrtN/SqWQvqLlzI6tz8=;
        b=ou/rre+SaEkZowmLf+z6SnKmKHimCFjs+BpzX8ycFxFqPCmYsOOE5cT4dsxxfuYuxX
         We+Zb0xHhEuk9UEzJZWiepBmpybG/wM2tbRs5dM9tb39K/GEVlU2o41iKE5YVzNzoC3s
         wcSVrVqpd9rg14ULX91E4Y1R1UoXEKZBIVCv6Rnn0odIFwN2E2jvHilJunMUfqtEPbHq
         bbNt0PKcQbhdV8fodXAArgpQ+A+4Gfc7VXwjkcMzf/oy+JtTLrDXWFzcnDOFqf3gw6Ov
         3/ctfK7Ld9p0lBcxBzOXTOLHzZfpEXnu7i3x0lJI5HDb+2shBR9TJa5YB3E2x/c6snqq
         w94Q==
X-Gm-Message-State: AOAM533T+vNjhwllBxL5gdAB583wNonAbxb4Wn2c7I+W3aGA9CHEZROn
        Eucr+q6JgYLMr5qm34DMKASbBg==
X-Google-Smtp-Source: ABdhPJyu7V/n0QSfvFBTfWYz/By9ws4KCuMYZsO/oeLNcQ6NLt1A4WDZHqlOI647xi/GwYytvGG3Zg==
X-Received: by 2002:ac8:1208:: with SMTP id x8mr20126292qti.14.1614002455257;
        Mon, 22 Feb 2021 06:00:55 -0800 (PST)
Received: from breakout.internal.digitalocean.com ([2600:1700:7aa0:1690:e583:b823:e3cc:4987])
        by smtp.gmail.com with ESMTPSA id o17sm9221766qki.100.2021.02.22.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:00:54 -0800 (PST)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id DBD888AAE4C; Mon, 22 Feb 2021 08:00:52 -0600 (CST)
Date:   Mon, 22 Feb 2021 08:00:52 -0600
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        cgardner@digitalocean.com, pmccormick@digitalocean.com
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210222140052.GA1520276@breakout>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YA/E1bHRmZb50MlS@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 26.01.2021 [08:29:25 +0100], Greg Kroah-Hartman wrote:
> On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
> > Hi All,
> > 
> > The 5.10 LTS kernel being officially LTS supported for 2 years
> > presents a problem: why would anyone select a 5.10 kernel with 2
> > year LTS when 5.4 kernel has a 6 year LTS.

<snip>

> > If 5.10 is "actually" going to be supported for 6 years it would be
> > quite valuable to make such a declaration.
> > https://www.kernel.org/category/releases.html
> 
> Why?  What would that change?
> 
> Ok, seriously, this happens every year, and every year we go through
> the same thing, it's not like this is somehow new, right?
> 
> I want to see companies _using_ the kernel, and most importantly,
> _updating_ their devices with it, to know if it is worth to keep
> around for longer than 2 years.  I also, hopefully, want to see how
> those companies will help me out in the testing and maintenance of
> that kernel version in order to make supporting it for 6 years
> actually possible.
> 
> So, are you planning on using 5.10?  Will you will be willing to help
> out in testing the -rc releases I make to let me know if there are any
> problems, and to help in pointing out and backporting any specific
> patches that your platforms need for that kernel release?
> 
> When I get this kind of promises and support from companies, then I am
> glad to bump up the length of the kernel support from 2 to 6 years,
> and I mark it on the web site.  Traditionally this happens in
> Febuary/March once I hear from enough companies.  Can I count on your
> support in this endeavor?

I am very sorry for the long delay on my end (I had privately e-mailed
Greg on January 28) -- DigitalOcean also intends to provide feedback and
testing on the 5.10 series. We intend to use it as the basis for our
next-next kernel and are very invested in ensuring the stability and
performance of the kernel.

Thanks,
Nish
