Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF01314B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBIJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230176AbhBIJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612861131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhbSJj/u7/Klvaf0H1NUS1T/THomFeB/0I+b8lFOAhk=;
        b=GLROGT2nyv/pBH0NuJ+2XaxWJ0SBjjmXnnCpt5MmbbxftM7ACarlvgDNDkWBdaXCRn+Uvb
        fWw7/97Fudq3z7qAbStJTKKowNwrtaNH2yGEXZzpvEjGis72uAGXnCQjPW4C9PJvsR+J+5
        adcp86hEzZUVtJRRW65/Vw57YsU4JNc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Gqub-l8MPVicwhB55id2jA-1; Tue, 09 Feb 2021 03:58:50 -0500
X-MC-Unique: Gqub-l8MPVicwhB55id2jA-1
Received: by mail-ed1-f72.google.com with SMTP id f21so14177835edx.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KhbSJj/u7/Klvaf0H1NUS1T/THomFeB/0I+b8lFOAhk=;
        b=Z03DljT6b0Ql/h2UVESPcq6N+zPhLd4wrK5BGJuG/5pYMK1v7+MtJYDY4bfjxi3Q7L
         1/Dxh5Ey4cH+6yBvf0KWa3Wf1wgfsNmBgsjZTv1Uh86IrfEsjdMvXamGHsKl7j3NaSVD
         alwwQHd9FrFpMf6sHvcmMBK7NXIawJMw4n0M547Wv0uAqriCLDRtvJWlv3BKL1vBYjTV
         eZ/DxKY4OhTaPCWoTD0+go+DHl+fkHCZa8WBj0Iz4UQedLL6l3p6IwKWXOsqp/JevrmI
         ec563f4gV3XmmY1gGcIYcxUcGrdv1wGhAYl92Kh1XaqeWkkCtinc4+cxZqG7mU27r7IZ
         Z75g==
X-Gm-Message-State: AOAM533FFC9pMXNbfkNangx9LT04frRCDTDKM5uvCAz72mYI+8/z2Pfl
        XO8U0G9LeaQkUgXdgJ65XgsRa9/31eqVCEPNcK1R61pA0FKocTtPWMQI2fcJeEXsJbxUm9gIp/p
        gpUYfxETXi9w1OwdVsqqsRn3T
X-Received: by 2002:a50:ec06:: with SMTP id g6mr21664789edr.12.1612861128702;
        Tue, 09 Feb 2021 00:58:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymcI9SAwF3UFCLc61KiBRA73aQgsEZsgY8MckX3xcIQCybfwa4DFmWwXMZJgFEzdRLQKkl3g==
X-Received: by 2002:a50:ec06:: with SMTP id g6mr21664777edr.12.1612861128479;
        Tue, 09 Feb 2021 00:58:48 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id du6sm9918346ejc.78.2021.02.09.00.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 00:58:47 -0800 (PST)
Date:   Tue, 9 Feb 2021 09:58:45 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209085845.5zwtxacfgnbmnlot@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:24:03AM +0800, Jason Wang wrote:
>
>On 2021/2/9 上午2:38, Michael S. Tsirkin wrote:
>>On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>>>It's legal to have 'offset + len' equal to
>>>sizeof(struct virtio_net_config), since 'ndev->config' is a
>>>'struct virtio_net_config', so we can safely copy its content under
>>>this condition.
>>>
>>>Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>>>Cc: stable@vger.kernel.org
>>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>---
>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>index dc88559a8d49..10e9b09932eb 100644
>>>--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>@@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>-	if (offset + len < sizeof(struct virtio_net_config))
>>>+	if (offset + len <= sizeof(struct virtio_net_config))
>>>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
>>>  }
>>Actually first I am not sure we need these checks at all.
>>vhost_vdpa_config_validate already validates the values, right?
>
>
>I think they're working at different levels. There's no guarantee that 
>vhost-vdpa is the driver for this vdpa device.
>

Maybe we can do these checks in the vdpa_get_config() helper and we can 
also add a vdpa_set_config() to do the same.

Thanks,
Stefano

>
>>
>>Second, what will happen when we extend the struct and then
>>run new userspace on an old kernel? Looks like it will just
>>fail right? So what is the plan?
>
>
>In this case, get_config() should match the spec behaviour. That is to 
>say the size of config space depends on the feature negotiated.
>
>Thanks
>
>
>>  I think we should
>>allow a bigger size, and return the copied config size to userspace.
>>
>>
>>>-- 
>>>2.29.2
>

