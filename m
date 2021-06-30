Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4F3B85C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhF3PLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhF3PLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:11:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC00C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:09:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so4516606pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qwm5a7S4d67APmjTQTuY/hq2xmS0TKPAGGqg/CRnPBo=;
        b=hQH2rW5/+D+sJ/vCi4D9X8JFCi1w+1YhK43zeTPcZwmHjtigMz7Hxi58hLvpUD+8hL
         SVROijWxos23t5Bb/r1YMi/mc8Qlw+LBTwkIUiGnwDG98PM+UoaKA+VhNbnNXA8clSry
         3ldvy7ODk38s0v9vbtVMyVEej8y/uv7Aw61OwDGVw//0fds4QMMRcHpqOZY8wLcHVsR2
         HE0T2XuJbZ9NOqgWdU6Qigdb4P/k4fjulqOovDJrE67zg57LT9uKxhlcwispghfWLBia
         hEQgsgBUr6LNJfYAlwn0AIuac1fIrsccm82oCVHZqn4WRMRnsiJDSZ2tL/2WGTWXXZQR
         DPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qwm5a7S4d67APmjTQTuY/hq2xmS0TKPAGGqg/CRnPBo=;
        b=OWAHMULvH8ih1gd8VbX/uLq0zQ0sSWuaSSeTF4FXq3l59nU53gdIT7czZYmEpGpnKa
         vut8PyYG5a8ZuR9gs8WE8Z2kvBO36lu1k76IZNi+HS0HFOF9WhhF9HASh1AsF6nxaLTA
         qDk96c+lEtbuQSuM8PsUcxNLBbnjQ90HC+nsHFOACHBYdADEoSqeNd5SnESWqNHGWCNS
         CNozBsSmH9Y+wWVMLIBYT5vv4TMQPBUSczBWNPVXj938gAjnFwr70GmrM+bsXBXMipJ+
         qIqXD4CkidGGu91fZFPybWzNu8CXFDTKwBbcdJ677zd5aT54PT5RzCxPypvWXb+F3Ran
         NW8Q==
X-Gm-Message-State: AOAM530kBdR9oHQuqxVDlZlCBWJh4SKsYXsYJfMaVOpjqnewRtluCY1r
        q01kuI82ZxvsIkwuoW3GGHS6fA==
X-Google-Smtp-Source: ABdhPJym5Xp6zNUdD2feUDXohHd8CRMVwRm3dGknfSKatUpwmL5kTwmKxG7StUS5g65JI3R/thswEg==
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr5005813pjb.49.1625065749166;
        Wed, 30 Jun 2021 08:09:09 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id f69sm3163333pfa.24.2021.06.30.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 08:09:08 -0700 (PDT)
Date:   Wed, 30 Jun 2021 20:39:01 +0530
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
Message-ID: <20210630150901.5uzjelg4k7xgbumb@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
 <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
 <YNnjh3xxyaZZSo9N@ninjato>
 <20210629041017.dsvzldikvsaade37@vireshk-i7>
 <YNyB/+fNK0u2bI6j@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyB/+fNK0u2bI6j@kunai>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-21, 16:38, Wolfram Sang wrote:
> > While we are at it, this has been replaced by a Rust counterpart [1]
> > (as that makes it hypervisor agnostic, which is the goal of my work
> > here) and I need someone with I2C knowledge to help review it. It
> > should be okay even if you don't understand Rust a lot, just review
> > this file[2] which is where most of i2c specific stuff lies.
> 
> From the high level review I can provide, it looks good to me. Block
> transfers are missing, but I think you said that already. Mising Rust
> experience, I might miss details, of course. But the general approach
> seems fine to me. smbus_prepare() will get a bit more messy when you add
> block transfers, but it still looks bearable, I think.

Thanks for having a look.

-- 
viresh
