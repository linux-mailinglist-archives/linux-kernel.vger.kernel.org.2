Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9233ABF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCOHCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCOHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:02:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D3CC061763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 00:02:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r24so6531292otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ercbfG1R+jYY5kAMzB1CxJzjP3BC476NBkefwMrUqc=;
        b=YuFpc6BFGFhaddH6/ks7Iiw0XD5QrBxYbt1LLavddq5hZFPHQZyiJh+MdBao6/KpAE
         rEDSi+XzdBH+QAKNqdB75Pz4Cd5yhI9WvAmfa5wJ5ar7HDXVPY4R5nCn+SyhaG0+TiJV
         sh7m5cxFaghQw11iO9k1bYgM9hgOyfVZO2INxuc8COvfJ0hZfXaYj3DCAYDyQ6wzsmjz
         DDN6RuxFC3gV9ckpUkHE819+aA+dvuZMHnZqGglS4dRtX7WvZwyaCxhxqHMF9tL1BYt4
         jDwwHNyN3xjosLFC5J3mG0/dghQm1wvSY7cSsRCZs3t7BWnHOc3/LckNfO9B1Q8ZxTtZ
         U4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ercbfG1R+jYY5kAMzB1CxJzjP3BC476NBkefwMrUqc=;
        b=DId0zXNpzyDfCw7O3Xf/hvbVRogfKM68TZLv7lZAMXsLDSdX32Ex/OX4ZFx5raIEux
         u4EvEMWrBe+Z3no6F6DW9kKD5TbiGYld2iSMVWtF8G0AEYpN/1fWikHkiJOc3q27l73H
         RnYK70DtT99uoNPi4wrF16wMfA8i5TvMoG5TH5YKZZeOfhbGCBQaAn2oMqUEN5TcStXX
         LQGWIK+tJLnZcb/xLxw5GOGVtcjnDt9r/F7dBb0QyPW/m/wSfmGEtI0ZWi2yos/UkB0v
         kv0x6Q+En0I6cQt56sz1lShHBXrY2A4HL/hcu9W8LwLXbpx5MfCkx+VyICMRiY6aK+tn
         nLDQ==
X-Gm-Message-State: AOAM531x1fzIqw/JjBSTkhalZWWxtWcDu3eqBvcLrTvK+Oy4wig44waY
        K4+F2RFvd23v6wK5Q8YWLxy0COfu+ePpGTFg5zr7cA==
X-Google-Smtp-Source: ABdhPJx6CKy7J+wpDnOOoXLtejW70Fv4dgOiOj+Mmwq5b1yfinOcgaUuMyswlceY1gvEQSms8Xrs4uswaF7wVt3gjLA=
X-Received: by 2002:a9d:2cf:: with SMTP id 73mr12856232otl.28.1615791720523;
 Mon, 15 Mar 2021 00:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210310052503.3618486-1-bhupesh.sharma@linaro.org>
 <20210310052503.3618486-5-bhupesh.sharma@linaro.org> <161567012068.1478170.1203237376997442299@swboyd.mtv.corp.google.com>
In-Reply-To: <161567012068.1478170.1203237376997442299@swboyd.mtv.corp.google.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 15 Mar 2021 12:31:49 +0530
Message-ID: <CAH=2Ntw9H0OrT=aPiAciP5B2ef7ZDdxM2i2nvuaVo+2NWD+uuA@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings/clock: qcom: sm8250: Add gcc clocks for
 sm8250 crypto block
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the review.

On Sun, 14 Mar 2021 at 02:45, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Bhupesh Sharma (2021-03-09 21:24:59)
> > This patch adds the global clock controller (gcc) clocks required
>
>  $ git grep "This patch" -- Documentation/process/submitting-patches.rst

Sure, will fix and send a v2.

Regards,
Bhupesh

> > by the sm8250 crypto block to function to the dt-binding header file
> > (namely: GCC_CE1_AHB_CLK, GCC_CE1_AXI_CLK and GCC_CE1_CLK).
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bhupesh.linux@gmail.com
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
