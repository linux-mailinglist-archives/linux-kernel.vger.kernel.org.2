Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAE33902A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhCLOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhCLOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615559891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wqR2VXBD9ShzLCVtX+qqk63mSGBNYYonntBUYfSNkBU=;
        b=Mm60Bo2e9yTWVZ52pVV9uU01ukeFBadzn8StzfYHq/JOajRhK09MS4M6rPh7rrrhBau4Na
        BVLQWuagqmheopdTtuNQfhVqD6xyPfV4KNIUWvilTZfWYMdWFmUZisPuCFK93WDOj7i8/s
        heKmq5nwTajareOJOKrDH3oGvtQAr1k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-jZSt8wWKPXe_hKyTv5KF-A-1; Fri, 12 Mar 2021 09:38:07 -0500
X-MC-Unique: jZSt8wWKPXe_hKyTv5KF-A-1
Received: by mail-wr1-f71.google.com with SMTP id h5so11207972wrr.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqR2VXBD9ShzLCVtX+qqk63mSGBNYYonntBUYfSNkBU=;
        b=FRJ+BzcDxYRi7xSuO+5Nze1iQkhLg0ZLZ82s2Hz3DuVLe11onLY9dmog4DKjaXqsFs
         0zPIRfxEv1MjqLZBsWS2Z+BlnOt7p+MioJRCc+AFlvnXZn04jjUo75ZcXtTe9sVRzhSb
         RuEGu/3ihlPFPfrw4myga2HiQWvghkwX7AIyRI1X4IBX3llHwZFE4NSBLuQ4Ah/xqMp5
         q+pdn6UgsAgG2hjrPyBldoNn7R0Z5c5IFwaGKKNRji/4tJccPXHNzz6+pWo2P7AhGKlp
         KTb640e3BgQJZn0Dsjors/d6lBeZbVmFCppZCmg7MHtAtKl/67wZ1PQb5CSn7neLkvrx
         e5eA==
X-Gm-Message-State: AOAM533PAXPaH+wzzJ3gYCzHTK5qhHb2F/YN4lp+liZn4WlmyBBD+oUr
        3dCOU4JlguS/YAmhHXzImIyY5py7SpFxNKjJpKNLWm9T/p3Fi0EgyVjVK0RGdt7PCPESf1Xfrq/
        KyZHUR4SU9rVEz+Fcy1mzO3ag
X-Received: by 2002:adf:a4d0:: with SMTP id h16mr14234136wrb.52.1615559886549;
        Fri, 12 Mar 2021 06:38:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCMOehTT6EynoUYujDmF8ZxV5JxPQ3Xa+h0M2h9lyxZbt2sDFpKhYb/X+GcurEHDbm83cQTA==
X-Received: by 2002:adf:a4d0:: with SMTP id h16mr14234110wrb.52.1615559886374;
        Fri, 12 Mar 2021 06:38:06 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id x11sm2760458wme.9.2021.03.12.06.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 06:38:05 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:38:03 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v6 01/22] af_vsock: update functions for connectible
 socket
Message-ID: <20210312143803.hcq4byotzx5x65j7@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307175843.3464468-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210307175843.3464468-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 08:58:39PM +0300, Arseny Krasnov wrote:
>This prepares af_vsock.c for SEQPACKET support: some functions such
>as setsockopt(), getsockopt(), connect(), recvmsg(), sendmsg() are
>shared between both types of sockets, so rename them in general
>manner.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 64 +++++++++++++++++++++-------------------
> 1 file changed, 34 insertions(+), 30 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

