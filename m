Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480D43D1906
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhGUUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhGUUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC0576120C;
        Wed, 21 Jul 2021 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626902875;
        bh=yBd/HwZEfIX5sh0k8B0keM9qnHKxrJmqgW07M/2+iDY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=nWm7ZnR7q1dCSXHFCrN9L4swRj0ZII1biK7KsVbd2H8qYpGP9fiFkVNMAjhSqmpXv
         h1Rf2UES9mmrRuQyop+acJGPQXG00X/ZmS+GEHXBzIdXaJ+36BeBLVc6CwEvFHOYe9
         xwVbQaLUJY7ZtbjjBZosr+k6m5G0ujOdmnHkCxAldvqTOOlpCLKeFhGFOKzewo4vmt
         1RmVGX/zpygQT4B7WMRsSH4Ni68v35eY1naXo8zraYWI+OqxEDF2fOskFnzMS8Gz+n
         PskQuLICRT+hJ4GM8hRU0QWwU8ykbch1E59nPUEQtqoc/a3NBJ3Vz7ZrN4KeVnwdFF
         FdCXcEDNTkUQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1D635C09A4; Wed, 21 Jul 2021 14:27:55 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:27:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH v15 clocksource] Prohibit clocksource watchdog test when
 HZ<100
Message-ID: <20210721212755.GA2066078@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted in a comment, use of the TEST_CLOCKSOURCE_WATCHDOG kconfig
option is prohibited when HZ is less than 100 in order to avoid signed
integer overflow.  However, comments can easily be ignored even when they
are actually read.  Therefore, add a "depends" clause to prohibit use
of the TEST_CLOCKSOURCE_WATCHDOG kconfig option when HZ is less than 100.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Rong Chen <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/lkml/202107040532.wqL30yFp-lkp@intel.com/

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 831212722924c..79487f3dad430 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2612,6 +2612,7 @@ config TEST_FPU
 config TEST_CLOCKSOURCE_WATCHDOG
 	tristate "Test clocksource watchdog in kernel space"
 	depends on CLOCKSOURCE_WATCHDOG
+	depends on HZ >= 100
 	help
 	  Enable this option to create a kernel module that will trigger
 	  a test of the clocksource watchdog.  This module may be loaded
