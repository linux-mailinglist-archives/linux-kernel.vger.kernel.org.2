Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE713ABEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhFQW3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhFQW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:29:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0736CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:27:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og14so12536604ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBUUiRVifylGetd2oLvmNK/P++7zX9Z7YgNBUErs4Vs=;
        b=ggMhfu3axYL8C4ap0nbWKkEpnCtKKRXBEbRmyc0jerIaGcMimeQWJ8RvvbZL6U5OZF
         WsKQNOenJLOATry+yy1U1+cXSxUZntw+/z8ZQnko27QXIQhw38R7wORTRIgr27P5X7SG
         ipspex+3Zz0PEpfp16gkt61mRkmdpFsOHIWBcRw8OPSGvyHSO6wptXqTlu+FCKCgUHMb
         +YwjCicDWlyHGL38hNobBy5/Rnxyjx9JfQORRi8AucdnazkVESDdcpVwGyG3XuU8kOLQ
         tluzcMwM060nXgRbuwLWeFmFDmU+vQZqQH2zB+Mzng45PbBywIr9QoiFrms3dtbr/HUb
         qVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBUUiRVifylGetd2oLvmNK/P++7zX9Z7YgNBUErs4Vs=;
        b=YTMVHX1u48fBmC+6h4pTF1fzJhVF9ZO5viTJWYaRQCTGJRhvuacjSw6ODUXzb5XMna
         V+EIcZ9H+SBQ7abtpOecW9ZxTYtoFJM4lZGXyKWsfdfXdS8VXj6+sC2iNtgpp1c+IFwt
         VdUmJmKdmzR6N8ZdMOpl8NAxwNIQQ9B74O0iRyiCCb04ZKNjaBHwlOeXJFN0NxUE4AwB
         /QDpYt97FHUv71HxeIrFMh/x3X6LWAtI3kU47tGZ49FxeLBaaNUKWs+nriifwkS9wusx
         MFVMFEEhofwB74FZra1kRatt4HONx72entBB9ci4+NW5+Ry8Y76yde+Tw2wjB6eoDFsd
         RaUA==
X-Gm-Message-State: AOAM533Gn3Kr5voHCK5YZwblzRxBZTe0l2UlWk+dG9/YbwWXoh2/6Tgj
        vELvdTAn6AlkfGNue4Kpj9MHySQCcP8E4ktf2Uc=
X-Google-Smtp-Source: ABdhPJyMKvbRGhk/yi1r0TWkeVgBBCLvywBFU7icC+Ej8Hh6tgBltevZFnA2nAbDjyGU1B7W65uQ06sVjxLlzccRECI=
X-Received: by 2002:a17:907:988a:: with SMTP id ja10mr7501286ejc.527.1623968822667;
 Thu, 17 Jun 2021 15:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-9-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-9-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:26:51 +0200
Message-ID: <CAFBinCCS6mzukqgnJijn2khaaOAPb_mg+zAqYxpUb57297C6Tg@mail.gmail.com>
Subject: Re: [RFCv1 8/8] phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER
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

On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> devm_phy_create can return -EPROBE_DEFER if the phy-supply is not ready
> yet. Silence this warning as the driver framework will re-attempt
> registering the PHY. Use dev_err_probe() for phy resources to indicate
> the deferral reason when waiting for the resource to come up.
This is a good improvement - thank you!

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
