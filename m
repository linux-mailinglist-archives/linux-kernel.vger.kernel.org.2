Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994723A89ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFOUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:05:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F26C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:03:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r14so371359ljd.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1Hrr3f9fv/XXkIZU+MLNVsm0U18tLCQbKfp3yrHWT8=;
        b=YiMM+MC6BQRVEChXL7+wtKkdr+F4h4WDN6eVeYv2RufmZ+UMBbJzKxUsZlajx1uZxz
         N75NUvGyE2GCltiGwjgLOsN1J1rReAzyxNOC5kS4p7QwKajkJg0sQZksW8FyFLfhqAzv
         JCAWSROzB3Vzwfs4yFLokKeJV7QESCayhuTLMpS90sJKbPcITclklyVP6DwdjbC1c32D
         krls5wanQmpzZ87ZUL92g7VFZ1Td0USLzblVpGCmWbaRQdeo9YtyOXLwIzrkjnxi+Kg9
         4X003EuuClFQUEv8qZ965MraCpA41G2aX+ZqY19L60T5/ousdJhPqTK8E0ok2f4cQpMk
         yhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1Hrr3f9fv/XXkIZU+MLNVsm0U18tLCQbKfp3yrHWT8=;
        b=kHFHISEvNn4tsusqaDk4jCaywmkWdU4JVN9pJGvlpWVjAmkDfYyQ38/GNN2qbwLiZb
         nEdUrC9c5bNwzu4FrvuWI6eAj0OFB5qkL3RLkbY7UTYgItrKyQ+L7K7EzJlRSAMo/y28
         +KLEsq0cGtKVNg0sZte6nOC1pmXMW9c2hsHn1jhK56cJKxZ7jgC1jU1qVTHRG1PglgUw
         PxG3GIS/SyIYQhkT/n15PaodMaeaqQ0Hw2iIx4kptg87U78QVZX4zGxxOFgH7rKjtXW1
         l2NqDrqa1md84x1d3FfkhWtJZoNebcks2sTWXgTtWuDcUQXetEGDle+H/IwxRltH23Sf
         Zu/Q==
X-Gm-Message-State: AOAM531zh7L41KvBaYB+FHYXNYFKJB7OwbWCKH3UDjsXppdJy35t9b9f
        MLAIXqGo2n25bF7iaK+GGOn4i19yiYndCNSAK2zUjg==
X-Google-Smtp-Source: ABdhPJz9cEbar1mnjekAl0Ye6iZkMzcSVk6zFhLVSrlKgTFdwFsO1h2OGqDzrM3sDl4B3S7MrPN8jgt+/57igMwVU/M=
X-Received: by 2002:a2e:7811:: with SMTP id t17mr1187761ljc.368.1623787413246;
 Tue, 15 Jun 2021 13:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org> <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7> <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7> <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
 <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
In-Reply-To: <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Jun 2021 22:03:21 +0200
Message-ID: <CACRpkdbyybnxP9p3Jh2TbJMhK+kfLyed-YyrZq9JbOqu1csmww@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> I am now wondering how interrupts can be made to work here. Do you
> have anything in mind for that ?

The aggregator does not aggregate interrupts only lines for now.

> GPIO sysfs already supports interrupts, (...)

I hope that doesn't make you tempted to use sysfs to get interrupts,
those are awful, they use sysfs_notify_dirent() which means that
if two IRQs happen in  fast succession you will miss one of them
and think it was only one.

The GPIO character device supports low latency events forwarding
interrupts to userspace including QEMU & similar, timestamps the
events as close in time as possible to when they actually happen
(which is necessary for any kind of industrial control) and will never
miss an event if the hardware can register it. See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/gpio/gpio-event-mon.c

Yours,
Linus Walleij
