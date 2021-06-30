Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70BC3B889E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhF3Slx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234636AbhF3Slv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:41:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A99261419;
        Wed, 30 Jun 2021 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078362;
        bh=idOYvZck+DrSLfwpxZjyNucc8Z4zRCEV7i4OiE00mHw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OKbcXhEYgw67/4s2FV9HOv4T8VnTrQKK3dsRGn+TQYIg3CFB5kqje78EJd4V9dwqs
         9D8Crg9hgCntA8/lqGvBSHuUNgrsdIdfT1TAoVHDrYnCFJFcX+xMf19ZlC3hTAawbA
         1NVtNNtUOC02KeVztVpkhd0B/tGlzKDANCi/X/IqpfUIHXVaaAv9hqn/V2bmMYu8cq
         K6sgzG3+2wrE7o5NC3WWEcytAnP1tFz4Fh463XuxwKEwmoW5xTDPSEvaPcmMtGyiEm
         2P8BLWStjem4nNFxsGZ/XOf8U9tRG1VfjHKYt0xbjGjx0oRoGY5Z/e/CAw1F02oGi+
         n6oXlha5fVxhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210627223959.188139-4-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-4-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 3/3] clk: meson: regmap: switch to determine_rate for the dividers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 30 Jun 2021 11:39:20 -0700
Message-ID: <162507836069.3331010.6408437361041793201@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-06-27 15:39:59)
> This increases the maxmium supported frequency on 32-bit systems from
> 2^31 (signed long as used by clk_ops.round_rate, maximum value:
> approx. 2.14GHz) to 2^32 (unsigned long as used by
> clk_ops.determine_rate, maximum value: approx. 4.29GHz).
> On Meson8/8b/8m2 the HDMI PLL and it's OD (post-dividers) are
> capable of running at up to 2.97GHz. So switch the divider
> implementation in clk-regmap to clk_ops.determine_rate to support these
> higher frequencies on 32-bit systems.
>=20
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied to clk-next
