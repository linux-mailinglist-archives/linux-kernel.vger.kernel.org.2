Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78AA420B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhJDMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhJDMom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA2A61264;
        Mon,  4 Oct 2021 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633351373;
        bh=ppIxm9wn36ZfKm5pk94tqcniiD9zp/G1KmUPogr9ie4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZ6oO4IPp3QVqvsUirtLSAaJWtRbiI1jbufaD8f1+F2v0bnzyTHx4FegrmoEV/ryI
         0QLvdectzwCFVTgFMsv+GOHEaY1CVG4jk+sXl/DIeCcYmHDQGrjhFCIJJ87ZGQMLkd
         SEG5ZL1wCMkmryboSrn7/YE05XjyXS7PxKY2RS7HOpPn3bNGpWkqf2MPYr286S92uZ
         dmuruK3X9Mm7FbJvzvrwnPGG7elBdisd4rAmEqEdvN0gFX9h+Q4qiPmOgb/tfeOoyy
         Lt7ELhfinyeO8k1xyTw2kIyOhlcUE/3ew0YFE25H2bVXAgiwsZruayRWqZQtJkIgd2
         yemOiIM9ex/ng==
Date:   Mon, 4 Oct 2021 20:42:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix eSDHC2 node
Message-ID: <20211004124246.GI15650@dragon>
References: <20210915202259.3000923-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915202259.3000923-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 10:22:59PM +0200, Michael Walle wrote:
> On the LS1028A this instance of the eSDHC controller is intended for
> either an eMMC or eSDIO card. It doesn't provide a card detect pin and
> its IO voltage is fixed at 1.8V.
> 
> Remove the bogus broken-cd property, instead add the non-removable
> property. Fix the voltage-ranges property and set it to 1.8V only.
> 
> Fixes: 491d3a3fc113 ("arm64: dts: ls1028a: Add esdhc node in dts")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
