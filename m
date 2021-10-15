Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D740542E615
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJOBWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232557AbhJOBVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:21:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45D2360E09;
        Fri, 15 Oct 2021 01:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634260780;
        bh=GZZ2feHg0GDLfc64+kYhL/INwc8MQcn+uMwJjklnMbY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ohRe9LB78Y+Xqb3pVvtFyeEY6yPnHm9nzEOsxeqCObVD59FF4jfYiQZDXqw8wG9YR
         VkET5SDbz347TtaEEDQtvgsWHl3gUYpDeFagXrR7/Aprw0YobAUs88KyIbDZkYnaJz
         XFXiX33kk0F3Ilc/K6s0YKdhPXFmquIo544JIJLZR7ElrVHkoxbZjC19Hkp3iy1EcB
         fMtUnbPF4fT4mB0Ekq/Ai3n7Ag6aIPysnTJfgXiNnF7aVkU9zd7rnvcWED9Ex1sedZ
         3tvo6+pd+gBIzQPSSEUQI4EI3HKYwZJGG7Ql+88PXgaLaAmYFNXtrZ+CWj0zsFsjuO
         fGuQgxFGN6u6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634095574-4076-1-git-send-email-wangqing@vivo.com>
References: <1634095574-4076-1-git-send-email-wangqing@vivo.com>
Subject: Re: [PATCH] clk-si5341: replace snprintf in show functions with sysfs_emit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Qing Wang <wangqing@vivo.com>,
        Robert Hancock <robert.hancock@calian.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Qing Wang <wangqing@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Oct 2021 18:19:38 -0700
Message-ID: <163426077803.1688384.13526132296218990684@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qing Wang (2021-10-12 20:26:14)
> coccicheck complains about the use of snprintf() in sysfs show functions.
>=20
> Fix the following coccicheck warning:
> drivers/clk/clk-si5341.c:1471:8-16: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1486:8-16: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1501:8-16: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1516:8-16: WARNING: use scnprintf or sprintf.
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Please include authors on Cc

> ---
>  drivers/clk/clk-si5341.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index 57ae183..5d62ddb 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -1468,7 +1468,7 @@ static ssize_t input_present_show(struct device *de=
v,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOSREF);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(input_present);
> =20
> @@ -1483,7 +1483,7 @@ static ssize_t input_present_sticky_show(struct dev=
ice *dev,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOSREF);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(input_present_sticky);
> =20
> @@ -1498,7 +1498,7 @@ static ssize_t pll_locked_show(struct device *dev,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOL);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(pll_locked);
> =20
> @@ -1513,7 +1513,7 @@ static ssize_t pll_locked_sticky_show(struct device=
 *dev,
>         if (res < 0)
>                 return res;
>         res =3D !(status & SI5341_STATUS_LOL);
> -       return snprintf(buf, PAGE_SIZE, "%d\n", res);
> +       return sysfs_emit(buf, "%d\n", res);
>  }
>  static DEVICE_ATTR_RO(pll_locked_sticky);
>
