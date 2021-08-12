Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31293E9B75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhHLAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhHLAB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:01:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C2FE6101E;
        Thu, 12 Aug 2021 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628726493;
        bh=fb3N6otN2O1cErcbcnTHP0VOJ/XxcCC8CJvEONjJUfY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=fjPqSbszPGo9IDZPoVcUsrfk7G+Esw1lKgFejTiNzzSTa4/VhwW1N9FXtd+bllFzJ
         x+O7sshgvChMho+U1yNufK7Uum0udGERmhKznUDl6iLrupkcDTvU6Y2RsVnDzf6koO
         PnKNUMoS19G3j5XgRO0GV3Q2nFdISUC3XwlUPJJR2z/SrKe3bBYpVk8kPe+PyTTQZ2
         69kVNpW3PG12YIBrvuFbmXjvRVp8AExnnJ128t94GdJhqtd9P3ItE9nmTT682GeDQS
         amCyA/08Hr7cVAmyKoxYrp1Yi9PSpMmeP/uyIWbVHHf4F0OiJWUU+xCTxhX7hjlWj0
         zcOvTJ1wWKnYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53A665C0981; Wed, 11 Aug 2021 17:01:33 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:01:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        kernel-team@fb.com, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org
Subject: [GIT PULL clocksource] Clocksource watchdog commits for v5.15
Message-ID: <20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

This pull request contains a single change that prevents clocksource
watchdog testing on systems with HZ < 100, thus preventing the integer
underflow that can occur on leisurely HZed systems.  This has been
posted to LKML:

https://lore.kernel.org/lkml/20210721212755.GA2066078@paulmck-ThinkPad-P17-Gen-1/

This has been tested by Rong Chen of Intel.  It has also been subjected
to subjected to the kbuild test robot and -next testing, and are available
in the git repository based on v5.14-rc2 at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource

for you to fetch changes up to 9b073961afabcf70d0804e472ea02fc6c739dcce:

  clocksource: Prohibit clocksource watchdog test when HZ<100 (2021-07-20 13:54:34 -0700)

----------------------------------------------------------------
Paul E. McKenney (1):
      clocksource: Prohibit clocksource watchdog test when HZ<100

 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)
