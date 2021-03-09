Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D70331B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCIAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:07:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:39968 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCIAHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:07:20 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1738B31A;
        Tue,  9 Mar 2021 00:07:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1738B31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615248440; bh=aro/K9hGsiCfNpWwbsTPq5Uhfyxfv2ugmYxqzUxcpGE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F2/984U5gJBHF3KshQD/dKQePRGRNGhVzKbSBdk08QrVaHW/qrEAHxocNXdtyK39e
         Ibl5SPY2qTkGIHYL2XKYxbbHKQFPiaUd4d+XLjg6mO+tmXx/3IdI+3aRt/+1HN47Jj
         Yep7u7z8Sc/hX0CTrq6b6zG1RTU4xC//mnEtVYoeeWiAz/hBqdiwVdzR1pRBHPjC7E
         fUtP5npR1vEFZ4KtVNYl/mx+9JXmTB3UXeLmdcV1+eYHysftByXUB4x1kfDxrYwtIC
         d5QeZCZ1hh/w2lQHWmHFiF/3BC3/ATfPWCESFuPJBMvnLHsgj5vgk+C/aeidPrWiZq
         gbT7fF/yCPsdA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] docs: driver-model: device: Add helper macro examples
In-Reply-To: <20210303133845.3939403-1-geert+renesas@glider.be>
References: <20210303133845.3939403-1-geert+renesas@glider.be>
Date:   Mon, 08 Mar 2021 17:07:19 -0700
Message-ID: <87lfax5gw8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> 	Hi Jon, Greg, Rafael,
>
> The DEVICE_ATTR_* and ATTRIBUTE_GROUPS() helper macros have existed for
> more than a decade, but are still not mentioned in the driver-model
> device documentation.  Hence this patch series adds them, including
> examples, to the documentation.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (2):
>   docs: driver-model: device: Add DEVICE_ATTR_{RO,RW} examples
>   docs: driver-model: device: Add ATTRIBUTE_GROUPS() example
>
>  .../driver-api/driver-model/device.rst        | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)

Set applied, thanks.

jon
