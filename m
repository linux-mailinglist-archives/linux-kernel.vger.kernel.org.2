Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F207390453
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhEYOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232939AbhEYOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621954346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSC9QpCDqCazF2mZq6d/82qLDoFltpJkJoLoXKJjvvg=;
        b=Ae/cDFzEdr4Mcv501zWIjTQa9VHrixNO8oXY31ht6RDbmrY1I3KyBOcIp8HLI1kpUHQzzT
        68losLhh71RyECvM2pMtY3sl9FDICW46pIP1yPoYMt9VEqoSy4aVWLce4fspgeHbllZLnW
        fh7sdYs91uJRsa0xHhyBzrKl1aiUUEM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-6QIRE0wzMW2imS9j1gb0TQ-1; Tue, 25 May 2021 10:52:24 -0400
X-MC-Unique: 6QIRE0wzMW2imS9j1gb0TQ-1
Received: by mail-ed1-f72.google.com with SMTP id n6-20020a0564020606b029038cdc241890so17442234edv.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qSC9QpCDqCazF2mZq6d/82qLDoFltpJkJoLoXKJjvvg=;
        b=U1QS5UZW2rmvvZQIO0faJRGZyCY361Vbsm20AY0cl10nni9MbYfB8f5JcD1Xdkp1BB
         YAPZm5FztYlxu5fulA/asawg76g2yneXB5dFiLquNKAWaS9sgLtSJcPlmo+tmy1lOcQ9
         fExG0dPn4MXstJ5a+MLnP9HINjAI1QxQa5d2lBBwkleQWqbLF3qiSgXTCa0jLvZCjxLY
         UKbmIiHUnz3UkXfgoSlL/118vEVU+ASJEqxOZnDvMokWc8MwGNcQFlKL6+4iEcgzQRyv
         rQsRrl0jxg3Ay0p/ukrJhkFL0t1kCaDmvlvhUJ205ZnsjOcBkuQCvb9AgH0BcUSPA5Xw
         ZxvA==
X-Gm-Message-State: AOAM531hiIpWE8QhbKodG4Vp+t4Divyg9+5od/s7fMbZUsmby62lIqp7
        JEegCdxEEZrf2/JqbH4Zj5Qm6QA1gmOWROBK8g+t9XyJbsGUzKwHIAByaKkLNUd0eDUnDqO7yT/
        DPXsQunBxGUd1yP+LM/IYNR8N
X-Received: by 2002:aa7:d843:: with SMTP id f3mr32220068eds.270.1621954343100;
        Tue, 25 May 2021 07:52:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDlSSMgDZFTIhLb5CNVeQ1FOGcYDV/D4Z+HKGAvXmcW1X5RbFzEx/ev3BuN5v5ARSJGUCLSQ==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr32220039eds.270.1621954342913;
        Tue, 25 May 2021 07:52:22 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id h9sm10912173edt.18.2021.05.25.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:52:22 -0700 (PDT)
Date:   Tue, 25 May 2021 16:52:20 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [PATCH v10 00/18] virtio/vsock: introduce SOCK_SEQPACKET support
Message-ID: <20210525145220.amzme5mqqv4npirt@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210521075520.ghg75wpzz42zorxg@steredhat>
 <108b0bba-5909-cdde-97ee-321b3f5351ca@kaspersky.com>
 <b8dd3b55-0e2c-935a-d9bb-b13b7adc4458@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b8dd3b55-0e2c-935a-d9bb-b13b7adc4458@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 11:22:09AM +0300, Arseny Krasnov wrote:
>
>On 23.05.2021 15:14, Arseny Krasnov wrote:
>> On 21.05.2021 10:55, Stefano Garzarella wrote:
>>> Hi Arseny,
>>>
>>> On Thu, May 20, 2021 at 10:13:53PM +0300, Arseny Krasnov wrote:
>>>> 	This patchset implements support of SOCK_SEQPACKET for virtio
>>>> transport.
>>> I'll carefully review and test this series next Monday, in the mean time
>>> I think we should have at least an agreement about the changes that
>>> regards virtio-spec before merge this series, to avoid any compatibility
>>> issues.
>>>
>>> Do you plan to send a new version of the specification changes?
>>>
>>> Thanks,
>>> Stefano
>> Hello, sorry for long answer. I'm on vacation now, but i plan to send
>>
>> it in next several days, because with current implementation it is short
>>
>>
>> Thank You
>
>Hello, here is spec patch:
>
>https://lists.oasis-open.org/archives/virtio-comment/202105/msg00017.html
>
>Let's discuss it

Yep, sure.

About this series I think is better to split in two series since it 
became very long. Patchwork [1] also complains here [2].

You can send a first series with patches from 1 to 7. These patches are 
reviewed by me and can go regardless of the discussion of the VIRTIO 
specifications.
Maybe you can also add the patch with the test to this first series.

Please specify in the cover letter that the implementation for virtio 
devices is under development and will be sent later.


When it will be merged in the net-next tree, you can post the second 
part with the rest of the series that implements SEQPACKET for virtio 
devices, possibly after we received an agreement for the specifications.

Please use the "net-next" tag and take a look at 
Documentation/networking/netdev-FAQ.rst about netdev development.


Anyway, in the next days (hopefully tomorrow) I'll review the rest of 
the series related to virtio devices and spec.

Thanks,
Stefano

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=486011&state=*

[2] 
https://patchwork.kernel.org/project/netdevbpf/patch/20210520191449.1270723-1-arseny.krasnov@kaspersky.com/

