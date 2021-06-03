Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22AA39978C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFCBgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhFCBgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622684060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ay34ayc0XC/WtKXXL+jwzIp+HQgsy2OJ9U8cZG5Fktk=;
        b=Iyz1Gaw1uWxsDteWAzzkxQNXmCVQe6oO6cLSYeCfxD4OeQZTZlmvWllAfNGTin4Qn5yIJ/
        KHRtZYWP5Q9yGaArjHPmrGNamvaIckF9HAnfVaouDsft379JZGIknPkXLvhSPHTVZq6JA+
        B+K4x+ECekjDzsNyOVsvjl4iUXLksik=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-qQcbRssrMz2AdMkxjj7-EQ-1; Wed, 02 Jun 2021 21:34:19 -0400
X-MC-Unique: qQcbRssrMz2AdMkxjj7-EQ-1
Received: by mail-pf1-f198.google.com with SMTP id g17-20020a056a0023d1b029028f419cb9a2so2577224pfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ay34ayc0XC/WtKXXL+jwzIp+HQgsy2OJ9U8cZG5Fktk=;
        b=H1l++2+/vU5T5PCsnVCMWayJUdKvFp39pJEDq1Cb1BN5NCnzgPDPaooz7ICSs+HPyY
         YuqCGAx1nEcIyzHoVeFAPdIsqyhTfmIQUtQ/1G5+ea0grpZa46KaYNGOQ7urh6wP/3CE
         q7L9CcgO8CbdP+syFm7yBstebjS8QeT95VphcNXgvQ2JI+4KXrWTGajWQTGJcipboL2t
         uZ9N5bu5OOGtP9oE0ciXfdqYmunHc+Z4Tc4Q3ISQT/pyWm68ytpso3a2Z9fpEhoxYsfd
         WwGzXDYHolTjEA+oBTdVA648Q3vJyvjGxGBVLMQ50VAdANuLaA7lwMJUNElHgSZMoK+L
         Pkfw==
X-Gm-Message-State: AOAM533p6AoY+XJHSckdYNl5nMiERd8zEzXRhBa7r/0DdiiQBsRKCbiS
        Yn+EwJs6IONyKsLmcX5p5uA744jhZ1yMFp54cAjs4sEJAmFwE4FCXjQJPbDfNFei4cHKgyGfEvH
        9Slfqt1898hmtjyW4X8p4/bEuHLzW5oOqa1Vl1ikOivilYrJXTzuXL0D1ZjhR6xAICMY6aTWQ4c
        n9
X-Received: by 2002:a63:cd16:: with SMTP id i22mr17954385pgg.251.1622684058205;
        Wed, 02 Jun 2021 18:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJyXEZUAiaYZdr9WbuWSy8K0NWk52sC+zgmLSU88RNWlKo9NgUzTDhRO6ojpL1AFvITL5iKg==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr17954351pgg.251.1622684057916;
        Wed, 02 Jun 2021 18:34:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c15sm884731pgt.68.2021.06.02.18.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 18:34:17 -0700 (PDT)
Subject: Re: Virtio hardening for TDX
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
Date:   Thu, 3 Jun 2021 09:34:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 上午8:41, Andi Kleen 写道:
> [v1: Initial post]
>
> With confidential computing like TDX the guest doesn't trust the host
> anymore. The host is allowed to DOS of course, but it is not allowed
> to read or write any guest memory not explicitely shared with it.
>
> This has implication for virtio. Traditionally virtio didn't assume
> the other side of the communication channel is malicious, and therefore
> didn't do any boundary checks in virtio ring data structures.
>
> This patchkit does hardening for virtio.  In a TDX like model
> the only host memory accesses allowed are in the virtio ring,
> as well as the (forced) swiotlb buffer.
>
> This patch kit does various changes to ensure there can be no
> access outside these two areas. It is possible for the host
> to break the communication, but this should result in a IO
> error on the guest, but no memory safety violations.
>
> virtio is quite complicated with many modes. To simplify
> the task we enforce that virtio is only in split mode without
> indirect descriptors, when running as a TDX guest. We also
> enforce use of the DMA API.
>
> Then these code paths are hardened against any corruptions
> on the ring.
>
> This patchkit has components in three subsystems:
> - Hardening changes to virtio, all in the generic virtio-ring
> - Hardening changes to kernel/dma swiotlb to harden swiotlb against
> malicious pointers. It requires an API change which needed a tree sweep.
> - A single x86 patch to enable the arch_has_restricted_memory_access
> for TDX
>
> It depends on Sathya's earlier patchkit that adds the basic infrastructure
> for TDX. This is only needed for the "am I running in TDX" part.


Note that it's probably needed by other cases as well:

1) Other encrypted VM technology
2) VDUSE[1]
3) Smart NICs

We have already had discussions and some patches have been posted[2][3][4].

I think the basic idea is similar, basically,  we don't trust any 
metadata provided by the device.

[2] is the series that use the metadata stored in the private memory 
which can't be accessed by swiotlb, this series aims to eliminate all 
the possible attacks via virtqueue metadata
[3] is one example for the the used length validation
[4] is the fix for the malicious config space

Thanks

[1] https://www.spinics.net/lists/netdev/msg743264.html
[2] https://www.spinics.net/lists/kvm/msg241825.html
[3] https://patches.linaro.org/patch/450733/
[4] https://lkml.org/lkml/2021/5/17/376

>
>
>

