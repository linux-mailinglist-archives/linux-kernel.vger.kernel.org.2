Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645813639B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhDSDSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:18:03 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35371 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhDSDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:18:01 -0400
Received: by mail-lj1-f180.google.com with SMTP id a1so37678275ljp.2;
        Sun, 18 Apr 2021 20:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=b1Esi1WD3INsXc8Mpz0AJivayvHJYCQXopFXhNta98w=;
        b=SwP6qdDfULNgiFhCReun5MFiKaUhBiFxL61WvF0I2F3onHcpUglftWCVGcIlTnrA2P
         ZuyDNJawkATYMnfYearmEjtNtJAcwu03Il1QdSw8zNODvHelC0Z25jvwCZt1CUmPWS8L
         /QC0IH88XHvW4Qeb7mEgu91vYWTA+bNxzXjI4nyhFNaEQRtqX2RK7Wp9UzpZpt9JfSh3
         ho5RC6A4gkzWNHA4PMJhkkvqvxLqC3+ODFtW7r5FzJthEboOYGxIkI38uTDrC1NW4Ifm
         1GNntD/FfLaBKGlNTkDpItr0s63k7c6BiIuxTB7gb8MbFjtUtATwmJSyLFiLFFQTN1R7
         dT6w==
X-Gm-Message-State: AOAM532vmh2Q7XZ1tNrvx3ygJpRMFwYi027kOqO+PYO4qsVEp2pAyZtY
        oOyDVGYcNX1i6Z+x4xebY7GPVk2HgersdQ==
X-Google-Smtp-Source: ABdhPJw/RqNKojJfu3DeiCIkYZ+LkTRMGTrzf+il+R/vQVf6hnz9t5/JKTZm2Cvutf+Is5ahVNPzug==
X-Received: by 2002:a2e:804d:: with SMTP id p13mr9994910ljg.267.1618802250357;
        Sun, 18 Apr 2021 20:17:30 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a25sm1720590ljm.130.2021.04.18.20.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 20:17:30 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f17so46630103lfu.7;
        Sun, 18 Apr 2021 20:17:29 -0700 (PDT)
X-Received: by 2002:a05:6512:3e0a:: with SMTP id i10mr10803227lfv.496.1618802249832;
 Sun, 18 Apr 2021 20:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210419025246.21722-1-samuel@sholland.org>
In-Reply-To: <20210419025246.21722-1-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 19 Apr 2021 11:17:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
Message-ID: <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] sunxi: Enforce consistent MMC numbering
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 19, 2021 at 10:52 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Dealing with the inconsistent numbering has been a major pain, and
> there is a solution with (as far as I can tell) no tangible downsides.
> So let's use it.
>
> Yes, I know the kernel supports UUIDs for root=. But UUIDs do not help
> when referencing the whole, unpartitioned device, like is needed for
> updating the bootloader and firmware. So for the use case of "write a
> bootloader to the SD card, regardless of where the board is currently
> booted from", I know of two options:
>   - Dig around in sysfs to find the mmc number from the MMIO address,
>     which means I have to know the MMIO addresses for every SoC, or
>   - Apply patches like these.
>
> Samuel Holland (2):
>   ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
>   arm64: dts: allwinner: Enforce consistent MMC numbering
>
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 6 ++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++

At least with Rockchip this is now done at the board level. IIRC it was
a request from other people to not do it at the SoC level. I don't recall
exactly who though.

ChenYu


>  3 files changed, 18 insertions(+)
>
> --
> 2.26.3
>
>
