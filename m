Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AF32749B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 22:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhB1Vbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 16:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhB1Vbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 16:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614547816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXqPeJKg2QGKVw3n7fJTnHQgpBneaYrsq3vZdSqlW7k=;
        b=bNK8l67Anlr43q1AH9mr4lEiOHcam3OQ2Pv3UY0ND5O9TTqh08oaCICDE2Hs3H/fdPTopN
        c4FkwbXfs1hvbvB/YRA1Bmbqag0w8lNs1anr1X9QXN0sE3ij9MtX/9O1kIVd0OxmjISfi8
        GEA94oVl2MyToI46mkfAzDoXAOHHTRU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-M9Xw7jn8P6CTBEvHRy1rZA-1; Sun, 28 Feb 2021 16:30:13 -0500
X-MC-Unique: M9Xw7jn8P6CTBEvHRy1rZA-1
Received: by mail-ej1-f69.google.com with SMTP id ml13so5640401ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 13:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CXqPeJKg2QGKVw3n7fJTnHQgpBneaYrsq3vZdSqlW7k=;
        b=dqmgUMPfWlPZMmeBaJdlDjgLJrAeSC1stZrT/qjwwffthL/MqQVjhTApF3fQZEmaSl
         nm5FhqW+y+BZP6C1ahCCL5lwE0LHSBgHgPWE72JcZWWQZzyoKd4XRt/ABwgxsiqEqjDv
         +aBQhPwyBlTDF1SC2g9J6UuKEJCV8CJT/eMiRhHQ6fa2gSwL+BtAQ5kAHP0sUr9gC/RH
         MpFiRTAucGuOw4QGX1tUegcKYwN6GkLXu5ZTg5Lo4eqRRRXT2dghbNfLAF+SFtYQFtTR
         T73djXenw7LoWUU7pZQHWGJYj2Z+vRYH9Xgay5TlgI7jfPB5nOIKItZXHLT47W5qLIB8
         LKpA==
X-Gm-Message-State: AOAM532CKXmRMvq7QRF65XncBW+aBcIdpPpUjM5F1KZ/hDYQUtL5NrtS
        PwQLRxeMfYl6TBasoIJsg0vDn5ozQUDB7lZjXe1MqxsydDBf3TKFfxxmAKF15ENIed6tde45ctg
        D++5rTNNX9GRp8FnGKV1SbVMf
X-Received: by 2002:a05:6402:3047:: with SMTP id bu7mr13480398edb.227.1614547811752;
        Sun, 28 Feb 2021 13:30:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQe0ItppMYhgmAUA2vjPEcmW4kC/4bt6WO+XXuj+FLAiEv0vViE+9442NUKWzZGOmTe4jrsA==
X-Received: by 2002:a05:6402:3047:: with SMTP id bu7mr13480386edb.227.1614547811608;
        Sun, 28 Feb 2021 13:30:11 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id e4sm11440644ejz.4.2021.02.28.13.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:30:11 -0800 (PST)
Date:   Sun, 28 Feb 2021 16:30:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228162909-mutt-send-email-mst@kernel.org>
References: <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
 <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
 <20210224021222-mutt-send-email-mst@kernel.org>
 <babc654d-8dcd-d8a2-c3b6-d20cc4fc554c@redhat.com>
 <20210224034240-mutt-send-email-mst@kernel.org>
 <d2992c03-d639-54e3-4599-c168ceeac148@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2992c03-d639-54e3-4599-c168ceeac148@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:30:37PM +0800, Jason Wang wrote:
> 
> On 2021/2/24 4:43 下午, Michael S. Tsirkin wrote:
> > On Wed, Feb 24, 2021 at 04:26:43PM +0800, Jason Wang wrote:
> > >      Basically on first guest access QEMU would tell kernel whether
> > >      guest is using the legacy or the modern interface.
> > >      E.g. virtio_pci_config_read/virtio_pci_config_write will call ioctl(ENABLE_LEGACY, 1)
> > >      while virtio_pci_common_read will call ioctl(ENABLE_LEGACY, 0)
> > > 
> > > 
> > > But this trick work only for PCI I think?
> > > 
> > > Thanks
> > ccw has a revision it can check. mmio does not have transitional devices
> > at all.
> 
> 
> Ok, then we can do the workaround in the qemu, isn't it?
> 
> Thanks

which one do you mean?

-- 
MST

