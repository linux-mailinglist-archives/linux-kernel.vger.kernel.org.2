Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6317B322865
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBWKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232202AbhBWJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614074180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9UOXjMdz3lHTcWvMJyRl4DlsSgw/pGrzIfxZceKJLg=;
        b=Jejcd5Bl040MAtP1glRI3LPz46lM3FVn5BB1yGnQ0rEMhYaAIzlWuORWNz3zt+n9fWaEN9
        vbNQd+GSqnpfBNZglFJkG/pL7SsHz3sU+TnOj8U3EBD2lZpgXYNTRT0l0QzfMJlcvruhJt
        Q+aRYMczXooThOr2S2/Ixjm1MnlJVf0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-yyAYodmXNISC2EMfo6OOKg-1; Tue, 23 Feb 2021 04:55:42 -0500
X-MC-Unique: yyAYodmXNISC2EMfo6OOKg-1
Received: by mail-wr1-f69.google.com with SMTP id e13so7129053wrg.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+9UOXjMdz3lHTcWvMJyRl4DlsSgw/pGrzIfxZceKJLg=;
        b=cxn2v5fjcRZP3XuSg4Po+g8g8Gu6Q1M+TU/7kYm3mzJiiAIZLxLltjMw4ZkS6yRs1X
         Juk0fR697mhQ1/0TLj+vaL/nedDGBPr4TkrRfOQ48tndgK/3/saVLLSOcxRUl7WxMix9
         l+wrBa958DhqbULr58K4zqVE3rQGyWNi6Yy1WyONjwnbwgBtOD4UlbEea9sbGRr7+LuK
         hcqoxAvmfyuLR40u9n6raO8i5FTvBHD693LEgqAfLECwwZ0M0Pq1ACSUUfsgeqdWHeYd
         PONgrDEMoT5i47YSGewnlZ9L25Xi0hkYJd2URG/QMl7pYQybDhB5JxqtlxSIeFbOaITM
         Izdw==
X-Gm-Message-State: AOAM533rhqPYKwMaVAaLKrXLJKuLH15nyiuIR/ocvVZMVNRMf4GqmW0+
        gteb9o/dpiGoEzp96HjwqnfTiXS3s/f5Lxl3oiBfQ0XFGJ9uCwaNgPdKLnSmXeHpyqmIXyAaoh9
        65H8Jjji70E6fMgcl891+pn/q
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr12417524wrm.253.1614074140893;
        Tue, 23 Feb 2021 01:55:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUnL19tqj/USYQ+8ZatPBcBGOycf7+tVGdH/yYlA4wjDSUTopCTrlMNHsMzZuipo+DmCRKag==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr12417508wrm.253.1614074140719;
        Tue, 23 Feb 2021 01:55:40 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id x66sm1978777wmg.6.2021.02.23.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 01:55:40 -0800 (PST)
Date:   Tue, 23 Feb 2021 04:55:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223045519-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
 <20210221165047-mutt-send-email-mst@kernel.org>
 <20210222060526.GA110862@mtl-vdi-166.wap.labs.mlnx>
 <20210223042559-mutt-send-email-mst@kernel.org>
 <65494f6b-9613-1c0e-4a36-e4af2965235e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65494f6b-9613-1c0e-4a36-e4af2965235e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 05:48:10PM +0800, Jason Wang wrote:
> 
> On 2021/2/23 下午5:26, Michael S. Tsirkin wrote:
> > On Mon, Feb 22, 2021 at 08:05:26AM +0200, Eli Cohen wrote:
> > > On Sun, Feb 21, 2021 at 04:52:05PM -0500, Michael S. Tsirkin wrote:
> > > > On Sun, Feb 21, 2021 at 04:44:37PM +0200, Eli Cohen wrote:
> > > > > On Fri, Feb 19, 2021 at 06:54:58AM -0500, Si-Wei Liu wrote:
> > > > > > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > > > > > for legacy") made an exception for legacy guests to reset
> > > > > > features to 0, when config space is accessed before features
> > > > > > are set. We should relieve the verify_min_features() check
> > > > > > and allow features reset to 0 for this case.
> > > > > > 
> > > > > > It's worth noting that not just legacy guests could access
> > > > > > config space before features are set. For instance, when
> > > > > > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > > > > > will try to access and validate the MTU present in the config
> > > > > > space before virtio features are set. Rejecting reset to 0
> > > > > > prematurely causes correct MTU and link status unable to load
> > > > > > for the very first config space access, rendering issues like
> > > > > > guest showing inaccurate MTU value, or failure to reject
> > > > > > out-of-range MTU.
> > > > > > 
> > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > > > > > ---
> > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
> > > > > >   1 file changed, 1 insertion(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 7c1f789..540dd67 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> > > > > >   	return mvdev->mlx_features;
> > > > > >   }
> > > > > > -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> > > > > > -{
> > > > > > -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > > > > > -		return -EOPNOTSUPP;
> > > > > > -
> > > > > > -	return 0;
> > > > > > -}
> > > > > > -
> > > > > But what if VIRTIO_F_ACCESS_PLATFORM is not offerred? This does not
> > > > > support such cases.
> > > > Did you mean "catch such cases" rather than "support"?
> > > > 
> > > Actually I meant this driver/device does not support such cases.
> > Well the removed code merely failed without VIRTIO_F_ACCESS_PLATFORM
> > it didn't actually try to support anything ...
> 
> 
> I think it's used to catch the driver that doesn't support ACCESS_PLATFORM?
> 
> Thanks
> 

That is why I asked whether Eli meant catch.

-- 
MST

