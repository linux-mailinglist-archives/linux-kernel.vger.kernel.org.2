Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28E03B74EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhF2PMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhF2PMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:12:18 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2CC0617AE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:09:47 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id k16so4815403vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MUGKjtNRcx2eQ6IHM1cr+oQJwylnW07251DtlqM0fc=;
        b=ysiCYap2U1/6EUncE0LGKvkF+rVElDPWfP7kwvHTtlqpQsCBb8TnwjtT03+OXA4rdg
         CKEuBvoV5RgZEjdemSMQIfcjU8terlcsNOCsrgWxSSahvBe/FJ/78odEEEupr325YG7+
         JcTtm58U+qczxurz6XvxSlKj6RifeVZkvpznoZTvlr22yh8zmbwMciM8rha0ZxCCBV1N
         YsQ/OXycYoBidXcrfrw/pkrKQkG8A5N3Pnpp88IcjEoC6YDtHWowOEgapRMnA9D6G2vc
         TRBPOh5oTYBx/Jbr6G5ajFvuhtFUZsW2d+O2Op4M/sNFYM8CWFXBVX/Mzc6HH85xMJ83
         7m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MUGKjtNRcx2eQ6IHM1cr+oQJwylnW07251DtlqM0fc=;
        b=R8dXwI8+X4qrYUdFOzGXFdNIEtbdksoZapZ9NWNMyjBwLaI7Bpu97ugdSMmu5itX7/
         aFp1iZG7B6qFNC31OqCXvG5HjZLrfuBxur415/t9Pm4AzafwDmz1Wo6kgyg78rMDJi+h
         6tJjrH7uizdkJr/jF+P4Bhss4X3bINyQp7ui4xSi9DgTnP5AI8FxwrKiYLq+ZYN7QfQQ
         OzapDXpu8FAa9gMazCkOLYZ9d2+kV3MqZ5zdUa0lQ3jt9QMfEITMbXkJPmveBWgXmNhV
         fItNbQrTeSjzrIr2+cPdumVtsQFEk3ELAgcJEMVriLOL0gn5uSNCYga1C/6GjM6LBNnk
         l2cQ==
X-Gm-Message-State: AOAM5314yMZJU8VFc3sBDjG1EH4WCnmepZvYxRzfxof4J5C9Svu6hby8
        duejwXF0OP+nDn5QD8YrcBiinaC3mWBsz7o2mMoZBg==
X-Google-Smtp-Source: ABdhPJxkLDJljK6CEHzij6Q39AgIRzFKnDf086DJILJcwdTSvxxoJmp/lL5dchVFlRfR9xnsEdcdlv1TGj0AZ2ZBdv0=
X-Received: by 2002:a1f:960a:: with SMTP id y10mr22482299vkd.8.1624979386744;
 Tue, 29 Jun 2021 08:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210623095734.3046-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210623095734.3046-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:09:10 +0200
Message-ID: <CAPDyKFqM5_Xd3KPG7kO_Hqg4=i2cNg6nZqMNcDKZk4eSzBchRA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: use proper DMAENGINE API for termination
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 11:57, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Update the drivers I audited.
>
>
> Wolfram Sang (3):
>   mmc: renesas_sdhi_sys_dmac: : use proper DMAENGINE API for termination
>   mmc: sh_mmcif: : use proper DMAENGINE API for termination
>   mmc: usdhi6rol0: : use proper DMAENGINE API for termination
>
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 4 ++--
>  drivers/mmc/host/sh_mmcif.c              | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c            | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>

Queued up for v5.15 (temporary on the devel branch), thanks!

Kind regards
Uffe
