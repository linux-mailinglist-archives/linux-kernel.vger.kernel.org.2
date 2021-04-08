Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01C535790F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 02:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhDHA3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 20:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDHA3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 20:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D892261181;
        Thu,  8 Apr 2021 00:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617841761;
        bh=fDrVtOA9CcpPnyJ1ecDAimSzxUJQMqgpZb9jfbgh27I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cNuVgmAdIzBTxZjhj7Kw8h52dBk3ne/0LL7j8jM8OdB679n7dzHbcEV0MXd4qeiyY
         uPKcNeMTXarBYQM7KzNKFOtFTZd+chhbh14XFwWfLoOP+jymWxwwEfi9oiJCkJJzaH
         lY9c0igu3SRBAQm5zxoJ47jQPePys2jVDe0/T2tCFNIIHHsMYX8MhG/nJ9+FPJ11Ak
         mMOzPS3y/76YVO8N8EhzcoGtnXGv/xOEvkYmHrPqqaN605Oqc1+CxARMu8DrMLP7On
         eOQ9kp+7QpqvTNKaLd4zsjsI3/BKw3HUb+vM1QEOPt1CYl9ubBhj1X/7F4GbE3naal
         EOTdzFGPUAOVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210407034456.516204-1-saravanak@google.com>
References: <20210407034456.516204-1-saravanak@google.com>
Subject: Re: [PATCH v1 0/2] Add sync_state() support to clock framework
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Date:   Wed, 07 Apr 2021 17:29:19 -0700
Message-ID: <161784175956.3790633.6032492675008535412@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2021-04-06 20:44:53)
> Stephen,
>=20
> We can decide later if both these patches land through clk tree or the
> driver-core tree. The meat of the series is in Patch 2/2 and that commit
> text gives all the details.

The majority of the diff is in drivers/clk so presumably it can be
merged through the clk tree if Greg acks the include file API.

>=20
> Saravana Kannan (2):
>   driver core: Add dev_set_drv_sync_state()
>   clk: Add support for sync_state()
>=20
>  drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++-
>  include/linux/clk-provider.h |  1 +
>  include/linux/device.h       | 12 ++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
