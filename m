Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4A32A148
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576943AbhCBFfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbhCBDng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:43:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D7C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:43:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s23so1022043pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hy5LXvf57LZa3+RpQ6HC/NoCXe1QM4rNzTl2I4J3TjE=;
        b=QcYlEuaaNB4xFOl9Rqyh00cFXU77wzJAFt9VOgkvBJjZGwYL6JrZ5DszoTmkUNcX/J
         p7ps4G3zHjq+qWWnFMoC//uVFPYxYLOJiflnZ/w24aoATEsnRV17dw1YcinFIQsGIA+V
         X0RRG2avoocQuwA3WYRHeyBnuIYpz3g61W0nmUXC5/ewy7Yr7Thudr6U5IEJWyG6eLlr
         cvCUgH8hQkURdya6G31XQqn0XE7Gf5tW22L51hQP7OSkRtc0NONkAXcGQ55UQljJHtWL
         WOE3H4Q1qAn47GESe8hm88JUk207szylRi3Xy64wDkXx/c92cYbvjnx/T1iU0nos9YC5
         qpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hy5LXvf57LZa3+RpQ6HC/NoCXe1QM4rNzTl2I4J3TjE=;
        b=htjMw8cUFAtD7Tx3EBRBVUOc4H9C/Dl/WMvUMBDjdvRsNVq/OjdudmGAdg6H5sS+OB
         bunm4Se/W/AK8z7VUrpGc37VrS6hjxPn8vhdB72s36YN2mcdSt4xc4kGFgF3ShrZS5GB
         uGX4b8VHuLd8g9H3GyBDcUrXFLVIM93fqoeIodHsvUFFjY4T83pQ53kn1ovDext22iiF
         t6JH3EJd4/R4faUZBFvy5bx2k4pTFMok86H6svrhEeEKCjsKSEErIOKphqleCrv/cihI
         gJRyPgAN4Z+ym0UFE+Qtff0G8sAKrwQyzGXZZ+7yEQ/wyfv6e4AIH8p2x5VvMP7wkydA
         ZouA==
X-Gm-Message-State: AOAM530GR9GJ2jxDx8JjkpfHNjsDE5bR32+LdlloXp24zhA1QpTLozUn
        1FT2zQbqUFFK8LnH1k998uaUXw/H7XdylA==
X-Google-Smtp-Source: ABdhPJxSIeHCI5UBdNvYJMP/ZjaOXgBUAVrkKZxBp0rJYdujXU537X58A4+EKAEDi1umZfgoCc6KeQ==
X-Received: by 2002:a17:90a:5206:: with SMTP id v6mr2256372pjh.22.1614656606013;
        Mon, 01 Mar 2021 19:43:26 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id w18sm962138pjh.19.2021.03.01.19.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 19:43:25 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:13:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, wsa@kernel.org,
        jasowang@redhat.com, wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210302034323.gkqymzngyqofrdsr@vireshk-i7>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <16efea9f-d606-4cf9-9213-3c1cf9b1a906@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16efea9f-d606-4cf9-9213-3c1cf9b1a906@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-21, 10:21, Jie Deng wrote:
> On 2021/3/1 19:54, Viresh Kumar wrote:
> That's my original proposal. I used to mirror this interface with "struct
> i2c_msg".
> 
> But the design philosophy of virtio TC is that VIRTIO devices are not
> specific to Linux
> so the specs design should avoid the limitations of the current Linux driver
> behavior.

Right, I understand that.

> We had some discussion about this. You may check these links to learn the
> story.
> https://lists.oasis-open.org/archives/virtio-comment/202010/msg00016.html
> https://lists.oasis-open.org/archives/virtio-comment/202010/msg00033.html
> https://lists.oasis-open.org/archives/virtio-comment/202011/msg00025.html

So the thing is that we want to support full duplex mode, right ?

How will that work protocol wise ? I mean how would we know if we are
expecting both tx and rx buffers in a transfer ?

-- 
viresh
