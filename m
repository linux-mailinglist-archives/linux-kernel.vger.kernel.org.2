Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141F53FA6A3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhH1P5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhH1P5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:57:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F9C061756;
        Sat, 28 Aug 2021 08:56:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g22so14531916edy.12;
        Sat, 28 Aug 2021 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvpIahskAaTOBlt+JLrDDDHCDcxjhGW+GXDJSUKJacM=;
        b=YWNcViXUHxUJyDr7/EtN+W3GEuZSkpZEbpafkzJbXpuZbV6HJgrSqMZsJfQSEvfniW
         NGoyc1631d2+pXKy3aa0hPMWcYvvKOJ3dKZN8ClhbpRh8f+lAjC0xPF3Td6/yuepHEtP
         62R0lA6VrxKnwymJmPRzzMyPtvz+sBqY8OpwFyVLdXAZQfDJ+bkIAMEtGm/6ftx6+WpD
         1WbiTxTlzIVoYWEC4Rux43hRGEoryzA7mrXcGQvQzxYX94WtfnbL+CwMK3kVT6eMVRqQ
         A92eBEKOfkaEwnupt8KP5jR8EJtcSJG7M5Av9/VmDCeUN230rvRZG33ell0Y8tmn9rTO
         JXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvpIahskAaTOBlt+JLrDDDHCDcxjhGW+GXDJSUKJacM=;
        b=FH58CwiCL3zzAhNDmwrmVvXzfN8w4tuRit7oDVIUbi85HRogpwAaB+nrzWu5JqN8OV
         oGlB/Kue4RbQ0ANmyViffRQdnalPi+yfqRQf/rBC4fRkfvNbd+/oZHqvhS82YfUqGxic
         mi5PnFk/jEEgj7h65LMJhi2K/1VpdrMdWEip4uOMky3t3f2TZZuwlp00GnIaHuB8/uz3
         L2w/wT3to3mVG/Tv4cveECBvm0jAIbKhGoCgKecQRou4minXYf/ibdkpqaRQjr8OUV/e
         sBfMAcsdPYNBUBgOx7DAyYZ9mDGYhN3G6cRuXt3lncpCUGDGSb0LjxOmiACrfiFiTJHi
         Aa2g==
X-Gm-Message-State: AOAM532fKviE/+CD+MeO5jq7hYZ2RzHJT7plSgpZDKAY5IT/BL6n5kTM
        0a3Ls2YuOQrUkSXS4eywc7IQQuVasx2YI0+Qxw0=
X-Google-Smtp-Source: ABdhPJxzFNpqSCAUZ337fhDSkjiD3TLh/T+GYBk8lHXVTmBrL94/bdOfFeeukR2CrwwkHFL0WzBUJS99chHZzyx+3Mg=
X-Received: by 2002:a05:6402:313c:: with SMTP id dd28mr15369640edb.179.1630166179073;
 Sat, 28 Aug 2021 08:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-3-linux.amoon@gmail.com>
In-Reply-To: <20210817041548.1276-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 28 Aug 2021 17:56:08 +0200
Message-ID: <CAFBinCB8CK8Bn2xKpiAToQQ4K1_W1XZjND9pOGZRZeMp-grs3Q@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] ARM: dts: meson8b: odroidc1: Set usb power source
 to always on
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
> Set P5V0 and vcc_3v3 power source to USB to always on
> so that regulator should not enter in suspend state.
Neither of these two regulators can be controlled by Linux in any way
(there's no GPIO to turn them off, no PWM signal to change the output
voltage, etc.).
So can you please explain what this patch changes from a functional perspective?


Best regards,
Martin
