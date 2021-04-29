Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4736EAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhD2Mki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhD2Mkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:40:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE775C06138B;
        Thu, 29 Apr 2021 05:39:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h10so78343859edt.13;
        Thu, 29 Apr 2021 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJyu5lztcvSNUMTwJMAPSqsY6Cxtw5hApErHFGbx1HU=;
        b=jldSeqrJV5ZbOrHdTDJQMFbhKbAWMiFSHoZ7U0KOfZr12HaxvOiLh7/Mg8N0U6ock4
         hB8UgP82MD3wsbfDgHWsmAq2nAacBjZX7GmrTpAg9iCxgo9yDw+11rANFtbyXKaQb9yH
         NHWksqUQveHODCl77RcYZ+VaQ0TQ1c+6+MzdtEFgo2eoJYvjtEs36SKrDl7YuTzorRp2
         3WZIJfyplJxpizb0UiMHoWEWsIFqiCyc9+mf90ty8TA8bV6YGBUsls539rd0MVjyBBUs
         KihGZdxgADqcW2oTQNhc1dUO3vWh9p/D5DAqDpYsGaTUxFlloyqvCUW6lsJVm0t8hwcD
         k2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJyu5lztcvSNUMTwJMAPSqsY6Cxtw5hApErHFGbx1HU=;
        b=b9YrQAGyTBxTxHhDkUVpWnbrJQH04mRKi8N2yr9DPaDUHwtugIVvyhIzlgSTJp6mn0
         DlrTMX5Slt1kNGZ8AxcHX7rB7WW0WajNKzwMOhWu9r23sU7QcEgM+LhwB5vWUtiTODTp
         qACl/dRVxed2iC4Tz+WjjUlO2oU/hIa8+2VJBC7x+LYMUFGTvFkuayYNdyreHvuDJpKj
         bxQOjZHfogj6DOby6Ie2N0ZfB+wKb7uQ6iUlWnBJTHZ6wLKbXBfdC3xXWMHvzFYsE5Ps
         43d6cSeNARBR6S287pxVkeM+BEzfyY4XLHbjjNAxNUPawnbC2g3fmYN3RCxUE2ZGYSTr
         +Oaw==
X-Gm-Message-State: AOAM530eZgTurJ3yarUY5f621mcNtGooE2uwbG0itSMJoG4lUNO65V6e
        3jQFUvKllOvNOuJQ/hIO4fpoNWJPpoLIfPRy/5cjA6ghSRo=
X-Google-Smtp-Source: ABdhPJzCk4affIPGYmtCQiONLDStcDuXuPaTQfOC9jfRI7kIkq5uQtMppWQHyXlx7sJQD2nlIr/E28WwT4Mr3VpnBKQ=
X-Received: by 2002:a50:9e0b:: with SMTP id z11mr18134061ede.228.1619699987286;
 Thu, 29 Apr 2021 05:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 29 Apr 2021 07:39:36 -0500
Message-ID: <CAHCN7xL11GUSVB3PThsfhxXPtgu1nm1LWSzkJYqj4MHf-aLbVw@mail.gmail.com>
Subject: Re: [PATCH 00/16] soc: imx: gpcv2: support i.MX8MM
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 1:59 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and several
> minor changes from me to make it could work with i.MX BLK-CTL driver.
>
> Thanks for Lucas's work and suggestion, Frieder Schrempf for collecting
> all the patches, Jacky Bai on help debug issues.

Thank for you all the work.  I have an i.MX8M Nano that I'll work to
add support for gpcv2 unless NXP has started this already.  At one
time, I posted some patches for Nano based on Lucas' work, but since
that work wasn't accepted, mine wasn't either.

adam
>
> Lucas Stach (12):
>   soc: imx: gpcv2: move to more ideomatic error handling in probe
>   soc: imx: gpcv2: move domain mapping to domain driver probe
>   soc: imx: gpcv2: switch to clk_bulk_* API
>   soc: imx: gpcv2: split power up and power down sequence control
>   soc: imx: gpcv2: wait for ADB400 handshake
>   soc: imx: gpcv2: add runtime PM support for power-domains
>   soc: imx: gpcv2: allow domains without power-sequence control
>   dt-bindings: imx: gpcv2: add support for optional resets
>   soc: imx: gpcv2: add support for optional resets
>   dt-bindings: power: add defines for i.MX8MM power domains
>   soc: imx: gpcv2: add support for i.MX8MM power domains
>   soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power
>     domains
>
> Peng Fan (4):
>   soc: imx: gpcv2: correct pm_runtime_get_sync usage
>   soc: imx: gpcv2: move reset assert after requesting domain power up
>   soc: imx: gpcv2: support reset defer probe
>   soc: imx: gpcv2: remove waiting handshake in power up
>
>  .../bindings/power/fsl,imx-gpcv2.yaml         |   9 +
>  drivers/soc/imx/gpcv2.c                       | 534 ++++++++++++++----
>  include/dt-bindings/power/imx8mm-power.h      |  22 +
>  3 files changed, 450 insertions(+), 115 deletions(-)
>  create mode 100644 include/dt-bindings/power/imx8mm-power.h
>
> --
> 2.30.0
>
