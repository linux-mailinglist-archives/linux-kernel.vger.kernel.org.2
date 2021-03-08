Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D333059E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 02:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhCHB0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 20:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233538AbhCHB0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:26:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17EC965146;
        Mon,  8 Mar 2021 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615166773;
        bh=1tSm5R9ia8fPzF5IrSlL2/zWCFx5XqCJFr8Mnci+D5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cI7ea3i2gdTYLkwdYDvlPowei2d+RVAfftoBEsi12hsWyX1zZytSw8MmuYu7zYESG
         yctrT9kNJ3EQLmwnQRH00J5yffqaFJgrhPmiKpnomKOr5T3AxSZhG7xl2vNrPY6Oai
         k5iJKTlQY2LhMBcHbJKZkWIHhiGjd8SpzF1I7JHSAUWWA/hPhRHpa9ygyYMrucSDF3
         44sGdog55AF8BFE5tpJd1mOsKZL3UYHUJSKS3mqCeCsIt8dvNtYSgakiVc6e4v6+zF
         Er2SsVgiKbXEJ/PNl5foGKcaAgjJnwqkldEtLxJHjx7H2l0IkXdvglEMEfvYQ+xzsY
         6wgLQ6JT7lD3A==
Date:   Mon, 8 Mar 2021 09:26:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 0/2] add Kontron pITX-imx8m board
Message-ID: <20210308012606.GS543@dragon>
References: <20210303211002.17650-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303211002.17650-1-heiko.thiery@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 10:10:01PM +0100, Heiko Thiery wrote:
> This patch series adds support for the Kontron pITX-imx8m board:
> 
> https://www.kontron.com/products/boards-and-standard-form-factors/single-board-computer/pitx-imx8m.html
> 
> Heiko Thiery (2):
>   dt-bindings: arm: fsl: add Kontron pITX-imx8m board
>   arm64: dts: fsl: add support for Kontron pitx-imx8m board

Applied both, thanks.
