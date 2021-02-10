Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3494B3163AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhBJKXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhBJKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612951710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ontaDL3XvHswihYEf1iBGmLwX9Q6quQQDImWbCzSgjA=;
        b=W+ZtDtESJ/g+SlT2S3JO4cKESIlpec5YEZUPEMZQLVZj/x49m/Uw9OOERlOjXgP+MdzPmb
        gJLAXq0VJkgkfeucGWFnrGIgQDAc6gsaaVXj0XnvJWv9RZa4ZdE9jfV9mBRRD9uAO56hUA
        iULKrDU0qUPNbqZlv3Rg6VAg6FjquLM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-XDTVWMfpOZC1p8INQTxVWA-1; Wed, 10 Feb 2021 05:08:26 -0500
X-MC-Unique: XDTVWMfpOZC1p8INQTxVWA-1
Received: by mail-ej1-f71.google.com with SMTP id p1so2155982ejo.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ontaDL3XvHswihYEf1iBGmLwX9Q6quQQDImWbCzSgjA=;
        b=Gi9yAjlu05YDu902HnEvyH7YZhcgu/PqrStBxs9Xg3mNay/syEp6bhH59Hgt4Ff13/
         mC+CH2UY3fpw9W+8YKSOduguBbx0Yxl2xO7QcJC3ZJ9o5v5jW3owVcA9bR51Dri4Sjjp
         G9JuP94iOVOWKMDtC+Pn0TleSZQbprayE+yFfqnQE0YjHhUBtEaonAtjmxzrIChNEJYV
         7WkutHm6Ce8e11UdxBsw0uTs6LOEPt++szrY2ss7lZYVSJjAavTfqC4ga8pQbZ2dM1Bd
         3OTWdpM3N7UbEawpaGb/w4noZwptQVjdptx3ol1nnHKbYV3IoFxem/1FxKJuPGW2KOWN
         jriQ==
X-Gm-Message-State: AOAM533S1WGGI1QhvVqO0nIbsxWZ60K+vpX2n+jq1clr3/AIzGPWsP8o
        m+YBhTwMt7nuXdEgACvSCS+q2oN/VQIflruG3Dbr7ubzTgZ5AMJ7e+qLyECBWrH774gNWC1OxJd
        6pR+Zjsn9VJlMtvwKjg7OwEPO
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr2511041edx.78.1612951705281;
        Wed, 10 Feb 2021 02:08:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0LU/mdAflFnADXNKIn3t7DOly8D6XltpB9BIjATe9vPTcbrofZaI6VVEMbq9k9xFmYLXzuA==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr2511028edx.78.1612951705069;
        Wed, 10 Feb 2021 02:08:25 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id g9sm777753ejp.55.2021.02.10.02.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:08:24 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:08:21 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210210100821.aaye2cgmrpwhhzgn@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
 <20210209042530-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209042530-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:31:23AM -0500, Michael S. Tsirkin wrote:
>On Tue, Feb 09, 2021 at 11:24:03AM +0800, Jason Wang wrote:
>>
>> On 2021/2/9 上午2:38, Michael S. Tsirkin wrote:
>> > On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>> > > It's legal to have 'offset + len' equal to
>> > > sizeof(struct virtio_net_config), since 'ndev->config' is a
>> > > 'struct virtio_net_config', so we can safely copy its content under
>> > > this condition.
>> > >
>> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>> > >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > index dc88559a8d49..10e9b09932eb 100644
>> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>> > >   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>> > >   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>> > > -	if (offset + len < sizeof(struct virtio_net_config))
>> > > +	if (offset + len <= sizeof(struct virtio_net_config))
>> > >   		memcpy(buf, (u8 *)&ndev->config + offset, len);
>> > >   }
>> > Actually first I am not sure we need these checks at all.
>> > vhost_vdpa_config_validate already validates the values, right?
>>
>>
>> I think they're working at different levels. There's no guarantee that
>> vhost-vdpa is the driver for this vdpa device.
>
>In fact, get_config returns void, so userspace can easily get
>trash if it passes incorrect parameters by mistake, there is
>no way for userspace to find out whether that is the case :(
>
>Any objections to returning the # of bytes copied, or -1
>on error?

Make sense for me, but are we sure we don't break userspace if we return 
the number of bytes instead of 0 on success?

I had a quick look at QEMU and it looks like we consider success if the 
return value is >= 0, but I need to check further.

>
>>
>> >
>> > Second, what will happen when we extend the struct and then
>> > run new userspace on an old kernel? Looks like it will just
>> > fail right? So what is the plan?
>>
>>
>> In this case, get_config() should match the spec behaviour. That is to say
>> the size of config space depends on the feature negotiated.
>>
>> Thanks
>
>Yes but spec says config space can be bigger than specified by features:
>
>	Drivers MUST NOT limit structure size and device configuration space size. Instead, drivers SHOULD only
>	check that device configuration space is large enough to contain the fields necessary for device operation.
>

So IIUC in the driver we should copy as much as we can.

If you agree, I can send an RFC series and we can continue the 
discussion on it, but I think we should queue this patch for stable 
branches.

Thanks,
Stefano

