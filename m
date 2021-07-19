Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9553CD200
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhGSJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhGSJxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:53:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64199C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:40:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so11843176pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K40Jyf6F4VypIX0uQQ58aazesoLZiATF2ozlOf/u82E=;
        b=tm6QKxQaVJ1rfx4hcKqkfQh+kNZs1qfo7yu8WQJ/aS2+N/K/j3hAC7EJoGOLcI7mki
         RbXLpX3EUAsaeCKfy7dK+lsB9pV6bpejySCGNZ0YrrUbjtL9cXrDtvYSaEOtKyH8Yl2h
         pQwq59Y80QoFdRlHXZ8BxNEhIWPeZUnsy31tQXJKRws0GQIqiqzGSSdf27UDzkXZs8WU
         e1QslQq68CgzpzJ9WZD1zQIK/3f5QCVmqRqT17KzPkbNDIEwoysrIasghiLrG6lc43/K
         0V/1IrT6lyVKAbt3+yYq/dWQNyTPcSMQk5oAmymYYQz6722hEl9bSCG0440pYjIpbs0r
         hcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K40Jyf6F4VypIX0uQQ58aazesoLZiATF2ozlOf/u82E=;
        b=VYc93i0dU17ID8I6vRxpugMpiluu+gTnPlUz1oLAT5jSs/7ZQ3VO+PSU8l0Dj09bcP
         Wu7HlUNLuOEt/SkdLvdlFkaXtiwkfHtp4BD0PYVoOrWD/Sd7V4ELZiBvF2GtTRox7HU+
         O7aaNYVKXo5ls2iMdD2L9UrB4cXQja869Y40OcrDszPx+Qi8A7JiPZ5qLiyopy2eh7Xv
         hSf2PVVMFVtCuSHuP17x3Z0YCuT9rv9Gd0/OnSymM3CiSdpczAooV/Iju6oF9wsrg0+x
         /HlNiapN6q3BUysns2fIYoVs97RO9wuwLcoayQgxz0e1tcsXU2c3GLBhg7MDZDpaWgu6
         u6kg==
X-Gm-Message-State: AOAM531RLv2UBwK1naJt8PjQxi7OoUG3P+M9VoVFpHg+ANX/TRA2LRYr
        rhfSorO7Rva65YWh+sfKVlMx4g==
X-Google-Smtp-Source: ABdhPJwl4MXidm+h6UyC6mKBdXmjy/5RSub0SZcKsJot16gWN5QT/b3nRghByFFqbqrk8t4XWLYxlA==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr24363136pjr.213.1626690819793;
        Mon, 19 Jul 2021 03:33:39 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id w5sm19850101pfq.130.2021.07.19.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 03:33:38 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:03:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210719103336.oyz6dppd5jf65w4m@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
 <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
 <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 23:07, Arnd Bergmann wrote:
> On Wed, Jul 14, 2021 at 5:43 PM Rob Herring <robh+dt@kernel.org> wrote:
> > I guess it comes down to is 'virtio,mmio' providing a bus or is it
> > just a device? I guess a bus (so 2 nodes) does make sense here.
> > 'virtio,mmio' defines how you access/discover the virtio queues (the
> > bus) and the functional device (i2c, gpio, iommu, etc.) is accessed
> > via the virtio queues.
> 
> It's not really a bus since there is only ever one device behind it.
> A better analogy would be your 'serdev' framework: You could
> have a 8250 or a pl011 uart, and behind that have a mouse, GPS
> receiver or bluetooth dongle.
> 
> In Documentation/devicetree/bindings/serial/serial.yaml, you also
> have two nodes for a single device, so we could follow that
> example.

So two device nodes is final then ? Pretty much like how this patchset did it
already ? I need to get rid of reg thing and use "virtio,DID" though.

-- 
viresh
