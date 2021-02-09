Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF45314BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBIJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:35:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhBIJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612863090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTBtQXm9+PZIPejujzW7OPUSsCM+yycqpB+qIdPgqFU=;
        b=IuofEZIVirlueozP8uYQajN9aDq0X4s+LpZ5BtUMoC+1fbXBzkSkX0IhKD568Dd8wJp+2A
        iA2a5/Nq1QqxRoxlOnKJ7/+ValX46CGRraQIEaVjx0TRc2yIX1NqN7yluhezyOZrUye20h
        Qz9WHXxnduIqf87pOd28nI8++QLHRD4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-pKItm4j4OUqcXShBsUe7Dw-1; Tue, 09 Feb 2021 04:31:29 -0500
X-MC-Unique: pKItm4j4OUqcXShBsUe7Dw-1
Received: by mail-wr1-f69.google.com with SMTP id c9so5875087wrq.18
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aTBtQXm9+PZIPejujzW7OPUSsCM+yycqpB+qIdPgqFU=;
        b=SmlYjT1ISB1QypyWcsrH4d6F2OScqctDhVY0/MgTdepit9E79s8Oe11f7ooge6lanX
         YtycpLCBz/OiweZOUkgLrgkcEGqszcFP71Ma4RDbrgc1o7TaD/h+6ZuBpbi1DyOFk+Hl
         aIXot51DaRcIVdWhha939VE+KFmj+znOxvKeBUGX/ZYUbZda+49zZeyZ+PqOFxLcoEpb
         0KYpjcxmQTErvk91Nvb9X8Rt39o9SBVoQZodY2ZnObCef6MYIv0n3HItqs/awfUmDXXW
         a7F9FszWds6w+GVmM0nrXat38HvoVCUA8wpvBGJw6iYjOhau6U34xOZEufxQzIaz7L2d
         nNgA==
X-Gm-Message-State: AOAM532A8jF9YKa05+7q1mgQ+vHWr81qY8PzBeT85tJ03mGM4zsOQ3/T
        QXmJkxeJ0M3xhn6ll7akDjvl9lKFKkrAqK4M9qPTmjh3b26RnK2SpZgJV8EugotkTyZ0FVBE7dX
        AdqyIlBjELS398uP+zqHu2JyU
X-Received: by 2002:adf:a31b:: with SMTP id c27mr411460wrb.188.1612863087244;
        Tue, 09 Feb 2021 01:31:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvQH6O/1Z4SbjyMQjmV5TIxqaUjNuCuqWmPnqSE9yF9i/anegjLrKjtiIcaYdnbBiGZuGg5g==
X-Received: by 2002:adf:a31b:: with SMTP id c27mr411442wrb.188.1612863087098;
        Tue, 09 Feb 2021 01:31:27 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id z6sm3318352wmi.39.2021.02.09.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 01:31:25 -0800 (PST)
Date:   Tue, 9 Feb 2021 04:31:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209042530-mutt-send-email-mst@kernel.org>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:24:03AM +0800, Jason Wang wrote:
> 
> On 2021/2/9 上午2:38, Michael S. Tsirkin wrote:
> > On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
> > > It's legal to have 'offset + len' equal to
> > > sizeof(struct virtio_net_config), since 'ndev->config' is a
> > > 'struct virtio_net_config', so we can safely copy its content under
> > > this condition.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index dc88559a8d49..10e9b09932eb 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
> > >   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > -	if (offset + len < sizeof(struct virtio_net_config))
> > > +	if (offset + len <= sizeof(struct virtio_net_config))
> > >   		memcpy(buf, (u8 *)&ndev->config + offset, len);
> > >   }
> > Actually first I am not sure we need these checks at all.
> > vhost_vdpa_config_validate already validates the values, right?
> 
> 
> I think they're working at different levels. There's no guarantee that
> vhost-vdpa is the driver for this vdpa device.

In fact, get_config returns void, so userspace can easily get
trash if it passes incorrect parameters by mistake, there is
no way for userspace to find out whether that is the case :(

Any objections to returning the # of bytes copied, or -1
on error?

> 
> > 
> > Second, what will happen when we extend the struct and then
> > run new userspace on an old kernel? Looks like it will just
> > fail right? So what is the plan?
> 
> 
> In this case, get_config() should match the spec behaviour. That is to say
> the size of config space depends on the feature negotiated.
> 
> Thanks

Yes but spec says config space can be bigger than specified by features:

	Drivers MUST NOT limit structure size and device configuration space size. Instead, drivers SHOULD only
	check that device configuration space is large enough to contain the fields necessary for device operation.



> 
> >   I think we should
> > allow a bigger size, and return the copied config size to userspace.
> > 
> > 
> > > -- 
> > > 2.29.2

