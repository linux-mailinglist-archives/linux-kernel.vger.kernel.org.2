Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140DF409F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhIMWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhIMWBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:01:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A61C061574;
        Mon, 13 Sep 2021 15:00:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f2so19889008ljn.1;
        Mon, 13 Sep 2021 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM0li4XvlIQHCZu79ZtrORrtJzrx72MNL8ruFqQoNNU=;
        b=EB7My+Lz2e9rjDlmUwZPgNa8RTej9CTElZ0S9CQJ9iszb2MtjQFRInWR3TzHzDK0Wi
         rxOfjRG0jSBaqS3WnRxlYddz55h3OZienPwkQAkAJKFPQIlOhGeVpSf2dp9RPuKF3Sci
         015Q26Ebbb5U3DT82/4mS0km/JStZ0yJAWpWMtjgl5FQ6N2ma5sNp/2kOgZTMBdnD8IA
         IsYYYGG7GWlK2TwutcIRIfxJd4DIRH/gugNDo2hkd1sikD72kVAXM0Ea3JtDBmwGOp34
         1YB0M/nRuiP/+npQeoFn4IZMV/NYAgBB2a9mVrGNHjZyUs0/6mNPfE7i3ctQnmtz+iod
         k/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM0li4XvlIQHCZu79ZtrORrtJzrx72MNL8ruFqQoNNU=;
        b=Rk102jWPOsmZIQNbgLREz6Zc2cQLVQUec0939GdvAHaDvt/riftugXoJGBtTC4W5/3
         dIFyqoSTTtKrJzW09RWK8ydVnQ22+b/1/x6gfvUKAKtbwvX4lxH15QZ6CYk3UghniXoT
         9lifd7LjGYZrje9Ftehh0R5pEioiaiyb9gtsV/1c/rMDmDqngH5D+9JueIs7zNbxsQlv
         vBnXCzF3oI/tsFGJaShpY307lwWH9T8LyljPAIl+uzgAV7CKwtVwmG1EaL2SfCcbktVu
         OZZC9m7B+Wo29sbMqO/kjKo+2RAYJ+uIO5DyGIfKnpe+IU6JzsFK+wuPyeYzqRixkUCb
         QdFw==
X-Gm-Message-State: AOAM533cOzC/Sh/K3vGmqCIQgJ8s1lgzPN7TaBAoykw2KWApPLAmIG7x
        Hyu3/A+AVbTi5J5idHkGozwjoiS/XsehWuR2ozs=
X-Google-Smtp-Source: ABdhPJxYUvCH2h37Rycf/3hZ3r8Xb5JBbjLPvvnSGZ0w9FLDcJIJxdE2bJsyHUnSACTX/QZsmY+/qCgBn7q7CMzY60g=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr12592802ljj.92.1631570418050;
 Mon, 13 Sep 2021 15:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210913191626.12726-1-heiko.thiery@gmail.com>
In-Reply-To: <20210913191626.12726-1-heiko.thiery@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 Sep 2021 19:00:07 -0300
Message-ID: <CAOMZO5BtpPX7-sJogk1zuqJViRg+jy_3T3E672Xmp3WgZ5DHjg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 vqmmc-supply node
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Sep 13, 2021 at 4:16 PM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> The sw4 output (V_1V8_S0 voltage) from the PMIC is also used as supply
> for the eMMC. This voltage can not be changed and is not allowed to
> switched off. So we do not want to provide this regulator to the SDHC
> driver to control this voltage.

A Fixes tag would be appropriate here.
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
