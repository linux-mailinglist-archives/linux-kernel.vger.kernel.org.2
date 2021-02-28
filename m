Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA943274A1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 22:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhB1Vga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 16:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230414AbhB1VgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 16:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614548099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ReI9nC5t0ilGJKO9iEAq6ntFlruOaE8Rz2Sr5GLVUJo=;
        b=Hm330mEl0HmLWRDSjiGWPTI+Ji90yV+g5IW3uZCqQqflFQy59EzDK1OadFZ32R2lQus2zQ
        mxeDp8lIhI9l9hQLSPXOIFeOXBY9STuLWZzl1iqEmMHdw/Ez61quNhLUixZ0I63MY/FQQW
        3ZTDPrjSV/JvZrJN06mOOGXJOSFH1s0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-B0xp6CNBNSqPRQIU_c-Wbw-1; Sun, 28 Feb 2021 16:34:58 -0500
X-MC-Unique: B0xp6CNBNSqPRQIU_c-Wbw-1
Received: by mail-ej1-f72.google.com with SMTP id au15so168428ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 13:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReI9nC5t0ilGJKO9iEAq6ntFlruOaE8Rz2Sr5GLVUJo=;
        b=GkiqPKcRwHDr+PGJJtURKcRXaG+336hgdlcn2JB3siFTBkMhQBlpI0/PlKQGZSBqh3
         UgZn58VuvQEsly3LLjWVX/v98FvBndXmvpxDYNVD+lA69YT5tXqkPYewF+c8n8vHbz5G
         pI1m4+M0rWYHt64pk4XWWrCrhtrxv2uBSAz+nVWg/grMoE+Ve+y3rZ0hfVhrcAxUblNh
         WULgFvP7G5A9E3Txb+JUgwalkU0gls4pVIgCa2Hao67xVOenhWZfBSSsZc8280uDuzqw
         gIwszepA2+f9hAKSsIFKNG5esgtybVkKRfn8urWEqiK1+zf7zHOnVbs75/b1mVLwoZxb
         kT0w==
X-Gm-Message-State: AOAM533NtPxonyeBptHbt7ZGMLp0Lm5O0hd9bNan2mRiOm4Et1YMXewV
        hC8ViwzBgf8TxML6vgz76iHtO6Jd8rmNTj1KdR+w0kNoRQcnOAU9+kA8WpoT5/3EkJOfmCl1lFm
        Zy164iZOEtOJbBn1C6o3LmyNG
X-Received: by 2002:aa7:d954:: with SMTP id l20mr9537928eds.1.1614548096612;
        Sun, 28 Feb 2021 13:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZfpQusPlK8SeLupsX5MkpMrCMoVqG9E1G+3AItVqjBlS3hF76KS3hDto3VFFR3Yt+hLv8gQ==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr9537925eds.1.1614548096518;
        Sun, 28 Feb 2021 13:34:56 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id lm24sm4333097ejb.53.2021.02.28.13.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:34:56 -0800 (PST)
Date:   Sun, 28 Feb 2021 16:34:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, elic@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228163031-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:24:41AM -0800, Si-Wei Liu wrote:
> > Detecting it isn't enough though, we will need a new ioctl to notify
> > the kernel that it's a legacy guest. Ugh :(
> Well, although I think adding an ioctl is doable, may I know what the use
> case there will be for kernel to leverage such info directly? Is there a
> case QEMU can't do with dedicate ioctls later if there's indeed
> differentiation (legacy v.s. modern) needed?

BTW a good API could be

#define VHOST_SET_ENDIAN _IOW(VHOST_VIRTIO, ?, int)
#define VHOST_GET_ENDIAN _IOW(VHOST_VIRTIO, ?, int)

we did it per vring but maybe that was a mistake ...

-- 
MST

