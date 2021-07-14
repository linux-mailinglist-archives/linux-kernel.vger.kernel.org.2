Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D83C7FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhGNINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238378AbhGNINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626250212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8UM8qKhd8lVsw4YNA+FXQlest2HKWswEUdYrUZ85lM=;
        b=YqvZWYKBI2YUJde5gj1bqKggNwNh5QRvd0bu9Hn3mklgfr/iOI1fHdEIFSi7UZpiYAa6Kw
        sszwEGjGcuPAwvQlxcuklpoa/o8GP1sbOJHi2678EsgvSmvHgLNvmMhsZ4aQANwPZXpsb3
        +CsMGgbh228g4pI+hf7u/PoJ+wdrOt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-OXFoNnDtMbqL0ZNXiXwhIg-1; Wed, 14 Jul 2021 04:10:11 -0400
X-MC-Unique: OXFoNnDtMbqL0ZNXiXwhIg-1
Received: by mail-wm1-f70.google.com with SMTP id l3-20020a1c79030000b029021ecdaeeafaso204451wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8UM8qKhd8lVsw4YNA+FXQlest2HKWswEUdYrUZ85lM=;
        b=VRTJ/nnSYxVWOovGyx2VbSR52tZKco/Ut/yBc4ibS7+CAOjXEts3BC5+n3GkeuvmX8
         enzppQC+VAtIFtX+dWMOy3KInMClRPI7oa5/Pr5/cEO+OGztsrar+nEPAKwlLHrcK6f7
         6tpXzR8k7B/gxb4CG/C9tqF48jdOgTxfpLsdIUshpGx/Z3M/OHdxvRKLeFQpN/yhjCE4
         yrOOOnLNNTxBZMTMbi3QlchzxGD+4G0rYanePo6NqpP5RSX7BrXVpM2KrHxAb2g1JkEt
         5xmO4QS8BA9kdOzzBti5dwZ90vIFNzZwtIyeilKvbf5071pF5LmD9XrKWMX+ORHRMryE
         koog==
X-Gm-Message-State: AOAM5318A7rYrT6ttBW9yJd6RxtnNClnIN0knUfJ3gUUtQTgl2Z1QMDZ
        Dqgfn/9eYkVSLZHXGzukeEvScUE1XasPy4VNVSxcdSjQjewhIy+/FZDTKfPFT/qQmX6XoLPwkFs
        TIREI0sH94Butd2hV1EyulLHB
X-Received: by 2002:a5d:457b:: with SMTP id a27mr11044874wrc.280.1626250210355;
        Wed, 14 Jul 2021 01:10:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYmPT3/5MsOfJha3Z52k9DoInyEWbS9uUahOBUUpguHN26tr7QhB1FbdzQKqoZRxvwl+W16w==
X-Received: by 2002:a5d:457b:: with SMTP id a27mr11044847wrc.280.1626250210094;
        Wed, 14 Jul 2021 01:10:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c15sm1292998wmr.28.2021.07.14.01.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 01:10:09 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Jason Wang (jasowang@redhat.com)" <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
Date:   Wed, 14 Jul 2021 10:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/21 10:01, Daniel Bristot de Oliveira wrote:
> Hey
> 
> I use kvm-vm for regular development, and while using the kernel-rt v5.13-rt1
> (the latest) on the host, and a regular kernel on the guest, after a while,
> this happens:
> 
> [ 1723.404979] ------------[ cut here ]------------
> [ 1723.404981] WARNING: CPU: 12 PID: 2554 at fs/eventfd.c:74 eventfd_signal+0x7e/0x90

> [ 1723.405055] RIP: 0010:eventfd_signal+0x7e/0x90
> [ 1723.405059] Code: 01 00 00 00 be 03 00 00 00 4c 89 ef e8 5b ec d9 ff 65 ff 0d e4 34 c9 5a 4c 89 ef e8 ec a8 86 00 4c 89 e0 5b 5d 41 5c 41 5d c3 <0f> 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00
> [ 1723.405078]  vhost_tx_batch.constprop.0+0x7d/0xc0 [vhost_net]
> [ 1723.405083]  handle_tx_copy+0x15b/0x5c0 [vhost_net]
> [ 1723.405088]  ? __vhost_add_used_n+0x200/0x200 [vhost]
> [ 1723.405092]  handle_tx+0xa5/0xe0 [vhost_net]
> [ 1723.405095]  vhost_worker+0x93/0xd0 [vhost]
> [ 1723.405099]  kthread+0x186/0x1a0
> [ 1723.405103]  ? __kthread_parkme+0xa0/0xa0
> [ 1723.405105]  ret_from_fork+0x22/0x30
> [ 1723.405110] ---[ end trace 0000000000000002 ]---

The WARN has this comment above:

         /*
          * Deadlock or stack overflow issues can happen if we recurse here
          * through waitqueue wakeup handlers. If the caller users potentially
          * nested waitqueues with custom wakeup handlers, then it should
          * check eventfd_signal_count() before calling this function. If
          * it returns true, the eventfd_signal() call should be deferred to a
          * safe context.
          */

This was added in 2020, so it's unlikely to be the direct cause of the
change.  What is a known-good version for the host?

Since it is not KVM stuff, I'm CCing Michael and Jason.

Paolo

