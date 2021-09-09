Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC58405EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbhIIVeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhIIVeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:34:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C8BA6103E;
        Thu,  9 Sep 2021 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631223175;
        bh=wh+BIbhMXd5mS7KMBDTEfvO/RMAk2Irr0HrxVVBSAis=;
        h=From:To:Cc:Subject:Date:From;
        b=jkjn7opwZj/v3UYxXClITbqmPJdRmkELqk756uzVJeo9jPuPLd6Z8xaLwgwqBFco8
         ALGlljn2wa/4Fsl0LCG0xkPMwYIR0iGenCvCm6P7+tQRU4r+JZHXxLIgRGKep3AAAJ
         k987XoUS/jae4I5NIY6WF7/pL2ebHjHryt85tWlZ3HONFZ3c299bm5hGje28MUWDdT
         1wm4AKSk99abbF+LnwoPXMlRDp3V52fWSblwVyMeRngiPUmmB7fiQebHhSP6Wa5eX9
         5dohBwYRpmYi2xeG3P8ULbw589SZCXiyKIpZk7o0Z5TcD23t99oQECKQYuYmwcv9MJ
         IQaz8LwThuSYQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Another clk change for the merge window
Date:   Thu,  9 Sep 2021 14:32:54 -0700
Message-Id: <20210909213254.2423881-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 47505bf3a82166c3576155c229e941af922bf147:

  Merge branches 'clk-kirkwood', 'clk-imx', 'clk-doc', 'clk-zynq' and 'clk-ralink' into clk-next (2021-09-01 15:27:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 2cfa946be843834d937e0914552d4967ffd421fc:

  clk: qcom: gcc-sm6350: Remove unused variable (2021-09-03 11:14:18 -0700)

----------------------------------------------------------------
One patch to fix an unused variable warning in a Qualcomm clk driver.

----------------------------------------------------------------
Konrad Dybcio (1):
      clk: qcom: gcc-sm6350: Remove unused variable

 drivers/clk/qcom/gcc-sm6350.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
