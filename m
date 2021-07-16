Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38F3CB2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGPG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235110AbhGPG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626418504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2/ayKuiffiy3YICPBYIgq3NBBxBKlJROEzMpWCI+BM=;
        b=cjcKvHGi7j22dztaJKvHqcJTi2MhB86xlo9XGuMTzWfRSls+y7DhysnzdQyREB736TrKM0
        02wp5qSWXyE2187x/4CxwtMlI/S+MRk/jjUTme55vp+maTa6oJQ8tk0fllCosFX71kCVlS
        KD9srsNpN/ueLdl6o/+yMTq4x7+FJGY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-LOzGfV4KO5Cg5gKP_PixNw-1; Fri, 16 Jul 2021 02:55:02 -0400
X-MC-Unique: LOzGfV4KO5Cg5gKP_PixNw-1
Received: by mail-wm1-f71.google.com with SMTP id 1-20020a05600c0201b029022095f349f3so3214472wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G2/ayKuiffiy3YICPBYIgq3NBBxBKlJROEzMpWCI+BM=;
        b=kBqWxZIJvQySYUeX9kGjJmOh1hMkCgwbAVIIIMpVRIgwJqgoMwmq88VRGIP7J1Zqpp
         M08Cm48cvW+gF8aQz1qQX4Ypd3xQxDaceo1fOjylvJRwLldCasteJhSnfo0NOPL7B+yv
         fxF/gaGPW1cICEmt0a5Cedrcnn7R85mk+Y2ddZYOyHu700Ov697E8r55a4bpNaCvYcqi
         Qfk1n1l3VHsYH0inYUxnkvimXnrHt/QAhLt3X64g/zobrKUCwc5PLx5bFBIdlUJBgRE4
         bmu4mqw1Kz2c+iHZoDdJ/oS0F2VUshWrEMn1k6iq8rSx3R37jSMwnve1s8tEtosAxQF7
         PxBg==
X-Gm-Message-State: AOAM531ETOIExSvEJJdwLKbwLEEuvDaXs/JrCRhgpu61koXhFLkMEXlZ
        Xbxi6XY4w5AWlCPvDQ1Y8Wau2W3/GTlLecFcaFqqknoPuBpcp3vqAP3KF+ga1bO9VxnLOj/h12Z
        m2fpL4bc+QIa+BAviY4oLrWcI
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr10554923wrw.30.1626418501631;
        Thu, 15 Jul 2021 23:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvXEs+UHNoWseUEXPi1RKsAEA1evMlPvZvUGwjdHerZri+1ke5g8EGjE+oGXMq8Fl/ebvlvQ==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr10554906wrw.30.1626418501422;
        Thu, 15 Jul 2021 23:55:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id z16sm8860702wrh.58.2021.07.15.23.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 23:55:00 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85944a65-4ecb-94d8-f2c5-d4643411fbee@redhat.com>
Date:   Fri, 16 Jul 2021 08:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716020611.2288-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/21 04:06, Hillf Danton wrote:
>> With the patch:
>> 	- no warn
>> 	- continue using the VM normally...
> Well with the patch applied, the VM works fine without the stuff protected
> by the spin_lock_irqsave(), then without the patch why simply printing a
> warning makes the VM dumb, given the warning is there actually also preventing
> you from touching the lock.
> 

If the warning is triggered, eventfd_signal will not do the wakeup.

Paolo

