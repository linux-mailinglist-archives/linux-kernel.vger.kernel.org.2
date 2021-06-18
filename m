Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C83AC813
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhFRJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230399AbhFRJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624010057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y0YXDU9YxlQ+hNYdZgdqLVuT+mH4+43SSYjLUVicsFM=;
        b=TbOvBev+vxhKFZjuvvxvg+Fbs3Sji4FwvtwsR1U0wrBtCmmypgqSn/F1jh4olx6j6K86r8
        MQnEOxQfpPVErFzmN7GzMG2KfQ/nQNCgb1ldlvUb23foQZjGjbSEjpU3y0gp/A53dd3XuC
        j5kCR0GcqrMalSAQC7dYSTSTXJoY/T0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-iQlzgIGFNM-7H6soyqfjYg-1; Fri, 18 Jun 2021 05:54:16 -0400
X-MC-Unique: iQlzgIGFNM-7H6soyqfjYg-1
Received: by mail-ej1-f72.google.com with SMTP id q7-20020a1709063607b02903f57f85ac45so1834616ejb.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y0YXDU9YxlQ+hNYdZgdqLVuT+mH4+43SSYjLUVicsFM=;
        b=ETBdo/a7l5HPEYh/BxlesvfEFKaUwWOZeTYY0GS+szSeVc1ko/Mb3FV0483qraDw4J
         s3kQb4Tuhvc3g44SN/cWyqPKzz3Owa2c88o9cN9p2jVtp5ft3wEAyFAAI47l5aK1zO/y
         WRcDX43IiKl6++x8fwvM9ANZljNb+Cm8Pk476hdIFxk6ehCqGmk2wb6QKQ9AI8w6qaL/
         im9Vpy4INEVuYo/Jn2HHKQ7TnzCa+1D9RZTZJlzy5s2diOski8FDxyanQ4D90qMofNIH
         EfVlPWNNsENOKNk8T7ijM2VfbK1ZsBaPQHaBVLUGTMmasesfQpAtCWLkND2tiJZsTxqA
         yI3w==
X-Gm-Message-State: AOAM530WNDktThshWfHBsJ4ud+PvPodxvVP1XDIgppbRGPSgCqYlymU5
        B9sUsNUbfH7UCXFbcvVB8UPKd6pqVyfJXFAUg1Zxy5IBPdZ0F1rv7wdlq6rNsfYP2vpC7yp+xEO
        APW8sfUO4PXJ+Hbz2YVKyYKAR
X-Received: by 2002:a50:c344:: with SMTP id q4mr813921edb.197.1624010055205;
        Fri, 18 Jun 2021 02:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWMR1bJzOfZ97L3/bNEKDwZD9gm2Oo2XE369CjGC2l9w0RaUVQn+dQb1wcWVE0CXQxEAZmHA==
X-Received: by 2002:a50:c344:: with SMTP id q4mr813911edb.197.1624010055087;
        Fri, 18 Jun 2021 02:54:15 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.252])
        by smtp.gmail.com with ESMTPSA id n23sm6101995edr.87.2021.06.18.02.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 02:54:14 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:54:09 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jiang Wang <jiang.wang@bytedance.com>
Cc:     virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        mst@redhat.com, arseny.krasnov@kaspersky.com,
        jhansen@vmware.comments, cong.wang@bytedance.com,
        duanxiongchun@bytedance.com, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        Lu Wei <luwei32@huawei.com>,
        Alexander Popov <alex.popov@linux.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 5/6] vhost/vsock: add kconfig for vhost dgram support
Message-ID: <20210618095409.q6s3knm2m4u7lezd@steredhat.lan>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210609232501.171257-6-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210609232501.171257-6-jiang.wang@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:24:57PM +0000, Jiang Wang wrote:
>Also change number of vqs according to the config
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>---
> drivers/vhost/Kconfig |  8 ++++++++
> drivers/vhost/vsock.c | 11 ++++++++---
> 2 files changed, 16 insertions(+), 3 deletions(-)

As we already discussed, I think we don't need this patch.

Thanks,
Stefano

