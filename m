Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A099D39A9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFCSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:10:51 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39706 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCSKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:10:51 -0400
Received: by mail-ed1-f48.google.com with SMTP id dj8so8186156edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYJURPxWBX0cR9mUpvvw71/w4E4zYIFQ+91/6hNUZl0=;
        b=jqr+MDrbXS4YAJ9lmXLHLruxtUvtxXjJqfzkg0sr3GVESKkRp614MZ+RdtvBX491w1
         qaIS+cqBFLKzdh/Fxx0eKeb7MnGps1YnL/a406/8CKBBMUuaQaA4qQcCMOiVEC6oPOV2
         7V/akX8QfHzSoTjdo1/I83L9iLt6Pfmtt+oLopR5dwzOnEu9d40Oof90DBXBAkxzuGTb
         h0GmBSHs79WLU29SvmSsPZUQgJxWzKYJtPPnW6HXl4aQTMHhNNUktaMaVPJLU9Yzwv+C
         gbUUIUbE72RjBjhXDbgON2crJzmjTTxW1uMpLYGucvrd6P9WPVZHVQX4aqIsIbQqNKnV
         P7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYJURPxWBX0cR9mUpvvw71/w4E4zYIFQ+91/6hNUZl0=;
        b=aC9PEX+WGP5dXzg3NZ/Ni+2JscdDpzXbBT9+Zd5Kj4vcesu/Lc+0UfNwy6O7vKqBjv
         sqJlqLUme3x08u9NnDaIF6kltjWT8ZVjAdIVtniWoevzORukZ2m6oKczd8A2GgQVxLKg
         RFryChiJDrT13KIY2xtO5Yq8jgF55sBl9rlf8EVEvkwSSOaYXc1Da91QsQwtOEW8QNgc
         UEzscgo46/pJPnwUOTomE+hWx/oQA9DnpEz3xAx7WdCc8z/mzY59nFAgwSgqlkrzEda+
         q4b9W8QfVBVryJW9SUucb0/xaPkvsBpPAN8BmoAVaaHaizm4S4qeFW//sxmdXZte3h4J
         b13Q==
X-Gm-Message-State: AOAM5308konavuLssslSfTJBaX0Pw8qHD82XRv+GHfknGSfsf4Txfnho
        XccbAESdMgoYxPrcJ3vPHOUWJ7owkUs//MYse5Y=
X-Google-Smtp-Source: ABdhPJy/BvQ0cnHa+Dxd3Zf1ycYh3D9JDrctNeFJ50qSmvb4IkIpefIcVam2VrRe8f/haAzfhOKl4cbVUc4JPNKhcpc=
X-Received: by 2002:aa7:da8e:: with SMTP id q14mr729410eds.13.1622743673906;
 Thu, 03 Jun 2021 11:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com> <20210601090140.261768-4-narmstrong@baylibre.com>
In-Reply-To: <20210601090140.261768-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:07:43 +0200
Message-ID: <CAFBinCB+SyCmxrjJLcuy=mLsChPZ9i_1TsaWkL3kuhPO1wGwWw@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: meson-sm1-odroid-c4: fix hub_5v regulator gpio
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Jun 1, 2021 at 11:01 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> As described in the Odroid-C4 schematics, the HUB_5V regulator is controlled
> by GPIOH_8 and in Open Drain since this GPIO doesn't support Push-Pull.
>
> Fixes: 326e57518b0d ("arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
my interpretation of page 32 of the schematics [0] is that GPIOH_8 manages VCC5V
GPIOH_4 is connected as RST_N to the RESET# pad of the USB hub -> this
seems to match the original regulator definition


[0] https://wiki.odroid.com/_media/odroid-c4/odroid-c4_rev1.0.pdf
