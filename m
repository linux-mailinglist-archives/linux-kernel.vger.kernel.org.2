Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF5386BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhEQUzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhEQUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:55:40 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:54:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d11so7218789iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WzNUoUY7AUzQjydPiHh/ZS4e3yrInAcISdLJEmYM3yc=;
        b=Wh5JfGpUaPJojzaNAJdl3t0QkhsYdECNwc7XO4FVOOoiBQrXIcmGr2ZP/wREltRbB1
         fjEXaxhFvw3FgNeJWbg0ErSkZ1xl1iAapPD0SVAtsr7JYb/yFf5Uk2eBTTBtd1frw1la
         Ym7pwwlLrenCybZD5B4vp0ky0zwOxWJDHqUuRc0HOjyQqLVH2/KqIskhf1FsSL+Dp8/e
         xYxjMOaPVELZdOjae1WMx6QQWjjpfKjeTO5K3l7dItJheVjfWhhY8naIoVnRcTHKuoHY
         vU1S+zxJviCcNNw3R5CIkt4m0RtXmJFEGfYG4RDLsM1HBzqv7VQhrv0iKi2dn7GZlKJi
         58zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WzNUoUY7AUzQjydPiHh/ZS4e3yrInAcISdLJEmYM3yc=;
        b=kRHDSwHPFR+0REauumymdXXBhxRo9mDH+Dedmtx4pR9AnE4gNPDU823IT0NeaHbThS
         gcEtCl0LJrEOfP77/pGCzYKAr1uiS6SV1FD5S8XU2M6V8AuwrfVdz4hzw4cb+BIT8grh
         svs7fF77to2ddrcZQIaMzeRfHO6W5HG7mGSOF40QUXPkf7cc1MmPVK/Hh5eiuiunJpBD
         YiNJ3oIEyzZGdNlUa3P6tTfyM6DzV4y6i5cgo6iYkdDF3TWXfhhUX1IcmSdHZ//8MbVb
         UnfUhnSSzT423dHHfML4nD56HAzeOzI7mIYD2fl1hQyK6tQvEODmPVGUDv/Ru8XY1cj6
         aMxw==
X-Gm-Message-State: AOAM531dMN6S7V63/Au/BM2kk0jrkMpZoQc6jY1HQTQnqvR22RbLDS7e
        U1uxCJe5ddc6KhDmZvmnRIMyJw==
X-Google-Smtp-Source: ABdhPJxip/qt7R4PId8aNCMSR9857mihgvMm44XHKbpxBIiXIVxpmhORCNHvc6siUldmvVcddtNCWQ==
X-Received: by 2002:a05:6638:138e:: with SMTP id w14mr1906162jad.33.1621284862780;
        Mon, 17 May 2021 13:54:22 -0700 (PDT)
Received: from localhost ([2601:602:9200:1465:17ad:f4bd:897d:c28a])
        by smtp.gmail.com with ESMTPSA id v16sm9581998ilq.45.2021.05.17.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:54:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] soc: amlogic: meson-ee-pwrc: Rename "get_power" to
 "is_powered_off"
In-Reply-To: <20210517202115.1004065-1-martin.blumenstingl@googlemail.com>
References: <20210517202115.1004065-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 17 May 2021 13:54:20 -0700
Message-ID: <7hcztpt72b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The name "get_power" is used within the Meson EE power controller driver
> to indicate whether a power domain is turned on or off. With the
> original "get_power" naming the result was:
> - true = powered off
> - false = powered on
>
> Rename "get_power" to "is_powered_off" to make the naming consistent
> with the third argument to pm_genpd_init. Also this naming is easier to
> understand when reading the code without looking at the implementation
> of "get_power".
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
