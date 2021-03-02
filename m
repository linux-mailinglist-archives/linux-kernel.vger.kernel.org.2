Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876BD32A4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446484AbhCBKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349596AbhCBKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:42:28 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF1C0611C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:39:55 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id o20so28317uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0hmZCFeDNqAbXx5GUKcKo1fxTItQnWIdXjqLdnPSeQ=;
        b=ImnDxZzQiN6+xQO0jDbYudZZ5bZAsbEITwar8lWZPd7fQ83yGWzCBnHvplZ0wWJ0ow
         P25AE9GJP4NQvMp4y3IIKvqAn/tQAkoIN31eb42woz6/xzDWE2L1co7qfEYN95VwpD+9
         n1EU4ETEtPCqhAH7MKBpDAXSsDYch2NkH6D959mXvnxfWVqsqe3mOcihO4BGcGIqAkc5
         lR7Fzh3YY10hQo0Z2VbA3GZqewqkRDAINWI7MU64FHTbamGCHdfwqRx/PXeNK9zNPlMh
         ygL953xVMYIz2asSrEiNZ75UNlZx3cjUi1iWP7o2oTGUGsTznPqLLjLUwMhqnffhYKd6
         pctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0hmZCFeDNqAbXx5GUKcKo1fxTItQnWIdXjqLdnPSeQ=;
        b=CUYBz98v1LC0DKVUL3ll1AeUrP59LZRgs3havxnsHEddS9epIi01UNt45WenY042P6
         YXf7qU2AvVJqsh4JQ80MevrWAf4MmEU7DxhvMsMKMb09yQgkzyNxQ6CvQAsOrpJsalb5
         t3UwcrYcboAkHEo8pA28yui6v4scMMnmolRkW8En8kW0kF5IMm+PJQaFtKQ60q5bMYCY
         8bO+aicaXQ38wbiASiewd0myg5aNzVirM/hb2Oa10gYli/ELuWM6KkEriRKwIDUd5pKQ
         q293InoTiMj071qwaKPqkKq284mgTM53hhuzowBm7HAU80JteHmEoWWbLr0owr+PMyoQ
         4H+A==
X-Gm-Message-State: AOAM531mfWJHUC2bkWJSSeRfLYvGAX9KY4HJx4KLbgIqTpJ/ummBQIxy
        DugaFMOB1/BzyZaN4KY325URi8oczw8vszxlDOUsMg==
X-Google-Smtp-Source: ABdhPJx5zWar9vzmGNaDwjkCHaFzZgByiXdLPVKbwNxLcirxr8ZsQUC7izpDBiTOw7BnhXrSEGYIkB5n9j8rL06nuYw=
X-Received: by 2002:ab0:1581:: with SMTP id i1mr10807661uae.15.1614681594298;
 Tue, 02 Mar 2021 02:39:54 -0800 (PST)
MIME-Version: 1.0
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:39:15 +0100
Message-ID: <CAPDyKFq3J=Shzgxp8XsdZqdZcOZ-n5WJ+mWejXM1-Qp8PgjBNA@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] imx esdhc dt/driver update
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 04:22, <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V3:
>  Patch 1, drop unneeded pinctrl-0/1/2
>  Patch 2 is new to avoid break dt bindings check
> V2:
>  patch 1, 2, 3 is new
>  patch 4 is not changed
>  https://patchwork.kernel.org/project/linux-arm-kernel/cover/1611198593-16287-1-git-send-email-peng.fan@nxp.com/
>
> Peng Fan (5):
>   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
>   dt-bindings: clock: imx8qxp-lpcg: correct the example clock-names
>   arm64: dts: imx8qxp: correct usdhc clock-names sequence
>   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
>   mmc: sdhci-esdhc-imx: validate pinctrl before use it
>
>  .../bindings/clock/imx8qxp-lpcg.yaml          |  6 +++---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 20 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 ++++++++---------
>  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
>  4 files changed, 33 insertions(+), 13 deletions(-)
>
> --
> 2.30.0
>

Applied patch 1, 4 and 5, thanks!

Kind regards
Uffe
