Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FED3B6E19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhF2GMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:12:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4667461D92;
        Tue, 29 Jun 2021 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624947022;
        bh=IWwBWM5EpNg3cZ6/cK+Cf5OhG2I9lG+DMt5REFSvWDI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dUGB0Lwn7U4A4aG0mGUfwNYw8REFlWwcffRRtS2wBqe9WFL9dFmboHPE1eFIEGtuc
         Yp0CPjqzUqNtArcMzecrgscepvaOA651iLX4I23JyFVP9ncaieXA1KFbfUkmQvmN6f
         5ibMcOBBS3niid5CpytDqIYQq2z4ACDHhghJglg/+howNHbROJB/9q76GToiSLOhdT
         r2Mfv2sJUijA6oN8MPxvrISXp55znRNuzJaFphDzd4w15j4iTxIg5tLI52+aQ/bCYr
         +j8MLN4aSC6E3ztQ+9I+jYvhuBIjZ3G/fLg9+RiUNwlJ84/ZrzpyirNLZIPic3ekXF
         eUqtpVw/IVI+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210628070122.26217-2-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com> <20210628070122.26217-2-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v6 1/4] clk: zynqmp: Use firmware specific common clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, kristo@kernel.org,
        lee.jones@linaro.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, quanyang.wang@windriver.com
Date:   Mon, 28 Jun 2021 23:10:21 -0700
Message-ID: <162494702112.2516444.13836179455930623514@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2021-06-28 00:01:19)
> diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zyn=
qmp.h
> index 5beeb41b29fa..aa013a59c7cc 100644
> --- a/drivers/clk/zynqmp/clk-zynqmp.h
> +++ b/drivers/clk/zynqmp/clk-zynqmp.h
> @@ -10,6 +10,20 @@
> =20
>  #include <linux/firmware/xlnx-zynqmp.h>
> =20
> +/* Common Flags */
> +/* must be gated across rate change */
> +#define ZYNQMP_CLK_SET_RATE_GATE       BIT(0)
> +/* must be gated across re-parent */
> +#define ZYNQMP_CLK_SET_PARENT_GATE     BIT(1)
> +/* propagate rate change up one level */
> +#define ZYNQMP_CLK_SET_RATE_PARENT     BIT(2)
> +/* do not gate even if unused */
> +#define ZYNQMP_CLK_IGNORE_UNUSED       BIT(3)
> +/* don't re-parent on rate change */
> +#define ZYNQMP_CLK_SET_RATE_NO_REPARENT        BIT(7)
> +/* do not gate, ever */
> +#define ZYNQMP_CLK_IS_CRITICAL         BIT(11)

Ok I was hoping the firmware didn't use the CRITICAL and IGNORE_UNUSED
flags but I guess we've lost that battle.
