Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE096368D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhDWGZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:25:35 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:44821 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhDWGZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:25:33 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id w6Qu2400721Fzsu036Quj9; Fri, 23 Apr 2021 08:24:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 08:24:55 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] clk: mvebu: Fix some error handling paths + do some clean-up
Date:   Fri, 23 Apr 2021 08:24:52 +0200
Message-Id: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fixes some (unlikely) error handlings paths.

The 4th patch is completely speculative. When I compile-tested the changes,
I had to remove this line in order for it to compile.
As it works fine (at least for me) without it, I wonder if it is needed at all.


Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
In order to compile-test the changes, I also had to change the 'bool' in Kconfig
by 'bool "blah"'. Without this change, it was not possible to set
CONFIG_MVEBU_CLK_CPU required by Makefile.

I don't know if I did something wrong, if it is an issue only on my environment
or if something got broken at some time in the build chain but it looks
spurious.

If I'm right and that these drivers never compile and no-one noticed it,
maybe removing them is better than fixing some unlikely issues and style.
If these drivers should stay, Kconfig may need some love from someone.

Christophe JAILLET (4):
  clk: mvebu: Fix a memory leak in an error handling path
  clk: mvebu: Fix a another memory leak in an error handling path
  clk: mvebu: Fix a checkpatch warning
  clk: mvebu: Remove an unneeded include

 drivers/clk/mvebu/clk-cpu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.27.0

