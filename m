Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215C84047AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhIIJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232262AbhIIJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631179266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04XyEftP8B2cwyDDczs6wy9wXoFSsdoEGB0DdA8URak=;
        b=OsihiTBz08uuro15DIi+Qg7Z8yFYJKU5dNTYsK1ZHyjGR420Rq+wsBINjmnzR77NozREMA
        VjeVNktGvVI6LhE6eE/RLI6huhU4gQNNCaHlvLKNxF41sEw691nTdEwD9/7WdwSFACab4p
        atjBnFwEYHpGwyeLNfSlP6EBN1hWGZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-xJQpxtSkOF2r26i8_KHfKw-1; Thu, 09 Sep 2021 05:21:06 -0400
X-MC-Unique: xJQpxtSkOF2r26i8_KHfKw-1
Received: by mail-wm1-f72.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso469527wml.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04XyEftP8B2cwyDDczs6wy9wXoFSsdoEGB0DdA8URak=;
        b=K+KfX9sbMV33D6JHvroaAG4VJebudxErkkaxf3ZkUVOTR0dW2WH1vi8x8pqODy9sPa
         Ixl3BD6aMvH7MgXwVXq/H+92SmjXcw4IGY5wE9ORB2Z6R8LmEMzgDlTNrVddnoNNvzBf
         w1jKpwacRH78yBzJegPe1DRqpNCEIIAQW+G1BRSh9Kj4246rzLtZsUzKnmfKJPyaCcxr
         sb/NM9AiivQ2jwUcd2nCQFdqYcn97QqycblqV22CnTJP2irggREFoHB9WLhtMGmA9YjK
         C8vsJstaDER4D+fskaaLl3jrsREMuPK97b3fokGjzxb4rZbZ5tAMcadMT8nqYIo8FMpf
         U8hw==
X-Gm-Message-State: AOAM531YjwyQU1u3l9RMD8rziaypxyRxVVFjZy+4fbhMMuw9fwKe7QH7
        vUgyBhZ8tqueu1s29GVwwTFLGfDDXeAFnrQ1LdzJeKwQAyPGBKNewnDakumw1RMXup1eAdigmrv
        TY1JIxytm/iLC7r6adpZj/4jm
X-Received: by 2002:a1c:192:: with SMTP id 140mr1853783wmb.101.1631179264534;
        Thu, 09 Sep 2021 02:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH3E9jPavsm71ebZFBPTANtCVc1EXdmI5W8Sdc21rVamcMC90TidgLKRIzdbEGe5wv156Esw==
X-Received: by 2002:a1c:192:: with SMTP id 140mr1853766wmb.101.1631179264375;
        Thu, 09 Sep 2021 02:21:04 -0700 (PDT)
Received: from redhat.com ([2a10:8000:cbff::13])
        by smtp.gmail.com with ESMTPSA id v9sm999187wml.46.2021.09.09.02.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:21:03 -0700 (PDT)
Date:   Thu, 9 Sep 2021 05:21:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
Message-ID: <20210909051936-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
> On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> >
> > This series implements the vDPA driver for legacy virtio-pci device.
> > Currently we already have the vDPA driver for modern virtio-pci device
> > only, but there are some legacy virtio-pci devices conforming to the
> > virtio-pci specifications of 0.9.x or older versions. For example,
> > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > Draft specification. Such legacy virtio-pci devices have some
> > inconsistent behaviour with modern virtio-pci devices, so some common
> > codes are split out and modern device specific codes are moved to a
> > separated file.
> 
> What worries me a little bit are:
> 
> 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> if I understand ENI correctly, it's a legacy device so it can't
> support ACCESS_PLATFORM. Or is it a legacy device that supports
> ACCESS_PLATFORM implicitly.
> 2) vDPA tries to present a 1.0 device, in this case the behavior could
> be ruled by the spec. If we tries to present an 1.0 device on top of
> legacy device we may suffer a lot of issues:
> 
> - endian issue: 1.0 use le but legacy may use native endian
> - queue_enable semantic which is missed in the legacy
> - virtqueue size, as you mentioned below

So this all kind of works when guest and host are
strongly ordered and LE. Case in point x86.
Question is how do we limit this to an x86 guest?
Add a new ioctl declaring that this is the case?

-- 
MST

