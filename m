Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26F73E9CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhHLDXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 23:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhHLDXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 23:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628738596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2m2roWrvbYZeRqtABbQ37PaOQOhXAkNprJbXopZhFmQ=;
        b=I1YRj/qgLA33z+HD0LRttf6Ln1A82T0C4frepbqrCbHrZAOP2XEQ/0Wt2y8wfnqFQmZ2fj
        6kGtNSIOTDB+Mme377ZWNtvTWbyLCpybyqAzY+nqipIKWnlBRlr44i/q15vIlHI4PDksIA
        HmwfKXhqbp9gwRaj+VmbjZdd1/giOzM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-S8u3SAPWNB262j0dKDV4_w-1; Wed, 11 Aug 2021 23:23:14 -0400
X-MC-Unique: S8u3SAPWNB262j0dKDV4_w-1
Received: by mail-pj1-f70.google.com with SMTP id r23-20020a17090aa097b0290176fc47a8b7so6948343pjp.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 20:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2m2roWrvbYZeRqtABbQ37PaOQOhXAkNprJbXopZhFmQ=;
        b=rhl0usoP/nFHSxP7vKQG+nF3e550asobhmwtd4ZrD9fKZuY6mJPaCNolgpdEqwFQfw
         5EynGdMzpKfk3lNZf5uxksfnvpdf5gd3zNQfelv3vXxgmJsj7XaAYF6O/oXnzDvHgO/A
         h6P9vJmSj+6vXfYeLmYQZORBRlpVGHP9fAilyac1bBbro13dn2L5ksJy5GUNob83f9Xt
         TVMW6eSHpfFVuqPqRNowqqbaNFKTqpxI/2kxA0uZDa6etNfx+21rKWgld2mJSowZ8orQ
         AWIPHjvFvNNtahZ/fdv+kSeqDBgF3TCafxADhsYkif1yH12gQ2gw8Ztq2MQRduupNS2n
         p60A==
X-Gm-Message-State: AOAM532tADL1FV7O708ASNWuTtjvmdvWbM5jTM0p/Uil75di5ohyA199
        wtX9cP3CjFR9/se0/6ZGmd7tbjPtFXow/GNMq8TAwGckAXvbSYWxGAn3Cv2SZHaeNoA4iS9Dy/c
        hsyqLzr4L3c4uM7a6dZWxYR/0
X-Received: by 2002:a63:4b20:: with SMTP id y32mr1859079pga.382.1628738593898;
        Wed, 11 Aug 2021 20:23:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxri0vz1C8dFRUmJIUTNidwykg+eDk8Nwx4EwLANMh4kFarSI6fxHbBC1+cB14MM5x9vm7Uww==
X-Received: by 2002:a63:4b20:: with SMTP id y32mr1859066pga.382.1628738593676;
        Wed, 11 Aug 2021 20:23:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m16sm8395422pjz.30.2021.08.11.20.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 20:23:13 -0700 (PDT)
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     mst@redhat.com, davem@davemloft.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ivan@prestigetransportation.com,
        xiangxia.m.yue@gmail.com, willemb@google.com, edumazet@google.com
References: <20210811081623.9832-1-jasowang@redhat.com>
 <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
Date:   Thu, 12 Aug 2021 11:23:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/8/12 ÉÏÎç6:17, Jakub Kicinski Ð´µÀ:
> On Wed, 11 Aug 2021 16:16:23 +0800 Jason Wang wrote:
>> Try to fix this by using NETIF_F_GRO_HW instead so we're not
>> guaranteed to be re-segmented as original.
> This sentence may need rephrasing.


Right, actually, I meant:


Try to fix this by using NETIF_F_GRO_HW instead. But we're not sure the 
packet could be re-segmented to the exact original packet stream. Since 
it's really depends on the bakcend implementation.


>
>> Or we may want a new netdev
>> feature like RX_GSO since the guest offloads for virtio-net is
>> actually to receive GSO packet.
>>
>> Or we can try not advertise LRO is control guest offloads is not
>> enabled. This solves the warning but will still slow down the traffic.
> IMO gro-hw fits pretty well, patch looks good.


If the re-segmentation is not a issue. I will post a formal patch.

Thanks


>

