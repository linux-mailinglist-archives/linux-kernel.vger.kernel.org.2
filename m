Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C0438CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 02:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhJYAHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 20:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhJYAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 20:07:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA7C061243
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 17:05:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r6so5755885ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXs3CPiRM0ktOPn6UKcTUaxBGbDFvG7y/D+eqfm+MiI=;
        b=EcqtqNeLccqZf+cv2/s25z9obdQyXFWwESdFctu92gglRQdTZilo0i5mW9ktv1CRSH
         8gcQDYNEbRGQpjfxp/u/Yp8OfTvFYkgPPwTw3RVE94rCfUxv5czaERJlokO+/zV83QrX
         RHKWpBeCyAIc+olrONkEnxnO7XgRReItJ9JV7LzvfQmiPxP3KKvNqP+/d+eFPXaywCEc
         TmyNwQm0YDxuzkNjLlb3wIDsjPypsGNEoyrbdKGB2nBh29/DpGCiwy3vMVKw3nmLcMhp
         /ycA5xhEyOFFyCUim9WUoTxrNWHnhfFLM1Xh8aToH0Ofnzpg5W53/HmH2Xlx4gp07260
         1vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXs3CPiRM0ktOPn6UKcTUaxBGbDFvG7y/D+eqfm+MiI=;
        b=p56XUsjhzNtYckBTThACrsDdLURLqKLrfjge12+t3m8Az2aZ41y2++6RjpqawL/BGJ
         F0V2ktGGqt1cXTdX5oBCBVO7SWTXok2A6Vivu92iVUOtqtW95oDdZ7/nttZy3nPxHvda
         QHS71IYYOIEHymWZoSCeV2LvVOr+OGokmIMVqjxgtavssH1MJ95IazO05Xly97UIkVUI
         Jn/fVeNqWO/p/mfXa9KuH4EH9e4jd+m8VReretAJYCTRC2BfI7TqqEoc7zm/cDcxP57B
         oz9kWnX8mR8csqeHe4HD5uvedELnk7v1XTQGTpSNm+ERgJdFUpgvql0EsM+0aHqOQ7fb
         CLDA==
X-Gm-Message-State: AOAM532lizjMOIp6f/xOKMbzG70L4Ue6j2jq8JMjaQtUCdFzG6umDtsu
        wRyPS7l1EBpeNoru7Q4KAQWgNt1fNJ365OR9dTqXuQ==
X-Google-Smtp-Source: ABdhPJwz/CLcFxBI/cvz+vNv1O1716R9EDbGS/lJN3cLLx8ZY3kiktxsKROfdKUg6qk8vtT+Kjkh2EnAzf/Kw34JXc8=
X-Received: by 2002:a2e:9e4e:: with SMTP id g14mr7718082ljk.261.1635120321725;
 Sun, 24 Oct 2021 17:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211024154027.1479261-1-Mr.Bossman075@gmail.com> <20211024154027.1479261-4-Mr.Bossman075@gmail.com>
In-Reply-To: <20211024154027.1479261-4-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 02:05:10 +0200
Message-ID: <CACRpkdZGAfJATC5MGaJ9AUs8x+nN_rDRATyV44Fkztoat4-ZLw@mail.gmail.com>
Subject: Re: [PATCH 03/13] dt-bindings: imx: Add pinctrl binding doc for i.MXRT1050
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        giulio.benetti@benettiengineering.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Huang Yongcai-B20788 <b20788@freescale.com>,
        Andy Duan <fugang.duan@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 5:40 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
>
> Add binding doc for i.MXRT1050 pinctrl driver.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

On this and all the pinctrl stuff I need review from the current
Freescale maintainers, the fsl,pins stuff is a Freescale pecularity.
I would hardcode all of this into the driver but there are historical
reason for why Freescale want it and does it this way.
(And I don't understand those.)

Yours,
Linus Walleij
