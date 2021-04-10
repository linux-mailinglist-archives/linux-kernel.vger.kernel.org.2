Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129B035AA01
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhDJBqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDJBqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:46:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C3F161181;
        Sat, 10 Apr 2021 01:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618019164;
        bh=P6QBemRP8IGw298jUI7d/3J59wHC8klmu0qYSesQYM8=;
        h=From:To:Cc:Subject:Date:From;
        b=SvJirFat05C1gSgWl0Fk6orz3NaEB67dSQnHy+vZf2HnwBvQmdg0k4yXeDjEBvZay
         G+frnyWp/jtTbSMx4xFQPHwJnOBbmKw3xJ1lKjQbZnexlLyWKZQdKjXP84iWe5LZFE
         +/9o55Fyt7JmraayjbPfiQZvyG09VNF/Hj7F8FO0IEb0+7siq1ZkI5VMa0J8S2+zWP
         SHa6Ui0VxkOLqi+GvrPSnFC21Oo6gC5ojVYgyBMjIlitczX3uY7uY6y/m4OS0tcRlN
         jqWmO6DY5CLnZCQNQU1AA8FybNfmkAvE6hFMb2UJk2JcVXRdoXzuUIadsA1UtMRolq
         wv5b1h1eqDX9A==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.12-rc6
Date:   Fri,  9 Apr 2021 18:46:03 -0700
Message-Id: <20210410014603.3762887-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 148ddaa89d4a0a927c4353398096cc33687755c1:

  clk: qcom: gcc-sc7180: Use floor ops for the correct sdcc1 clk (2021-03-13 13:00:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 50ce6826a48f119baf2794fa384a64efe9bd84a5:

  clk: fixed: fix double free in resource managed fixed-factor clock (2021-04-07 16:01:25 -0700)

----------------------------------------------------------------
Here's the latest pile of clk driver and clk framework fixes for this
release.

 - Two clk framework fixes for a long standing issue in
   clk_notifier_{register,unregister}() where we used a
   pointer that was for a struct containing a list head
   when there was no container struct

 - A compile warning fix for socfpga that's good to have

 - A double free problem with devm registered fixed factor clks

 - One last fix to the Qualcomm camera clk driver to use the
   right clk ops so clks don't get stuck and stop working
   because the firmware takes them for a ride.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      clk: fixed: fix double free in resource managed fixed-factor clock

Krzysztof Kozlowski (1):
      clk: socfpga: fix iomem pointer cast on 64-bit

Lukasz Bartosik (2):
      clk: fix invalid usage of list cursor in register
      clk: fix invalid usage of list cursor in unregister

Taniya Das (1):
      clk: qcom: camcc: Update the clock ops for the SC7180

 drivers/clk/clk-fixed-factor.c  |  9 +++++++-
 drivers/clk/clk.c               | 47 +++++++++++++++++---------------------
 drivers/clk/qcom/camcc-sc7180.c | 50 ++++++++++++++++++++---------------------
 drivers/clk/socfpga/clk-gate.c  |  2 +-
 4 files changed, 55 insertions(+), 53 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
