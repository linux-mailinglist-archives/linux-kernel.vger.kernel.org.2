Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0E4041A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhIHXNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232342AbhIHXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631142765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOaLPYWvCmKA3+gZFk6HgMiMUXXOGyn19f1P8xgHAEI=;
        b=Dtjf43qFPQjT9LXwsVeqgb9sD2igASUeQfP9V/JV32VaM54g+ZZL2HeAlTvQi3RZ9IozSS
        yHh4F83cbu3aUn6qpSbtuM6Ieju8N7/X/yRqQIEajHYneVtiHtRYGcH8FXN2U8JeOT/8fP
        Dl2RaQyDiX6ssfr7aVbvBMcAZQiTHvU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-yPMrHej6MQandSdgAHef9A-1; Wed, 08 Sep 2021 19:12:44 -0400
X-MC-Unique: yPMrHej6MQandSdgAHef9A-1
Received: by mail-ot1-f71.google.com with SMTP id x20-20020a056830245400b005390988b0c9so2362838otr.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 16:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nOaLPYWvCmKA3+gZFk6HgMiMUXXOGyn19f1P8xgHAEI=;
        b=C3VrKl6uFL4ZbQ/IwudGWB1vgIOhu5qh24i+wiXR5raerC4ffteo/lerQt4O+cZmJt
         4TiKX70ie27kRxIcUXtOzSN6+6z7WCKqZDLD2+fe7HllL0sb3g2CiiEu5KHdpq2RNKqT
         RKvVaw0nRr01P3/jUNMQukch2Bj1Jebiq3a8s7jcI+H8Wh7p9LEy43gNCDg9YDP4ndnJ
         zcfF5+pHR6hkH0eUZt+wiK9K647xxKdYfPmeBJgVsM2qmhJjyUm2586Ky28eq6XD0FE2
         AorsMZx8IYXcYpvCrHPpqwWSOFOX8rS+AwfnwCS9jrWMfIdjkWareve94/AYzFBRJ6ng
         XNmQ==
X-Gm-Message-State: AOAM531sv/cFAEZCvWLH5gUFOLzJ7h+86INKjnkGHRd0v3zjThpaY/Fj
        xPFadxqSq/9Bd41LPKTDXbJ9yiNJP+x48r9k9E/YX3wbkKo/ZiG1fu6BwnrR325pLOrdZG5i5FV
        TIjWEIUykiMmHtIwIX2y29zt8
X-Received: by 2002:a9d:63cf:: with SMTP id e15mr498584otl.172.1631142763554;
        Wed, 08 Sep 2021 16:12:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqJXuGzjBMZyjx4FIV1ALqedQxy0ByHV+FDgb9944WAR2nbxG24k2RxSKOZtXTYszMG+qinQ==
X-Received: by 2002:a9d:63cf:: with SMTP id e15mr498561otl.172.1631142763201;
        Wed, 08 Sep 2021 16:12:43 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id j10sm11655oiw.32.2021.09.08.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:12:42 -0700 (PDT)
Date:   Wed, 8 Sep 2021 17:12:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vutla, Lokesh" <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
Subject: Re: [QUERY] Flushing cache from userspace using VFIO
Message-ID: <20210908171241.63b0b89c.alex.williamson@redhat.com>
In-Reply-To: <d338414f-ed88-20d4-7da0-6742dedb8579@ti.com>
References: <d338414f-ed88-20d4-7da0-6742dedb8579@ti.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Mon, 6 Sep 2021 21:22:15 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Hi Alex, Cornelia,
> 
> I'm trying to see if I can use VFIO (Versatile Framework for userspace I/O
> [1]) for communication between two cores within the same SoC. I've tried to put
> down a picture like below which tries to communicate between ARM64 (running
> Linux) and CORTEX R5 (running firmware). It uses rpmsg/remoteproc for the
> control messages and the actual data buffers are directly accessed from the
> userspace. The location of the data buffers can be informed to the userspace via
> rpmsg_vfio (which has to be built as a rpmsg endpoint).

In the vfio model, the user gets access to a device that's a member of
an IOMMU isolation group whose IOMMU context is managed by a vfio
container.  What "device" is the user getting access to here and is an
IOMMU involved?

> My question is after the userspace application in ARM64 writes to a buffer in
> the SYSTEM MEMORY, can it flush it (through a VFIO IOCTL) before handing the
> buffer to the CORTEX R5.

No such vfio ioctl currently exists.  Now you're starting to get into
KVM space if userspace requires elevated privileges to flush memory.
See for example the handling of wbinvd (write-back-invalidate) in x86
KVM based on an assigned device and coherency model supported by the
IOMMU.  vfio is only facilitating isolated access to the device. 
 
> If it's implemented within kernel either we use dma_alloc_coherent() for
> allocating coherent memory or streaming DMA APIs like
> dma_map_single()/dma_unmap_single() for flushing/invalidate the cache.

In vfio, DMA is mapped to userspace buffers.  The user allocates a
buffer and maps it for device access.  The IOMMU restricts the device to
only allow access to those buffers.  Accessing device memory in vfio is
done via regions on the device file descriptor, a device specific
region could allow a user to mmap that buffer, but the fact that this
buffer actually lives in host memory per your model and requires DMA
programming for the cortex core makes that really troubling.

For a vfio model to work, I think userspace would need to allocate the
buffers and the cortex core would need to be represented as a device
that supports isolation via an IOMMU.  Otherwise I'm not sure what
benefit you're getting from vfio.
 
> Trying to see if that is already supported in VFIO or if not, would it be
> acceptable to implement it.

vfio provides a user with privilege to access an isolated device, what
you're proposing could possibly be mangled to fit that model, but it
seems pretty awkward and there are existing solutions such as KVM for
processor virtualization if userspace needs elevated privileges to
handle CPU/RAM coherency.  Thanks,

Alex

