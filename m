Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9A45E3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357290AbhKZBIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 20:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243791AbhKZBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637888569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDyFTKO2QF1JvvfmCS1Hx11I7QAIU5JI9G0dgtPx/uM=;
        b=Y1CqvHkvS93Cnb7niNVhAHZIkt0CDqManBjl6pYnMdc06AhGKHuq1/iwO/1XvnN8Hefie6
        Me03DYNda4kSnSVCMyzuZzbebTON7NUwftpJAqc+ZdScTb4mWGLnvu5INt/wMcNsQuHmgg
        QUHl6ft3TLJ+4iU2fZOYrSQzhkgQLNo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-229-aEjGhxshOr6ERpqhGzqgjA-1; Thu, 25 Nov 2021 20:02:47 -0500
X-MC-Unique: aEjGhxshOr6ERpqhGzqgjA-1
Received: by mail-ed1-f70.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so6609030edr.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pDyFTKO2QF1JvvfmCS1Hx11I7QAIU5JI9G0dgtPx/uM=;
        b=0H/bafuBM32FEHIO0lPIKs6AR2o3wULnPNmmMgqxVwuQqx8JdQjxZJOf90C4Tg5BwC
         SY915TC3asYv2VR7Zz9IF4d+0g48dCZQaxrtSYihGGC4UtURgBgC4fjFjdX/ZTStzra2
         hgaCb+KuOuXw09hxSQ8Cpy2tTSn16oMJC4BRXXRvRLP0keewjZvVNozhtClImHYlNDOA
         rIBXFmw1ZvNJIqNxW0C5o2atP9t7b+NUDoTZkSRBm72G691npJXYd35G5qcKo4iggWzT
         CtrxaZ/xVh9RnG1QWlnP1gRxVXPWyAlT75l7prIO4KRj206/Kimm40lGZlk3Bnuj41cn
         a5Aw==
X-Gm-Message-State: AOAM532O12PTIgIYFxDtHA1b8DoBjLA2fMl+ea2LKctHO/RdBNcttT0v
        won0MUQtdQR0BtuNns0BKkyM/yqG0NOVn9QKE1uzTuNw+iRiR3rodT9I6DOeWXrhcYogtlbD/M8
        1HLQVvWkvp/NaUjJqobqbvqB0
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr36287489ejc.555.1637888566162;
        Thu, 25 Nov 2021 17:02:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMPqdXsVBsibJBeonfauIqf1MFangHN3wRhjaKDXYfs/2bZGG9BdweRbPr7wODShHNrf11lQ==
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr36287466ejc.555.1637888565979;
        Thu, 25 Nov 2021 17:02:45 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
        by smtp.gmail.com with ESMTPSA id gs15sm2097648ejc.42.2021.11.25.17.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 17:02:44 -0800 (PST)
Date:   Thu, 25 Nov 2021 20:02:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125195924-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211125154314-mutt-send-email-mst@kernel.org>
 <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
 <20211125161434-mutt-send-email-mst@kernel.org>
 <2B9668C9-427B-4D8B-A393-AAB5E50763C5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B9668C9-427B-4D8B-A393-AAB5E50763C5@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:58:56PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> >>>>> Device removal is clearly out of virtio spec: it attempts to remove
> >>>>> unused buffers from a VQ before invoking device reset. To fix, make
> >>>>> open/close NOPs and do all cleanup/setup in probe/remove.
> >>>> 
> >>>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> >>>> to be doing. These are transport enable/disable callbacks from the BT
> >>>> Core towards the driver. It maps to a device being enabled/disabled by
> >>>> something like bluetoothd for example. So if disabled, I expect that no
> >>>> resources/queues are in use.
> >>>> 
> >>>> Maybe I misunderstand the virtio spec in that regard, but I would like
> >>>> to keep this fundamental concept of a Bluetooth driver. It does work
> >>>> with all other transports like USB, SDIO, UART etc.
> >>>> 
> >>>>> The cost here is a single skb wasted on an unused bt device - which
> >>>>> seems modest.
> >>>> 
> >>>> There should be no buffer used if the device is powered off. We also don’t
> >>>> have any USB URBs in-flight if the transport is not active.
> >>>> 
> >>>>> NB: with this fix in place driver still suffers from a race condition if
> >>>>> an interrupt triggers while device is being reset. Work on a fix for
> >>>>> that issue is in progress.
> >>>> 
> >>>> In the virtbt_close() callback we should deactivate all interrupts.
> >>>> 
> >>> 
> >>> If you want to do that then device has to be reset on close,
> >>> and fully reinitialized on open.
> >>> Can you work on a patch like that?
> >>> Given I don't have the device such a rework is probably more
> >>> than I can undertake.
> >> 
> >> so you mean move virtio_find_vqs() into virtbt_open() and del_vqs() into
> >> virtbt_close()?
> > 
> > And reset before del_vqs.
> > 
> >> Or is there are way to set up the queues without starting them?
> >> 
> >> However I am failing to understand your initial concern, we do reset()
> >> before del_vqs() in virtbt_remove(). Should we be doing something different
> >> in virtbt_close() other than virtqueue_detach_unused_buf(). Why would I
> >> keep buffers attached if they are not used.
> >> 
> > 
> > They are not used at that point but until device is reset can use them.
> > Also, if you then proceed to open without a reset, and kick,
> > device will start by processing the original buffers, crashing
> > or corrupting memory.
> 
> so the only valid usage is like this:
> 
> 	vdev->config->reset(vdev);
> 
> 	while ((.. = virtqueue_detach_unused_buf(vq))) {
> 	}
> 
> 	vdev->config->del_vqs(vdev);
> 
> If I make virtbt_{open,close} a NOP, then I keep adding an extra SKB to inbuf on
> every power cycle (ifup/ifdown).

So make sure you don't :)

> How does netdev handle this?
> 
> Regards
> 
> Marcel

For net, open adds buffers to vq. close does not free them up -
they stay in the vq until device is removed.

-- 
MST

