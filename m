Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE5315C39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhBJB2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbhBIW50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:57:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F5F164E3C;
        Tue,  9 Feb 2021 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612911393;
        bh=PfEDKvuwh0gfWlzyckF5/9G3rDhdLAKB/9Bd79EjxRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNrxVIA/ihj/SZyR+qr0RBsxTNLKmDqITO/hQIrF8kmkOmSmGzg4BIxwzBpBLW310
         y982bZnwvHlKva+CtWiRuOcEh2c+Kp6iXVPVtRhmg+eujEZWp3nu7xFPKrPtLTnFQE
         aP82+DOEoUzwc9zvI+ObrEXqp9j70e5u5c6EbXWl9AlJOFm50paIRBcp0tH0uNoYGF
         9zwEUFIifhzIH+1Rm/oKRXVK9nvEoHn7kK+ZuPPyPLBGEkEe2SeEczOl02KA6eUYuc
         SDuiVtVnY8U9TUyrRyPQbdpgu9/TBhTwPPKM1KwYIg02McJa0sw5ZbxDlFLp4awJQS
         ecQ9CP2jnIBEA==
Received: by pali.im (Postfix)
        id 9EED4F9A; Tue,  9 Feb 2021 23:56:30 +0100 (CET)
Date:   Tue, 9 Feb 2021 23:56:30 +0100
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
Message-ID: <20210209225630.mdwnzkvnaz3r4blt@pali>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 February 2021 14:52:56 nnet wrote:
> On Tue, Feb 9, 2021, at 2:42 PM, Pali Rohár wrote:
> > On Tuesday 09 February 2021 13:45:08 nnet wrote:
> > > On Tue, Feb 9, 2021, at 1:33 PM, Pali Rohár wrote:
> > > > On Tuesday 09 February 2021 13:00:26 nnet wrote:
> > > > > > If you have other Armada 3720 boards (Espressobin v5/v7, uDPU, Devel Board, ...) then it will be nice to do an additional tests and check if instability issues are finally fixed.
> > > > > 
> > > > > These patches applied to the 5.4.96 in OpenWrt (98d61b5) work fine so far on an Espressobin v7 AFAICT per changing values in /sys/devices/system/cpu/cpufreq/policy0.
> > > > > 
> > > > > Are these changes intended to work @1.2 GHz on the v7?
> > > > 
> > > > Hello! Do you have 1.2 GHz A3720 SoC?
> > > 
> > > Maybe (not)? ESPRESSObin_V7_1-0 on the underside.
> > 
> > Look at the package of SoC chip. On top of the package is printed
> > identifier 88F3720. On the last line should be one of the string:
> > C080, C100, C120, I080, I100 which identifies frequency
> > (080 = 800 MHz, 100 = 1 GHz, 120 = 1.2 GHz)
> > 
> > Can you check what is printed on A3720 SoC package?
> 
> Both of mine are 88F3720-A0-C120.

Interesting... it is really 1.2 GHz. I have not seen it yet. And few
weeks ago I thought that it was never available on market.

Well, if 1.2 GHz variant has same issues as 1 GHz variants then this
patch series should fix it. But you said that with this patch series is
board crashing when running at 1.2 GHz?
