Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5B4307AD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245240AbhJQKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:06:00 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58688
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245237AbhJQKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:05:58 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D06ED3FFE2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634465028;
        bh=/w7rnLVxUNTURGieCGfqqQ4bUB62VIx19Vc4b3uH07U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RAV43nb+Xvzmk2b/rUhePogqGjzuJB2LHSGz91ycrLavn6DYaeSWTLd1GXm9fRhWz
         8w861Ayp6obOuBB9VUMThkiiVCYL2piVKQ61dY31Vk7pQaHbTefifPLwga8gBNw31g
         10W78NfV3Qi4g8HIuDaBuhfGiIF6P+MQsgOyTS80mIYnlrFpq6GAPa8ARkGdzOU8qn
         aGlpncOe+BugWtpVt6eEVjpH6p2cKMRjgTBaxfw41jS4/+I/mXfiXStCzKqImd1zVb
         s+IuNOHamPxQnr/K9VfIxk3VFHWQGSrdQy4pThcJxUSDqT0P2j2n0qbkWDhBzkEuEe
         sFBCJ41GYYcqQ==
Received: by mail-lj1-f197.google.com with SMTP id e26-20020a2e985a000000b00211109b97e6so255846ljj.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 03:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/w7rnLVxUNTURGieCGfqqQ4bUB62VIx19Vc4b3uH07U=;
        b=y9dGsNDIb6nNfl0212e9Hrno/F12SrilJ/ImiXHm1vma0D6kLE5VF9owX5rkZx7WZx
         zShS5gBJHC6ZoXIthKDXEmvqrVK6qQ8aYuboW2zknAvIRgg5djs5o06vAYrDZ5jJbDMQ
         CSJGmPnm1uQur5vn9zrhUz/UoW3uWE7ZCPv3kMMXvDVLBFR9S+1vFciZQKYhLg7vUqq3
         9aQ3NosqCNMzqVspZZ0V5juQMer4LmEc3guB6T81Si8zozC24AUnv1y6GSpGuK+udau9
         kzVqdRXs3WHX89fbLNgrdMN0bF46x4uYKM/MZXZISalJbgZYy2/Id+eCBwh78cInA13r
         ciEg==
X-Gm-Message-State: AOAM5328p4XcIoRwsTl/7uDUva+l73nTrWUTEOQNldhTVUu5i1vqPoI4
        7OaqBxI92ShToLazrg+V1LAQxoO8dpc6NvQc/PJ64sOqAioFZKhX+B067iYgXcQrDWW7qF22jUw
        dE1pYVp2waD2KG0JZ3f9H/s41RVH7slME6uOlGhmSUU90qXG2vY3+8qdRVw==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr21077563ejd.171.1634465017857;
        Sun, 17 Oct 2021 03:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBD4IVI+3m1jDS1GLi//iCI68rTkdNzvWdP8PXY93uSfBu2PzfjILpnco+k3Rb/r6y11YH8kKxYU50YYZPaHc=
X-Received: by 2002:a17:906:919:: with SMTP id i25mr21077516ejd.171.1634465017650;
 Sun, 17 Oct 2021 03:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211016102025.23346-1-arnaud.ferraris@collabora.com>
In-Reply-To: <20211016102025.23346-1-arnaud.ferraris@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Sun, 17 Oct 2021 12:03:26 +0200
Message-ID: <CA+Eumj5zqbk7Vn7dAvjNWXKK6pCNgu34-VZGudP=BmO0_+0Tgw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: dts: add 'chassis-type' property
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Lucas Stach <dev@lynxeye.de>,
        Angus Ainslie <angus@akkea.ca>,
        Guido Gunther <agx@sigxcpu.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Dan Johansen <strit@manjaro.org>,
        Simon South <simon@simonsouth.net>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 at 12:20, Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:
>
> Hello,
>
> A new root node property named 'chassis-type' has recently been approved
> added to the device tree specification[1]. This will allow userspace to
> easily detect the device form factor on DT-based devices, and act
> accordingly.
>
> This patchset fills in this property for existing ARM64 consumer
> devices (laptops, phones, tablets...).
>
> [1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst#root-node
>

I'll add the same for Exynos, S3C and S5P. Do you know by any chance
what is the meaning of "embedded"? How a development board should be
classified?


Best regards,
Krzysztof
