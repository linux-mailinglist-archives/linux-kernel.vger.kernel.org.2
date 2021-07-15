Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1254D3C9D70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbhGOLI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232607AbhGOLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626347163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iigDebZmco0taqe9SkCJHTZVbm5Ws4kCnxgL/XzwRgo=;
        b=MGyJvJdD+U+DrNf4VeX4JfpwrwV6xneTKEZZoKN9FPqvvCekcZtePXUnjxwuyYub8TkrqD
        BIN7XseHXTDsBaYuUsipSyBAoHeWsp7VdEB79cXcSHuBx2uo/71laaDITLnyyfsrKWaqDw
        7SWyo9eQjL5danH2XgKqW9z8oAyf6Nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-o7DqarVfNbqzID69Hf9x0A-1; Thu, 15 Jul 2021 07:06:01 -0400
X-MC-Unique: o7DqarVfNbqzID69Hf9x0A-1
Received: by mail-wr1-f70.google.com with SMTP id 32-20020adf82a30000b029013b21c75294so3143095wrc.14
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iigDebZmco0taqe9SkCJHTZVbm5Ws4kCnxgL/XzwRgo=;
        b=oOgvwkKdnmrbe80X2//jLU/DxKWR9CUFsM90Uu8tJtEwvIlgxgk/7QV4IbglU9ztyX
         Md44YdVlkKkUUL8T2eYSGjeZIQuseDbZbhvrLAV7DtreAqw2OuADw4ra87/4Rgm7azZq
         k0h2FwbjZv5vOkknMwlZKYAXjv4YriaK6RAMpsa8RW3rB7/FVR37cD9e54+E14UfSUWb
         FZ0yh4Yu/HPtS/3Y54M72Dg68ze5jgTZ2WECeD5kP9OZHWS70Oi2oB7JgA5skqnfs4Ub
         iVOwqox6VCdvCFmCyRSkSSshTb19tpg9hBaM6QorFn3uyzWq9WNquRFWiiwIZUA/gnJo
         Gwrg==
X-Gm-Message-State: AOAM533WRTFyl0MeePUgNh133WBFfY5NE8cGluIKEYS0CbOaqbnhpLMu
        6gNmJkjn+YVgMJaLL7FxHm5xLH+0kjdopnvsmKh1yZ8Ur/+qSki63cGU/iAKVp4OkbHY4mKzvcF
        tA1KgDFY6wueuxKNOdp6aKh/N
X-Received: by 2002:a5d:4086:: with SMTP id o6mr4617947wrp.379.1626347160800;
        Thu, 15 Jul 2021 04:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ+zbFYRvjk7XzAMyfGV2R3BmxlI7+TZ94aXGmMBcGbP+vD7W920maAE3H7GZxUttgqjOeKw==
X-Received: by 2002:a5d:4086:: with SMTP id o6mr4617931wrp.379.1626347160625;
        Thu, 15 Jul 2021 04:06:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id t6sm6198126wru.75.2021.07.15.04.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 04:05:59 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     He Zhe <zhe.he@windriver.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
 <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
 <e20c3d90-db24-7722-3f89-adadb83a9bf7@windriver.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c05b358b-1e96-c002-085c-b25e416e7be5@redhat.com>
Date:   Thu, 15 Jul 2021 13:05:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e20c3d90-db24-7722-3f89-adadb83a9bf7@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 12:10, He Zhe wrote:
> The following was provided in this thread. The commit log contains the call traces that I met and fixed back to Apr. 2020.
> 
> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/

> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40

This call trace is not of a reentrant call; there is only one call to 
eventfd_signal.  It does fit the symptoms that Daniel reported for 
PREEMPT_RT though.

> https://lore.kernel.org/lkml/beac2025-2e11-8ed0-61e2-9f6e633482e8@redhat.com/

This one is about PREEMPT_RT, so it would be fixed by local_lock.

There _may_ be two bugs, so let's start by fixing this one.  Once this 
one is fixed, we will examine the call stacks of any further reports, 
and diagnose whether the second bug (if it exists) is related to vDUSE, 
PREEMPT_RT or neeither.

Paolo

