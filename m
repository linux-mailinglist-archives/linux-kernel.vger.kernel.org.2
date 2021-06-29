Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB73B6FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhF2Iyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhF2Iyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:54:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EAEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:52:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e20so17915708pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRDj6e+Lqnmeo3ZhydynJ+H5q+l8CnwAokRbOJM0nwc=;
        b=yVj+8Vh6JwKM1tH895sPcIlFKTgBt2qxInbHnxNMFWHV4he+OcXXLT/d2niuW/CEmt
         g9LYtuNyCBURRSH+gir2EOQsBc8Ms36tLjuJT6K3xh6IRdMyFSb/vFjLOmVfb+R1YLAR
         QlMG1UZ5m5WdsAhU4IQSZqywzzDbpO5q2umuw49EBwIfpxKkE7DFiYuzw1Y2Er+mWb8m
         uBtbkndiJ5HLBNFuecdEr6zQjvDbpCIzp9zK1jA91S0u2/HB63MQ9nqK9+RzGrxrXtem
         r+8542jeuxhdX+4v6UJSi0UBXrv6FsGVqiWxulZBWrrF/rPR6NkSMZGIlzG4PaEhALZR
         V28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRDj6e+Lqnmeo3ZhydynJ+H5q+l8CnwAokRbOJM0nwc=;
        b=F+3J/A7XcyI6rMDtifuQ5cLodmdsdVw66TpmK+CPPb6nF6fgdjvx8wa4sum9YiXJZn
         lw0oTTy0KmFbk8586i0YS+SeuKlRG5WUCXbB+aXnKaxh/dmNqCnRNf384Jie/rjHR/jA
         bvXu/FON2lrobXG5qUkG+d7tZzZIo951AbGHgOX7fxlMWqAdYpINCragKn/GOsFGNYb6
         HmYNIszC7JOdyXINxkSxVrersz1EMxWLGPYzcWmPOMBKFAZ5cD9oT2D/QXx++FHsLsnz
         8qgSwMIL8YrRvKTor3ykrgghzfZL3u89mIUh3Y1TfCHH97cZa586Xi0K5SqbGv7BxWhM
         IZlg==
X-Gm-Message-State: AOAM531PJaTIeYjcW3x3OWI8T/IImiIqHXaLEPuCm0QZ5iNVYIEHBTKC
        MgvCJMW30egsMwRyw+f67Rel8A==
X-Google-Smtp-Source: ABdhPJxw2YQgANmJKSXb0azrt7CyxbCAGSM9vVRfeCOACPl0w7wdr4dlRe4f8Q2/+LafbzEvYR8owQ==
X-Received: by 2002:a05:6a00:d0:b029:30a:4c82:181 with SMTP id e16-20020a056a0000d0b029030a4c820181mr16562171pfj.27.1624956735846;
        Tue, 29 Jun 2021 01:52:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id t8sm17547212pjs.12.2021.06.29.01.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:52:15 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:22:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jie Deng <jie.deng@intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20210629085213.7a7eqcgkmtk5y7nh@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
 <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
 <YNnjh3xxyaZZSo9N@ninjato>
 <20210629041017.dsvzldikvsaade37@vireshk-i7>
 <YNrZVho/98qgJS9N@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNrZVho/98qgJS9N@kunai>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-21, 10:27, Wolfram Sang wrote:
> > While we are at it, this has been replaced by a Rust counterpart [1]
> > (as that makes it hypervisor agnostic, which is the goal of my work
> > here) and I need someone with I2C knowledge to help review it. It
> > should be okay even if you don't understand Rust a lot, just review
> > this file[2] which is where most of i2c specific stuff lies.
> 
> Can't promise I can do this before my holidays, but I will try.

Thanks.

> > I am not sure why you say I2C_RDWR isn't supported. The spec and Linux
> 
> This is how I interpreted Arnd's response. I said mulitple times that I
> might be missing something so I double check.
> 
> > SMBUS. To clarify on an earlier point, every virtio transfer may
> > contain one or more struct i2c_msg instances, all processed together
> > (as expected).
> 
> That was the information missing for me so far becasue...
> 
> > If you see virtio_i2c_send_reqs() in this patch, you will see that it
> > converts a stream of i2c_req messages to their virtio counterparts and
> > send them together, consider it a single transaction.
> 
> ... when I checked virtio_i2c_send_reqs(), I also saw
> virtqueue_add_sgs() but I had no idea if this will end up as REP_START
> on the physical bus or not. But it definately should.

Just think of virtqueue_add_sgs() as something that setups the
structures for transfer. The actual stuff at the other end (host)
happens only after virtqueue_kick() is called at the guest (this
notifies the host that data is present now), in response the backend
running at host will re-create the struct i2c_msg and issue:

    struct i2c_rdwr_ioctl_data data;
    data.nmsgs = count;
    data.msgs = msgs;

    return ioctl(adapter->fd, I2C_RDWR, &data);

So we will end up recreating the exact situation as when
virtio_i2c_xfer() is called.

-- 
viresh
