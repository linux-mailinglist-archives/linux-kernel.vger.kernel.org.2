Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7982039A9C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCSKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:10:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5878AC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 11:08:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h24so10616820ejy.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqJApWu3yIryGJ94oPzmcdVCCRZ+Rf69VMmTDQgilrQ=;
        b=cgxatrGN1cAAij5lL/nKJzH8NJCp3ytP4HZKltOYA1fzm8r+kdwfBis4k1uuG8T0Yq
         58FLjUrbPOm5W9XAs9V7OB9gvb+eTf14guyyCepsLV+EJqel5uZkiNUmbxcHhejZFrHT
         ekhkHrSoRwqfjn8ZO4MduHAkrh0+DNaYZX42JZE50UTjFTehMZ4pysaB1HCjUKJDzR65
         IP1RX2x6XyXdN5j6pfTMLicnNGZY5VpccoAepBH+AXUjotDAQkqxG3NV495IaShXZpAi
         mp8rze+UcFnT0ZTaKFlTUGr5dwR0N5eTgEH80huLI4SCVHn2NDRU8tmJrDJBUUZr/X28
         WcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqJApWu3yIryGJ94oPzmcdVCCRZ+Rf69VMmTDQgilrQ=;
        b=RcEUYwi5WIjMcHl7LCcCysLOI/V9iNvBN7BcuAtuUuCQ+A0R47NbGsZ2YgXpI9/QAC
         SyMT41o3cKi8tUpD21UHtranOtbGvbBGxLB/vJRpj+3SIBQ4FOPX5G/79T4C4JMoehIE
         ZlywS9IcpgUt1DqxzHRZiM/JCoxYIQip3vUWtPh8uwootOAhnoEcfItX6cRhKnR1i+N5
         j1QwJ2b5Gj0ND000ZEdb7TZH5SMf4+z3FacGmXQmku9mgcsjOiLFz4qEoKC5L9wJczLX
         SWh/eVuEHjmQ9jKwCnD4zFxM+ATMJvA7cobQN6pbuaumRGZZLsaNG8x1VL0hkH8IyF3R
         hVVg==
X-Gm-Message-State: AOAM531bv7FRGjSWGrL5pAo+MLq60MoY2cMPraaVeiMM6rAUN4PeZqqn
        xsGeoBYmdapYvEKyIXWVkZ9fnA0bODnTH5s6vTc=
X-Google-Smtp-Source: ABdhPJwOK+Ce5Tm63Qqo/klQZ5xpJAMOHqsnp7E6PqDLVTnzCOcNae/hg6EDF3ZdFX2BYpQoKi37TTVnHc13QNm4qiY=
X-Received: by 2002:a17:906:56ca:: with SMTP id an10mr584760ejc.328.1622743736953;
 Thu, 03 Jun 2021 11:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com> <20210601090140.261768-6-narmstrong@baylibre.com>
In-Reply-To: <20210601090140.261768-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:08:46 +0200
Message-ID: <CAFBinCBjX04=r1Xs_7ef4cy56zXqpQuqnGtK=F=v1E7fRZgr+w@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: meson-sm1-odroid-hc4: add regulators
 controlled by GPIOH_8
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
> As described in the HC4 schematics, GPIOH_8 controls the USB 5V and 12V
> regulators used to power the SATA drives.
>
> And is set as Open Drain since this GPIO doesn't support Push-Pull.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
