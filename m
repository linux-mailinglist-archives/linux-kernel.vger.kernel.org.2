Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF43A05FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhFHV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233470AbhFHV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTl1+jTDXK4/+Z//CZLJMjtvlHBS0lRzIg34WUYNSgw=;
        b=JKuWakcuXqfgDtPUuA/1t4qBP5RXAVJ1YDcy78PIAcmhiUnC+H/c/UCG4990x3RRJ92tjh
        QtV0jTwYvjVth81ipxKx//BvSk/FXv8vs7+GrRxgJi1YyzZKc4WC1LZDnIFYVfx0RFj5dS
        42UEk4uiSPyqMabpdcKQfsn3d2pFMXM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-PxwTLLMmOPiRvTNKTBDZ9g-1; Tue, 08 Jun 2021 17:26:46 -0400
X-MC-Unique: PxwTLLMmOPiRvTNKTBDZ9g-1
Received: by mail-oi1-f197.google.com with SMTP id l123-20020acad4810000b02901f1fb44dca7so6494367oig.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=oTl1+jTDXK4/+Z//CZLJMjtvlHBS0lRzIg34WUYNSgw=;
        b=K53zR2/ipFzBjHulrH5eL08q5RtaNxSXml6YPERTbcFzU36DJ4hEEhTl/RgbHFwE81
         EeWfUKUEaNC1UeGAQdtHj8Pa0JrMTVswLqoW2p56WvenIGdnZ649NjxuDM8y0UY++ZNQ
         8WLK64NoCN+Ck105I1bkZz5ZixGuJpjYF00fhT68kSvedybJVgjGwMZrtZcOLdiktI/f
         7zr+sqag89F1Fubihqdoda+DqUA//FKm4jeyYJSRrxh2BVgBI7bcikUU1sDW2Y7erR3j
         kegmNNc6uTTSiy7AU49/blI870Eb3J/BxaYBWwoNMWdhLcygTAPLd7b/vVGXVMinCU25
         XNTQ==
X-Gm-Message-State: AOAM531WKxtI38/argdHQaghTYFhlx2n/WzthF76pc+wAFRBhD+3aR1S
        D7rRiWjz/NVhojXOTcvs1jH5Gyr/nl+/7OQUY6c/CEyzM4WpFG/Iy9RRs5PA0ZYggM8R9FWuojd
        ZZHsf+i2VBVmyUgJJGqltt+ed
X-Received: by 2002:aca:39d4:: with SMTP id g203mr4304817oia.158.1623187605875;
        Tue, 08 Jun 2021 14:26:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhqt8hzm9PPzK237+q2Oz4nn7wvQvfT2ISKovodCgGN3KvS0c+qDcFTQB17aEM+Z/wGTvIOA==
X-Received: by 2002:aca:39d4:: with SMTP id g203mr4304793oia.158.1623187605677;
        Tue, 08 Jun 2021 14:26:45 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o21sm642393oie.34.2021.06.08.14.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:26:45 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:26:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jgg@nvidia.com>,
        <aviadye@nvidia.com>, <oren@nvidia.com>, <shahafs@nvidia.com>,
        <parav@nvidia.com>, <artemp@nvidia.com>, <kwankhede@nvidia.com>,
        <ACurrid@nvidia.com>, <cjia@nvidia.com>, <yishaih@nvidia.com>,
        <kevin.tian@intel.com>, <hch@infradead.org>, <targupta@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <liulongfang@huawei.com>,
        <yan.y.zhao@intel.com>
Subject: Re: [PATCH 09/11] PCI: add matching checks for driver_override
 binding
Message-ID: <20210608152643.2d3400c1.alex.williamson@redhat.com>
In-Reply-To: <20210603160809.15845-10-mgurtovoy@nvidia.com>
References: <20210603160809.15845-1-mgurtovoy@nvidia.com>
        <20210603160809.15845-10-mgurtovoy@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 19:08:07 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> Allowing any driver in the system to be unconditionally bound to any
> PCI HW is dangerous. Connecting a driver to a physical HW device it was
> never intended to operate may trigger exploitable kernel bugs, or worse.
> It also allows userspace to load and run kernel code that otherwise
> would never be runnable on the system.

This is just another way that an admin can do bad things, with the
intention that they know what they're doing and if not they get to
keep the pieces.  There's also still the new_id scheme for binding the
wrong drivers to devices, so the hole this claims to be addressing is
still fully present.

> driver_override was designed to make it easier to load vfio_pci, so

Actually driver_override was designed to resolve the non-deterministic
behavior of new_id, which allows inserting dynamic match entries.  The
problem is those match entries match any device that might come along
during the time window when userspace is trying to bind a specific
device to a specific driver.  driver_override flipped the problem to
match a device to a driver rather than vice versa.  Other bus types
have since adopted driver_override interfaces as well.

> focus it on that single use case. driver_override will only work on

It's used for other use cases across numerous bus types now.  For
instance, how can I user driver_override to bind pci-stub to a device
after this?  driverctl(8) uses driver_override to perform arbitrary
driver overrides, this breaks all but the vfio-pci use case.

> drivers that specifically opt into this feature and the driver now has
> the opportunity to provide a proper match table that indicates what HW
> it can properly support. vfio-pci continues to support everything.

In doing so, this also breaks the new_id method for vfio-pci.  Sorry,
with so many userspace regressions, crippling the driver_override
interface with an assumption of such a narrow focus, creating a vfio
specific match flag, I don't see where this can go.  Thanks,

Alex

