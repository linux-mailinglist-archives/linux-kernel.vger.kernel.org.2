Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E163FDED4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbhIAPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbhIAPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:40:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E7C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:39:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so3791ejz.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gtxtlf+IvPbb5S4KUDPGBv/IseOgDOneCJ4TI1+PC5w=;
        b=W9ttA5JKJsbe0026yGjy3AiJE2JS0BQJeNEshdziMVwGYYqu4uTR16v5ftqqA5LoTd
         R0kfilGPdNJzDInnXmcLdLsV89icUPFbRoWSULCF7JpvmJdYIsxjbfYvzPk9E5yST5pL
         mhFJ4LKxRqjO5VuaKtvGCFeEg9wfXGX1XXLwbn0HsvuQ+WudH2hiQE8r54d16beCvUBd
         tScsJ8V8h0Cq4BG+N008WF3PjMDu51fGjfRF6r2N2dZU3GyUV1k94Y0WWnPAdqlXbZYA
         p31PLd+vlxa47cVzrp3ubhBBbVPDAlyeyqITHb81u5M4F2xO2Ow+FPta/XQqCr9JMUIq
         mNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gtxtlf+IvPbb5S4KUDPGBv/IseOgDOneCJ4TI1+PC5w=;
        b=bcJtbHOzk+AN0gEWubu6aMkOF5Cm+5NA5MFKz3FmCPBCgDCMq6xgFC8NgJ48dL6qoH
         ruCv+oBfi9jddtrK83FoWAPSFQu+7BC73NxiyF2Ky+Ax+Iw/06SVVyOLP+cyR+ybiO5X
         l4rguBbeMbOKlP63A67RSDF27m+/sSVrHlN0XrF01xNRPrEmI+dLG8luQs8JuZ+/INrZ
         JnwA5ZZSHOwiG4BT8mgH5wNyos4+V8VxYiwMyHWmLw0KHEmhPHJSQuWW8EHxLSOBxwhs
         QhCSBlER5rz4l3ecVea63hu5AL1dpFDXgQnW4AtaHlxaikTe7sA5Z0FMAcDEWm4yhUuF
         KJBw==
X-Gm-Message-State: AOAM532ysucEGFg+VrsiurdiOM1AO+j3fgu4mDNZ6yp0d9De9KgMOrMi
        lZrL7McY9W9Hs6YU+uKQ6gs=
X-Google-Smtp-Source: ABdhPJy43iwSCZVMf2T5xtACWqKltQuAv2LAC08MVHPt3txFGtmVbJKC2vEoNDAeA6yK6ZRYJRi8bg==
X-Received: by 2002:a17:906:a0a:: with SMTP id w10mr54387ejf.416.1630510789079;
        Wed, 01 Sep 2021 08:39:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id qq16sm17102ejb.120.2021.09.01.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 08:39:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Date:   Wed, 01 Sep 2021 17:39:46 +0200
Message-ID: <2942098.x5hDSQIzYV@localhost.localdomain>
In-Reply-To: <YS+ORkbD9NuEOl0D@casper.infradead.org>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com> <8914101.vIO1HAjRha@localhost.localdomain> <YS+ORkbD9NuEOl0D@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 1, 2021 4:29:26 PM CEST Matthew Wilcox wrote:
> On Wed, Sep 01, 2021 at 03:56:20PM +0200, Fabio M. De Francesco wrote:
> > Anyway I tried to reason about it. I perfectly know what is required to 
> > protect critical sections of code, but I don't know how drivers work; I 
mean 
> > I don't know whether or not different threads that run concurrently could 
> > really interfere in that specific section. This is because I simply 
reason in 
> > terms of general rules of protection of critical section but I really 
don't 
> > know how Greybus works or (more in general) how drivers work.
> 
> From a quick look, it is indeed possible to get rid of the mutex.
> If this were a high-performance path which needed to have many threads
> simultaneously looking up the gb_tty, or it were core kernel code, I
> would say that you should use kfree_rcu() to free gb_tty and then
> you could replace the mutex_lock() on lookup with a rcu_read_lock().
> 
> Since this is low-performance and driver code, I think you're better off
> simply doing this:
> 
> 	xa_lock((&tty_minors);
> 	gb_tty = xa_load(&tty_minors, minor);
> 	... establish a refcount ...
> 	xa_unlock(&tty_minors);
> 
> EXCEPT ...
> 
> establishing a refcount currently involves taking a mutex.  So you can't
> do that.  First, you have to convert the gb_tty mutex to a spinlock
> (which looks fine to me), and then you can do this.  But this is where
> you need to work with the driver authors to make sure it's OK.

Dear Matthew,

I think that I understand your suggestion and, as far as my experience with 
concurrency in userspace may have any relevance here, I often use reference 
counting with objects that are shared by multiple threads.

Unfortunately, this is not the point. The *real* issue is that I am not able 
to provide good reasons for doing IDR to XArray conversions in Greybus code. 
I tried to provide some sort of motivation by using your own words that I 
still remember from a message you sent a couple of months ago: 

More or less you wrote:

"The abstract data type XArray is more memory-efficient, parallelisable, and 
cache friendly. It takes advantage of RCU to perform lookups without locking. 
Furthermore, IDR is deprecated because XArray has a better (cleaner and more 
consistent) API.".

I can reason on the "cleaner and more consistent API" and for what I 
understand from the grand design of the implementation of XArray I may also 
attempt to discuss some of the other parts of the above-mentioned statement.

Anyway I must respect the point of view of Johan H.: "And remember that a 
good commit message describing the motivation for the change (avoiding 
boiler-plate marketing terms) is a good start if you want to get your patches 
accepted.". That's absolutely fair and, I say that seriously, I must follow  
this rule. Since I'm not able to do that I understand that I have to desist.

If it depended on me I'd like to convert as many possible drivers from IDR to 
XArray, but it seems that many maintainers don't care (even if the work was 
perfect in every detail since v1). I guess they have their reason to think 
that the trade-off isn't even worth the time to review. I'm yet not sure that 
IDA to XArray is worth as much as IDR to XArray is. But for the latter I 
would bet it is.

Please, nobody should misunderstand me. I know that I'm going well beyond 
what my experience may permit to say about this matter. I'm just expressing 
my opinion with no intentions to push anybody in any direction. Please 
forgive me if this is what it may seem to the readers that are following this 
thread.

Thanks,

Fabio


