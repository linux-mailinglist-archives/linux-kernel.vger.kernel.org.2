Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81D1423BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhJFLAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbhJFLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:00:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7234C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 03:58:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so8727637lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4/bR370sJeXKagzVx84eEl7it6OjGumKTP1D7BeHtkI=;
        b=vwPdU129u5zyAAZVoq5ICdMKOAqzuAuD8txMDSGBEU46GJ20pL+UIOCx/7mI4hc77q
         1OsVnqF23iXe04QrTh3wZI7MHG/1JH9kERtU7AK4GKPoiWlgNbCk52wG4DqKWRZ9olkT
         NkC7f+9TKPi1uH36JHd0L/kZjZygZwaOM+CxyrDpPI7lfWS4tsS8ONgTfRr1V6FSL28I
         AU2yh/UT35MQXsj5axdshFQ0CLbHAHqlz752JmTqJ7O00P/9d5WaJ/Ha0VMTDyi6SAsN
         wbMug8QL+boYiymommIwzomg8dS1Cfr1pGVvMIjUVRtILQiKsEC5ek06xS6bCIcgfhQL
         PrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4/bR370sJeXKagzVx84eEl7it6OjGumKTP1D7BeHtkI=;
        b=RwYsdEc9LCfW8fzvqRVSPY8TsuJb79V38TAEaceVN5QyPTtosDRhzhvwh6F4Bejc0y
         EDwnw1G7usJVCsuQiYj3wOaERGyIA3CePPTDoZ/LbRSJSeJxbrnpaGwMZb++SbdXVZYL
         xC+yrWXvFC43HNgPd+jEqeqkSdW+awjUN46+TcQnSUia3f4JYLqWWiY9moBpZm22/bhc
         R7I+1VGw8QwF2XkZ/IX2BcCzRMLouJsykOILcurzh0SQhVcXzmirRypobbh5zAxMnYc3
         w8IVh/uIVY2WEz+qLPY+n5Qpx5puCUX5nvdc36InyGEcAOSN1vno7zWEgdMG5fzqx0cO
         6Drg==
X-Gm-Message-State: AOAM532sZ92zW5C4ZUZuYi5nuVk7DJd01JknFI2vLEFbOwy1l+y2eSz9
        ugUA9evaO0JxAMa7JU+ZjOyR8g==
X-Google-Smtp-Source: ABdhPJx+pnnfB8C3Cjf8Zh+CAzXxa1LiUWiRG+ojgXuj8NlzQ8P1qVROeh4QiQHfNpNhowl5wMx97g==
X-Received: by 2002:ac2:5582:: with SMTP id v2mr8987296lfg.143.1633517937070;
        Wed, 06 Oct 2021 03:58:57 -0700 (PDT)
Received: from jade ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id x2sm2247657ljc.59.2021.10.06.03.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:58:56 -0700 (PDT)
Date:   Wed, 6 Oct 2021 12:58:55 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jerome Forissier <jerome@forissier.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>, sughosh.ganu@linaro.org
Subject: Re: [PATCH v6 1/5] tee: add sec_world_id to struct tee_shm
Message-ID: <20211006105855.GA2555558@jade>
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
 <20211006070902.2531311-2-jens.wiklander@linaro.org>
 <2af3eda2-2ceb-4812-a813-ae3dff02cdac@forissier.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2af3eda2-2ceb-4812-a813-ae3dff02cdac@forissier.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:36:22AM +0200, Jerome Forissier wrote:
> 
> 
> On 10/6/21 9:08 AM, Jens Wiklander wrote:
> > Adds sec_world_id to struct tee_shm which describes a shared memory
> > object. sec_world_id can be used by a driver to store an id assigned by
> > secure world.
> > 
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  include/linux/tee_drv.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 3ebfea0781f1..a1f03461369b 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -197,7 +197,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >   * @num_pages:	number of locked pages
> >   * @dmabuf:	dmabuf used to for exporting to user space
> >   * @flags:	defined by TEE_SHM_* in tee_drv.h
> > - * @id:		unique id of a shared memory object on this device
> > + * @id:		unique id of a shared memory object on this device, shared
> > + *		with user space
> > + * @sec_world_id:
> > + *		secure world assigned id of this shared memory object, not
> > + *		used by all drivers
> >   *
> >   * This pool is only supposed to be accessed directly from the TEE
> >   * subsystem and from drivers that implements their own shm pool manager.
> > @@ -213,6 +217,7 @@ struct tee_shm {
> >  	struct dma_buf *dmabuf;
> >  	u32 flags;
> >  	int id;
> > +	u64 sec_world_id;
> 
> Wouldn't it make more sense to have this outside struct tee_shm in a
> driver-specific struct? (which could always be obtained from a struct
> tee_shm * using container_of() for example).

Yes, that could be quite useful, but the problem is that it's
tee_shm_alloc() that allocates this struct so it can't easily be
embedded in a driver-specific struct.

We could of course change that but that will require changes to the
AMDTEE driver also. I'm not sure it's worth the trouble though, since
the AMDTEE driver could make use of this field too.

Cheers,
Jens
