Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B88F3E9E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhHLGTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233118AbhHLGTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628749124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvZhZuJyvKoGArMGtcu0Yd/1tL7iWCU66WqR2CvGmE8=;
        b=HlOxd6IO2Ics2rDn/PB8DwTbDbB/RvevIfqL/pyRaBl22yf2WJMfK1QOcU9+XF6d3Djr2Q
        rOY3B0a6W8vM8BORWaevOu5CrLksxuDmF91/3i4KJKp9GP8ZO+OoWRmDXYrmk27v+01qcS
        XdqSiIoBx1jIZk1iepDjqY5ftQvgeSE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-2VJbVJVRNW-NxZzI8UVJlA-1; Thu, 12 Aug 2021 02:18:43 -0400
X-MC-Unique: 2VJbVJVRNW-NxZzI8UVJlA-1
Received: by mail-pl1-f199.google.com with SMTP id z1-20020a1709030181b029012c775d35e1so3038649plg.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BvZhZuJyvKoGArMGtcu0Yd/1tL7iWCU66WqR2CvGmE8=;
        b=TeBquuU7FShjrxdprm3ocDNlI3iIza20PVRwPM0JX8baDaKg5AeBTMeWkqpQugv2Ih
         gBrESCf+Sf7uCyssKeqoaQ8vPQVtT63qYjiwh63CYCGTf1W9sjy4J0OJVETIP2vdCVft
         J9Chboe0n6GkeWhVeV7agzjhra+pwBSRbpMAur8BUAY466771XXSjQWmKQK+8oRVJNrb
         lWfNAEatkJ4S58ZhB7OLmUgJ5H2eP1PXA4hNfekMioj+ICQOHSQ09GSjcW/IjiBCFk5a
         bX2x4gxoFtJvzcHAmFEhyE3syL1FrxmvznenEm+46AAHgfHAGBiBU1pQ4gDp2E8kTyAq
         Amlw==
X-Gm-Message-State: AOAM532GrkpO+GLyg4+PQVovF4OvKlOxyPEixPL5NfYBQnU0g0DvU8oR
        4avVXIw9aLH0X3FIakJpqAUr2ogTzI8Yt78jRZjWXQip8bjafHrBynxzG3OE8HHjlXTjkUpk6lw
        oXIHaH8ANwX11lsXYWaXAE20E
X-Received: by 2002:a17:90a:2fc2:: with SMTP id n2mr2598330pjm.112.1628749122468;
        Wed, 11 Aug 2021 23:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFrm3POic9qEvhrnkuWwMOSiimTrdgBhs9p0B+QoI0fTv1CL6z2bwTKU2r5umFD60vtgGQAA==
X-Received: by 2002:a17:90a:2fc2:: with SMTP id n2mr2598308pjm.112.1628749122202;
        Wed, 11 Aug 2021 23:18:42 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g19sm8881371pjl.25.2021.08.11.23.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 23:18:41 -0700 (PDT)
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ivan@prestigetransportation.com,
        xiangxia.m.yue@gmail.com, willemb@google.com, edumazet@google.com
References: <20210811081623.9832-1-jasowang@redhat.com>
 <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
 <20210812004655-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <da7f6d50-2144-2c84-74c8-fbeb5c10b8b0@redhat.com>
Date:   Thu, 12 Aug 2021 14:18:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812004655-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/12 下午12:50, Michael S. Tsirkin 写道:
> On Thu, Aug 12, 2021 at 11:23:04AM +0800, Jason Wang wrote:
>> 在 2021/8/12 上午6:17, Jakub Kicinski 写道:
>>> On Wed, 11 Aug 2021 16:16:23 +0800 Jason Wang wrote:
>>>> Try to fix this by using NETIF_F_GRO_HW instead so we're not
>>>> guaranteed to be re-segmented as original.
>>> This sentence may need rephrasing.
>>
>> Right, actually, I meant:
>>
>>
>> Try to fix this by using NETIF_F_GRO_HW instead. But we're not sure the
>> packet could be re-segmented to the exact original packet stream. Since it's
>> really depends on the bakcend implementation.
>>
>>
>>>> Or we may want a new netdev
>>>> feature like RX_GSO since the guest offloads for virtio-net is
>>>> actually to receive GSO packet.
>>>>
>>>> Or we can try not advertise LRO is control guest offloads is not
>>>> enabled. This solves the warning but will still slow down the traffic.
>>> IMO gro-hw fits pretty well, patch looks good.
>>
>> If the re-segmentation is not a issue. I will post a formal patch.
>>
>> Thanks
>
> It is but the point is even though spec did not require this
> we always allowed these configurations
> in the past so hopefully most of them are not broken and combine
> packets in the same way as GRO. Let's not break them all
> in an attempt to catch bad configs, and meanwhile amend
> the spec to recommend doing GW GRO.


Ok, let me add this in the commit log and send a formal patch.

Thanks


>

