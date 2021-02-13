Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59931AE1A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 22:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBMVUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 16:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhBMVUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 16:20:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70D3A64E07;
        Sat, 13 Feb 2021 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613251193;
        bh=AciXU5G6i/inyBsBJJJaM57WVRBnmaQtCGGm7lKuzhY=;
        h=From:To:Cc:Subject:Date:From;
        b=P7R/hqkZuKtF6iw9N1sx4eJHQjs8SVYb8y2dDKGlEQKuLzsjnLrHTYTD7MAiJRL/c
         3PETCLNWdKYVNalgNS1A9psyrHSt9mHcfemefiz59SIcYBu/6v609zdLEzByLNX3IM
         mtEAJD1KI7a43n5/dKEhH+WSIR4pkuN58Hd8uotePDKPUepsfC/IsRxUTe7TNf0Jeh
         kQ8S9EnzheKGuv9rBOEviifNrAI2Qi176jWkS485N+sZV8zwgRAeDKyv/4QsolQ6iO
         YFUnOP6yHiJ+oJxU4vSkxUyx3NUhxsjVPVWsOiJflzrNVq+sUdUcnatq4J2GX+0AQu
         InwzE8rtw0WKw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fix for v5.11-rc7
Date:   Sat, 13 Feb 2021 13:19:52 -0800
Message-Id: <20210213211952.1071982-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c361c5a6c559d1e0a2717abe9162a71aa602954f:

  clk: mmp2: fix build without CONFIG_PM (2021-01-12 12:10:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 245090ab2636c0869527ce563afbfb8aff29e825:

  clk: sunxi-ng: mp: fix parent rate change flag check (2021-02-11 19:02:24 -0800)

----------------------------------------------------------------
One small fix for the Allwinner clk driver so that display clks figure
out the correct rate to use. This fixes displays running 4k@60Hz and
some other resolutions that haven't been exercised and fully understood
until now.

----------------------------------------------------------------
Jernej Skrabec (1):
      clk: sunxi-ng: mp: fix parent rate change flag check

 drivers/clk/sunxi-ng/ccu_mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
