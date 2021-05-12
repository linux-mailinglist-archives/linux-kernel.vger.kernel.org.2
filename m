Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982F337B393
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhELBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELBea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620783203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DG4/tk483cnbSJ3ONzjX6O6bMM+E3eYFHY3G4cqhSY=;
        b=BmleRHTLGBrT08h6C35MHn1tgswT6FVDdACFESK2QtB/pKhA5pM0SHaMf9dmH1LBMGPYPZ
        D++ndrH6fyGIwXqWLEoDmGd7/BHRCzW0hGyFdYvUEHsml1+Z4zTJnrpPAIdvh63fiUt5fq
        swl88ZD9RAhMAhAlQj1hbj6DycjbR9E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-eL1ijsfONG-aDSfeaIsawg-1; Tue, 11 May 2021 21:33:22 -0400
X-MC-Unique: eL1ijsfONG-aDSfeaIsawg-1
Received: by mail-pl1-f200.google.com with SMTP id z14-20020a170903018eb02900eed5c11984so8440442plg.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 18:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5DG4/tk483cnbSJ3ONzjX6O6bMM+E3eYFHY3G4cqhSY=;
        b=BHzotBjI2oBksK+uQWtuAR6fkt7H/njsAFuLlGadsno4vQaQIPYX0tXbJrsEwUyHlr
         WwlnzKL3ZlWxEifSnM0A1tBPt2MY6ojckcKHx3n4Bf6eTUtXpCv3x7Z5uW3JguKEJN0h
         +ap2D/d0lCo2uOq+ibVcf1YzQU1yZaYo2OyXJOOE//JRgD0xSY0e0E6AXJATe0Zo7Wdj
         ujCIqemITjPlztXSm+EBboKRaBV4ZDSOcWqNdV3IARkkAykBa0K0Yt1yBvjM+jhRLeaX
         IFSqSZSgAvJfzsyCmqIv4Z2+ny051Alq7uvFhGmTlAoGe4y3vM2YdpCZr8xTzlAHpO+E
         9Wiw==
X-Gm-Message-State: AOAM532AqCvUGLr+C6hKJFsMosjj53vXsokCNZKjfqby07W2/q8jc7bj
        OD/5YFrIpPmbzk+ip/5wVGQPD5+y2xvHRuwlaX0Ae2LzJDGYJoL3pFN3OekwC8uyRKtVrQL3uJI
        ndwSO4POgNfThyyPRR1v0QvEq
X-Received: by 2002:a17:902:7847:b029:ef:4421:6a2e with SMTP id e7-20020a1709027847b02900ef44216a2emr9969695pln.44.1620783200673;
        Tue, 11 May 2021 18:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnOWQX4Mk3jCxH5ECtdPMzPH8hqjnoRf3edC55nxhKlgPAZIcSRNEJvASEQmVclxALyMDBHQ==
X-Received: by 2002:a17:902:7847:b029:ef:4421:6a2e with SMTP id e7-20020a1709027847b02900ef44216a2emr9969662pln.44.1620783200008;
        Tue, 11 May 2021 18:33:20 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m14sm15181976pff.17.2021.05.11.18.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 18:33:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Yan Vugenfirer <yan@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
Date:   Wed, 12 May 2021 09:33:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/11 下午4:33, Yuri Benditovich 写道:
> On Tue, May 11, 2021 at 9:50 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/11 下午12:42, Yuri Benditovich 写道:
>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>> ---
>>>    drivers/net/tun.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index 84f832806313..a35054f9d941 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -2812,7 +2812,7 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>>>                        arg &= ~(TUN_F_TSO4|TUN_F_TSO6);
>>>                }
>>>
>>> -             arg &= ~TUN_F_UFO;
>>> +             arg &= ~(TUN_F_UFO|TUN_F_USO);
>>
>> It looks to me kernel doesn't use "USO", so TUN_F_UDP_GSO_L4 is a better
>> name for this
> No problem, I can change it in v2
>
>   and I guess we should toggle NETIF_F_UDP_GSO_l4 here?
>
> No, we do not, because this indicates only the fact that the guest can
> send large UDP packets and have them splitted to UDP segments.


Actually the reverse. The set_offload() controls the tuntap TX path 
(guest RX path).

When VIRTIO_NET_F_GUEST_XXX was not negotiated, the corresponding netdev 
features needs to be disabled. When host tries to send those packets to 
guest, it needs to do software segmentation.

See virtio_net_apply_guest_offloads().

There's currently no way (or not need) to prevent tuntap from receiving 
GSO packets.

Thanks


>
>> And how about macvtap?
> We will check how to do that for macvtap. We will send a separate
> patch for macvtap or ask for advice.
>
>> Thanks
>>
>>
>>>        }
>>>
>>>        /* This gives the user a way to test for new features in future by

