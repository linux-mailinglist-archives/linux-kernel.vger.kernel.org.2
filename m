Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD137B366
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhELBWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELBWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620782505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQBTeUOnJxVvQe5cf+H0ezJO8F9KLJswaFRFl5Rl3ks=;
        b=Vv7aQf6xuFrd1yhWsTsgrpImiOmL9LnuIYA+0PTU5KybmWs50pgiiOcz+EgG9XJG2BAYwM
        I2ENqEfoRaJFvJegaoSigjgktk1bpBrX3hwY4FxITNI28b15IA5aHNmlGXz/CNRZAf03wo
        nvqX7Q6jJBFNjMvYj0OS3JqS6Vmirnk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-ORK0akqUMDWX0x-8AyKt9Q-1; Tue, 11 May 2021 21:21:42 -0400
X-MC-Unique: ORK0akqUMDWX0x-8AyKt9Q-1
Received: by mail-pg1-f198.google.com with SMTP id k9-20020a63d1090000b029021091ebb84cso12701321pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 18:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WQBTeUOnJxVvQe5cf+H0ezJO8F9KLJswaFRFl5Rl3ks=;
        b=Q6vs6A78Y+fbuU3ttPaFvBX3pEO5kbChcvx4rPzhYR8b5IsWnTOf6lQ16x9rCJQ91H
         X5yS4D35Vzw/ccceaW8jQHyoc38lbKNl5z81SOdb4nzIDJ/Xq6dqlbARU2T6jv3B6KH7
         YxAhkpIN4LT5U0yrDXpuGVflLhCUjelSkv/gOoYM/XVDN9XUBSLFt4ksWLEaCn55ge/7
         HUAtmpLuuXX73pQ7RXaG443bjKl3RD2JIkhqWIqj454w/z/UZUUSPa5rzAsrblzK8ku7
         h4eSco9G6Kyp64JlmNuLESsBxVFhwhPpavIR6AWr5yKjBVYZobWshAw86EwfjGWC8J/i
         boSw==
X-Gm-Message-State: AOAM530LvsYsL3MDnh8gbOWzdeBOB02G5P0q8oXOptrGOGZDsz3cO/Mn
        NsN16rv+455j4oh1UB0or9AUC0qKfRm5VMwZcI+zmM564n8BbXTbLSMPT7RJnuFg7AzpozHzZcD
        VvfbhiKD5f9hNN4kpHrHeGHIe
X-Received: by 2002:a65:62d7:: with SMTP id m23mr33812946pgv.244.1620782501822;
        Tue, 11 May 2021 18:21:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjIxWtZRQoYRS6HSFMlqpYwjeopoTbiSUnpPPoiu9LAwL9NQs+qfYYo/83LXGoLG2nOAsGDQ==
X-Received: by 2002:a65:62d7:: with SMTP id m23mr33812932pgv.244.1620782501503;
        Tue, 11 May 2021 18:21:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gm17sm14533127pjb.11.2021.05.11.18.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 18:21:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Yan Vugenfirer <yan@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
 <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
 <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com>
 <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
 <CAOEp5OfAEb4=C7GK_EJvJnoTTk-ebdg0RygShPwbn3O67ucQ2Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b6ccd865-deec-47e1-df19-c10fd8ee107f@redhat.com>
