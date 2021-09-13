Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4410409E19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbhIMUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhIMUZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631564644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhPD0uUD31I/CKuX1ZppKPQ477bEoW/ZxvwAE00nVcg=;
        b=GtumtC5Y7X1IXmNlVTCC/WxDY62tfTkYFrAwe8+TnWHO40Rbt9Z/ZM4NjVQjg+PeX1CgIi
        P3IwRcGrMBq/ErZjJLLkyqZdrqQhfZ+Ld415iJJjP8+QX9wJfCRiYPzlIfF9Akces9LBbT
        8vme7MV9X2zBItQHkJBmDc4T20pbxvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Di83G6YZOm6doFCI2-dLuw-1; Mon, 13 Sep 2021 16:24:03 -0400
X-MC-Unique: Di83G6YZOm6doFCI2-dLuw-1
Received: by mail-wm1-f69.google.com with SMTP id b139-20020a1c8091000000b002fb33c467c8so5406410wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NhPD0uUD31I/CKuX1ZppKPQ477bEoW/ZxvwAE00nVcg=;
        b=3W/tRQD0pXEhSj8dUQb9E0SwLKSw27cWLlPPtGAYXUYBrTF+IHEE3KI7iq/JDDqi29
         FhahwNByJRiqt128/bDdF67OhGa/HgZ4zDjYqDXMFj4+GKfvrCh48E11OiMQ6FkaTnds
         GGLIdFTt/M2UUZnX1njvbn1Q9p8QNNzHAQ9BQ5TMAy+vTJg5j8IwE5gCvntkM6PqzDIP
         /ghbXNxKc1EZrb5eFAaCxpnGfcjPg/vB1v5cRyD7aGpn5gMQipohMWE4SHQZIAmOygaK
         64iFlPj5kKYvOe/MReaj0JZpLpLIADg5zn9xXU1W7P/EU7vZ72QIVeosPPEqZmSQE+3t
         YSXQ==
X-Gm-Message-State: AOAM531nI30cfI1u6rI5460bZuoHkks9FExMgolCs8SzPXxIBaRqEfLn
        WA41GZaf8vZcMpM41e4tGv4j9lp6Oa18Jvxd1HoI76FwYWNXa9xyV3kqXnPkLgGEZxXu6NOHfef
        mHtzY69W4PlHGp+y6OxZgBlkP
X-Received: by 2002:adf:8b19:: with SMTP id n25mr15678737wra.216.1631564641939;
        Mon, 13 Sep 2021 13:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ4VPgchaH0UTtSoQXdz3pY1CJwy3IEzUFNkJqC0hstFpyRondLeVvmI4fHJvgYlZOixZWGg==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr15678716wra.216.1631564641742;
        Mon, 13 Sep 2021 13:24:01 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
        by smtp.gmail.com with ESMTPSA id j98sm8615187wrj.88.2021.09.13.13.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:24:01 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:23:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Jason Wang <jasowang@redhat.com>, Rob Herring <robh+dt@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
Message-ID: <20210913162308-mutt-send-email-mst@kernel.org>
References: <20210913104640.85839-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 06:47:52AM -0400, Michael S. Tsirkin wrote:
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


Guenter could you take a look at this patch pls? Does it help?



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

