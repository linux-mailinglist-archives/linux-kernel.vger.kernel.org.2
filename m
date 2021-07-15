Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1463C9EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhGOMh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhGOMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626352472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3153vYEmrzkJWaghsuHOLitFH++quk00sidolVvra+Q=;
        b=Zd+jpEsC/5N2myV1qWso8csl1rPjnQQ7xpB8dzHBm5fjRN86kOte7C+92m6P/+M0mxbOht
        Bwmp+EAz8gH7SDbEFU4XOHR+y0YSYmk4gENuMRK3z3+ZiujmeCzFvi4jc1wVDEVfvPnwLe
        C/4JfziZQrOFmJXNMiI+iw/IO9IpKSg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-eeqQomtwMyyynXYX8xtUfw-1; Thu, 15 Jul 2021 08:34:31 -0400
X-MC-Unique: eeqQomtwMyyynXYX8xtUfw-1
Received: by mail-ed1-f69.google.com with SMTP id v2-20020a50c4020000b02903a6620f87feso3038636edf.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 05:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3153vYEmrzkJWaghsuHOLitFH++quk00sidolVvra+Q=;
        b=rI2/ZcxPt4S/C5aWMyJqW48OdnyDRDbUfyIsquQ2kU+p5f2SQ/maBkP+jpFTzWDnrT
         y1VweML4SB+eJQlhqpc9wi7K4lYD+g5+8BGz0GKHpHv4TmSTW4W4UcMg5AcIfOQCPLSa
         Nku5s6nUnx4j0oCbmmZcbmvRZtnnph+Cj1bloOeP8QvUeMJnsZGTUvBsJYnoBqs16wae
         +zRDhZ8N7zpwebv/tMXDUTnkZqK91nT1yCgmtODnjZGuTTWAq0nPdjJ9Kf8SchZaYce1
         YHjCdJ7tAXhcoTbrfpJSLF1HyVulZKTlqy9Wh9yr6lRyjrk2R9NqMflcycx1tFgU3lrx
         dLPg==
X-Gm-Message-State: AOAM533js9dxOpOoFlyXHDnrvl/yRYX7+rc3+Y/OCdl2WY4HF4X93PZr
        rGCiCdwZFdjulK/vfQQw9+GCOQ924437Q5hJ9767FjIeSTQ8n5lU1wFZpYwXlYN1V/5yieQi7fz
        TcnZMi9HW05ZwLBYQaVzKwECo
X-Received: by 2002:a17:907:2d8a:: with SMTP id gt10mr5439752ejc.10.1626352468575;
        Thu, 15 Jul 2021 05:34:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznt0BLl7OH13fXecmqXtNvUDWfNEc0CdVOvZdzyxaWFg50P1PEjDAFN2fGGHH7PG1yz3a8Rw==
X-Received: by 2002:a17:907:2d8a:: with SMTP id gt10mr5439586ejc.10.1626352466575;
        Thu, 15 Jul 2021 05:34:26 -0700 (PDT)
Received: from x1.bristot.me (host-79-37-206-118.retail.telecomitalia.it. [79.37.206.118])
        by smtp.gmail.com with ESMTPSA id z8sm1816096ejd.94.2021.07.15.05.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 05:34:26 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <9951ef78-587a-34e1-7b5b-280285e37098@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <82c20a95-4616-eeef-2459-b2decdd7f3bd@redhat.com>
Date:   Thu, 15 Jul 2021 14:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9951ef78-587a-34e1-7b5b-280285e37098@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 11:46 AM, Paolo Bonzini wrote:
> On 15/07/21 10:22, Daniel Bristot de Oliveira wrote:
>> On 7/14/21 12:35 PM, Paolo Bonzini wrote:
>>> On 14/07/21 11:23, Jason Wang wrote:
>>>> I think this can be probably fixed here:
>>>>
>>>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
>>>
>>> That seems wrong; in particular it wouldn't protect against AB/BA deadlocks.
>>> In fact, the bug is with the locking; the code assumes that
>>> spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
>>> increments and decrements the percpu variable inside the critical section.
>>>
>>> This obviously does not fly with PREEMPT_RT; the right fix should be
>>> using a local_lock.  Something like this (untested!!):
>>
>> the lock needs to be per-pcu...
> 
> Great, thanks for testing and fixing the patch!  Are you going to post
> it again once you've confirmed it works?

I can do that... unless you want to send it yourself...

-- Daniel

> Paolo

