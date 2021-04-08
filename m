Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64EE3584C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhDHNcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:31:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:31:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g35so1405308pgg.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=urweAOoUvm3tXo6To57HIW+uVzqmNXUWv/SU0VXhKJA=;
        b=Z62HAkdrl2n13lTDc9ckxQfr2eg5n3b77K+5a4po+k0aeX190Ve3RWes/bT2Mrl2R+
         vVAbzeU5RO95iHc/9vA7pkYqoEiNxnSvv/7mZ3Boy+0lN4LyrGeBSNyBN52ekXsv8I1b
         rUjSCkWYmIFbz7gBRbwv5We4RlstcHicV/O6xn7ooR7cSk5X3WAWJyiYQDc6nANtN754
         884CYGLfx/LrH0t30klmwbOTxjODf+gSGiTG8Ptwqk1vfs/PvZCDTNAZK0KM5+O8PIxX
         fzEoTYsdSChYFOpE4tYCR1X+3+488EfJRtoFyqRjK5RKp+v+fQPUhx+LQwrL3ACS/p17
         E+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=urweAOoUvm3tXo6To57HIW+uVzqmNXUWv/SU0VXhKJA=;
        b=HfSeZc+SLegBlTRO+xpbhMGMA6cSzy6ZoRNVOHs/hYtYHucFFjf4Q6MNdk/DvPBgTr
         BRli6zNi5/N4zpo1oHsVV1xiC7Cbe6CEYIQa1rgzwTysmKf9iWr98k8DtjfmThNXEqkD
         Yb7dUoYzV97YqzBgrvNCUbX2zmCaERf6QO+c5Tb3LrNoxAVz+Tc6nsnXwZBm72y/VWko
         w1FPq7GZjuls5a2qT98WCzrs6PJzJTrLHU9yDHBi/x2xpL2MvdWvP4PvTKy7zAMUKEfc
         IHyRdrhRwHBnPiAhWB/H9P/PV6h0Pm9YZag1rYAA4g2/l5djk0PFVxAH1jyLIo+22Flu
         fBew==
X-Gm-Message-State: AOAM530XhrgkOQHDzTh7rkVCNsScJsUYqzsj8JHz+iXiJJbFuAaJ+9HX
        4ajQPwomKR8OqV0HF4JRe/sp
X-Google-Smtp-Source: ABdhPJw6VeoUjWzfdkDkdYpakZInl1620WH3EjSslU9ezZ84HYlTva4y4uaGKqyrxXMrFi7OqTsNGw==
X-Received: by 2002:a65:5cc2:: with SMTP id b2mr7917562pgt.280.1617888706197;
        Thu, 08 Apr 2021 06:31:46 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.173])
        by smtp.gmail.com with ESMTPSA id f16sm22569038pfj.220.2021.04.08.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:31:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        bbhatt@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] bus: mhi: core: Fix shadow declarations
Date:   Thu,  8 Apr 2021 19:01:34 +0530
Message-Id: <20210408133134.6548-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes below sparse warnings with W=2 about shadow
declarations:

drivers/bus/mhi/core/main.c: In function ‘parse_xfer_event’:
drivers/bus/mhi/core/main.c:667:17: warning: declaration of ‘flags’ shadows a previous local [-Wshadow]
  667 |   unsigned long flags;
      |                 ^~~~~
drivers/bus/mhi/core/main.c:565:16: note: shadowed declaration is here
  565 |  unsigned long flags = 0;
      |                ^~~~~
drivers/bus/mhi/core/main.c: In function ‘mhi_process_ctrl_ev_ring’:
drivers/bus/mhi/core/main.c:856:23: warning: declaration of ‘new_state’ shadows a previous local [-Wshadow]
  856 |     enum mhi_pm_state new_state;
      |                       ^~~~~~~~~
drivers/bus/mhi/core/main.c:837:19: note: shadowed declaration is here
  837 |    enum mhi_state new_state;
      |                   ^~~~~~~~~

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Used a separate "mhi_pm_state" variable

 drivers/bus/mhi/core/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index b0c8afe16e3a..47a8df550fe0 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -664,8 +664,6 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	case MHI_EV_CC_OOB:
 	case MHI_EV_CC_DB_MODE:
 	{
-		unsigned long flags;
-
 		mhi_chan->db_cfg.db_mode = 1;
 		read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 		if (tre_ring->wp != tre_ring->rp &&
@@ -853,14 +851,14 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 				break;
 			case MHI_STATE_SYS_ERR:
 			{
-				enum mhi_pm_state new_state;
+				enum mhi_pm_state pm_state;
 
 				dev_dbg(dev, "System error detected\n");
 				write_lock_irq(&mhi_cntrl->pm_lock);
-				new_state = mhi_tryset_pm_state(mhi_cntrl,
+				pm_state = mhi_tryset_pm_state(mhi_cntrl,
 							MHI_PM_SYS_ERR_DETECT);
 				write_unlock_irq(&mhi_cntrl->pm_lock);
-				if (new_state == MHI_PM_SYS_ERR_DETECT)
+				if (pm_state == MHI_PM_SYS_ERR_DETECT)
 					mhi_pm_sys_err_handler(mhi_cntrl);
 				break;
 			}
-- 
2.25.1

