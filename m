Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3013B123B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFWDd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhFWDdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624419068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZSgP5xqL55dngZG3CanjqGD23m6Wc1RN7v32XWp3kc=;
        b=D0rT+9lKGIV1w9C2Ioin8KLW5yFWmlewxYNLvASOFoxe06tyKATEMZ58Of6am4GfmT5ACq
        SsIryGYe5f7eEAL03BvIlqvfnbkLyMjsVAA9Ocjmdr1Xd1eq8SHx0eBFbVNZeX9L5IL+AH
        22XoJ1041TB3jOG5QupfYXb76lPItiU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-r1Uwdi9WN4y1g1nacndhLw-1; Tue, 22 Jun 2021 23:31:06 -0400
X-MC-Unique: r1Uwdi9WN4y1g1nacndhLw-1
Received: by mail-pl1-f200.google.com with SMTP id 4-20020a170902c204b0290121d3ad80ecso321733pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 20:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VZSgP5xqL55dngZG3CanjqGD23m6Wc1RN7v32XWp3kc=;
        b=W4LMxRdPiCue94noSGWHV22FQNvvM856+jUJBoJaEkKd9Wpno4HvAqAd2XSrrgzB9H
         LLvyo/ybX5b+IMOnahAjSjdG5dfOeAxrusc51Nsy5KYbFp8UgZSAKlnhFrfJN48+FvFn
         1S0siKwio3WpK8jLykOt3YtbTKgDCdn+5p5DxcT9RUEaeF7kQM86Dw95prQiW4s8KWET
         5A5Nf25P6REsURhiGc6HuWQfrZ/J+RcVj7ZbPpc0x/ZGkuJEiCAI0DF+XKx+AXtfON9W
         LD5uzXu9TJfnIESjwes76EVrl/KFI5FWLkFJ/l+CqogHniI0nt7o5dhqKjYjTc7rEQYk
         KYMg==
X-Gm-Message-State: AOAM533qoH2NvF3OxXpQQZPh8SQ8KMhWFy7p0VaHtuU1S+fXuIfOQ9hQ
        ViWNqkaKXOk23Vy7nM7gQKgVBreJi9UMhDwezeO0twW24rUojg+GhN5oClIuXWOPu3xsuQpf/bH
        tiynWdDE0iviTjzo9y/33kiZag/E/OahCBW9qjjm1nwZeh9PZ7UMirGdGrNDVEBNHjrl3+Lh8YF
        7x
X-Received: by 2002:a17:90b:a4d:: with SMTP id gw13mr7324905pjb.104.1624419065722;
        Tue, 22 Jun 2021 20:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQhXaoy3jxuNbqcv+CnTgPw9skCZRgRJ2b9PqWzTzCghH3uazW1CaiGjP6RnFZCrYeeAvhUQ==
X-Received: by 2002:a17:90b:a4d:: with SMTP id gw13mr7324867pjb.104.1624419065413;
        Tue, 22 Jun 2021 20:31:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g4sm658859pfu.134.2021.06.22.20.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 20:31:04 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
Date:   Wed, 23 Jun 2021 11:30:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/22 下午4:14, Yongji Xie 写道:
> On Tue, Jun 22, 2021 at 3:50 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/6/22 下午3:22, Yongji Xie 写道:
>>>> We need fix a way to propagate the error to the userspace.
>>>>
>>>> E.g if we want to stop the deivce, we will delay the status reset until
>>>> we get respose from the userspace?
>>>>
>>> I didn't get how to delay the status reset. And should it be a DoS
>>> that we want to fix if the userspace doesn't give a response forever?
>>
>> You're right. So let's make set_status() can fail first, then propagate
>> its failure via VHOST_VDPA_SET_STATUS.
>>
> OK. So we only need to propagate the failure in the vhost-vdpa case, right?


I think not, we need to deal with the reset for virtio as well:

E.g in register_virtio_devices(), we have:

         /* We always start by resetting the device, in case a previous
          * driver messed it up.  This also tests that code path a 
little. */
       dev->config->reset(dev);

We probably need to make reset can fail and then fail the 
register_virtio_device() as well.

Thanks


>
> Thanks,
> Yongji
>

