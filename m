Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87D409E98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbhIMUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbhIMUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:54:57 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D402C0613E4;
        Mon, 13 Sep 2021 13:53:27 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id e206-20020a4a55d7000000b00291379cb2baso3834713oob.9;
        Mon, 13 Sep 2021 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eowsm0WXQayq+f9h1wgvwR/JZtrOX+En4eFl7+WOlJs=;
        b=g5uzMEgnMFOubg6Z8h0lpgOqktkRalXsNb3Mt7L1Ph2REfEY4vab+FDFNdC6yS2cge
         K24dMT291o9tC2ixgmOZR4sFmqurRXf+uEmV3d/WwTVSpp5hx1aHRYl6LOYWoAg4DpZ8
         lJ8Vm88ntwrJjaId0AqE9wYlifbt5NvWlhw+RWYHBG2yHbbnQtrs2GEF/mwuF+SXzoIw
         hXVq27QMLtMrk8yIkVNvd0O4xD9DS0DgDAkUNIEvyELLSqsyhUdaYkqG+UEq39ZUlwXe
         XxgAFyar7gckkiu/ZFJvi/fbaV5qGM8QNCumjsH/d2TMNOTNI3OR7xX99kGaWXuEzWIz
         E0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eowsm0WXQayq+f9h1wgvwR/JZtrOX+En4eFl7+WOlJs=;
        b=lcctXSL0yRnjkxYF30VJd9n9Iy/YqURqZQxl+ekagGjB5JoAmwwhOUatLSJgrr+hNp
         Fh0dnu6y8fEFnGIGFjbB08hXQDq5uLWJUQYwKTcy5uCg5n41vBCiadAGTZ5ylShOkzhp
         +ZQ8SFbwbt7XeGZDPCQm2nXAC+jeNjtBM78uhDkccuk0IPU2YIwjJTIVkqqJzJdW93ma
         M+z3Qc7o5ho8uix6VwuhP+NnUdFNkiSdEeqoRFzCOrLXKyJVdY8kMRuDpWqDNFv7GwfG
         LzdN0uIzJrnAKOm/8FBZIkLKnyWyX2ANDd96C0vBoSTJMvCTo5sdTksLRVyzppA9VYQ+
         ddWw==
X-Gm-Message-State: AOAM530EvKgqAvetVc+OrPN8SJAsWcufRULcFKuL7UC5+MFTr2d1iPAg
        xpV843EYBaiROwdtgtqxfJE=
X-Google-Smtp-Source: ABdhPJwLuPVzLTHtC96D5WTpwJctZ5+XjhCzJhzFN7Xv1kWCz8/WlSYJUBNBwuzZySkRTQGmvjsbYA==
X-Received: by 2002:a4a:800e:: with SMTP id x14mr10837623oof.80.1631566406399;
        Mon, 13 Sep 2021 13:53:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm2120794ooa.42.2021.09.13.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:53:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Sep 2021 13:53:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
Message-ID: <20210913205322.GA1076369@roeck-us.net>
References: <20210913104640.85839-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 06:47:46AM -0400, Michael S. Tsirkin wrote:
> A recent change checking of_device_is_compatible on probe broke some
> powerpc/pseries setups. Apparently there virtio devices do not have a
> "compatible" property - they are matched by PCI vendor/device ids.
> 
> Let's just skip of_node setup but proceed with initialization like we
> did previously.
> 
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

This patch also fixes a similar problem seen with sparc64.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> 
> Arnd could you help review this pls? Viresh is on vacation.
> 
>  drivers/virtio/virtio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c46cc1fbc7ae..19a70a2361b4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
>  	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
>  	BUG_ON(ret >= sizeof(compat));
>  
> +	/*
> +	 * On powerpc/pseries virtio devices are PCI devices so PCI
> +	 * vendor/device ids play the role of the "compatible" property.
> +	 * Simply don't init of_node in this case.
> +	 */
>  	if (!of_device_is_compatible(np, compat)) {
> -		ret = -EINVAL;
> +		ret = 0;
>  		goto out;
>  	}
>  
> -- 
> MST
> 
