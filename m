Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0267845B014
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbhKWXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhKWXaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:30:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 15:27:09 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so1271602otv.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwR7w/M4Q8qtIzCDcAQVXEmcuIC9wJDRftO6EL4gBoo=;
        b=mSaZ2VU5+HDgoa/iDnfBfMpzjYzjog8eQcqJClYoBoCNX6T3kcHgQn5eO5nEtySDS0
         c49yFdabzc8RhTCQOQHvoxPfsWehvF/AWyZKZGq7I27B2fh9n9qrMGwqDSA/VPtlMzcw
         xK9z/EK716wVZf2WEk4/RsD5T0Yd6qRAErS1PdD7wwRYbGmgwTXun4FcO4nq4HoHGPF9
         rGXbNjNEIUdRUWPZnYn3cRVhAEOZSDyn06tntY0R9aPNHCtUhwsP04WXsx3BOzwU1+QZ
         qSFgar3kmDD/UyeTQtnqnpndS3VOAcUV+OMlh2k47TSfxYyfavFl8O3RN/OXZwYxsMKQ
         AR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwR7w/M4Q8qtIzCDcAQVXEmcuIC9wJDRftO6EL4gBoo=;
        b=X6qsee90OzdxdUGInHHMHP7F7xlISuO0sfodv1ygTxKqZj9AoJ6Dpd3lwowY5V0MZB
         1iXGkLe1w1O/1xE13NlyZEDJYhGs8kjsxn0FoaeNrVcv0old433g4CN8bwS2djQnaepg
         UCHQSYv9UMo7IJZORyAuO6LZY4hPWbrG4N02TWRwSG0fVXXtMXq0CSPrVSe7xhi8U2iJ
         kkD3lEhF5+YoT0ZHgcRgemRk1Oh5/JrVyFZ8R//tF+ZMNbNgTH9apCS5l4sinwV1Kvgg
         lfTAy+2Zq6vTBOHsBYDp4rXwee9GBRJgC89nD/CBEj5l6heLUNhv4nLZaGQGDvVccfNP
         5tRA==
X-Gm-Message-State: AOAM531ZGHC1WRO5bUaEa241DyujdVx7+XVvZKoT/28cmCcNfHoWo5bU
        G3iFXe/ixdBqJjqnH3iIm7g3XKlTRmOhoJUSt72tmQ==
X-Google-Smtp-Source: ABdhPJyXt8C2HSDSOfsA/RV/93m93YeKUVlAgbSNT20jk3LS6BL0w2h0DLsVZx3fAj2o0+Zx4oRJueGUwfUtiPFyBd4=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr8593599otg.179.1637710028501;
 Tue, 23 Nov 2021 15:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20211122225807.8105-1-j@jannau.net> <20211122225807.8105-4-j@jannau.net>
 <5f16c962-72a1-21ec-9651-744053f74365@marcan.st> <d48d2e85-42f1-570a-bd8f-e3834147c8b8@marcan.st>
In-Reply-To: <d48d2e85-42f1-570a-bd8f-e3834147c8b8@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 Nov 2021 00:26:56 +0100
Message-ID: <CACRpkdZghfRvox4aY4ROXYwFqiV6mnXZgw+42ZWYisXXgQ5+jQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
To:     Hector Martin <marcan@marcan.st>
Cc:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 3:43 PM Hector Martin <marcan@marcan.st> wrote:

> For those following along in the list: the reason why i2c3 was getting
> stuck is because it seems the unused bus is weakly pulled low on these
> machines, which jams it.

That looks like some power saving attempt.

I suppose that means that even i2c buses that are in use
could be weakly pulled low when suspending the system
and maybe even inbetween transactions to save some
leak current.

Yours,
Linus Walleij
