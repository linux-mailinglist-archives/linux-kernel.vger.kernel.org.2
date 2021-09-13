Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19B409EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbhIMUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbhIMUzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:55:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564FC061574;
        Mon, 13 Sep 2021 13:54:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so15228561otf.2;
        Mon, 13 Sep 2021 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JhNwW9vKPdT/8xW2t5CnBHG5KTMvD7rZ1Q1VcJJES5U=;
        b=aAOcyW/3Q9/QTeYM94UGTMXq1FcYtUCn9FBGI/MFltxTl2PypT1ZbgcRQ4YQIVKebb
         zS7Z/qtGWxSwj5qgOopRIkw8uk4FKG1m7tUlDIvZ3QSAWAP9wN99VlQBqVrJ2CLk4cnb
         UAmZ+FvUa2Q4WTfR75zsoa+8QF1O1vS2O5DX9iEaJ3gHy3MuhHV+Nd3xHQmWKBWw37Sb
         4VpVcqk4aWmh30ccQLwFVA07TJNFdfE3sGr9UkFDPfZ7SPjGnBHGa9dqqufo5l07QQtJ
         fhua5lg0l4Yp/b5E5TOFFbEVbvLGvZeoBHlG9uR/NYBzB8qeSqznxG9VM3EwYs/wiTcI
         4b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JhNwW9vKPdT/8xW2t5CnBHG5KTMvD7rZ1Q1VcJJES5U=;
        b=EYxj4CV/MBpbA9cqHguVJTYPid941jw2khMB2KO/NYYaps1j9EYdt4Px1jM5YdCEvJ
         exqf6/REhzw/6GrUUs+eY9AmjRPJOAyWTK1EPW+ufJEHUcEKKfksM87y80BJxLxsfwqo
         NHRj2Rr4NSy0chI9Iivuw2Bi+UVW16rYAZHLNNO1q3aBLCkSVBfrrzyMHeCvBwXtm9ha
         mXChFji32hP8E0ywdXVyJaNJ1EhUixl4nCI4xjZfSB/f9KdSM0Id8I6vDe3ZJ1UIbFDD
         omLHrksw715TGneOoX2YAYC4s3mUDhLLD+a46P1a9ZBuVR9uaVm/ynjPTQdZTtndxbXR
         u3+g==
X-Gm-Message-State: AOAM530C+Vm65ODcOxeFfx7dcadAgxP4l8UjeGXLoJkYvj4JOdjhosdD
        8wYFBS7BDAjG/gjCbqb/OF0=
X-Google-Smtp-Source: ABdhPJxcJ1N6icl5s1a4lizrnA9pq1ecVtoE+OOOH7RyC3quPK4yUX9d7HkImt0eOEyoBSbMVE/nDA==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr11406547otm.215.1631566471411;
        Mon, 13 Sep 2021 13:54:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be5sm1960153oib.10.2021.09.13.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:54:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Sep 2021 13:54:29 -0700
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
Message-ID: <20210913205429.GA1085962@roeck-us.net>
References: <20210913104640.85839-1-mst@redhat.com>
 <20210913162308-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913162308-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 04:23:57PM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 06:47:52AM -0400, Michael S. Tsirkin wrote:
> > A recent change checking of_device_is_compatible on probe broke some
> > powerpc/pseries setups. Apparently there virtio devices do not have a
> > "compatible" property - they are matched by PCI vendor/device ids.
> > 
> > Let's just skip of_node setup but proceed with initialization like we
> > did previously.
> > 
> > Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> 
> Guenter could you take a look at this patch pls? Does it help?
> 
> 
I confirmed that this patch fixes the problem. I replied in that thread.

Thanks,
Guenter

> 
> > Arnd could you help review this pls? Viresh is on vacation.
> > 
> >  drivers/virtio/virtio.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index c46cc1fbc7ae..19a70a2361b4 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
> >  	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
> >  	BUG_ON(ret >= sizeof(compat));
> >  
> > +	/*
> > +	 * On powerpc/pseries virtio devices are PCI devices so PCI
> > +	 * vendor/device ids play the role of the "compatible" property.
> > +	 * Simply don't init of_node in this case.
> > +	 */
> >  	if (!of_device_is_compatible(np, compat)) {
> > -		ret = -EINVAL;
> > +		ret = 0;
> >  		goto out;
> >  	}
> >  
> > -- 
> > MST
> 
