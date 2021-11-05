Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B54460B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhKEIfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232736AbhKEIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636101179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSxcNVRVB/DnKZ4+R+U2HEVeDSNW0idhy+8Cu/Pwcx0=;
        b=APMT/2up7s68m7Hru2j/xMF7qi+7x3C2nOT1Lu9cxn33Pw3qiRgBFOwBthC6O9q+tEdd1o
        g4i3lFlEBSZWLdL6WhGN4FWj/OGo0DKEVyZSAsO9QLamTQqskivBkyb361q38YQM72OhLF
        vD+UeQBCLxywKBVfrIvBn2bS3F6/TAQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-BHL6sGacOX23kg6du7JCew-1; Fri, 05 Nov 2021 04:32:58 -0400
X-MC-Unique: BHL6sGacOX23kg6du7JCew-1
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso8249945edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 01:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JSxcNVRVB/DnKZ4+R+U2HEVeDSNW0idhy+8Cu/Pwcx0=;
        b=U5mt28TblXsJXtI7ShTqLPqmOqPDcE+qef1EGFUMaEjM8ozQO+GTplrRVm7f/9GOgd
         yt1rpSBq3pjG1hs6mMMgTMjY++MYzVqAboX/PUfxzUw7rpelkUsDf3SfhtnaiD7HIkbp
         sLWb2x+zlAR24hyRRawVCVPzvVjJRhP91UtZZvF7U0rKfeNYwJJ/hMjJxMOuCffV0dFa
         X66L5m0cmzHL2ZR+hTDfcVEwujm22QsQObKOyaCKZMo4YTAV6bGwwfKrTF02ZvDc0GZl
         hFD4WDxJlcrLFdrGUp9kSbZUbWx5TmJ5xFqDRUtl5UI5F1Pp2p8QKoqyziqz1BYmdWix
         TE4Q==
X-Gm-Message-State: AOAM5301AM8WC53+ue/hbaD0erJFCePhC+0whIVxuUPR1V8tEEoA338I
        TNAPNH1bJ9XxNmcXJ8b3/+m2lPwOy0mXn+2avpSDTYT7W/O/61pPHyug+S+h35ZEFDyZbrWftGW
        mxKR0tNH4gw4kVZYrQKPMHkSG
X-Received: by 2002:a05:6402:6c8:: with SMTP id n8mr44987882edy.38.1636101176829;
        Fri, 05 Nov 2021 01:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1GoJj1G+zOd7oQ+Yq/sGjIs8oFTI+82pGo9B8tvnTk8Cb+1Fmockzi86p8mv8w/4VBcIpXg==
X-Received: by 2002:a05:6402:6c8:: with SMTP id n8mr44987864edy.38.1636101176724;
        Fri, 05 Nov 2021 01:32:56 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id f22sm4127471edu.26.2021.11.05.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:32:56 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:32:53 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: Avoid duplicate call to vp_vdpa get_status
Message-ID: <20211105083253.y4mikalhbfwmcuhp@steredhat>
References: <20211104195833.2089796-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211104195833.2089796-1-eperezma@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 08:58:33PM +0100, Eugenio Pérez wrote:
>It has no sense to call get_status twice, since we already have a
>variable for that.
>
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
> drivers/vhost/vdpa.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 01c59ce7e250..10676ea0348b 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -167,13 +167,13 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> 	status_old = ops->get_status(vdpa);
>
> 	/*
> 	 * Userspace shouldn't remove status bits unless reset the
> 	 * status to 0.
> 	 */
>-	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
>+	if (status != 0 && (status_old & ~status) != 0)
> 		return -EINVAL;
>
> 	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> 		for (i = 0; i < nvqs; i++)
> 			vhost_vdpa_unsetup_vq_irq(v, i);
>
>-- 
>2.27.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

