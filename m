Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07E1368DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhDWH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:27:40 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43521 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhDWH1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:27:39 -0400
Received: from windsurf (unknown [91.174.235.35])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 107A7200004;
        Fri, 23 Apr 2021 07:27:00 +0000 (UTC)
Date:   Fri, 23 Apr 2021 09:27:00 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: mvebu: Fix some error handling paths + do some
 clean-up
Message-ID: <20210423092700.6a857460@windsurf>
In-Reply-To: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 23 Apr 2021 08:24:52 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
> In order to compile-test the changes, I also had to change the 'bool' in Kconfig
> by 'bool "blah"'. Without this change, it was not possible to set
> CONFIG_MVEBU_CLK_CPU required by Makefile.

CONFIG_MVEBU_CLK_CPU is selected by ARMADA_370_CLK and ARMADA_XP_CLK,
which themselves are selected by MACH_ARMADA_370 and MACH_ARMADA_XP
respectively.

So unless I'm missing something, this code is definitely reachable and
compiled. You can use the mvebu_v7_defconfig of ARM32, and the code
will be built.

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
