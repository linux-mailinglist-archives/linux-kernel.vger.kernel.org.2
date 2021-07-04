Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857E3BAFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 01:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhGDXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGDXER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 19:04:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E898C061574;
        Sun,  4 Jul 2021 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bR0QEHVYAdW3v72Aw8kC9THbMpNs2o+j6IWYhXHWArQ=; b=pR2pENaQmLKuVLljp3vAWZ0rIw
        D3huTZ2u+hOmQnmJh3zEPRxQRnZYHXfgx+8ZVjjGx6prK94cwlhA9ahlGCm5HaKJHZe0YovDxsHBo
        hvxOH+4wTugIKll+Ewho0TjDvQfSqgNwzMQm3EwQ0LZkF0nmd3zpVOTMMD1cIyZ98uWbMCLwF9qq5
        24KpE992qrIZOc6Dt2w7EN14lyAYL+aPIAxtRx/E8w4l8rqp5yG8Js1WEFXTGdTwTk2CHdtcOdTte
        Cic4X2q5ZinDOlEJGoVrKmItPNPUb6GJdFt7PkBX72sR0Jya6BbbFQqvuN6bRMs1oSZiYYegoq+jZ
        eHkJi8bg==;
Received: from [2601:1c0:6280:3f0:7629:afff:fe72:e49d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0B7K-006sCv-2P; Sun, 04 Jul 2021 23:01:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] m68k/coldfire: change pll var. to clk_pll
Date:   Sun,  4 Jul 2021 16:01:37 -0700
Message-Id: <20210704230137.28915-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_CLK() makes the variable name be clk_xyz, so variable
'pll' should instead be 'clk_pll'.

In file included from ../arch/m68k/coldfire/m525x.c:12:
../arch/m68k/coldfire/m525x.c:29:30: error: 'pll' undeclared here (not in a function)
   29 |  CLKDEV_INIT(NULL, "pll.0", &pll),
      |                              ^~~
../include/linux/clkdev.h:30:10: note: in definition of macro 'CLKDEV_INIT'
   30 |   .clk = c, \
      |          ^
In file included from ../arch/m68k/coldfire/m525x.c:21:
../arch/m68k/include/asm/mcfclk.h:43:27: warning: 'clk_pll' defined but not used [-Wunused-variable]
   43 |         static struct clk clk_##clk_ref = { \
      |                           ^~~~
../arch/m68k/coldfire/m525x.c:25:1: note: in expansion of macro 'DEFINE_CLK'
   25 | DEFINE_CLK(pll, "pll.0", MCF_CLK);
      | ^~~~~~~~~~

Fixes: 63aadb77669a ("m68k: coldfire: use clkdev_lookup on most coldfire")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: uclinux-dev@uclinux.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/coldfire/m525x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210701.orig/arch/m68k/coldfire/m525x.c
+++ linux-next-20210701/arch/m68k/coldfire/m525x.c
@@ -26,7 +26,7 @@ DEFINE_CLK(pll, "pll.0", MCF_CLK);
 DEFINE_CLK(sys, "sys.0", MCF_BUSCLK);
 
 static struct clk_lookup m525x_clk_lookup[] = {
-	CLKDEV_INIT(NULL, "pll.0", &pll),
+	CLKDEV_INIT(NULL, "pll.0", &clk_pll),
 	CLKDEV_INIT(NULL, "sys.0", &clk_sys),
 	CLKDEV_INIT("mcftmr.0", NULL, &clk_sys),
 	CLKDEV_INIT("mcftmr.1", NULL, &clk_sys),
