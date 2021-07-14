Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF56B3C817A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhGNJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238351AbhGNJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626254592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eirgtDSsj4ahPekk723XAL8YTiHIreSNnTppDGggss=;
        b=dvIfIJDzYYS5IfSRnwf65eFR9RpYqTkMnUo1m8lUS9WRWvZxcFHDvVtf+Z8e1+2uoBCmm8
        Gg3cXic8jjy4cSy5NAztUndTJ7ohMFttdg29ZNqAJFBj/Jh4/OVW8wnShxoX6eFpg8NMSb
        pByVowyvUAMjgK3nuKUpSKmf4bKDb3U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-0OujwFdnNKCW30n9ouO3iA-1; Wed, 14 Jul 2021 05:23:11 -0400
X-MC-Unique: 0OujwFdnNKCW30n9ouO3iA-1
Received: by mail-pj1-f69.google.com with SMTP id k92-20020a17090a14e5b02901731af08bd7so3344471pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2eirgtDSsj4ahPekk723XAL8YTiHIreSNnTppDGggss=;
        b=TN7oXkQpWao0IQzhiRMZ5MLWuLn18IpolVRhjVnSmJZAP7bcOrAIvRxU0YlkpP861r
         WDl2rYMkMjjRYklV+XxSmmboFa4IMaARA9mLm+mMMloJ5cgKi78Wo9fm6XVYIgYly+4h
         Vyr4LehvbmgDDixMXqdU4/yVcduC4EbaYajEvvH9qZxwSeNACmc4yyfLvjx1DP8N1qyg
         e+XG0kVog1YP1OwE87PRFLSgyzUtNSRHjBlLxO8XHBTZsGVZIFE5jiTfCOyjIhSs1RtG
         BwKijC63b+VSv3zdomhycbuPCR8IBr0oM2PwQq3xhKu8+rANfLpJtrgLT7RJxsapfuuX
         0wXw==
X-Gm-Message-State: AOAM532jNEpqTSpPurso8SO2y0u+DcyvskKGg/3f0IxiFrqInSPDAinp
        XdmBo9oVsmCI6Vx1VBbrKVCyuNJ+Ai/nFN43Hhfyy0TMGcrz8flo/GUGEs+e8qKukpD4Hw+WKlj
        cZsW1NyWtlia8doCTfmVPfvyI
X-Received: by 2002:a63:1648:: with SMTP id 8mr8597329pgw.140.1626254590746;
        Wed, 14 Jul 2021 02:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ2PEAMu24VXI2oq1w1Z5wZaZhxPNzGw65OA55/ytyDcNHAhES7yVqcOKYGCSf9bmNs4ThUQ==
X-Received: by 2002:a63:1648:: with SMTP id 8mr8597299pgw.140.1626254590432;
        Wed, 14 Jul 2021 02:23:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d129sm2060084pfd.218.2021.07.14.02.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:23:10 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
Date:   Wed, 14 Jul 2021 17:23:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/14 下午4:10, Paolo Bonzini 写道:
> On 14/07/21 10:01, Daniel Bristot de Oliveira wrote:
>> Hey
>>
>> I use kvm-vm for regular development, and while using the kernel-rt 
>> v5.13-rt1
>> (the latest) on the host, and a regular kernel on the guest, after a 
>> while,
>> this happens:
>>
>> [ 1723.404979] ------------[ cut here ]------------
>> [ 1723.404981] WARNING: CPU: 12 PID: 2554 at fs/eventfd.c:74 
>> eventfd_signal+0x7e/0x90
>
>> [ 1723.405055] RIP: 0010:eventfd_signal+0x7e/0x90
>> [ 1723.405059] Code: 01 00 00 00 be 03 00 00 00 4c 89 ef e8 5b ec d9 
>> ff 65 ff 0d e4 34 c9 5a 4c 89 ef e8 ec a8 86 00 4c 89 e0 5b 5d 41 5c 
>> 41 5d c3 <0f> 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 0f 1f 00 0f 
>> 1f 44 00
>> [ 1723.405078]  vhost_tx_batch.constprop.0+0x7d/0xc0 [vhost_net]
>> [ 1723.405083]  handle_tx_copy+0x15b/0x5c0 [vhost_net]
>> [ 1723.405088]  ? __vhost_add_used_n+0x200/0x200 [vhost]
>> [ 1723.405092]  handle_tx+0xa5/0xe0 [vhost_net]
>> [ 1723.405095]  vhost_worker+0x93/0xd0 [vhost]
>> [ 1723.405099]  kthread+0x186/0x1a0
>> [ 1723.405103]  ? __kthread_parkme+0xa0/0xa0
>> [ 1723.405105]  ret_from_fork+0x22/0x30
>> [ 1723.405110] ---[ end trace 0000000000000002 ]---
>
> The WARN has this comment above:
>
>         /*
>          * Deadlock or stack overflow issues can happen if we recurse 
> here
>          * through waitqueue wakeup handlers. If the caller users 
> potentially
>          * nested waitqueues with custom wakeup handlers, then it should
>          * check eventfd_signal_count() before calling this function. If
>          * it returns true, the eventfd_signal() call should be 
> deferred to a
>          * safe context.
>          */
>
> This was added in 2020, so it's unlikely to be the direct cause of the
> change.  What is a known-good version for the host?
>
> Since it is not KVM stuff, I'm CCing Michael and Jason.
>
> Paolo
>

I think this can be probably fixed here:

https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/

Thanks


