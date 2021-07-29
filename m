Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8353DABCD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhG2TXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhG2TXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627586629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLUUShINeg3zB4pIKNSTR17WVfI3x7wR0IScyDb0lIQ=;
        b=SoiuN1QW376dvkocMXZUKOi2N8QTwiyiGsc6sHW18sST/aUO9mxlLRqaRWCjJNHe2oHG2b
        lLf1M5OBUD8eaz16nvSUqYmi2I2r/t/UWT4QmFe4K4yltm9M0g+V9IlNJVSbsdQJjUkqoR
        3k1LK6iKj6Is/Fw1f+uYPvqm67TPcPk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-_IkW8kJ5NTe8VBClptwxKg-1; Thu, 29 Jul 2021 15:23:47 -0400
X-MC-Unique: _IkW8kJ5NTe8VBClptwxKg-1
Received: by mail-ej1-f70.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so2331348ejv.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CLUUShINeg3zB4pIKNSTR17WVfI3x7wR0IScyDb0lIQ=;
        b=k2KTjd2qo8lKUc1fHve1HZRK0J1Wz8p8imUYPW/4lenv6Bgx6gyBT2gksw9eqibPpf
         yyA5ziZ1njPDJg+Am0BqcCK69rSj6oZvULmazvWJkeWWFUSXR/11Dpj1X2psZKdIFEzV
         GUyDcSy5V1dNsVs+CtDbIMkJop9DnYyv3jfd0oZ5KSnj6hi1gis0sw57AdoHriNseLmu
         cOys7TI9qxqvoBFPCAWoIME/vOBVb78MbdaZx3v+3O21bAdYSQNCDnO25mo0u6o5PjY6
         X5VK/Q+8e6bnVkiwL6wVYfw40pebXM7milByrke2Z/ahgO3xfrb5pbzvUsbyf/PAbI5E
         DcIw==
X-Gm-Message-State: AOAM533aVG6dk4R0EmJ/HffUT74RIiOL3ZYSl94bFHf5Sd5T5tCwqJRa
        yrrLvvdup5w3xCXKLCgX4cisdTo10+vEjOJ2X/O3mYP0V1nSMIiLFhpvAfbcQL37lER9ep7oHwz
        k9BGZoXLvZlfsqvMNlq/JtGKp
X-Received: by 2002:a50:a456:: with SMTP id v22mr7669398edb.333.1627586626650;
        Thu, 29 Jul 2021 12:23:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxcVU8qe4eofOgQYBBJ78ITD74ZtYTi0VNXjTbdltfj+kxbn12NU416uMWOSAUzZ27/KlEvA==
X-Received: by 2002:a50:a456:: with SMTP id v22mr7669378edb.333.1627586626432;
        Thu, 29 Jul 2021 12:23:46 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id jy17sm1272810ejc.112.2021.07.29.12.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 12:23:46 -0700 (PDT)
Subject: Re: [PATCH] eventfd: Make signal recursion protection a task bit
To:     Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <87pmv23lru.ffs@nanos.tec.linutronix.de>
 <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com> <875ywujlzx.ffs@tglx>
 <87wnp9idso.ffs@tglx>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <d99d8f37-b217-266b-b7bb-6128dafb549b@redhat.com>
Date:   Thu, 29 Jul 2021 21:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87wnp9idso.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 1:01 PM, Thomas Gleixner wrote:
> The recursion protection for eventfd_signal() is based on a per CPU
> variable and relies on the !RT semantics of spin_lock_irqsave() for
> protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
> disables preemption nor interrupts which allows the spin lock held section
> to be preempted. If the preempting task invokes eventfd_signal() as well,
> then the recursion warning triggers.
> 
> Paolo suggested to protect the per CPU variable with a local lock, but
> that's heavyweight and actually not necessary. The goal of this protection
> is to prevent the task stack from overflowing, which can be achieved with a
> per task recursion protection as well.
> 
> Replace the per CPU variable with a per task bit similar to other recursion
> protection bits like task_struct::in_page_owner. This works on both !RT and
> RT kernels and removes as a side effect the extra per CPU storage.
> 
> No functional change for !RT kernels.
> 
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!

