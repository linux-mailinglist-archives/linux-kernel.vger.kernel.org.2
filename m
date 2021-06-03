Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2541D39A9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFCSX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:23:28 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:35555 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFCSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:23:26 -0400
Received: by mail-ej1-f52.google.com with SMTP id h24so10665177ejy.2;
        Thu, 03 Jun 2021 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADVoquzaV0LEIwvO5Q6pqef0DTPmXc23DXJhuut77RA=;
        b=D3lf5UiTa9SvEkPsI7imOnzwWcIjbYO0/a3Jg5VFaj5MCXTyhcZE8yWE3TahpqWTaL
         BtMiAQBRWV/HT2ZqmwV7DKqnRaAV5z89xM8bYnRlgXqiu7qHGs7hCIHq+dNPV2h0ycmg
         4Wtv2CqkZFuFOjJVuZCM30nlPpJpaaG7Loc+TycbjPboJkkVo4Tl3JcPO5kdIZRw8BBA
         RVoQ6Nyh55iZXVVaADPdjkCwz09FJZwxSlbZ1AzWI6JdaymZWSKH7GVAdiJwluQthYRw
         jRDjtjPiCB59t1wPaKFngQ9RNCNxLtF09VgWweFwVT+wnBpFOTI0+kiodG4m0gqCsg3b
         P7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADVoquzaV0LEIwvO5Q6pqef0DTPmXc23DXJhuut77RA=;
        b=MnVo3j+3Du0/JtHDFP0PJMlrpxi1hGMX5fA6yyDR6dOmJ/tGNrf6YCQ/MZPmgck5CN
         HQbhPQvdqw/0o0SChUAgGTZGtrrN0jzQbNZSA98veOWertYCZ5u5ANRqZ057C5JFtG9h
         h3plSLPM6GSPauDY+TVuDOSwIx0jQmMWOLNqXBGKPj+AZXeBvmtkaxxRfVAlNSeLvoCS
         Pq/TsOxS5Fk0feBC3Geqz7nbEhcyGoEYz5BeOhdw1q6fXDfWbCMiM5VTa/b1bCFgnSc0
         Klho4RnSkWHjTcI9swWd9/4GUM24joRBdH+zpECu259dXN608yocIHVjOfjPOxuJ04n/
         3DhA==
X-Gm-Message-State: AOAM532Ho9iCyljpu/lHGnieNk/qUBvynG72QIP+k/Q1IY0/iRjTY117
        +g1+nfJH+YGwmNr2WDI+Vj80i4nhYhRCz+BdtitOiS6kt7A=
X-Google-Smtp-Source: ABdhPJw2MzrYlh8vu+LAt1q2tmMgENbP3bjmsOtbZJwHu9NzmzZmm5ZNkJTKCubMB3ZXF/AlchDhFRYZtvDSHiIspiI=
X-Received: by 2002:a17:907:2d8d:: with SMTP id gt13mr633877ejc.162.1622744440824;
 Thu, 03 Jun 2021 11:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210601084830.260196-1-narmstrong@baylibre.com>
In-Reply-To: <20210601084830.260196-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:20:30 +0200
Message-ID: <CAFBinCDeo=Mc=hjSuan_zE=SsZnz=vdjOwBY178PTnNcJBJK0g@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 10:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When only PHY1 is used (for example on Odroid-HC4), the regmap init code
> uses the usb2 ports when doesn't initialize the PHY1 regmap entry.
>
> This fixes:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> ...
> pc : regmap_update_bits_base+0x40/0xa0
> lr : dwc3_meson_g12a_usb2_init_phy+0x4c/0xf8
> ...
> Call trace:
> regmap_update_bits_base+0x40/0xa0
> dwc3_meson_g12a_usb2_init_phy+0x4c/0xf8
> dwc3_meson_g12a_usb2_init+0x7c/0xc8
> dwc3_meson_g12a_usb_init+0x28/0x48
> dwc3_meson_g12a_probe+0x298/0x540
> platform_probe+0x70/0xe0
> really_probe+0xf0/0x4d8
> driver_probe_device+0xfc/0x168
> ...
>
> Fixes: 013af227f58a97 ("usb: dwc3: meson-g12a: handle the phy and glue registers separately")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
