Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0051B38D621
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhEVOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 10:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEVOLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 10:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85C8561176;
        Sat, 22 May 2021 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621692628;
        bh=H4qnApTos5x3+TgMDimpnbGQABU8Hn3nnvMg0d7M5/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5t02FrNMH9gynwz2kSBgHbA+hN3vSurXOu62jvbAxuxm41AT7yq9srM12K/YRN9t
         wWF0OX9DQW0fH5mjlO5f3GJVWtI1MC8CXN2INu929+/ownPAU4c/VaekpEM7/EnT4C
         bqePbw2nE5WSVYyz20500G+tGbfGaP+nsRxE7WoqUHjd68n5IZnRarih0GJn/LaquL
         5VC092nTnYbICI5cdIF65/qo0Hk39s9wdl10As3ronHDQioXlY8fG73UQGo/3tVrOt
         5SxvTtPDxOWQels5CGxh97cfWXkQx+j5kDJkNtIm4/QQcpwoVV2NfocvXBaywtIoI6
         YwEe3UtmtyNvw==
Date:   Sat, 22 May 2021 22:10:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Add HDMI audio sound card
Message-ID: <20210522141020.GF8194@dragon>
References: <1619664755-12631-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619664755-12631-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:52:35AM +0800, Shengjiu Wang wrote:
> Add HDMI audio sound card, the interface is sii902x.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
