Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A53FC2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhHaGcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhHaGcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:32:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE220C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:31:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so1421595pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wx1FDrVHCRBqDvRaHXak7M9kfgXHCkU5zPaASGw2oLA=;
        b=aPJa2N2MY5Z7BKQF5gTAMAyTuN7gxdROFNru4ixmqR+6K6Eai7JK6GVv6IMqPYTQPm
         4woSXX6gnH0ZuFC+om9Bf8Or74CTSzg+74vMPY2T6kMxDYNIrKYjVocVCRo8e2qwiArE
         xWYvlUBy5P99Ix1QLLKagMn8X9VqOJ8f/JOlGz9poVdbWDKGvTHTiBtcPaKqLDvYCq6D
         HXI7K9qLNpnswBYh9p7MHorx65FTSxNO3oio2RIdYTG7XlPCcZJJDVUtkyENwTtpahCk
         TqUPv05fcWpSQ5y036aYs3PKvLN6+Z6oS5LGBCU8t+OT41qByaH40rSpslzEEMdN+KpE
         BkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wx1FDrVHCRBqDvRaHXak7M9kfgXHCkU5zPaASGw2oLA=;
        b=VJT0rBEuyhnP5g6HlNFrt2eU2DHfUT7FmP2XMjNn910Yr7URLb3SyBi7j2bOWeL/gq
         EAORDsHjPW4YrE8T0ilV71WC4Nxmw8jAziTJJo5aj/ZCu35TgtDVKX7jF6mZQVJZB9TH
         R8viP9Fo/H+epA5eb1akS63fFiYvfb0qVg07lqCCYj4kQGy/warMaW480TZKutv2fyLA
         Tj/U51sU6BVZ8HfTu6lz55PGoWBYQ9av+cCDGOmAQCfXg9FxQDHr89HBdMZC+ihgFkIA
         G67U7d0wJHav4gaIGUdkutPkKGV0VcvalJq3Kfgu1RRTvllTB4lHFw+dTRGsy1r5MWiv
         Lu7Q==
X-Gm-Message-State: AOAM530VGBuKj70fhJnhgMfSTL2AfQ4krc4j3IbN0tSHCODiXxt6cJYk
        AInLkc/KWFd2ilsGNoQovpDRMQ==
X-Google-Smtp-Source: ABdhPJzwbDvXXfhIxrp8QSQqB48TnUI6F5NGl+r7oFXzRWGJBYGkY92yx00/9g0/BBpLhMowfwv1hg==
X-Received: by 2002:a17:90a:6a01:: with SMTP id t1mr3496203pjj.31.1630391511361;
        Mon, 30 Aug 2021 23:31:51 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z67sm16827221pfb.169.2021.08.30.23.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:31:50 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:01:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] gpio: virtio: Fix sparse warnings
Message-ID: <20210831063149.gcctzqtn635mn3wb@vireshk-i7>
References: <32ab7b833743449b21f529cae41f4cbb60dc863c.1630387746.git.viresh.kumar@linaro.org>
 <20210831022224-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831022224-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-21, 02:25, Michael S. Tsirkin wrote:
> On Tue, Aug 31, 2021 at 10:59:25AM +0530, Viresh Kumar wrote:
> > Fix warnings reported by sparse, related to type mismatch between u16
> > and __le16.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I'm not sure which tree has the above commit - can this be squashed?

It has gone via the GPIO tree:

https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/log/?h=gpio/for-next

I believe it can be squashed, Bartosz can confirm the same though.

> Also, the driver lacks a MAINTAINERS entry - we want at least
> L:      virtualization@lists.linux-foundation.org
> on all virtio drivers.

Sure, I will send a patch for that.

-- 
viresh
