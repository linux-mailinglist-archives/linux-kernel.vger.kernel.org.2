Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B319A38D850
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhEWChl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhEWChk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:37:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0559061175;
        Sun, 23 May 2021 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621737374;
        bh=XiuTAzzl73X1uz7WOFrlCR1K/yQTHxLmPvV2dxErY7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE/fyDFa4146aiF8NHr6A0usCdL2umb/4sSEGVNBcflQyFScrinTOyL77LP6VWIYs
         36NVs+WRjln5KrT0m9C++RUnUlEJder9SKF9nJL8XkZZUQl6qEEj9XuRutRbJeCV2O
         QRInGfbgCZyAPgFd9onn3LUTDsnCixZ/+m2n508QQRRY8WAdmZEU3W0uTQ0qDXhbgY
         vkOQdqx1z9kOOPAZ4guup5T8uNh+nJwtQCRHQZqKvCTqGDivl0KoUJVkV55tm4HJgA
         bXWjVxo7Qwf5UXFEksBtak5E060fA4yl5Mo25S6c/223WfT8ElN6Lf0PUbDdot+6rj
         NkL1cUvOvxSiQ==
Date:   Sun, 23 May 2021 10:36:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6qdl-sabresd: Add asrc support for
 wm8962 sound card
Message-ID: <20210523023608.GL8194@dragon>
References: <1620272479-1219-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620272479-1219-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:41:18AM +0800, Shengjiu Wang wrote:
> Add asrc support for wm8962 sound card.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied both, thanks.
