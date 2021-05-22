Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6134138D61F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhEVOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 10:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEVOKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 10:10:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AEDA61163;
        Sat, 22 May 2021 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621692569;
        bh=H0NXL9VOUdnIRHNYjjNeRU1s79hTUbPEH9qJUyRf7SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nk2Imh1r18FHGN9BWcFwhtVsl+06J1fR7VFMuRorGiCpTSo//Wlw4nq1j1YXNj26+
         FOIn2hXB3zHBK7asimlslgQNdlB/blNfKS+VX4lKs77w28+jP6ITSlfdVVngPiy2gD
         dksOiF4hX75dEOzw95l7QgLgIJppiWxB9MqCy/NqBWSulrbinznB58gu21y9cnZzNH
         YafVpkcRMW7yf7EzviK/XhEhF4rqpGBoD0JBRI5a3pIVM4mpz2S/GEv6mr9wu0mrCV
         LDDQ7kB+uheW6jXT4GbzqB/wkpsUlrq+6KE84s9ONqjKj9u4zH0/prrLarvnAPXZmQ
         dpNCgzwUWbWeA==
Date:   Sat, 22 May 2021 22:09:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH] ARM: dts: imx6ul: Switch to fsl-asoc-card sound card
Message-ID: <20210522140917.GE8194@dragon>
References: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:52:19AM +0800, Shengjiu Wang wrote:
> There is issue with simple sound card, the simple sound
> card can't configure the pll of codec.
> 
> [  115.352669] wm8960 1-001a: failed to configure clock
> [  115.358843] wm8960 1-001a: ASoC: error at snd_soc_dai_hw_params on wm8960-hifi: -22
> 
> So Switch to fsl-asoc-card and the fsl-asoc-card can support
> asrc module as front-end component.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Changed subject prefix to "ARM: dts: imx6ul-14x14-evk: " when applying.

Shawn
