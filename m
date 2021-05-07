Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C7376B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhEGVNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhEGVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:13:52 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5AC061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:12:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso9089242otv.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsiX0491JH5IOV8h/Q3djHE853ReiHtmamJNPaM0VTw=;
        b=bM0IPTD6Uhow8CEABbb6NWIteuWPIHYv+WcypqnfaZUkylgsH17rxpX9bnnsIvIXjc
         j/3bKL+SBDonzgdNYT9lnDKViiKQwvk7lSVW+fyiCJDI9vl+YBpLezXlhGu1GwmdorXB
         ofIq6Emv3PTXPNh8CL/Hhq1l3bs5Ua9wjnZONMZLgcdhIQnKs/3GRLU66CRLQo2n0tLR
         8qqJttbvSPulNsXgsILacd30QNcHTLnfbzkPi/b6+Qpl1dhhhN9u7F2MNXcMvHqrwZHL
         qENyaYEH2B/hjJyqP5fl1nZT2tBmLG6DFxN97liTzUmYfAHCacXIDhvVbBoKmQkRiV5T
         fvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsiX0491JH5IOV8h/Q3djHE853ReiHtmamJNPaM0VTw=;
        b=PHJ6drhWP9uzIcV1CluVfeMkFHE+cpZ7Xli4XJapFtZICD/xV40eRbOsScGpipAYCp
         uH9OJtaNWpL2klZoAmARgdXUWbcuW/DBZo17yDnnnCsvasXSaF36v9GEA3WqoXS6AfUY
         dBRoNWUA3UjcFt3OABD61qqcXw6LInyHLudiRVNLV7bpdPvoaIagPU6eWWTzivb+STUS
         3DN/M43TjTDH9y+Lji0upakDVTNOIZPnDEsjxaGutCASbbnZJv0ko9UWsEBuHN1iU12S
         tD3ToHHn0KA1Ups2wVPd8c+sYKukj1vUag+wQU4L80LoNAu3Q3LHCsa23ecUdh/XZdg3
         kvFw==
X-Gm-Message-State: AOAM533jDxyTOuXbamdpFIad8vrJclPOnB32t6kCTOuhw5jK6qw7tLXH
        jOaAEZagslOTxuN/B0VSddVsNNYdb9qngm6fvD7VIg==
X-Google-Smtp-Source: ABdhPJxZbupy4cCJYrSiAUuciDj3HUdW/Zx4At+9BWzirsCJnGat2A0wTgEZlYtdVRYqdsIK8FwuT/t42w3ZeAMRJ8I=
X-Received: by 2002:a9d:1d01:: with SMTP id m1mr10113074otm.155.1620421970694;
 Fri, 07 May 2021 14:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org> <YJMXpi1V/2vTdJKD@gmail.com>
In-Reply-To: <YJMXpi1V/2vTdJKD@gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 8 May 2021 02:42:39 +0530
Message-ID: <CAH=2NtzufupReL_cKFVCX8NY8syRdQTy9VJfU9B9Uxr_uTv50g@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Enable Qualcomm Crypto Engine on sm8250
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On Thu, 6 May 2021 at 03:39, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, May 06, 2021 at 03:07:14AM +0530, Bhupesh Sharma wrote:
> >
> > Tested the enabled crypto algorithms with cryptsetup test utilities
> > on sm8250-mtp and RB5 board (see [1]).
> >
>
> Does this driver also pass the crypto self-tests, including the fuzz tests
> (CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)?

I did try running these self-tests and they pass with
'CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y' as well. Do note that we need
the AEAD fixes from Thara (see[1]) for all of the fuzz tests to work
(so my patches are actually rebased on this series).

[1]. https://lore.kernel.org/linux-crypto/20210429150707.3168383-5-thara.gopinath@linaro.org/T/

Thanks,
Bhupesh
