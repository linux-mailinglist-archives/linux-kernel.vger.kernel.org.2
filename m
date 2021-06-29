Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414CE3B6E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhF2GNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:13:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2D3C61DC5;
        Tue, 29 Jun 2021 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624947035;
        bh=erYjZM3znz/8Dd47OzSopVWIyIGBBPSiIH5Ekwq9QII=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A5MqbJCADNlwHQGPLdJivV1bRq6gEFCw4cEOiCo1Z4MgZTJQAnRyek3OhKkvdLt2I
         p2OxmnzzZsIOnTyG3qScwFPpYBC39hDKNlPI9jDo4lIuFWCpGD2DGIOjkz55S/EZkG
         g4ShpSbLriPSTjrULb34DZBpPKINMOQn5J5O7L5qEf1SIl/kfWhVDLmQ6DafMdrsPa
         Iq3YI+rhVtcflffrcyMN2Qx8cRe/xRnfGHRj1Jj9bJT3T0Qwn9xwxERVVv2V4xBZMR
         SAmwMUhvs6Nq8gw/pS7mXtSwAGusOoDMJ2YiRFurwjWpgTKGJ3wpqS6Pn3kXaWWkiF
         F8Nsf98aSPnvg==
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
Date:   Mon, 28 Jun 2021 23:10:33 -0700
Message-ID: <162494703384.2516444.13293216331096267775@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2021-06-28 00:01:19)
> Currently firmware passes CCF specific flags to ZynqMP clock driver.
> So firmware needs to be updated if CCF flags are changed. The firmware
> should have its own 'flag number space' that is distinct from the
> common clk framework's 'flag number space'. So define and use ZynqMP
> specific common clock flags instead of using CCF flags.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next
