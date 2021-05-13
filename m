Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF237F36F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEMHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhEMHNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:13:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64FE8611AE;
        Thu, 13 May 2021 07:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620889920;
        bh=k+6Ew2CIxOhEvA6CXddp4OAx2+o8XObSLpDWTsumM0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUOTmWaX1DxVWSzvnUckdViRhoEqa5p703Fdyf38JH7+F995g5d2H4bQPGvnlpOmf
         kAIe4HtO1eP6agRjvnG8EOmtHs7xlM90IPzWCyeIR/JcHGpxdujvIWMes9OhcyxYv6
         xXMhxNOxI2lwwwgqHCu9eWwCudomN/UxRKExTyun18lSx2t5YDWLoInoD1r227zpgB
         VmwIm/a0udC+ImabEEDYR269+Q85naGx1EGAI44Ddl8qBvy3UT5nWWah9KLuFwMhTL
         KOVjU9QR+Mw7KYSSIRQG/4ws6WMmn3gfh7NjDfwOYPpaI/L+RrhPVLerJvnVaiO6Qs
         PWoeuS8sbQ5gw==
Date:   Thu, 13 May 2021 15:11:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: freescale: sl28: fix RGMII
Message-ID: <20210513071154.GP3425@dragon>
References: <20210413153349.29119-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413153349.29119-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 05:33:47PM +0200, Michael Walle wrote:
> This fixes the RGMII on the sl28 boards. While the network port was
> actually working it is still out-of-spec.
> 
> Please note, that this is split into two patches because each one fixes
> a different commit.
> 
> Michael Walle (2):
>   arm64: dts: freescale: sl28: fix RGMII clock and voltage
>   arm64: dts: freescale: sl28: fix RGMII clock and voltage

Can we distinguish the subject a bit by using different prefix like
'sl28-var1' and 'sl28-var4'?

Shawn

> 
>  .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts     | 3 ++-
>  .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts     | 5 ++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.20.1
> 
