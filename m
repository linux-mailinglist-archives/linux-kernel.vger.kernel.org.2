Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AC39A9BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFCSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:07:32 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:37495 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhFCSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:07:22 -0400
Received: by mail-ej1-f43.google.com with SMTP id ce15so10569468ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhuorpEwWaM24p5GKEX8o1M3vPLTB9Mbm2fC2Wr3lLc=;
        b=MO7ybZYyh1zLZK3xW5pB0qSJ7+MeBnGLfNZk6FGlHi4Qsus1eXoKj/MJ/Dm9Zhd0He
         81yBlPed88OQVbDUeCVxNwV0MEIHm84UZOHPzK0uAPxHJ06k7AO4aXC81BQ6wJdzaI7w
         qAgCXn3UpsuLBt3cAZnlh9LlG8xmGgHiiLso/NfT+U8TEy4Jd/HdrNlEMV8X8i1I454M
         wbeeF1e4b7GEGLLcSNuJSXNXix4xSbpsJPLBRdL2++uW6BZa/Il4qyeDuIH0kfzrP9Hl
         FA5PZnNrN7pNHWDWPCkqyLfZI6D7dswnlTAAx5npDKro4SEO6/Eys6eFYWNolPfEfE0N
         dvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhuorpEwWaM24p5GKEX8o1M3vPLTB9Mbm2fC2Wr3lLc=;
        b=nOlr/7E5V9uF06GPgBZ7K8NDiRJ4TKtQOrqdWcqs3MNE/lYPx12CLG4HHtyv+Uy/cx
         4WzyPJBdpARFODFHqCrJM12X2fvm9VankawGSxxD8G9rARuG7UEehdr0MEceMUmnkFmn
         QLXeRxmJgBn53jyPqJEy1qgY/yW2RMaaXLZSzMTThAljiH+W8aDCSc9kcZLqC1DWM0p2
         6e1dT09seMQzXgLL8II6xnVJf44zZBsAz0+R10/par39/E/GYOcwmQpKUHH+EC27S9MY
         KfFg7jNwKwtCoyhpqizE+KV7ZYF1NrKrJY9vKofae7Tv89uLT2UkR5Bu9XenNRF68Jzs
         Z1Ng==
X-Gm-Message-State: AOAM532yM4TP0iyXu4mg6QkS+rzSCJ3YXQlokiXIfk1BiEKy2vp17HUO
        u6q0EkKYXTH/xsfFxOP8Rb3oGnJEMjF32kjbCME=
X-Google-Smtp-Source: ABdhPJy/HSvM6SWAJNO+/5mUui3RjSzM8+GY+x941nZByI3bRfV+ASnzQ+GE7gjz53O5+Wo0R2Dt32XKtr1k+6zzpxM=
X-Received: by 2002:a17:906:1682:: with SMTP id s2mr566367ejd.172.1622743409439;
 Thu, 03 Jun 2021 11:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com> <20210601090140.261768-3-narmstrong@baylibre.com>
In-Reply-To: <20210601090140.261768-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:03:18 +0200
Message-ID: <CAFBinCC0RJ=HGzOHSy+8C-WsA2rd-Yiri3_sF--h4vGcz58N=A@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: meson-sm1-odroid: set tf_io regulator
 gpio as open source
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 11:01 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> According to Odroid-C4 & HC4 Schematics, the TF_3V3N_1V8_EN can be in Hi-Z for 3v3,
> and since it's the default GPIOAO_6 mode at reset, let switch this GPIO as Open-Source
> to drive for 1, and input for 0.
>
> Fixes: 88d537bc92ca ("arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
