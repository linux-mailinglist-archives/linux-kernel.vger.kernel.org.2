Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F223B1AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhFWNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFWNNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:13:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D02B56108E;
        Wed, 23 Jun 2021 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624453885;
        bh=/blXvtCxZawzukWrMHd4didSA48vZpDv5YhTrQQKVqY=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=e9fK9m5MgIRPg1NVVqoE3FK3uD30J9j7VOC8QoEQfNInsHLhBoccrl4UaxSoV7Io9
         ZyCRbL+Q6jFPOUuAU314ilXnWFLebPGn1JdW4xRjo0QY3Dmw9kqZAfPScjsUM2fxOV
         im/QTxjI5hTZBXV8IMLbF3VlRt7WXLF4oY+ToVUzZF1R05actGGsLSO00f/u8wqscI
         gAe2M6pSXJuLchV1waHfrcru1p22vdMxXF6csNk70NyguSmGJmH6+Amzoi1qdKbeAK
         fe5zubiaAf3U1txTtnxsDLoxU5g1xwqREDFOY/wljigFLFIqeOBpS3Wb6Vv6XIiCAZ
         5cq0s1dl8acKA==
Received: by mail-lj1-f181.google.com with SMTP id d13so2895971ljg.12;
        Wed, 23 Jun 2021 06:11:25 -0700 (PDT)
X-Gm-Message-State: AOAM532DMnpLyooShW9GO7hOc4q7nm4YjrTRNhaamVsMYlzoaZDw+yYB
        cgtkqhXmDnWSVabH4fb8MiUfYsjLBSmHRK9UdjI=
X-Google-Smtp-Source: ABdhPJwSSz9HB4JFze26YtRuZndqnzLvA54RbVubu2ZMK2SJ8j1l1bIGHHU8vEaSU+X/2yyGfPBuqfoUT0wgJJ5C82I=
X-Received: by 2002:a2e:9ac3:: with SMTP id p3mr8133193ljj.94.1624453884191;
 Wed, 23 Jun 2021 06:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210623120001.164920-1-knaerzche@gmail.com>
In-Reply-To: <20210623120001.164920-1-knaerzche@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 23 Jun 2021 21:11:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v67K-BRhQ_a1yXtdPCX8T30FJPLojueJ2cvpXmGUskOLjA@mail.gmail.com>
Message-ID: <CAGb2v67K-BRhQ_a1yXtdPCX8T30FJPLojueJ2cvpXmGUskOLjA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdmmc_ext for RK3328
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 8:00 PM Alex Bee <knaerzche@gmail.com> wrote:
>
> RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
> boards have sdio wifi connected to it. In order to use it
> one would have to add the pinctrls from sdmmc0ext group which
> is done on board level.
>
> While at that also add the reset controls for the other mmc
> controllers.

I recommend splitting this part into a separate patch, and
adding an appropriate "Fixes" tag to it.

ChenYu
