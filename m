Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE89393BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhE1DYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhE1DYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:24:48 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BEBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:23:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so2243102otc.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBoABoXGVEa26J6F9F+2JMduVsAPFL5b+xGIvhg/4IE=;
        b=p4Mj3FtJ5pxI+R00Ltm9+OfNZyxEbsyNr0j+slHqk2xPQydrge/J/fLKquCwEAygxB
         BMamVP8ukqf4hPUre1PsNQa3/9lMuXN3+2LhYKRhKDsd50nY8za1uYkg6B8Kh8CsnRWZ
         B6ZI4M06N+/dVQa0t/19rJGaKm3kWLspFHpN9m4irqd4erKdLGd2p9DxlX+JOnDOQkFG
         nK1TQI3V3IU9XQtjfRkEdz/HKrvfCNJ30bc9xvZvCNQfTO+wRiqmlLykj86Xg6EiTWNF
         Ki+LMFcwjUq5mosnmgA1MEee9Gb2YjK07MZ0cY6k+wjqlqWdcfMlB6DKiNPDCnHG0zmR
         +1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBoABoXGVEa26J6F9F+2JMduVsAPFL5b+xGIvhg/4IE=;
        b=iMWMg4uw/lJRfW4ljn823BsTc8c/Uh7sjTO1l4hMUmEXRrXqHSaUaaqBAi9oEhkZZP
         uC3AqB89uWrm3M5Fii0ZXe9oqIALhXWAt3YJcxgVZ/g9Xs9I5OSiAZH0lDdJ5EUBJi6D
         YZWFRL0HvQLkl+Ud2No4CRN+dpXJjJhrUNbOsqVfO0HcPGqaCEp9G5QvsY4cdEYdRtLI
         Xk07f7PHBC0fgqMhKWSl76ecge6yQ+JRwuBbHD8yL0vx0GTOCEQgGU1QGCcDHUfWRRVg
         cpg8uylOhJMRTNa4mZ3qdAdmE4gQtp6Btc2VmErLDhpUAg6qMkj9mRiQQP2bTgRGYKyv
         cNgg==
X-Gm-Message-State: AOAM530OPCT41CPAasyA4n0MBZVY7EKnXWxqcd9lV06TitO3p1x6uSP7
        H0mERx7Sk3CfeWn4Fkggu5LNUg==
X-Google-Smtp-Source: ABdhPJwAh6Qd9Zru7S20u3fiNv40kZbjB5VjE+6kH7YUPz5VQcENH7fS7PdezVqyZiK0PMQ6QQwSXw==
X-Received: by 2002:a05:6830:17cc:: with SMTP id p12mr5235975ota.270.1622172192118;
        Thu, 27 May 2021 20:23:12 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 88sm894485ott.51.2021.05.27.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 20:23:11 -0700 (PDT)
Date:   Thu, 27 May 2021 22:23:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v7 0/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <YLBiHQaW6H4K7QyO@builder.lan>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
 <95e93676-cfcf-1aed-1741-d69b72286033@sholland.org>
 <20210525180744.24187bb1@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525180744.24187bb1@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 May 11:07 CDT 2021, Wilken Gottwalt wrote:

> On Mon, 15 Mar 2021 23:33:31 -0500
> Samuel Holland <samuel@sholland.org> wrote:
> 
> > On 3/14/21 4:30 AM, Wilken Gottwalt wrote:
> > > Wilken Gottwalt (2):
> > >   dt-bindings: hwlock: add sun6i_hwspinlock
> > >   hwspinlock: add sun6i hardware spinlock support
> > > 
> > >  .../allwinner,sun6i-a31-hwspinlock.yaml       |  45 ++++
> > >  MAINTAINERS                                   |   6 +
> > >  drivers/hwspinlock/Kconfig                    |   9 +
> > >  drivers/hwspinlock/Makefile                   |   1 +
> > >  drivers/hwspinlock/sun6i_hwspinlock.c         | 210 ++++++++++++++++++
> > >  5 files changed, 271 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> > >  create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c
> > > 
> > 
> > Thanks for the very thorough testing!
> 
> So when will this end up in mainstream? Or do I have to somehing to get this
> triggered? This is not my first driver and back then it was included into
> mainline without anything special on my side. I'm a bit confused. Did I miss
> something?
> 

Sorry, I wasn't paying enough attention and you didn't Cc
linux-remoteproc@ (as described in MAINTAINERS) so I lost track of the
patch.

It's now been applied, I'll do some build testing on the way out but it
should show up in linux-next in the coming days.

Thank you,
Bjorn
