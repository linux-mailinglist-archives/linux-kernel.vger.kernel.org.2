Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA63D3511
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhGWGaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234089AbhGWGao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A13EC60E77;
        Fri, 23 Jul 2021 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627024278;
        bh=Bg3ANpTHxCIWcv/J+IdB7J1du5qqzQb4wVCHjnd2MCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYEWuNUR5uHD9qXHv2BRMevZsR6MDao15tgkj6W/b7doCsA1ex3SNnzWBzbeSjpa+
         hI6aAMBf/3PB9Woht6mLrFGOlbu+NQkMcYXWa7RBn13zLZHbn/EWpH/48Ox8eknUKK
         N9qgwNX2mHA3at88Ih16secu1w5thkn/+ZfM9pTP7QPQFomGNTN2uhWIyq7qjjj+Yz
         XfNdxVF7CoNxn8SVBN2vtDcfF6CsL7UHU/v924vyy4EGq48+f57Q1/MR1WIhUZtcZa
         5+QDEX6Cy3wHgs4tM4cK+XFbpx9vVkHAWKKu22xRzCmua9RjjWrSC5TNvxlunCX5di
         opeS7gykzxoBg==
Date:   Fri, 23 Jul 2021 15:11:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kwon Tae-young <tykwon@m2i.co.kr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: add CD pinctrl for usdhc2
Message-ID: <20210723071112.GC30773@dragon>
References: <20210715065431.25370-1-tykwon@m2i.co.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715065431.25370-1-tykwon@m2i.co.kr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:54:31PM +0900, Kwon Tae-young wrote:
> Add CD pinctrl for usdhc2.
> 
> Signed-off-by: Kwon Tae-young <tykwon@m2i.co.kr>

Applied, thanks!
