Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004C13A506B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFLTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:52:44 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38498 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFLTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:52:43 -0400
Received: by mail-ed1-f49.google.com with SMTP id d13so27628111edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HU4M/zWvYHA9MO16eRl8/ZC5Nof0nEpPAE4d0u2Lmi0=;
        b=S3fOucbKcUPLAyzZNWGGqoTZWAUZT6Y1AiMxQdbenxH1CfIxYInNRTTReDXRbZu15O
         nfFO3/JzwLC3Va/Wqiqvz1cD13tdlCIjIAfgMH8GADGHqYOmbBeEh7YnItuciQ5QP3s1
         eY92K/lGmJfnU8yPTj1MXzX7RaxeZi8hK2LqEHXKtJhe1ghLLv1t0S8OWbLC13ylQSDz
         oxJfrLW7RLv+d8u0GhhS8M2UbkUN9aEAeXOSAjWUrP7QRE2IfW9955WWTTy/YGKsEKF2
         9c6oQHD2QFtbhym+861xmLATL6A8P6d3ASuxm4T3mN4laVn86Vuu2zLMrk23zhYnWqpu
         nFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HU4M/zWvYHA9MO16eRl8/ZC5Nof0nEpPAE4d0u2Lmi0=;
        b=RGreMOiAqFYzzVFrtD/edamKzFvilmZtoAem7vLk/EQnhIDLpFRD4K/YGK3LDvx6x6
         1Mhtf0AR32xA3bP9aupIrWUWm46A1nzcdkQWE3b9puYPtxypzBMSIKe9BdLOaAVCRWjj
         mVOQ3FEJ5mGQkSpj/gdRxivqoNvZtE4EKQ/w5cjJMkowWmkiKBX1sFAMV1wHbsTlq4sv
         uId6e5u0tj6Nscvn3IK30rv3PkO8V8Wjgy+Tjdp9JyuccY/56a+Tx56IxikRjWqDVK/n
         3Hku2DDPR1h6+4h2/NLd2RG+kiGSHOp391TbZ+QUDXO55OfCk6yzclX1YNTSrUGz2elp
         iqFg==
X-Gm-Message-State: AOAM530MZue/rY4lVTiV0MiWtH1VKFcr4r803Oxp9Esk3S/5MtCNIoJ+
        K+Wrd8PnfjnHJpnGzHh9xpjiVOJBGDCAA8F2dpo=
X-Google-Smtp-Source: ABdhPJzGK0E1ZeKp+M2Rz05vQ3XOOQKE082kbFcrBpoa0ot7pD501i2KToyWEaOQZ4TlsbDB3t0KUxPQPYpbYXAHfuA=
X-Received: by 2002:aa7:d755:: with SMTP id a21mr9953685eds.146.1623527372009;
 Sat, 12 Jun 2021 12:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210607065435.577334-1-narmstrong@baylibre.com> <20210607065435.577334-4-narmstrong@baylibre.com>
In-Reply-To: <20210607065435.577334-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 12 Jun 2021 21:49:21 +0200
Message-ID: <CAFBinCDMGJRsCQde-MB-mbU2qdJ9qnOUXo0SqpsDkVx1CWoeVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] arm64: dts: meson-sm1-odroid: add 5v regulator gpio
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 8:54 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> As described in the Odroid-C4 & Odroid-HC4 schematics, the 5V regulator is controlled
> by GPIOH_8 and in Open Drain since this GPIO doesn't support Push-Pull.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
