Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9983C832E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhGNKrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239148AbhGNKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626259485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOKE2GZL6fTWgITADtSj3+kfbdCqczacGjJyqa6cu2Q=;
        b=UuFMdrRpwhx5o65V1/BPJpahs/4o5mfLJ4DJD3FOmZR472JnrVdRvCpUKkrwz9j1ZmBBQW
        uBA0P02AsnojpMi4ZHgT1diYOq5vbcsM3/oiiGCuoGpd1RkGZuE7FewrLxtRQtuOmmYg68
        oqW8EspCStHwt987b3djXdg+dv6zs9A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-q11ZtIv3Plqvit6r1w7z6Q-1; Wed, 14 Jul 2021 06:44:42 -0400
X-MC-Unique: q11ZtIv3Plqvit6r1w7z6Q-1
Received: by mail-wr1-f71.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so1280984wrc.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nOKE2GZL6fTWgITADtSj3+kfbdCqczacGjJyqa6cu2Q=;
        b=dqbqVLS7vufS/GGyPVKFC13DZmvoQjyjniTRxkBT8SKSXqI+FvUcUNt5SkWDdsh2n4
         1qj5pftAUFD9aD57/ARn4uxAN4sUeNG8oFG7nmoOkf5ZbF/JhXjKInUdE8jq/QQ5QqcA
         ubVqPrNa26MyRYXNEHwIlOxEKJXhC5bBV6QuF2THJa7mozavityXXmIDZ5llLEjgjn5x
         z8crgWsi4cg4hn+G+tWfiVcP6uVLTxhehblmFu7Y98E4FCoNMx8mNtuKjsK4q+lQuDdv
         ZuaMueZSnCDf/eEmPk2aH55hjtJBK2u6u45OiYWX3ha16lW0dWRXKqwzzX7N0iMQ9iFt
         r8VA==
X-Gm-Message-State: AOAM531WjuHVylxW770Uf2M/aFfF3t0qW8iQIZfmr1/usqA9Fzbh33cB
        vBuzC/iM4zbix3iDsMX91onGq+8S4VoGp2nc7ihNQDrwCtUKmEMHDrUptURzV7hNyAGVEuixhUV
        4AsTeCGYb2sY8X0+lApGyHUxJ
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr12065470wrt.293.1626259480992;
        Wed, 14 Jul 2021 03:44:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBrhPbsqvtDXxSIp+KaPgOZIl+LpZ7BZeaQ/21MrKE7Luf9eg3eKwmIBISMRnttuaBR9R+yg==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr12065451wrt.293.1626259480804;
        Wed, 14 Jul 2021 03:44:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id 19sm1750935wmu.17.2021.07.14.03.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 03:44:39 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210714063814-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6aa0d9b6-94f8-6321-9015-da56ac93d863@redhat.com>
Date:   Wed, 14 Jul 2021 12:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714063814-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/21 12:41, Michael S. Tsirkin wrote:
>> --------------- 8< ---------------
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
>>
>> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
>> non-preemptable and therefore increments and decrements the percpu
>> variable inside the critical section.
>>
>> This obviously does not fly with PREEMPT_RT.  If eventfd_signal is
>> preempted and an unrelated thread calls eventfd_signal, the result is
>> a spurious WARN.  To avoid this, protect the percpu variable with a
>> local_lock.
>>
>> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>> Cc: stable@vger.kernel.org
>> Cc: He Zhe <zhe.he@windriver.com>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> 
> Makes sense ...
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> want to send this to the windriver guys so they can test?
> Here's the list from that thread:

I included He Zhe, but it should be enough for Daniel to test it.  The 
bug is quite obvious once you wear your PREEMPT_RT goggles.

Paolo

