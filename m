Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D363FA6A6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhH1QBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhH1QBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 12:01:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E993C061756;
        Sat, 28 Aug 2021 09:00:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me10so20724045ejb.11;
        Sat, 28 Aug 2021 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+Lu3zsplYuNKF2IF+QmpVTl2y5bBSCP+aSg8wuwsiw=;
        b=HF+xsgvsnrJrPToIAqza2r4D+a2I4uKoEWs4qUPB9ZtxE2lP61oybEuf71lmwwsehc
         chY8Av/MqB3ykfHwW0Ja5AxiiZmS4/DeXKkolm4txdYKhEzQZ5l138XMO3+VGsgrn+CR
         qwuu/5OM9ZpeW453SAUOh2G0AL+xSwJflEuEAGZTKZRElo1NZcF6YyQ3H8TiHqZmsX9W
         cIp2roGNC2b7of6WssIXw6mppEIUbFl7OvHHsaudDCz6Zt2sFliwpt/O0M5kPzE1zl1N
         756MlwT00hoeEpixvex5O9YwQCeeFTh1XN4lFUY34JKFo2eSz4EfQNcOSLu2WHn5h/N7
         mH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+Lu3zsplYuNKF2IF+QmpVTl2y5bBSCP+aSg8wuwsiw=;
        b=RIMVKLZlsL32dyIcp2aUGMkwdJ8hDwCsa68WNKJLKEVZTqPyMENUBcuCJStN23DL/c
         arKZ1ra35+J+vZLqQ91mNybPZwilMVXw8i9Yu9DyfPpYz3WotaAemZPloBtO950tYe9u
         yW5M2nLZujS1R6jAB/5lqINvOxx1tLQfK/foR58B83b8WVJO4JBc/rNnus65zxf7Qucd
         nmfmIDeafQoOa30QVGa2aI3iNz8lrc7ZSlKP+ZzsGvB+xVK+YiMORa2Uy7LwaRQbBnac
         SfIQ+fVIZNK4PSJwMS3KyLUuWVQ2NHC25KADXZ9ki63bAiaExbpxLbLWFYXIwdJWZldf
         /meg==
X-Gm-Message-State: AOAM531DLl1h05KSYXUSjZ4q2T6U256dGh512SQKtKwSd6FzNpfv3Pdw
        vuKVI7g/fBu4idUJAz99Kje73GdthArsxiBAlyU=
X-Google-Smtp-Source: ABdhPJwD2vEA5j8yQQHHv0y4xe5OPRu0rQ5pLqz4tIRsU3/TzhWBp80jORvSGA8DCjkphVreH8wjKsmX3LcpVwfxUqE=
X-Received: by 2002:a17:906:369a:: with SMTP id a26mr15768976ejc.539.1630166438950;
 Sat, 28 Aug 2021 09:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-4-linux.amoon@gmail.com>
In-Reply-To: <20210817041548.1276-4-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 28 Aug 2021 18:00:28 +0200
Message-ID: <CAFBinCAx33SnuL8n1GF8nz2Q4giNR8tsWxjU32X0wsb6kR_nhw@mail.gmail.com>
Subject: Re: [PATCHv3 3/6] arm64: dts: amlogic: odroidc2: Fix the chip enable
 signal for usb power
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Aug 17, 2021 at 6:17 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Fix the chip enable signal changing from Active High to Active Low
> to enable input power to USB power. Also updated signal name as per
> the schematics.
according to [0] (page 12) Odroid-C2 uses an "RT9715EGB" for USB OTG power
The datasheet for that power switch [1] mentions on page page 1 that
the "E" stands for "E : 1.1A/Active High"

Can you please elaborate how you have tested this to confirm that
active low is the correct polarity?


Best regards,
Martin


[0] https://dn.odroid.com/S905/Schematic/odroid-c2_rev0.1_20150930.pdf
[1] https://www.richtek.com/assets/product_file/RT9715/DS9715-03.pdf
