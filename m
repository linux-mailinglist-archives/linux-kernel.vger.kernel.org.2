Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE67343085
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCUBmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 21:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCUBl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 21:41:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1380C061574;
        Sat, 20 Mar 2021 18:41:57 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v3so11597915ilj.12;
        Sat, 20 Mar 2021 18:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESm/lcAtyH6vOOdrN20V7/6mrqkNWK2PhIRlFX72nnk=;
        b=Slcomi9lRemWi45PXjS7tTUbBS1JZHYQfYXhgBxhP+9jVcYoUxSw1zNCF+6hI0dpvE
         OpAVg5Fx6KjZ8rzlCo/9+eq1Qppy/d6PoMe5dGg3tSUvPlTorilWuAKVSW/UZPe2qCc5
         W4bT4ORI2HSrfhMWqb97uTHncbWKD7kBJLDcir/Yl4tYuhjCeHLA3Dkose3m0oKwkzpd
         wJD7JA+0pMDDEb6BGh3etKeK6MQuwJZsQOS9FgrtaP//Gd6BhsGnU0QldhL5P9ewYxSS
         BvUU79N8p2MN2law69tklUsqCjH4/pNoalQgbinJI7FeLXHK0ciK0W8d1AZfE4JWbkEW
         wXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESm/lcAtyH6vOOdrN20V7/6mrqkNWK2PhIRlFX72nnk=;
        b=Agpi9aTfjgm9qpWfyXpVnOpMep4n78Zq75mLY9IkRT5am0QbftPW724VZCCafSH2+S
         jFixLKEjDgcMXS4vU3KM6AWaPGT2fTQSL2eatcO/t9hSOFOzOtxBWqqPpP7cc70tU6KS
         6hoVmtBE7v96RHL7ii1pl9EDhC6UhPNkKbuTtx4xBeomCeuo1beLbswi1xekhJzPlrjR
         L6SMpSeIIECDFHxYuZkQ/P1vx7J3hHKYVExD9vDVCDLbHxNM7mx8rYJSdvMgAiHoMq/W
         nwKYPPoWa30oK7LXq4MnzyvN08oeqzuD+TjgbgngJtziiLyWdABfj89wNFSEHpqJN4kK
         5axQ==
X-Gm-Message-State: AOAM533S4b3rKqDytAuQxIIlosEVIT8DKs9igj0lAB1Ki1z2ADZQRq2/
        U3z5hPkGcsvCix9zetn4R7q+MvHGNfvsKJU8/Vs=
X-Google-Smtp-Source: ABdhPJxNeIjqHTvGCd7IurM2wlzsVlmtt6xN0OLxtQkRnmCvjdQMcxkQ0T6588MjsLSkCQny4bHDaSB87LL3nLoSd/I=
X-Received: by 2002:a92:d6cf:: with SMTP id z15mr7156094ilp.40.1616290917099;
 Sat, 20 Mar 2021 18:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210316022740.132-1-alistair@alistair23.me> <20210316022740.132-3-alistair@alistair23.me>
 <20210319130615.k2y6u7otnzbs3hpx@pengutronix.de>
In-Reply-To: <20210319130615.k2y6u7otnzbs3hpx@pengutronix.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 20 Mar 2021 21:40:05 -0400
Message-ID: <CAKmqyKOxnXb5Pvbs=ikm_YqvRHrC03s3QU51cfwpw9C4+EWQFw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ARM: imx7d-remarkable2.dts: Initial device tree
 for reMarkable2
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:06 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Alistair,
>
> the patch looks quite good only a few notes inline.
>
> PS: It would be cool to have a log to previous patch versions.

I'm not sure how I could add that, I will add a changelog for this
version though.

>
> On 21-03-15 22:27, Alistair Francis wrote:
>
> ...
>
> > +&crypto {
> > +     status = "disabled";
> > +};
>
> Why do you disable the crypto subsystem?
>
> > +&dma_apbh {
> > +     status = "disabled";
> > +};
>
> Why do you disable this dma controller?
>
> > +
> > +&sdma {
> > +     status = "okay";
> > +};
>
> This is the default state so you can drop this node.

You are right, these are all just left over from the vendor DT, I have
removed all 3.

Alistair

>
> Regards,
>   Marco
