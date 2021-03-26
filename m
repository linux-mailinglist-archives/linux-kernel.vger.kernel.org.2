Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBD349D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCZAJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhCZAJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 530236198C;
        Fri, 26 Mar 2021 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616717340;
        bh=rfHNeZy3xAA9yAvhD6BBRZD5DW31WjGDzteujbD/pZQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cun7tR9jtx/N+rwe7kNhy7Lqi7pywG+g44F23esq+Lb5jGF1q5h2zb1dphMqZxA54
         I7EBfuSflaykovnNs8bQTAb8RYQtx9cavHA9QFMYw3IJuRE5dHlUsLFvlhw0rI7BAH
         3ufDJwd4FG9RLRK80zHebS+ucTTZ8vaqeFvfEcacnj2VUUIFQC/UHZcJYO9R/Ja09u
         7K0aMJNIz/8KmEKdWXvkfJHsIEcdXAebaSG0zN77eKClRiXTdsApQk6df5OE4STICL
         0/kNjVJ/h4l4AwJG0OFFzPArsMM76RayQbVg+t900hwsZK/5lnIMCTBMWTrmK/fmUX
         fFPvVVgF6UUvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210316124903.35011-19-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com> <20210316124903.35011-19-cristian.marussi@arm.com>
Subject: Re: [PATCH v7 18/38] clk: scmi: port driver to the new scmi_clk_proto_ops interface
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 25 Mar 2021 17:08:59 -0700
Message-ID: <161671733901.3012082.11186673559577220910@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry didn't notice because linux-clk@vger.kernel.org wasn't Cced

Quoting Cristian Marussi (2021-03-16 05:48:43)
> Port driver to the new SCMI Clock interface based on protocol handles
> and common devm_get_ops().
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v6 -> v7
> - fixed Copyright
> - renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
> v4 --> v5
> - using renamed devm_get/put_protocol
> ---
>  drivers/clk/clk-scmi.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index c754dfbb73fd..be4c13d63385 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Power Interface (SCMI) Protocol based clock driver
>   *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2021 ARM Ltd.
>   */
> =20
>  #include <linux/clk-provider.h>
> @@ -13,11 +13,13 @@
>  #include <linux/scmi_protocol.h>
>  #include <asm/div64.h>
> =20
> +static const struct scmi_clk_proto_ops *clk_ops;

Can you call it scmi_proto_clk_ops instead of clk_ops? We already have
'struct clk_ops' and this pollutes the global namespace with another
'clk_ops'.

> +
>  struct scmi_clk {
>         u32 id;
>         struct clk_hw hw;
>         const struct scmi_clock_info *info;
> -       const struct scmi_handle *handle;
> +       const struct scmi_protocol_handle *ph;
>  };
> =20
>  #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
