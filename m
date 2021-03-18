Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9761B340467
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCRLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCRLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:15:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB66C06174A;
        Thu, 18 Mar 2021 04:15:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 15so7060938ljj.0;
        Thu, 18 Mar 2021 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyNcHfk83roTwvdJIlHqrYHP3nduWOOraeh2JSUHlGw=;
        b=uv6TY1wQg4REZq3APCa64EYho4ouL5vuGEU0UZ45C60RE5NqtEWlBk0Jd64PUqVuN/
         lJNKMbZTg7EJ55w4OWPtfhYTSlRj/NByXX9CCxcQZujlax6S0s/KgIY1+89MOH6AAs8C
         S0cp1Xf3CFt3x7Y+zjwSf81tvA2q9jfCATtU2gh4tZ4YfOWY+t3ytZmz9dwRiQlpMbyq
         CC61BtR6mQXJ9sLR0horfofk37JXsE9KWzau9v/XL+N/HHfbwu6QqQg4K6lYkTHeDUfw
         EjwQfYWKtMJDFyvnk02w/V4l/FdH3ALumbUOFHSN68XBs6gw/B1YPr5VVW7y9XaLSVOS
         Cplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyNcHfk83roTwvdJIlHqrYHP3nduWOOraeh2JSUHlGw=;
        b=ZoQCJ6TG8wZLfAw4tqNmsOsAFOfu7M/qhj0JwN9LoNhpI/AWTfvJxgtDJ0CGMa0OiN
         CaFtZJTCPOKNnacn/uomHmmQPgpe/uAq5kDPpL6DUtHmHLy9MNJ1bi/kFs/AFG0mxYr0
         R2SV64ChMJpQ1LzIxFIx8OEtPchNruioC+dFI21DiLkVBEmGkmwT+VkInFsOhvE5hL9O
         lAiJmMv0GOW5Tym0gf76LrN6u7Vf76pQiNsFrqnhXgafpZDXw4jOfqqXV032CbTcsK9B
         oIwx6HBYTFM4QR2uDgoCnyXD5yT3EA1zzroRVfXObE/oRsUw0+PfmVbTgQ0sSfeiiTsP
         0qxA==
X-Gm-Message-State: AOAM5309lau2PiKXEPeqQg3GFqKW6cNnXVAIIKM8WiCjFBwC+j1G1PRv
        bE/cMUObpRteZMOcbXdweMWcZrAVUKKaE9ZI3Yw=
X-Google-Smtp-Source: ABdhPJz8mKz5IRLIKkRTKtqyV7TUGy5n7srh7ZxcZbrYzDpbqQ2IR0M4B8d+oi1rBqHMf/v6jtevAfs3i/j8jG9KqaU=
X-Received: by 2002:a2e:6f15:: with SMTP id k21mr5124042ljc.444.1616066142520;
 Thu, 18 Mar 2021 04:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
 <20210318104813.GB22955@dragon> <DB8PR04MB6795178A70C52D067DC1AEE1E6699@DB8PR04MB6795.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB6795178A70C52D067DC1AEE1E6699@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 18 Mar 2021 08:15:31 -0300
Message-ID: <CAOMZO5D8n-+PUgrr5wer4y92hX8CLxwDbfLb4mxahTbG+HTNMQ@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached
 to generic phy driver
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On Thu, Mar 18, 2021 at 8:04 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:

> Hi Shawn,
>
> Seems you prefer to 2, is it possible to buildin Realtek PHY(CONFIG_REALTEK_PHY=y)? If not, it is going to be tricky.

Yes, we should select the driver as built-in and describe the reset
timing requirements as per the datasheet.

I have just sent two patches to address the issue you reported. Please
test them.
