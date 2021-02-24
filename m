Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3103242DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhBXREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbhBXRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:02:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B385C061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:01:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d2so3404669edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIaWLlRGMPWjJAANsdhm+dxvE3B3PRnitJWx+eVprg8=;
        b=hHt2LHfZIrOKnIfRckmAg+Yq/qIAkw5e+fAWcDfPizCozNYpxuHndetb0bIgO0HaV4
         vPfnFXpTnTetk0vb2tM/+XUzPiYn/LgxErMIKzFWuXy7h/cF3ZtUCeJ2deFUQkGZNZIG
         agX74bsYx8h5rrXrYRQr7D6l9S8to6FDPJ8HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIaWLlRGMPWjJAANsdhm+dxvE3B3PRnitJWx+eVprg8=;
        b=te/cGCkYHqNgMeOaF2LENTVqO/aIivCScMRLUcfWftmLdIJI4q3ScZLj7qdTkwSxjs
         wSzpbbFHL5JmFa8vqZc1iuzWsEbI3kat3pVMSIg/dLjErvgrgX87AEdYR6eKeB/ORgfj
         pJ99ll1aJ/1Zzoc4YTe70y+qtoyXEngmATOM+jB7SwbIrvcDNvYNdyAnIhOPXBaHOcWL
         vJQRDE3xU8ijfTV7YgNOblvjWg78wQU2sgqHdg9aVr9DlySw93/FyMX2A4kCCCrVpXh/
         sQW2WImmLp4WW/agTVc6O2wvq5C4LPManmRVTh9P7LAZNsuNAttCYyb0xQAp7lZndIxy
         olGA==
X-Gm-Message-State: AOAM531+3uN1aaAsVbbw4UV2JdijfHMW158rk3WEarkDehZQYQ1bndw+
        WxjuGqFb07cg2eiAq6NEe7vcC9/4IUSKiVOeme/YDw==
X-Google-Smtp-Source: ABdhPJzewAeTReHo9MUCUjKxOFpTyAYWsLI54xHmLfOtoCpl2BcLo1l69SMDTPxOObL/cpT7apO4a73B0/+MWuq3JXw=
X-Received: by 2002:aa7:c542:: with SMTP id s2mr14136553edr.369.1614186091162;
 Wed, 24 Feb 2021 09:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20210203091306.140518-1-jagan@amarulasolutions.com> <f9cfa159-ac88-325b-d971-7c860fa722ff@foss.st.com>
In-Reply-To: <f9cfa159-ac88-325b-d971-7c860fa722ff@foss.st.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 24 Feb 2021 22:31:19 +0530
Message-ID: <CAMty3ZAfy7M7TnM_sb0FqPSFYqc1cLGPXB7S-AE=oUST78dYNA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
To:     yannick Fertre <yannick.fertre@foss.st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Heiko Stubner <heiko@sntech.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Marek Vasut <marex@denx.de>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick,

Thanks for testing this change.

On Mon, Feb 15, 2021 at 1:39 PM yannick Fertre
<yannick.fertre@foss.st.com> wrote:
>
> Hello Jagan, I tested your patch on the stm32mp1 board.
> Unfortunately, the dsi panel does not probe well with this patch. The
> problem is due to the panel which is placed in the node of the dsi
> bridge (no problem with i2c devices).
>
> Regarding component bindings for stm drivers, I am currently working on
> a new version.

1. All non-I2C bridges are attaching dsi via mipi_dsi_attach during
the bridge controller probe and that would be expecting
panel_or_bridge need to be in DSI host attach.

2. I2C bridges are attaching dsi via mipi_dsi_attach during the bridge
attach function and that would be expecting panel_or_bridge need to be
in DSI probe.

I believe these types of DSI controllers followed by DSI panels,
bridges are not available in Mainline. if I'm not mistaken.

Adding component bindings in this regards never helps, this seems to
be common for component or non-components DSI host drivers.

One way to handle this issue can be during drm helper initialization,
like attaching the dsi host instead of calling directly from bridge or
panel drivers.

Laurent, Heiko - let me know your suggestions if it make sense, thanks.

Jagan.
