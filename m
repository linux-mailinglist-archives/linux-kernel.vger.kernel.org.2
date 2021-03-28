Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C487F34BC35
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhC1Lb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 07:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhC1LbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 07:31:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8630B61971;
        Sun, 28 Mar 2021 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616931065;
        bh=ygvSF2Bvmh+H0Ma+sUc7kwaXVrdd1FF8mhiJ8+JAGfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acADhzr0jVnivNqQulEMufS5/dn17nejyQXJ1PwzYDzlN9+67zA8tpuyIl2mXZBfo
         C6u6XgitRCNszbWow5OAmYxHjOof/VgM86sQ41bAjDq4aX0H/EImyqHwgRmYS+JoVD
         hKbC/yRNCcKEk+eqP7dQBFEzLYRRJ1RxXzsyvkgJdVscRD9r3ICUMcE35fta5LCPV3
         zCcOzxDhoya2PKyI7mnjayEIgsje1qqXaaEr/Rdrn1PFC+LoeE6RtrIl+HrYHfEN40
         rOcf7axb+FDUNyuEtP7RrJ+RcLltbmiHZ5rd0cgsVvR6dwFajqPA4BhB0GR3aaIb+9
         EZG3Ja1aYL0rQ==
Received: by pali.im (Postfix)
        id 1B8E956D; Sun, 28 Mar 2021 13:31:03 +0200 (CEST)
Date:   Sun, 28 Mar 2021 13:31:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
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
Message-ID: <20210328113102.jk3os7p56kq43yve@pali>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
 <20210301192024.tgvp6f5zscbknepo@pali>
 <87a6r8ka6x.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6r8ka6x.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2021 10:12:06 Gregory CLEMENT wrote:
> Hello Pali,
> 
> > Hello Gregory!
> >
> > Patches are the for almost two months and more people have tested them.
> > They are marked with Fixed/CC-stable tags, they should go also into
> > stable trees as they are fixing CPU scaling and instability issues.
> >
> > Are there any issues with these patches? If not, could you please merge
> > them for upcoming Linux version?
> 
> Actually I am not the maintainer of the clk and cpufreq subsystems, so
> the only thing I can apply is the device tree relative patch.
> 
> Gregory

Hello Gregory! Could you please at least review this patches, so other
maintainers could merge them?
