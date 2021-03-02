Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45AC32A179
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577402AbhCBGWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbhCBELp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 23:11:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55536C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 20:01:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so12970647pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 20:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFBpOaqnIYwYnvUE7iGG9eoxcoU1KoADt/9w4iLg1yw=;
        b=q0OEep7CBUYxMngfrjMfv3HZu1xA48/HR3WYDg8qoU56rfayFbakMoW82KYFzgKiKF
         VgHLKajrxipKwAGxsfOn2tcuvEY8sR8HfPh+6P1FYTj3AEgzbvUIoor9ftbErqzATWYr
         xFDJno2Q0y9X4K3L3vcm4y+X5ekiPoux6piKGtXBCnhSTBIb72yCypB5bhP1CeBXkBR4
         twotd69qrl7DT1eum1/QK9XD8i0rKweAd5TP7ktTNAtcRD3/ZOqpAB8+sY50IZPGkobt
         GfN1auFf741DxgpuvNjEWBCO/KsejxjnrqbOo8qnqU3LlFezhBttzLbe+jQ+3Pv9rWlI
         8YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFBpOaqnIYwYnvUE7iGG9eoxcoU1KoADt/9w4iLg1yw=;
        b=V8xivaIq/m7BrCQhkfgDdG4x4rc3v3CMXgfJQqXEUz1Y83Rfa6aKRvtxKjogNYjnNL
         n3VkIugfIt2FsyaxeuBH95JasnzzkxigJuCOSK4TF7GjRjZHfMHP8Q+Slcm2GuQUs+7O
         Zzk50fImvdF+H71jdsMDoQgHhvU9vx0UyAmfhB1VceScIAYCTbqCQ0AkB/QQ08VBbCeD
         JcjwOxg371FaPntF+ZZWTE083bvCE6svOA+n11Kcdfir7orPm2/N6X6Ks3FC6643N049
         GGCprDeuwXq0vaD6HFA0CwO5liVDarUz/I/CbSZt+76W4LYoBO98f3KKVa6fIwMa9iRC
         QMXQ==
X-Gm-Message-State: AOAM533cLa6J3/pqzLzlOY1Nm3H5frAeuRHXQI9dUDQVzEp9/hA1GG5z
        vxalzcAbSxA5hC/FXSR+PjCdmQ==
X-Google-Smtp-Source: ABdhPJwbjaFWc0Ydncg0uXfe9DLT4ZT7DoinOOCZ+jmQSnlLVm/5KAgdBGUCxAUDY6noeHfJpmIz+Q==
X-Received: by 2002:a62:4e92:0:b029:1ee:251d:50a1 with SMTP id c140-20020a624e920000b02901ee251d50a1mr1492865pfb.53.1614657677648;
        Mon, 01 Mar 2021 20:01:17 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id c29sm17523742pgb.58.2021.03.01.20.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 20:01:16 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:31:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jie Deng <jie.deng@intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        conghui.chen@intel.com, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
        Tali Perry <tali.perry1@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        yu1.wang@intel.com, shuo.a.liu@intel.com
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210302040114.rg6bb32g2bsivsgf@vireshk-i7>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-21, 16:19, Arnd Bergmann wrote:
> On Mon, Mar 1, 2021 at 7:41 AM Jie Deng <jie.deng@intel.com> wrote:
> 
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_i2c.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> > +/*
> > + * Definitions for virtio I2C Adpter
> > + *
> > + * Copyright (c) 2021 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
> > +#define _UAPI_LINUX_VIRTIO_I2C_H
> 
> Why is this a uapi header? Can't this all be moved into the driver
> itself?
> 
> > +/**
> > + * struct virtio_i2c_req - the virtio I2C request structure
> > + * @out_hdr: the OUT header of the virtio I2C message
> > + * @write_buf: contains one I2C segment being written to the device
> > + * @read_buf: contains one I2C segment being read from the device
> > + * @in_hdr: the IN header of the virtio I2C message
> > + */
> > +struct virtio_i2c_req {
> > +       struct virtio_i2c_out_hdr out_hdr;
> > +       u8 *write_buf;
> > +       u8 *read_buf;
> > +       struct virtio_i2c_in_hdr in_hdr;
> > +};
> 
> In particular, this structure looks like it is only ever usable between
> the transfer functions in the driver itself, it is shared with neither
> user space nor the virtio host side.

Why is it so ? Won't you expect hypervisors or userspace apps to use
these ?

-- 
viresh
