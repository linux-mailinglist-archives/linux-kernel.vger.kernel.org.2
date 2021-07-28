Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E5B3D8D62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhG1MA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhG1MAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:00:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F01C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:00:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l18so2206200wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVAGWXk6C/RClkhxJBC2qc8hyZaz+QfRZnXkvbgygas=;
        b=ElZkUGcJJwD7Aa2mRV34LlTvFelQdA333XEOrmYWZPMcj7iUpAEUVcZgerqW02QZIv
         D7u6xaS/dfr5c+SWwNuNeLDpKoasAQz8G5J0cuXDfqAU88VPr1shGX0hvw78ZRfbkqlq
         DTz728iCazAcDN+cmZP5a/QDOIGh+KTFZncG5V06KvlsbtqNsxlcfNmcEZkTSwEHTvlk
         AXWrR3emzZjJ1buD3hPAH4HktVHPwqhOMqPxi8dONbIR0gAiYdkaUbkG1PcShWST9xoX
         w0kd5JFo1MYqlr1mGMdpFHFnUi9AwXArIra5D2Q2QutxIfjGyVM/FD4iH9mUvMRnw0fY
         Afog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVAGWXk6C/RClkhxJBC2qc8hyZaz+QfRZnXkvbgygas=;
        b=P7zUFJD/RWjbJcCBs3QQ6JLYwQ8ldKbbVVhEnuTpzdK0jGmp1yNVeHqQLt55mlvFZq
         IEde5QaUWynxEso+dEHXqT66xCiS4mlR2JU/zlNhdgsj1zboTqSPg6Nko+v09VsMv6a9
         8P1E4piTkIEFfS7nTdAcxBI4myJTHrPNGKsMkqRzUbkHP4b8AKGWZevwDnnNdNG9Jw9q
         U3z0hbckGlim1H3rlKXiSb02tezMKuqdolFA9sUaid8Ntn+VrX27gIlHoHmh5Ag5FYKD
         fzM449X88lZX2gB52aWV6R4KWTIMwftA3xJcrQlkEhZsh+qpDwTDVUiud2BPyELrQbbC
         oKVQ==
X-Gm-Message-State: AOAM532Ip6uZLQ6R87Pb15LUzyZ3KhBzB3uRWNmdrK0lWJt/HODw7SVG
        fcdLYpbeLfIULmivo6VUgbI=
X-Google-Smtp-Source: ABdhPJwafNQZVd1Gwz3myc+7Vx0WTbCDQuQXyXHGgpvrzw8HDEpiOTh5dRVAeEvqlgvQ7KhAojQi6w==
X-Received: by 2002:a5d:67cc:: with SMTP id n12mr30345956wrw.131.1627473622800;
        Wed, 28 Jul 2021 05:00:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id n5sm6354930wri.31.2021.07.28.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:00:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: Remove set but unused variable in ashmem.c
Date:   Wed, 28 Jul 2021 14:00:19 +0200
Message-ID: <4425350.seJdf4cM5h@localhost.localdomain>
In-Reply-To: <20210726134454.GJ1931@kadam>
References: <20210723200514.10139-1-fmdefrancesco@gmail.com> <13453441.4PhDYAFLLM@localhost.localdomain> <20210726134454.GJ1931@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Monday, July 26, 2021 3:44:54 PM CEST Dan Carpenter wrote:
> On Sat, Jul 24, 2021 at 09:49:35AM +0200, Fabio M. De Francesco wrote:
> >
> > [...]
> >
> Another trick which would have helped is to try find out which patch
> forgot to remove the "inode" variable, because that developer would have
> seen the warning as well.
> 
> > > I'm guessing you are building with CONFIG_LOCKDEP=n.
> > 
> > Actually my .config sets CONFIG_LOCKDEP_SUPPORT=y. Did you refer to this?
> > There is no CONFIG_LOCKDEP in the file.
> 
> Use make nconfig and then use f8 to search for CONFIG_LOCKDEP.
> 
> regards,
> dan carpenter

Thanks a lot. As always, you've been very helpful. I appreciate your 
willingness to help and, more generally, your attitude towards people with 
less experience than yours.

By using F8, I found that CONFIG_LOCKDEP is selected by CONFIG_LOCK_STAT (in 
logical AND with other options) but, in my .config, the latter was set to 'n'. 
After setting this other option to 'y', CONFIG_LOCKDEP magically :) appeared  
in .config and it was automatically set to 'y'.

I see that the same kind of search can also be done by using the slash if one 
uses "make menuconfig".

Regards,

Fabio



