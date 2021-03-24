Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23AA34704F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhCXEA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCXEAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:00:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAEAC0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 21:00:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w8so11045000pjf.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BvjxiqCyLdjZ9DE+rOSxQSIjsWumbqejyQY6hWGvjNk=;
        b=crP6sIAcefYbLFDARXUCZMUyNIqN1JlvND4DSJl8yHy4TTHdJEFdeIMdpABGT1HyIJ
         EOLjlDbC7VW3yHANayiDy3FNECnf0N8tw42pnpsZmjY5KwiRrrnoY7O5BLwjotpdHuVA
         XCNWRZRoXLL0k2OWAuI9KzpBleZiKJ4TbAxjxwMWZk8n5DSdVnKZlXyvP43lCKDNmxwL
         XYLz9HqgLiFjv9ncs45yNb/zBHbC1T5xTlDgvMmIXpwzwL0CvEIbrgSamcoUCOpNGXZi
         Hdf3gtvFgcU1YcxrfkVu1iRHP3bRHyRuOpg2eElzk+FEspGwVxACBJY+2X0gPlwLDvZz
         LEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BvjxiqCyLdjZ9DE+rOSxQSIjsWumbqejyQY6hWGvjNk=;
        b=me6NeS6UbvtSn9nLSeBUF860JWfynIM1uBsPRZDVSNdnHu0OTTtnSbitdoyCzWZCZ0
         005zSq0kMkQo6DxYNBMtpJxt4JK/x5jnxjUst65zB6WoBU+VHlUVQsSZ7pDU2Xpbuqxx
         SgSmj4sJtuqEqSaYkymV23TnIcoe/yAVcPuH1Fe/RIN7EFJd498WtW2UevwdaNl6bvPA
         VoNr6XGTUEV/XdnPRpwBylYx4FrFm8XhUFnkbsFCorP8LiIUizZ8vdLqctDD921jSYig
         g3mfEatlYcaqgJAaJXdhdNtr8xY6bEYgqyrvWyU+ETcrjY345q9xz8GEDuYwSRinEwwz
         kXXg==
X-Gm-Message-State: AOAM532+Vek2qinGkMHZsmQwUBeokkhVmwLm+xyuH00BDdX4wO6kSb9R
        /mZKP3H7B+pZ/7dcUHxCpX7lFQ==
X-Google-Smtp-Source: ABdhPJwI2dszTqiKaLfPxR18AlS5ErZh9EuAODw3IWfiwB4FKr8rgVC6CGU29eIHfVCARaE9zOAuIw==
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr1328740pjb.80.1616558423289;
        Tue, 23 Mar 2021 21:00:23 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id 14sm582900pgz.48.2021.03.23.21.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 21:00:22 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:30:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        yu1.wang@intel.com, shuo.a.liu@intel.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210324040020.xazfou6wgvvh74gs@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
 <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
 <CAK8P3a3OBUZC2nxaQ2wyL9EeT3gzXUX9sfJ+ZJfJUiJK_3ZkrA@mail.gmail.com>
 <3a671a0a-b0d0-be1a-5463-8124ff63684d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a671a0a-b0d0-be1a-5463-8124ff63684d@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-21, 09:17, Jie Deng wrote:
> I didn't see the "struct virtio_driver" has a member "struct dev_pm_ops *pm"
> 
> It defines its own hooks (freeze and restore) though it includes "struct
> device_driver"
> 
> which has a "struct dev_pm_ops *pm".
> 
> I just follow other virtio drivers to directly use the hooks defined in
> "struct virtio_driver".

Right, I think we can't use the SIMPLE PM OPS for virtio yet, the core calls
only the freeze and restore callbacks which are part of struct virtio_driver.

> For this driver, Both __maybe_unused and #ifdef are OK to me.

Yes, and so you should use only #ifdef here as Arnd confirmed. You shouldn't be
using __maybe_unused as there is nothing confusing here related to the macros.

-- 
viresh
