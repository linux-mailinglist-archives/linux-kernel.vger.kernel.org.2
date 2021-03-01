Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD92329F83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574040AbhCBD2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242740AbhCAUfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:35:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE6B64DD0;
        Mon,  1 Mar 2021 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614626427;
        bh=4Fbz/Gcym0foCbh9vStNcQpQ+1PRuy7d+jh0MaZf+Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ot0QeQLqnqrW8Yz+bSpChMgzrHQz7xltTkG5tYLWTlCXrGOabF+Z8zIaGno3aSxDu
         1GzmQu5NiWG+GtA8VRbwLHvUlCbueAtvCnJY1NbscWaqniFLc6JyrFwZRj+NX4KLm/
         +8vupFIFYu2Ru5BWG1h+FpTqP9ZwQj2MyjMbF2jhZXCLUJZ9Zpf/t8wJqo/gIxsmHQ
         CLN/q4BSeZrHgyKGpEDCXxcb/02vJeD2iiW0/FNeW1ogHlIvREpSs5UUhdoo9KhUYH
         +DpyHEaEoPgtSk97dJNMgGdo/EsfJyl4sPrBcWJUqwXENkHvG7j+GfIMpcauscGL4m
         yW/p+rmpgPdrw==
Received: by pali.im (Postfix)
        id B140DA32; Mon,  1 Mar 2021 20:20:24 +0100 (CET)
Date:   Mon, 1 Mar 2021 20:20:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210301192024.tgvp6f5zscbknepo@pali>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222194158.12342-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gregory!

Patches are the for almost two months and more people have tested them.
They are marked with Fixed/CC-stable tags, they should go also into
stable trees as they are fixing CPU scaling and instability issues.

Are there any issues with these patches? If not, could you please merge
them for upcoming Linux version?

On Monday 22 February 2021 20:41:48 Pali Rohár wrote:
> Hello!
> 
> This is third version of patches for Armada 37xx cpufreq driver which
> fix CPU scaling with 1 GHz base frequency.
> 
> The only change in this third version is modified patch 04/10 with fixes
> for 1.2 GHz variant of Espressobin. Minimal CPU voltage in L1 load for
> 1.2 GHz variant was increased to 1.155V.
> 
> Patches are now rebased on top of the kernel version 5.11 with all
> collected Acked-by/Tested-by lines and are available also in my git
> tree in branch a3720-cpufreq-issues:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=a3720-cpufreq-issues
> 
> If you have other Armada 3720 boards with 1.2 GHz CPU, including
> Espressobin V7, let us know if it is working fine for you.
> 
> Marek & Pali
> 
> Marek Behún (3):
>   arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
>   cpufreq: armada-37xx: Fix setting TBG parent for load levels
>   clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
>     clock
> 
> Pali Rohár (7):
>   cpufreq: armada-37xx: Fix the AVS value for load L1
>   clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
>     1 GHz
>   clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
>     to L0
>   cpufreq: armada-37xx: Fix driver cleanup when registration failed
>   cpufreq: armada-37xx: Fix determining base CPU frequency
>   cpufreq: armada-37xx: Remove cur_frequency variable
>   cpufreq: armada-37xx: Fix module unloading
> 
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
>  drivers/clk/mvebu/armada-37xx-periph.c       |  83 +++++++-------
>  drivers/cpufreq/armada-37xx-cpufreq.c        | 111 +++++++++++++++----
>  3 files changed, 135 insertions(+), 62 deletions(-)
> 
> -- 
> 2.20.1
> 
