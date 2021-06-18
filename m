Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441553ACCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhFRNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233873AbhFRNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624024313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4m43haMZkXo+6dMXFc2UeeK5bFqrx7krUnKM0CcDLn0=;
        b=YDGsMz+aYbC9Y8bemDniYqdmf8hii4zbdxoZby2JrQyv1RPCwAY2IOBvsQ86wf1chCVAoq
        tKqDp7Wb0s1blD0V+VcmIoyMaYhaCwQMDVEpr64P9Rql7zHLRTncYUp+lxHWHwIuIkE2LC
        VRh0SRlJHGBvlCPIVEp72MXiHbuiM1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-O_HUIpZxPMi-GerJ39A0dQ-1; Fri, 18 Jun 2021 09:51:51 -0400
X-MC-Unique: O_HUIpZxPMi-GerJ39A0dQ-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso3808035wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4m43haMZkXo+6dMXFc2UeeK5bFqrx7krUnKM0CcDLn0=;
        b=ccLkA6DhtBcKv6/4TKdu4jGhG+J1Jn/ost8Cg6CMDCZGwpN1if/Lj8Mz5eY0X1b2IJ
         TsFTLNUHg44lmG+onIxmC4CCEvE/9l2D386ZTeNb3OrKbW/5UaUlVGZOHIt17xUvVi59
         OT1Qi/Ds4y8SpBWeiYleNspThrTEJjdX4Bh8m58PJ/Qt84FebEBkIpi0dInELQSAUPsV
         wQDaBIy0zUFdTfWU/9XEkyG0lhrK9HuHp2V/iwxxf3m6nXhb3sM176zCVSphXmGw3Y6E
         al2gJsIP0EwDwft8DJIagKcEe6qqU7FTO7XdEfGxFGrLf0akrxRor1jkZkeLJQRj2coZ
         vR5A==
X-Gm-Message-State: AOAM530gjK553X7DPO184kUZ3mam11W/MFwtH2NK6hbQVht9G/j6rMQM
        jAAOStAwugug0QNcQiG/QdgjVCItihf7QlAQ9oZFkJsxBMwhSFyQAIm0Yl/Q2R7l86rLbZuXQhA
        PWoEGjUxlRV3t2jHrThRIbf+1
X-Received: by 2002:a5d:6350:: with SMTP id b16mr12960565wrw.41.1624024310550;
        Fri, 18 Jun 2021 06:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqJ3GZeW6jRvmnJbJ7b1ZhOousWSFHH5OW+Xxp1vDn8d5uUTDBmjRCWu6e4mCUYbWrxf7YAw==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr12960548wrw.41.1624024310425;
        Fri, 18 Jun 2021 06:51:50 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
        by smtp.gmail.com with ESMTPSA id b11sm8767138wrf.43.2021.06.18.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 06:51:48 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:51:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        oxffffaa@gmail.com
Subject: Re: [PATCH v11 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210618095006-mutt-send-email-mst@kernel.org>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <20210611111241.3652274-1-arseny.krasnov@kaspersky.com>
 <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 03:44:23PM +0200, Stefano Garzarella wrote:
> Hi Arseny,
> the series looks great, I have just a question below about
> seqpacket_dequeue.
> 
> I also sent a couple a simple fixes, it would be great if you can review
> them:
> https://lore.kernel.org/netdev/20210618133526.300347-1-sgarzare@redhat.com/

So given this was picked into net next, what's the plan? Just make spec
follow code? We can wait and see, if there are issues with the spec just
remember to mask the feature before release.

-- 
MST

