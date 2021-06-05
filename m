Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2990D39C72D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFEJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 05:52:49 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:42933 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFEJwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 05:52:47 -0400
Received: by mail-ej1-f54.google.com with SMTP id k25so12765373eja.9;
        Sat, 05 Jun 2021 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUL55trsK3iGDeYqiUfYG/F0lSMpavljcEoIgPo1+wg=;
        b=LABjJDxVAjH6/Z1R9UFnNFIsoku1Lgc1UO56pI3YW3D1ObTc4BzjQaK2K1FCncFmOp
         xI1/zq9XyNfgtHI+4otJh9IxOJ0KPJBavDYMtlEUrBvy2WKN+/4EsuiFrHU9P196SPhO
         mOU+pV/3MqY9dSfYIP6d7vC5BLf9UZ54JQXys3WYcLYu9VcvyDoF7Zj0qONCrYDCpwta
         SaUbpzS5m2EmhR5GX7gQc91Lpl2dYodo1Wf87SynTuDD/Nus/zWPcllx/tTVXg5V5c0C
         Hx32bR8k7JD79EDu6z2KUpwB2FIz93rskeS2Oug3kGbMVdpqJPPRrKyNdAJnPJ3lI50N
         MNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUL55trsK3iGDeYqiUfYG/F0lSMpavljcEoIgPo1+wg=;
        b=mWvTM3CYA6Qfl/XyXVedjTvMqgN/13EbPh/jW3FpvfNsAriY5yhGSAXUlQg23B+ZUD
         247VKMOUh2F3nzGs+YVl2aIZp7sG+AIKMTH8wZ5Gy/eNP6Jj7ir3e3HtUxC4jOSk2vS2
         nicSMTTxuqcBDaVKif8jFf93umCnwxMPITScL7574nveP2qbPDHhsA11a3Xr2QUTOGEC
         VOlHQvD0Z3GGAHQ/OFgr2EJ3NDKn5RO9GGqvmMVt8VhGGFSB9wmAQ5O/164051royeuc
         KXXGS4KHkz/yTesYGG78XNKu3evmlixerW3uJorp+ITGphB2o/uSCUqPe1Zfjd2BNyj5
         60Gw==
X-Gm-Message-State: AOAM531JLbclwHrtOQU5j4YPcPnnIHFPuUn+qknPRIt9UrqswrFMglbC
        5p4M2KgEQxT8J1HG7EyTcugK312zHpPwRe5yLBg=
X-Google-Smtp-Source: ABdhPJxBdFNViNJgZhsw7KvR5SGb6k9Ioqc/iEODGjTsNTPsZKHaPYbvAQ2t5UTDRMbXnq0lsxic+Wh9AVF4c5PMzms=
X-Received: by 2002:a17:907:2d8d:: with SMTP id gt13mr8666648ejc.162.1622886589815;
 Sat, 05 Jun 2021 02:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210605030915.411391-1-xieqinick@gmail.com>
In-Reply-To: <20210605030915.411391-1-xieqinick@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Jun 2021 11:49:39 +0200
Message-ID: <CAFBinCA+Rm3X43fT4oePS0vXphPPEZMweoM_7c0MR1ZwSbsoaQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: vim3l: add NNA node
To:     xieqinick@gmail.com
Cc:     robh+dt@kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, artem@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Sat, Jun 5, 2021 at 5:09 AM <xieqinick@gmail.com> wrote:
>
> From: Nick Xie <nick@khadas.com>
>
> Add Neural Network Accelerator device tree node
> for Khadas VIM3L.
we neither have a driver for this upstream nor any binding
documentation in Documentation/devicetree/bindings/
are you planning to add this?

Especially the missing binding documentation is problematic as it
causes some warnings when validating the .dts files against the
bindings from Documentation/devicetree/bindings/


Best regards,
Martin
