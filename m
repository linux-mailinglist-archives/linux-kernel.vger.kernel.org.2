Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972E03FB463
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhH3LL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhH3LLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:11:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1974DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:10:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lc21so30291797ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MI9eImtV3JH8nNzI3Rjc2fShmqiaX13ZfYFOv7am00M=;
        b=SHEkU1Xx9MHblQ1FF5Z/pom2Bw84hCdzzqgkHelabKKS3ZOvorVnfUeB7m0HEg/u3J
         sso7O+QcqqBoweCR+KlwWMKNN4KOqRmpuPKUZmpM7R/KISlqwTQrrPb+UG8RQJcOI3BT
         LQ/dD9SmcUY+2gkSlERoJLzhrHNdEaXq1WBheVJWftiLM+65IBm7QgclFzxFOJIikR/F
         HSRZ8lg47yDdGvMvWbSC7QCezv2UNzZo0hzyA302ypHkv6cBj6E5Fl36NJKIMIuCOBYb
         CPU/ElzIUoFBx3/g7oG9g/eVn2Pp0kYP/FevZ7uzWAzjpNa3MmhcJNqEtQv2DdO8xXEA
         +pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MI9eImtV3JH8nNzI3Rjc2fShmqiaX13ZfYFOv7am00M=;
        b=r76I2vpxEGjFJyw+hkY7xXxO6Y1U3VR06PP9Hg1xpoI/aeDH5ykqDpFCwRvhA/wK1w
         E9m9S2kQL6sDEghQ7f5b00HGaC18x9I/GWPyAq3Vwx8qPBSgxSvVt4RWkI7Fiy+wU7+h
         iZCnFqVHmz2+o6/oPanJsIg8KjOLnZ1ktwSAC11yVaCRABjYZds1b603qpQSYcUUrUQn
         IMUbBFrW00/JgX6A0+xghdNpVQ2aoijslQCYmyfifOhkxvoOMg828KEBf35QumgLUbLI
         rYob9XI3Bl+/6MOSJidbkHpsUPwcmeSfuC71dGkrgaqewoy5zZxrMNSmkep8vHoiwlby
         sfCA==
X-Gm-Message-State: AOAM531VRwOhVGKsMpmkrPLC8UwoEoPRCtEcb7JeW30JpO93wOjWPI5w
        xlOWOiKlozhNfnc+bmseJ1Y=
X-Google-Smtp-Source: ABdhPJw6yOvQ5HMSz6OWRemKjGMiVONs3hccLmw5KoaevSrm5AXs3rlL16qd1wcGVFMAK1HS7nSC1w==
X-Received: by 2002:a17:906:6445:: with SMTP id l5mr24590756ejn.194.1630321857251;
        Mon, 30 Aug 2021 04:10:57 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id n2sm7640337edi.32.2021.08.30.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 04:10:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Date:   Mon, 30 Aug 2021 13:10:54 +0200
Message-ID: <2879439.WEJLM9RBEh@localhost.localdomain>
In-Reply-To: <YSyg/Db1So0LDGR+@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com> <YSyg/Db1So0LDGR+@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 30, 2021 11:12:28 AM CEST Johan Hovold wrote:
> On Sun, Aug 29, 2021 at 11:22:50AM +0200, Fabio M. De Francesco wrote:
> > Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> > is more memory-efficient, parallelisable, and cache friendly. It takes
> > advantage of RCU to perform lookups without locking. Furthermore, IDR is
> > deprecated because XArray has a better (cleaner and more consistent) API.
> 
> Where does it say that IDR is deprecated? Almost all drivers use IDR/IDA
> and its interfaces are straight-forward. In most cases we don't care
> about a possible slight increase in efficiency either, and so also in
> this case. Correctness is what matters and doing these conversions risks
> introducing regressions.
> 
> And I believe IDR use XArray internally these days anyway.

Please read the following message by Matthew Wilcox for an authoritative response to your
doubts about efficiency of XArray and IDR deprecation:
https://lore.kernel.org/lkml/20210503182629.GE1847222@casper.infradead.org/

In particular he says that "[] The advantage of the XArray over the IDR is that it has a better 
API (and the IDR interface is deprecated).".

> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v3->v4: 
> > 	Remove mutex_lock/unlock around xa_load(). These locks seem to
> > 	be unnecessary because there is a 1:1 correspondence between
> > 	a specific minor and its gb_tty and there is no reference
> > 	counting. I think that the RCU locks used inside xa_load()
> > 	are sufficient to protect this API from returning an invalid
> > 	gb_tty in case of concurrent access. Some more considerations 
> > 	on this topic are in the following message to linux-kernel list:
> > 	https://lore.kernel.org/lkml/3554184.2JXonMZcNW@localhost.localdomain/
> 
> This just doesn't make sense (and a valid motivation would need to go in
> the commit message if there was one).

OK, I'll take your words on it. Alex Elder wrote that he guess the mutex_lock/unlock()
around xa_load() are probably not necessary. As I said I don't yet have knowledge of 
this kind of topics, so I was just attempting to find out a reason why. Now I know that 
my v1 was correct in having those Mutexes as the original code with IDR had.
>
> > [...]
> 
> You can't just drop the locking here since you'd introduce a potential
> use-after-free in case gb_tty is freed after the lookup but before the
> port reference is taken.
> 
> That said, this driver is already broken since it can currently free the
> gb_tty while there are references to the port. I'll try to fix it up...
> 
> >  	return gb_tty;
> >  }
> 
> But as you may have gathered, I don't think doing these conversions is a
> good idea.
> 
> Johan
> 

Thanks for your review,

Fabio



