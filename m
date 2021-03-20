Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1E342E66
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCTQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 12:35:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B49DC061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 09:35:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r12so14522429ejr.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=geO6mCSc3dvv1NARqozbaI1WUAau8sllKB/fxc1UDbM=;
        b=bxGQcNXeXpeOjtlbExlasnrrD4MoXwr67JE38ojVBZQDWHavj7IsdgHlypHV4KT/zm
         jbv8e4H1BKT2oJPPkbqXJYdYU54W5rdrkATCLaA82splC/ZR4IuSZap7PEktx4Tw5pEe
         SOgXyyB5CsTUyC7mMTj5Y3Ozq4vduGceHAMk11YHCyoVeAKvYLksPS+tVAyfri2XHhgN
         XWMH10oqXf+4kAX+uhaPbwt7CVNrteD3bB7pyJu1A5C9rdBAn4LR8zwSzcAM1pr2qRrQ
         MEcQ2B5xEpshRhrKFsRVNOayfq4qNi2Mf+halbudKxu846Eml+oRnXwAnW51oRepWA5j
         t4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=geO6mCSc3dvv1NARqozbaI1WUAau8sllKB/fxc1UDbM=;
        b=i3dafK1rCx5pZ3vKilTQwOitanfuJU7ynbfHj3pb3Ns7D0Fn03r+UBk7+zjeS1jKIJ
         bH3bh1+jUvta6EDO6XpOD8ajdh26+ILIMS2JvK79i5y/KKumxGEU83IdlP0/Onolb3FL
         YC4ZQbWp98773Q3MUjs/kbZLjzHq3/WvDSEIQUFx+R2paDZMEVX4UvKf7yc/wNsS6U+S
         FrQYn1X5cCkCRp+XAhS93TubBFoa4BZEMnVt/CaL53SCV1IVgev8dQwPkr3WwKaN0NNT
         JSPKmAaQa1kirIVG9vAR81C5VBTg/2JPHWZu/6RlEi2I04AwmF15Sp2w4yRR4fTJtJXt
         FAWQ==
X-Gm-Message-State: AOAM53340be7a2uuXufq912onqc9+WX6F4jIxvA9hBCz6zhqaZoY/IwY
        AXIw3LONAa6Me9ooT2i6Hl962w==
X-Google-Smtp-Source: ABdhPJzoCF6MXJjTZ1Ewss4fv6CRsklM39YRlzdu2kuke0QSu48Ab3TkuHoF9Zb0kmrS1es8k4pRxA==
X-Received: by 2002:a17:906:22d4:: with SMTP id q20mr10802998eja.54.1616258136055;
        Sat, 20 Mar 2021 09:35:36 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c10sm6356126edt.64.2021.03.20.09.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Mar 2021 09:35:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/6] revised version of third and
 last batch of patches
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
Date:   Sat, 20 Mar 2021 17:35:34 +0100
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <07F133BF-A518-49D5-96FB-E416ECF61A9A@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 4 mar 2021, alle ore 18:46, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> this is the V2 for the third and last batches of patches that I
> proposed recently [1].
>=20
> I've tried to address all issues raised in [1].
>=20
> In more detail, main changes for V1 are:
> 1. I've improved code as requested in "block, bfq: merge bursts of
> newly-created queues"
> 2. I've improved comments as requested in "block, bfq: put reqs of
> waker and woken in dispatch list"
>=20

Hi Jens,
any news on this patch series?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
> [1] https://www.spinics.net/lists/linux-block/msg64333.html
>=20
> Paolo Valente (6):
>  block, bfq: always inject I/O of queues blocked by wakers
>  block, bfq: put reqs of waker and woken in dispatch list
>  block, bfq: make shared queues inherit wakers
>  block, bfq: fix weight-raising resume with !low_latency
>  block, bfq: keep shared queues out of the waker mechanism
>  block, bfq: merge bursts of newly-created queues
>=20
> block/bfq-cgroup.c  |   2 +
> block/bfq-iosched.c | 399 +++++++++++++++++++++++++++++++++++++++++---
> block/bfq-iosched.h |  15 ++
> block/bfq-wf2q.c    |   8 +
> 4 files changed, 402 insertions(+), 22 deletions(-)
>=20
> --
> 2.20.1

