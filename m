Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13A3198E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBLDlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBLDlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:41:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AC6564E36;
        Fri, 12 Feb 2021 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613101224;
        bh=902ral9gacRgw098ICH6/nm9ePThn6pw1zsXbniDEfs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WrMK1vdbXJhWJUelkspQ60k0fN1pYYM8wxIgfZ27IC98OAdPMne+L64XgB/ACwIoF
         ctJ01jpM4mYRP5QVuDYnMVcaD5MldMGwFcSlXnURPLU/yzsn9zd6Uixjx70bwmXehq
         7m1WPYERLo3QSlHIes190mm34eGLuv0DIXkO92cqYB8Qn7gS7HTxn7w3gWhbO1eVWy
         GkqI/VSrzrFLNo4jP2Ms7O7aWP4Lgakp8U6nyn8VCPd1Qtyx/o0yWtQkB07lPmdU58
         BJIHwRnZ+dQrx6d6cn1km+LmtwXkY3KCER9MBM3EGWJH2nzFQHSDAZxUgu8dAnnTf3
         f0FS5ooFl30wg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0f44b1d32d28f64b5a33a8319319506fdf317487.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com> <0f44b1d32d28f64b5a33a8319319506fdf317487.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 15/17] clk: bd718x7: Add support for clk gate on ROHM BD71815 PMIC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        linux-clk@vger.kernel.org
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Date:   Thu, 11 Feb 2021 19:40:22 -0800
Message-ID: <161310122259.1254594.13571103811238327212@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2021-01-18 23:30:26)
> ROHM BD71815 also provide clk signal for RTC. Add control
> for gating this clock.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
