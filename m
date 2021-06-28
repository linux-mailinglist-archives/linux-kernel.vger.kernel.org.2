Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3BF3B5781
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhF1C5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhF1C5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:57:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17BC561A1D;
        Mon, 28 Jun 2021 02:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624848913;
        bh=rBeaQfE/ChRTkTpFnZYcqpRxTHDdHehrQ3MlxBY3+Ps=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KABcgMlNIUmIHQvmn4NJ8wj3tzB0LllqeT7vjaDGT/aOHN8WzswK2gczBcjkeJYDk
         PowGYLAnVHpev1r3hPW7dFTRTDXPP+y5N0DOotQ6oMY+l8JoTGDKU9W91cSJLx+eRN
         cnjCOI4NoVMzmnoTkOrYgWnwIOcacvcC6MMzReLED7gObhP/L80OTanOnMoJVQlrYd
         Xjh3Z8zFul1ve8mUDs1IwNMzG4aBai96j8Hf3Ofxm+PYOgtt9YtBeAN+Gami9z5FWb
         1k3cGY6QnI0EJi9SanatMhBvAG6WfTC1WVRtbqXQ4baN73xRrWcoDQYMy2F6exOktT
         Yy+V1tgcJyjvQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331201632.24530-7-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com> <20210331201632.24530-7-avolmat@me.com>
Subject: Re: [PATCH v4 6/7] clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 19:55:11 -0700
Message-ID: <162484891199.2516444.7746269828847489069@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-31 13:16:31)
> In order to avoid relying on the old style description via the DT
> clock-output-names, add compatible data describing the flexgen
> outputs clocks for all STiH407/STiH410 and STiH418 SOCs.
>=20
> In order to ease transition between the two methods, this commit
> introduce the new compatible without removing the old method.
> Once DTs will be fixed, the method relying on DT clock-output-names
> will be removed from this driver as well as old compatibles.
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

Applied to clk-next
