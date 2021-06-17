Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095B13ABF04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhFQWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhFQWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:39:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:37:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c7so4986357edn.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUciLQPe2Dk0W8P+MRSTjK4kMOaVU6u+TFpGcIEqZkg=;
        b=go05/on96W3tqe+r5HAAC/EouJUuzocIqNZcxoyePCdqdf1ZyIv5X0OUulBSw0vFZa
         eBB8nourSCgCsbxJd2wzMqaSLUgIRzkvaQ+2jr17NDmhJ07lCqDGcvBD7EJgnZrlHi4J
         HAk2KFnY3OvRz2WHPJyEmEpmnCqJ9mntAbLGKGZI7wkw60NgJmZDB6ulfCTijFuaqZLM
         RgVWqIWPEPVSPn7wEyuAmaVaxomq9Rw7qVF5ZK/zX1OiKq9zboVk4jZjOjQ+cp3uI8TT
         xyfuXJq0VXzpXXoOLCyzc8cjgeodHCsdfRXTMLmuhFf9SQKUFnHywo8IYtKhSFDN6E2J
         jbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUciLQPe2Dk0W8P+MRSTjK4kMOaVU6u+TFpGcIEqZkg=;
        b=uFnBSTdVNSFIPvX+29WiRytNFU9mbO2a+nvcQB/2intRIWPV095zk92txnYjJppkIU
         C6XEXWkTcFESZ2lvfN9JK2PT4h3O4KTv9Tge35j0OhpHB5mQrGDi4dF6zomUCnuvJUaF
         cyqrzbAnz2qI75w0aB1eFuepApLNUv3iLkZdhnj4i5xoD20AQKSr/jlfV0JkCeoLorh4
         JJbOA6adLcEwcFUyy9NS05WMzm/SpfGR3iGzV3nD9NUusOx/pqBJytnSbRLxSrdu9WlT
         YVlSZ6Fc3tGfWFbfCyJuQEmPdEVkPtmJudwGnw/fT8Mgr1Jv0SzBBm4rjsnO1KIEX1c/
         59CQ==
X-Gm-Message-State: AOAM533Po04LnlG5kLOUqO7Gnc46hoE8YcQxQHhhICUvmWG1+DzN0UgX
        UAas5E39nCX25F8iRp5VdLk0vvFlKm64snfVTVc=
X-Google-Smtp-Source: ABdhPJyKnkbQdRPfTK0z4c4f22bYrhYhEWRgvpOoInIGpp2TniF7iZEMWL7FXEb8W9zWpi1CYWtdISGt0cg93nBmuaE=
X-Received: by 2002:aa7:de1a:: with SMTP id h26mr830256edv.176.1623969433156;
 Thu, 17 Jun 2021 15:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-8-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-8-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:37:02 +0200
Message-ID: <CAFBinCC0KScn6cJ36ZB_=TRncOOCXJHWwR3s=o3TobH=yOrGJA@mail.gmail.com>
Subject: Re: [RFCv1 7/8] phy: amlogic: meson8b-usb2: Power off the PHY by
 putting it into reset mode.
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> @@ -245,8 +250,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>         regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
>                            0x5 << REG_CTRL_FSEL_SHIFT);
>         /* reset the PHY */
> -       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
> -                          REG_CTRL_POWER_ON_RESET);
The vendor driver uses the following sequence for the power on reset:
- set the power on reset bit
- wait 500us
- clear the power on reset bit
- wait 500us

With your change we now:
- wait 500us
- clear the power on reset bit
- wait 500us

I don't know if this is sufficient to bring the PHY into a well-defined state.
Maybe it works, maybe it doesn't reset at all in this case - I don't
know how to verify this though.


Best regards,
Martin
