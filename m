Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5045E264
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhKYV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233572AbhKYV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637875400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pimlV2lH4TvXP6k8O9RhFaNOCPNxxUOqrc3BdluZm0g=;
        b=jHohF+896h1DkTQrRO7z62VXuuko68G/s6o2nYxwhv77keR1JzOii4lAqXRqnj6E6cukF4
        247xPDNvgoFimoETcqz0JHkoYFXMZWBTsa7xSZHiy3JC33VRAjyNULuiUGHFxrcK6915xX
        3ofBJwiVcrqj0iWVdoXyN/ip50snDww=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-RbuMvXTsNLqE9rV_Gk0hDQ-1; Thu, 25 Nov 2021 16:23:19 -0500
X-MC-Unique: RbuMvXTsNLqE9rV_Gk0hDQ-1
Received: by mail-ed1-f70.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so6351939edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 13:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pimlV2lH4TvXP6k8O9RhFaNOCPNxxUOqrc3BdluZm0g=;
        b=0VvN/MSOjVGwMUP8V1Ru9hOwAsOuOFtbhm6e+axq310OdLJ/IdfCm4TbL8IXXHoPBc
         TJaFJLp1ZcJtBQT+Woq5/KSorkOZtX21tSPcbsoONimZKcgyGbfXurGtWJdNnSguJEGn
         mynPDYcgH5Lcgy/Vh5qQWoXKP6GQu1yH9YLiaKVg/fG0fSJpDA6Nq7V2oVXswG/rhmJ5
         jQPpw9TeZDamS9OXHOqpCZ70vqwuelNrMuXOprlS+MQeYTB5fb5B1pww8f+cZPHMNK+y
         0zHww68W3R2fVt/dqxu4o8IlqHM6LNBtiMTmDNPqB6HhsIpib93KconzzsLiwky/s7O2
         TIvQ==
X-Gm-Message-State: AOAM531vsVKxE4GUmrVMpGhlke7GX2tjm+eO4iaTPk6ssIoIoYnvVl6q
        U3fHEZ2wzG7Rc9TTMMfKX7Zx92mB7yIeEgrrPMaZp/TScIIpG0MXjwFIKl6TbcBHGEzBsNjdGed
        88NptS6agiazeK7hO5H7bqagi
X-Received: by 2002:a05:6402:185:: with SMTP id r5mr41305560edv.259.1637875397443;
        Thu, 25 Nov 2021 13:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRnkN9tLkP2cFib+nh4KuSKdGhb+rdlBs95rCLkSJayE9xRjQxSLcWiis9cvGEhBgCQuB7ig==
X-Received: by 2002:a05:6402:185:: with SMTP id r5mr41305537edv.259.1637875397263;
        Thu, 25 Nov 2021 13:23:17 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
        by smtp.gmail.com with ESMTPSA id lv19sm2367409ejb.54.2021.11.25.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:23:16 -0800 (PST)
Date:   Thu, 25 Nov 2021 16:23:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125161434-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211125154314-mutt-send-email-mst@kernel.org>
 <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:01:25PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> >>> Device removal is clearly out of virtio spec: it attempts to remove
> >>> unused buffers from a VQ before invoking device reset. To fix, make
> >>> open/close NOPs and do all cleanup/setup in probe/remove.
> >> 
> >> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> >> to be doing. These are transport enable/disable callbacks from the BT
> >> Core towards the driver. It maps to a device being enabled/disabled by
> >> something like bluetoothd for example. So if disabled, I expect that no
> >> resources/queues are in use.
> >> 
> >> Maybe I misunderstand the virtio spec in that regard, but I would like
> >> to keep this fundamental concept of a Bluetooth driver. It does work
> >> with all other transports like USB, SDIO, UART etc.
> >> 
> >>> The cost here is a single skb wasted on an unused bt device - which
> >>> seems modest.
> >> 
> >> There should be no buffer used if the device is powered off. We also don’t
> >> have any USB URBs in-flight if the transport is not active.
> >> 
> >>> NB: with this fix in place driver still suffers from a race condition if
> >>> an interrupt triggers while device is being reset. Work on a fix for
> >>> that issue is in progress.
> >> 
> >> In the virtbt_close() callback we should deactivate all interrupts.
> >> 
> > 
> > If you want to do that then device has to be reset on close,
> > and fully reinitialized on open.
> > Can you work on a patch like that?
> > Given I don't have the device such a rework is probably more
> > than I can undertake.
> 
> so you mean move virtio_find_vqs() into virtbt_open() and del_vqs() into
> virtbt_close()?

And reset before del_vqs.

> Or is there are way to set up the queues without starting them?
> 
> However I am failing to understand your initial concern, we do reset()
> before del_vqs() in virtbt_remove(). Should we be doing something different
> in virtbt_close() other than virtqueue_detach_unused_buf(). Why would I
> keep buffers attached if they are not used.
> 
> Regards
> 
> Marcel

They are not used at that point but until device is reset can use them.
Also, if you then proceed to open without a reset, and kick,
device will start by processing the original buffers, crashing
or corrupting memory.

-- 
MST

