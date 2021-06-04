Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1A39B6D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:16:45 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34373 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFDKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:16:43 -0400
Received: by mail-ed1-f51.google.com with SMTP id cb9so10531394edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB54r1V/q9zaUM9NCE4utN55uwjXUtblCYI3g2TbvbU=;
        b=Vyw818AXHPpKdqs8+MaL+/QEyb12dBdnoGlHzHizRS4xah+v4HsS2iOoL3LCt69yeZ
         4vwe9cTEdUv8/6y2l2x5PdBUNgneltjhZ0HkIQUOvWJgXHAOu78fhCfhMMuaCE33ywO0
         E9zvrXVQE86nXtkJExOWWux3cob42HR+IP/E6leFA75b6vTHKYRck6xs79dRRf+1Xfo0
         w0fjbVHWgoQSolsGhecVLpvOPgMW8GPt5qY9MLadhJHcZPMEi81iHoHxcEt/BwGB+Lso
         8Ws9IIJEqn+5u5ji7yuCoe0JUpOnGwrrYYSgc4TQ+k7B83k2Nu51PtbtwnJSs+XPqVmR
         8O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB54r1V/q9zaUM9NCE4utN55uwjXUtblCYI3g2TbvbU=;
        b=DHmL1lES3sEWVdUD9TH7k63q1FsK4KZbCvgWq9HOJS8lkZ5PYQ3DrW4rBskeCsVhge
         ZBHTwMK73IOhg0/h0WMclyuJWERDOPKxXgtCwYgpkUXfvu15Qhjq216bXg1dKlcKH0ix
         1+Qrna88aBuL8HI9YeN+5FWCH5RUu89uiFV7Fw/L0q3cTaEA22UuqcfkWBTSm8240s/Q
         wAjGJUVv33Z66ApOKaAhLM740V3pbKXlf4sE2mRAWoIWi/BCAyYb6RfWoKj5zCoMRn2k
         rxpjHj9amjXNyNbukPKAIfgPJnobCClCeiAM6Tal2Y9hflLtfiUdwAzv09fmmmR74MDC
         GV8g==
X-Gm-Message-State: AOAM533y9dfNJkMAaINqKqzuoMjXI9YmJto7rHzNIFH0/Zdxhm92SwW8
        CXVjmg4mYtSzg5kh2vkhaobLCKmTcrdDpTycKGE=
X-Google-Smtp-Source: ABdhPJxcc5NQiqlUzhlIKHRb4AethxYoWgauUWCwx+PMU+e3Kee73mAWY6Wb9cGuHb3UO/ZRq6cSFnBxn3xeTItob7k=
X-Received: by 2002:aa7:cfc7:: with SMTP id r7mr648821edy.13.1622801621239;
 Fri, 04 Jun 2021 03:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com>
 <20210601090140.261768-4-narmstrong@baylibre.com> <CAFBinCB+SyCmxrjJLcuy=mLsChPZ9i_1TsaWkL3kuhPO1wGwWw@mail.gmail.com>
 <802340ba-edd1-d148-4c6b-e2eae9c2a096@baylibre.com>
In-Reply-To: <802340ba-edd1-d148-4c6b-e2eae9c2a096@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 4 Jun 2021 12:13:30 +0200
Message-ID: <CAFBinCAVeEVWVmpn11RWxuvYBpAVUj37R=U7ykv+YPUNYYTLMA@mail.gmail.com>
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

On Fri, Jun 4, 2021 at 11:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> So I'll add:
> +&vcc_5v {
> +       gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> +       enable-active-high;
> +};
>
> in odroid.dtsi instead in this patch.
that sounds good to me

> Not sure what to do about the regulator-hub_5v.
maybe dropping this regulator overall? we're using gpio-hogs elsewhere
for the USB hub's reset line
or dropping the gpio-hog and keeping this regulator to manage GPIOH_4


Best regards,
Martin
