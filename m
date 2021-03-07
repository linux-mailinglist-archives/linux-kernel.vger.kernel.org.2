Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4C9330145
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhCGNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 08:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhCGNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 08:39:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 348BA6509B;
        Sun,  7 Mar 2021 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615124340;
        bh=pFH+++9BiE7w2CgaBDLxBHwlrr9XUAOPbgo4hmFRXUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO8iX6GNLvMn/fed0QyhR26BBm/faYcuFWRj30hSaINKqyMs5E9T4zuqwIxk5Kmei
         5xuV1gTIdaA0C2MT75DAX/uVTp0+CC6CmuZ5jZjciV1q7WpLN5/9eLq+08GZDvuZpy
         4QcyJ6qWUrxBnSqBoxpvs8rHSNNZ/sKe/kcTJmXhsgSxHENVH3BZdEdlvsCDF3PrLS
         Sf9dRRnynaBbtgNeZm8NyN//v9ybPI6u+MQASWts/co2/xQszXXU65rb7SoPBVqGSC
         FkCwcvi2IlTpvC2Hw4G7E8ZXF+ZrS1SqrX2e/Iyxk1KtWnbi8XM7wrNzoQPon/4rEK
         5ITuNU8IScVMQ==
Date:   Sun, 7 Mar 2021 21:38:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] arm64: dts: librem5 phone and devkit dts and
 config updates
Message-ID: <20210307133842.GG543@dragon>
References: <20210219100439.9428-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219100439.9428-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:04:34AM +0100, Martin Kepplinger wrote:
> Angus Ainslie (1):
>   arm64: dts: librem5: protect some partitions of the nor-flash
> 
> Guido Günther (3):
>   arm64: dts: imx8mq-librem5-devkit: Drop buck3 startup-ramp-delay
>   arm64: dts: librem5: Drop assigned-clocks from SAI2
>   arm64: defconfig: Enable devfreq support for i.MX8MQ
> 
> Martin Kepplinger (1):
>   arm64: dts: imx8mq-librem5-r2: set nearlevel to 120

Applied all, thanks.