Date:   Wed, 12 May 2021 09:21:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOEp5OfAEb4=C7GK_EJvJnoTTk-ebdg0RygShPwbn3O67ucQ2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/11 下午5:21, Yuri Benditovich 写道:
> On Tue, May 11, 2021 at 11:24 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Tue, May 11, 2021 at 4:12 PM Yuri Benditovich
>> <yuri.benditovich@daynix.com> wrote:
>>> On Tue, May 11, 2021 at 9:47 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>> 在 2021/5/11 下午12:42, Yuri Benditovich 写道:
>>>>> Define feature bit and GSO type according to the VIRTIO
>>>>> specification.
>>>>>
>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>> ---
>>>>>    include/uapi/linux/virtio_net.h | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>>>>> index 3f55a4215f11..a556ac735d7f 100644
>>>>> --- a/include/uapi/linux/virtio_net.h
>>>>> +++ b/include/uapi/linux/virtio_net.h
>>>>> @@ -57,6 +57,7 @@
>>>>>                                         * Steering */
>>>>>    #define VIRTIO_NET_F_CTRL_MAC_ADDR 23       /* Set MAC address */
>>>>>
>>>>> +#define VIRTIO_NET_F_HOST_USO     56 /* Host can handle USO packets */
>>> This is the virtio-net feature
>> Right, I miss this part.
>>
>>>>>    #define VIRTIO_NET_F_HASH_REPORT  57        /* Supports hash report */
>>>>>    #define VIRTIO_NET_F_RSS      60    /* Supports RSS RX steering */
>>>>>    #define VIRTIO_NET_F_RSC_EXT          61    /* extended coalescing info */
>>>>> @@ -130,6 +131,7 @@ struct virtio_net_hdr_v1 {
>>>>>    #define VIRTIO_NET_HDR_GSO_TCPV4    1       /* GSO frame, IPv4 TCP (TSO) */
>>>>>    #define VIRTIO_NET_HDR_GSO_UDP              3       /* GSO frame, IPv4 UDP (UFO) */
>>>>>    #define VIRTIO_NET_HDR_GSO_TCPV6    4       /* GSO frame, IPv6 TCP */
>>>>> +#define VIRTIO_NET_HDR_GSO_UDP_L4    5       /* GSO frame, IPv4 UDP (USO) */
>>> This is respective GSO type
>>>
>>>>
>>>> This is the gso_type not the feature actually.
>>>>
>>>> I wonder what's the reason for not
>>>>
>>>> 1) introducing a dedicated virtio-net feature bit for this
>>>> (VIRTIO_NET_F_GUEST_GSO_UDP_L4.
>>> This series is not for GUEST's feature, it is only for host feature.
>>>
>>>> 2) toggle the NETIF_F_GSO_UDP_L4  feature for tuntap based on the
>>>> negotiated feature.
>>> The NETIF_F_GSO_UDP_L4 would be required for the guest RX path.
>>> The guest TX path does not require any flags to be propagated, it only
>>> allows the guest to transmit large UDP packets and have them
>>> automatically splitted.
>>> (This is similar to HOST_UFO but does packet segmentation instead of
>>> fragmentation. GUEST_UFO indeed requires a respective NETIF flag, as
>>> it is unclear whether the guest is capable of receiving such packets).
>> So I think it's better to implement TX/RX in the same series unless
>> there's something missed:
>>
>> For Guest TX, NETIF_F_GSO_UDP_L4 needs to be enabled in the guest
>> virtio-net only when VIRTIO_NET_F_HOST_USO is negotiated.
> I understand that this is what should be done when this feature will
> be added to Linux virtio-net driver.
> But at the moment we do not have enough resources to work on it.
> Currently we have a clear use case and ability to test in on Windows guest.
> Respective QEMU changes are pending for kernel patches, current
> reference is https://github.com/daynix/qemu/tree/uso


This looks fine but as replied in another thread.

We can test both TX and RX with Linux guests simply:

We can just use 2 VMs, and let one VM send GSO_UDP_L4 packet to another, 
then both tx and rx in both guest (virtio-net) and host (virtio-net) are 
tested?

Thanks


>
>> For guest RX, NETIF_F_GSO_UDP_L4 needs to be enabled on the host
>> tuntap only when VIRTIO_NET_F_GUEST_USO is neogiated.
> Currently we are not able to use guest RX UDP GSO.
> In order to do that we at least should be able to build our Windows
> drivers with the most updated driver development kit (2004+).
> At the moment we can't, this task is in a plan but can take several
> months. So we do not have a test/use case with Windows VM.
>
>
>> Thanks
>>
>>>> Thanks
>>>>
>>>>
>>>>>    #define VIRTIO_NET_HDR_GSO_ECN              0x80    /* TCP has ECN set */
>>>>>        __u8 gso_type;
>>>>>        __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */

