Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B394460AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhKEId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232721AbhKEIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636101075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPiyoiSRvncHrQx4lUP4gZt2i/XD5//Eik7XImjQZmI=;
        b=Zz1vGr6Qd2vHu475F0XThMGpduOwpVnLCHqIzDrahon7+sMcAyl4A6/r3EWRxr/C30GlN5
        RDFDkHCNPtrmqNWHiDZzgkrGc7M6yRcbjltieyZEycM2k5dCKdYH9m3NeSILY43VQdJCft
        udqztgvzQB3xewfIT7xtAZODOldRG4Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-dGe5nl2_P-iRt6sRVUhJxA-1; Fri, 05 Nov 2021 04:31:12 -0400
X-MC-Unique: dGe5nl2_P-iRt6sRVUhJxA-1
Received: by mail-ed1-f72.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so8187578edv.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 01:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WPiyoiSRvncHrQx4lUP4gZt2i/XD5//Eik7XImjQZmI=;
        b=ZOrkXWg687VmKdEWETiUt0O7chvpoUap0L7lLn3NKwvAWdFp7lpdbdbi+gxj9xKAGP
         9gviZ71TSjKWsB0qyxccZshEWViEtg+rZuiyKhXz9U4yenh7lvUwf3b5KNQg7gVVNHoI
         75bJV/aUOXK0TVhsBFKQdnUN5TRmqkntHNMcnTnEWNTXwzneG+3aWAajKE/Ay8oObIMR
         z0hVSSGvMY1Qf1C/wlC5L1GnTCXvz5hL+e+Ds34agwfleuYh8rroGU+fZesUUAYrxS+5
         8GFWPObKVyqYH3s85rA1ZY68EDmz9WDN6U7Kwfuo+3XYXTFqjje/8lahl9whhAGDBq54
         7wyQ==
X-Gm-Message-State: AOAM533I2TRPhBw/h9XULsK0gKVCkJRZcO2kwurGyxmzl/quWBBJyXgG
        bFuRh5fLo/pjs+86i1sTD1cogboJsahZ8WuzJFU3ptueBIqimuWiKvW5tDlLoyw5654dtUVPden
        a5Jm7UW4Hd9XFZwxA0GwEevwe
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr76653542edv.248.1636101071136;
        Fri, 05 Nov 2021 01:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7h923akD7WiTYrUKfGSfmOMcvIFCqZfZzbM91hCco7x+YgLQ12F58YTT8vDChWZht28poKg==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr76653511edv.248.1636101070913;
        Fri, 05 Nov 2021 01:31:10 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id di4sm3852618ejc.11.2021.11.05.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:31:10 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:31:08 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Parav Pandit <parav@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211105083108.kfubtzdbucs2drzs@steredhat>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <20211105080454.wpvtwa7el45kayem@steredhat>
 <CACGkMEvNZKc2K_bdKxiUmbLzoZL-Vdbc14+uw9Ro-2jzdFMRRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEvNZKc2K_bdKxiUmbLzoZL-Vdbc14+uw9Ro-2jzdFMRRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:26:44PM +0800, Jason Wang wrote:
>On Fri, Nov 5, 2021 at 4:05 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Nov 05, 2021 at 11:01:30AM +0800, Jason Wang wrote:
>> >On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> `driver_override` allows to control which of the vDPA bus drivers
>> >> binds to a vDPA device.
>> >>
>> >> If `driver_override` is not set, the previous behaviour is followed:
>> >> devices use the first vDPA bus driver loaded (unless auto binding
>> >> is disabled).
>> >>
>> >> Tested on Fedora 34 with driverctl(8):
>> >>   $ modprobe virtio-vdpa
>> >>   $ modprobe vhost-vdpa
>> >>   $ modprobe vdpa-sim-net
>> >>
>> >>   $ vdpa dev add mgmtdev vdpasim_net name dev1
>> >>
>> >>   # dev1 is attached to the first vDPA bus driver loaded
>> >>   $ driverctl -b vdpa list-devices
>> >>     dev1 virtio_vdpa
>> >>
>> >>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>> >>
>> >>   $ driverctl -b vdpa list-devices
>> >>     dev1 vhost_vdpa [*]
>> >>
>> >>   Note: driverctl(8) integrates with udev so the binding is
>> >>   preserved.
>> >>
>> >> Suggested-by: Jason Wang <jasowang@redhat.com>
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >>  include/linux/vdpa.h |  2 ++
>> >>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>> >>  2 files changed, 76 insertions(+)
>> >>
>> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> >> index c3011ccda430..ae34015b37b7 100644
>> >> --- a/include/linux/vdpa.h
>> >> +++ b/include/linux/vdpa.h
>> >> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>> >>   * struct vdpa_device - representation of a vDPA device
>> >>   * @dev: underlying device
>> >>   * @dma_dev: the actual device that is performing DMA
>> >> + * @driver_override: driver name to force a match
>> >
>> >This seems useless?
>>
>> I'm a bit lost, do you mean we should remove the documentation of
>> `driver_override`?
>
>I misread the code which was misled by vdpa_mgmt_dev above:(

Yeah, the same thing happened to me now while double checking ;-)

>
>The code should be fine.
>
>So:
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>

Thanks,
Stefano

