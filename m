Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D0314B23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBIJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhBIJBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612861220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ssXcbCxajiNCzH/D1KYh6ScyY3wgkyKhopHLnboLrLI=;
        b=GlJHpkFCSfhL5o1AIBP5hKA8FTVA3pjnZSDMN78maQUcunEaXZ99qj0PCL/vOXtAkgwke2
        4ejXnPRFlOleVQM6LDkEcfp+xjBaXBY1vAKSkEWXYFVW+IawCca4r15kGRmoaG51UcmYZW
        mVm4ujgnBT8v4hzyCJgOlzC05SIyMg8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-XZqVS7G5O8mcvsVKp8O1Lg-1; Tue, 09 Feb 2021 04:00:18 -0500
X-MC-Unique: XZqVS7G5O8mcvsVKp8O1Lg-1
Received: by mail-ej1-f71.google.com with SMTP id yh28so14981750ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ssXcbCxajiNCzH/D1KYh6ScyY3wgkyKhopHLnboLrLI=;
        b=Mu+9YnLPUrl6bWiAIrRd0GMmzS8wknc/ZXlhPMocAYLakyVxbyAm2BPucpqpgiLXW5
         zba6Bb71116Iaa/pIHqix/glx8H698RYsHZ0BV474SsLj2m0l+dr/tY7JqUGv07Bio4S
         FanIT4pWSD60jB6OzGhbS7wopYiFm1OtIftg87k4xwkbicFBizVh/AiMgMUlUaUBT9v+
         NdEQLVONqKExxlooPf3ccqGw6n/M0z/rYi2U9btmsn5ZjxsBZGcBKEtakSfJzorVwc+o
         aNQK7IbXHVCrXrF5CwEuL6gL6/V+pzvDz/VcodYf+7BNObR3ai4GifGHKXS+0s7A++tV
         mtVg==
X-Gm-Message-State: AOAM533G4dhkUwENMHTF47ddV0lorT+yeu8aB1QF7H28b4jZmLw5JDbR
        +v2VJu1o0F2PJyi+ZoGmCnHFUdQhrRsdJWWszp+W6gvzVPvbTdKUkkS/FoL0Nvsr6FQinRSEbko
        ZXsmYTxStN5hex5BBJ3CSxKZW
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr20677920ejb.170.1612861217139;
        Tue, 09 Feb 2021 01:00:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFhMR1s45N9hKd52KF7rZ7SoHNdNI4kdNR6gUmrzh6kavL86rdUETsPkBxOC2mPkBcOuN80g==
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr20677901ejb.170.1612861216952;
        Tue, 09 Feb 2021 01:00:16 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id a7sm10239416eje.96.2021.02.09.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 01:00:16 -0800 (PST)
Date:   Tue, 9 Feb 2021 10:00:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209090014.xolf5kxri3xdmacz@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:43:02AM +0200, Eli Cohen wrote:
>On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>> It's legal to have 'offset + len' equal to
>> sizeof(struct virtio_net_config), since 'ndev->config' is a
>> 'struct virtio_net_config', so we can safely copy its content under
>> this condition.
>>
>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Acked-by: Eli Cohen <elic@nvidia.com>
>
>BTW, same error in vdpa_sim you may want to fix.
>

Commit 65b709586e22 ("vdpa_sim: add get_config callback in 
vdpasim_dev_attr") unintentionally solved it.

Since it's a simulator, maybe we can avoid solving it in the stable 
branches. Or does it matter?

Thanks,
Stefano

>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index dc88559a8d49..10e9b09932eb 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>
>> -	if (offset + len < sizeof(struct virtio_net_config))
>> +	if (offset + len <= sizeof(struct virtio_net_config))
>>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
>>  }
>>
>> --
>> 2.29.2
>>
>

