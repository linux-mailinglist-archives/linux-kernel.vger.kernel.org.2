Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0131E62F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhBRGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231764AbhBRFtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 00:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613627256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEzp7Q6dzVcDVJyytaj42+XIoYTvxu65V7wyoIhA9bU=;
        b=BrByRELS6LjfM12tnB4nHvECZy2qd5DbMH1broyn5e4YbFFbAw4r4v0g9H96bOyypgwKCM
        OwaN8u15OE+nxqtN1k0Y1gOG2aYWv8yk7bp8tELRZ/+ZMVR1DxdpfKTDmrFxqxN4mwu/wW
        gZhjfjLat+A8YRZkrxinlxlNDQdDYyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562--ipJzhiQPR6dI9UCcYvbFg-1; Thu, 18 Feb 2021 00:47:32 -0500
X-MC-Unique: -ipJzhiQPR6dI9UCcYvbFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CBC51936B66;
        Thu, 18 Feb 2021 05:47:31 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFCB05D9C2;
        Thu, 18 Feb 2021 05:47:25 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To:     Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
 <20210209042530-mutt-send-email-mst@kernel.org>
 <20210210100821.aaye2cgmrpwhhzgn@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5b748533-7091-cba1-50c6-3da2049bc354@redhat.com>
Date:   Thu, 18 Feb 2021 13:47:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210100821.aaye2cgmrpwhhzgn@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/10 下午6:08, Stefano Garzarella wrote:
> On Tue, Feb 09, 2021 at 04:31:23AM -0500, Michael S. Tsirkin wrote:
>> On Tue, Feb 09, 2021 at 11:24:03AM +0800, Jason Wang wrote:
>>>
>>> On 2021/2/9 上午2:38, Michael S. Tsirkin wrote:
>>> > On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>>> > > It's legal to have 'offset + len' equal to
>>> > > sizeof(struct virtio_net_config), since 'ndev->config' is a
>>> > > 'struct virtio_net_config', so we can safely copy its content under
>>> > > this condition.
>>> > >
>>> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported 
>>> mlx5 devices")
>>> > > Cc: stable@vger.kernel.org
>>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> > > ---
>>> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>> > >   1 file changed, 1 insertion(+), 1 deletion(-)
>>> > >
>>> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> > > index dc88559a8d49..10e9b09932eb 100644
>>> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> > > @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct 
>>> vdpa_device *vdev, unsigned int offset,
>>> > >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> > >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> > > -    if (offset + len < sizeof(struct virtio_net_config))
>>> > > +    if (offset + len <= sizeof(struct virtio_net_config))
>>> > >           memcpy(buf, (u8 *)&ndev->config + offset, len);
>>> > >   }
>>> > Actually first I am not sure we need these checks at all.
>>> > vhost_vdpa_config_validate already validates the values, right?
>>>
>>>
>>> I think they're working at different levels. There's no guarantee that
>>> vhost-vdpa is the driver for this vdpa device.
>>
>> In fact, get_config returns void, so userspace can easily get
>> trash if it passes incorrect parameters by mistake, there is
>> no way for userspace to find out whether that is the case :(
>>
>> Any objections to returning the # of bytes copied, or -1
>> on error?
>
> Make sense for me, but are we sure we don't break userspace if we 
> return the number of bytes instead of 0 on success?
>
> I had a quick look at QEMU and it looks like we consider success if 
> the return value is >= 0, but I need to check further.


So I think in the vdpa bus level, we can return #bytes and in vhost uAPI 
level, we can return error if the size is not expected otherwise zero?

Thanks


>
>>
>>>
>>> >
>>> > Second, what will happen when we extend the struct and then
>>> > run new userspace on an old kernel? Looks like it will just
>>> > fail right? So what is the plan?
>>>
>>>
>>> In this case, get_config() should match the spec behaviour. That is 
>>> to say
>>> the size of config space depends on the feature negotiated.
>>>
>>> Thanks
>>
>> Yes but spec says config space can be bigger than specified by features:
>>
>>     Drivers MUST NOT limit structure size and device configuration 
>> space size. Instead, drivers SHOULD only
>>     check that device configuration space is large enough to contain 
>> the fields necessary for device operation.
>>
>
> So IIUC in the driver we should copy as much as we can.
>
> If you agree, I can send an RFC series and we can continue the 
> discussion on it, but I think we should queue this patch for stable 
> branches.
>
> Thanks,
> Stefano
>

