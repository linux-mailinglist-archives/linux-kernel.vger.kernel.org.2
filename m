Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B128D348CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhCYJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCYJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:27:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB97C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:27:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f16so2264997ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsHdTvG/QnL/RMsV0A6gUhCQmyonTHg1LR33V9IaQI0=;
        b=hnSnZtQTEM48kP52tFUl98D3BvVRhgU+MU+zZy0+v5+cLblLERQsxgffOKscuDuk3m
         0Olwlf6QAEJgAgmNI9vqkN6ZmW4k52se0TtUIyCNlQiR06axgKo8KrRN06ogsVz9yfGo
         vErqgGYdxq3ToQ/mnevJUK2wgkY/AQOiKYbh4/k2EtHxX0/kTORXR/YqvQs1C9J6xusO
         9Z9PYmAFK2nM50gF+mkQyZXUp8APc7f5AcyGt0wGAxa8fBew7cpPxKHNA6rynpToGkag
         muZy2GHLB50nZ9TVpuOPOxloKLVCLGqcsBoggfGm6fDCke5Qc1d/k62mEqw8Q3mqVXPS
         t0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsHdTvG/QnL/RMsV0A6gUhCQmyonTHg1LR33V9IaQI0=;
        b=p3nfOa0GkGBNLvLAYFoHfB46Bpqc+jb4e6Srl7Zo9RnYIUzLTAa6SzqH8lzBZDsexs
         CB6MzMKuELf17kp4HwLj5oI9tLGVJZR3z3Z3eWUdvlEvYqKGUQA0Ir30zL1TZCuGM3DS
         TrukwqzC0FHF4b4572/OhP/xS4QB3/4j/DKv1KnMM81OsHbwFcEkyMnpvmcPbRVRxXW3
         CSu8fHR/uiCYkASFidwMGaArQyW1lrhhooGE5rl1VhSTY/Q7o5bU18XCVDlo65auIAK7
         jMwG39JqQE2ylx4iWuG0lP1tvm3pE3nm5fYS4ay9C4aCpiGTHKK4s5YikMrJlHGocOIx
         +uUQ==
X-Gm-Message-State: AOAM533KpL0F1bPEroR//VQaDED97AWESBFgV1lLNi0PcPcEMW0y0LIF
        eDgEP8L3ngDuYFa/g/I91CPr9tPN8nIY39iNKXNyqA5prZx4n+Mg
X-Google-Smtp-Source: ABdhPJxa8BhcHz0FA2PXr6I2mYN+MNsgGHXLC5Ew+Y/aWPtsb3Ri0CK0CzggWptQnMrGEMid2pK+Ky60HOeRIbawnLc=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr4931647ljc.200.1616664460376;
 Thu, 25 Mar 2021 02:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210323013727.135571-1-wanjiabing@vivo.com>
In-Reply-To: <20210323013727.135571-1-wanjiabing@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 10:27:29 +0100
Message-ID: <CACRpkdaMpSDQduyTHPGvyo4NC07uvfTBcmhPiodOsJ929QxMfg@mail.gmail.com>
Subject: Re: [PATCH] drivers: pinctrl: Remove duplicate include of io.h
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 2:37 AM Wan Jiabing <wanjiabing@vivo.com> wrote:

> linux/io.h has been included at line 6, so remove the
> duplicate include at line 18.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Patch applied!

Yours,
Linus Walleij
