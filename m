Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4936E315BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhBJA7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234150AbhBIWO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:14:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8E0064E8C;
        Tue,  9 Feb 2021 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612906412;
        bh=m8k7mmXys1RUFq6qujjO66b+EdVXFLMSPJNPdVyXlNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVrhhBDak5uhy5UZ8ZvxFiYSdBpuNImA3x0LnWQvRp1gshgIEHXkgzdnQTXfkpp/i
         zUmiDyno2aUwVW4itQ8jwaqqlieT7UKM3MJpOVL2yzsn+FCC50YxTZa89qLmwRyFxz
         rqfKT4MrLgjO/+JUo8d15ZY6s/QADeIA6WbT+m3ktxSMOdq2WCCXT/FXAcgqpXjvnZ
         ZNITkjSwKjU/DWql4cHSkWp6a+GM6OrXPzAkKJ+ZWh6Xws4brRVvjKhLqbVlNSuGik
         Jh3iHMlxfs7vTFiR0Nqo+IJktlwzb9VdgevjTwh7w156z/arw+N8CtOuazV3B0uwJx
         v6p2QrMF/fe5A==
Received: by pali.im (Postfix)
        id 61346F9A; Tue,  9 Feb 2021 22:33:30 +0100 (CET)
Date:   Tue, 9 Feb 2021 22:33:30 +0100
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
Message-ID: <20210209213330.hnc7op72zoj24mgz@pali>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 February 2021 13:00:26 nnet wrote:
> > If you have other Armada 3720 boards (Espressobin v5/v7, uDPU, Devel Board, ...) then it will be nice to do an additional tests and check if instability issues are finally fixed.
> 
> These patches applied to the 5.4.96 in OpenWrt (98d61b5) work fine so far on an Espressobin v7 AFAICT per changing values in /sys/devices/system/cpu/cpufreq/policy0.
> 
> Are these changes intended to work @1.2 GHz on the v7?

Hello! Do you have 1.2 GHz A3720 SoC?
