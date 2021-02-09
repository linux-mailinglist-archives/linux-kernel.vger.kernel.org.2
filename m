Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36BE315C07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhBJBRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:32934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhBIWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:43:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4241E64DE3;
        Tue,  9 Feb 2021 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612910546;
        bh=7eMvg1VPEGo3lWW4zotCo/3XyQ70lbVzFTFiKgWsqhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYRbitpU3bTMG/kdrSDLl0dNKnUgn0pdLEyvq6hWXMyuApyrM8FuWnzt+869wtR2Y
         3xahI8A7PWarnmW3k+ke8IqeMmvxugZYjZD9rSVu6k2cV61cdRBcJR35iKBNKdtPWF
         +Py1m2cqtNK30GLozZevFOHu270/1RNRsfg/vIWOY20aNzB3vlafirJMQLOzsmJ9Q4
         Fn8CwUteOyZqCGWr03aD0yekMXv0+DsjqBkmqTAceyMXnt5Q74reSDVpg9ymUCfOUU
         g7vcAMfUEPjtlg+Xjrdk6HLvLzLsgdd63FsRIqJLi3mY+Tk61UB+ul4C58aCnE/N7X
         rQh8AFFWurE1w==
Received: by pali.im (Postfix)
        id DE53FF9A; Tue,  9 Feb 2021 23:42:23 +0100 (CET)
Date:   Tue, 9 Feb 2021 23:42:23 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     nnet <nnet@fastmail.fm>
Cc:     a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kabel@kernel.org, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        miquel.raynal@bootlin.com, mturquette@baylibre.com,
        rmk+kernel@armlinux.org.uk, sboyd@kernel.org, tmn505@gmail.com,
        vladimir.vid@sartura.hr
Subject: Re: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210209224223.p22yhjdy7ibzepss@pali>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 February 2021 13:45:08 nnet wrote:
> On Tue, Feb 9, 2021, at 1:33 PM, Pali Rohár wrote:
> > On Tuesday 09 February 2021 13:00:26 nnet wrote:
> > > > If you have other Armada 3720 boards (Espressobin v5/v7, uDPU, Devel Board, ...) then it will be nice to do an additional tests and check if instability issues are finally fixed.
> > > 
> > > These patches applied to the 5.4.96 in OpenWrt (98d61b5) work fine so far on an Espressobin v7 AFAICT per changing values in /sys/devices/system/cpu/cpufreq/policy0.
> > > 
> > > Are these changes intended to work @1.2 GHz on the v7?
> > 
> > Hello! Do you have 1.2 GHz A3720 SoC?
> 
> Maybe (not)? ESPRESSObin_V7_1-0 on the underside.

Look at the package of SoC chip. On top of the package is printed
identifier 88F3720. On the last line should be one of the string:
C080, C100, C120, I080, I100 which identifies frequency
(080 = 800 MHz, 100 = 1 GHz, 120 = 1.2 GHz)

Can you check what is printed on A3720 SoC package?

> BTW, with the 1200_750 firmware and the patches:
> 
> root@OpenWrt:/sys/devices/system/cpu/cpufreq/policy0# cat scaling_available_frequencies 
> 200000 300000 600000 1200000
> 
> Of course that could mean nothing, but thought I'd mention what I do see.

This is value set by firmware file which you have started.
