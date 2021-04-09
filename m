Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5E359422
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhDIEqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIEqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:46:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C4C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 21:46:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t23so2272439pjy.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 21:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRtHGh3ghhd5SnF8boy66XpM24heqWa4Tp6e3hDq7QM=;
        b=BTpjnf06Xkb4nTNWHjUYUEdgLKo+6xwtvLg7wYjOg5bBx62OwbGM/7wuEufD3b4aAa
         TEycVgdwTK36tYhhi3S2uE8XL/yEl730WTEjKW0bNjQKMbD61acedxrOw0S/ipn35Pq1
         anMM/lgJtcClWsbDSidgvrIWsL8gSdHuGt3LiZPT/64E2iHKPtGgyvYbubwyFXt9/okB
         gwtXCHfIiaPXoYCiyVpP7nnK83yIqi5qDgloboW5yZpBhweO8bOJ54DblJCIS9aLFvNK
         tlvSlhI+msZzed+VLbg+WUb+iKwlJjrrYFivZUK7tG75V7skY/qJJ4AbagKzGTYk+yYK
         EuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRtHGh3ghhd5SnF8boy66XpM24heqWa4Tp6e3hDq7QM=;
        b=geh1b7c9lzTmCTQkXbID3tCodrBvQ+toTGf/FlDUNipszeBZs16SUoCO2IS0kntMDG
         2VSXcRUD569SCeP6tikkwGPL9tJ1xsSjaiDgD2jxjc0N2xyzqRoET7/bRj2guotWlnO5
         WHIHwwm89sFU60qwAG8XOyg3L817oXrBcBTVLQ9JDxt1ULaVPKct/P/M4y4QUiq+aarF
         0TAtX4QRQaojxWyzQ4NrS+5zN9JPKkatlXx9RcwmXQ7vcajpTJmGDZGeHPFtDPPZyD7o
         wNrvagkmSFqmfljh0Q/PsqBRFeqtM7P9ve36tSflLOEUjZ/46NWiJJiH+OnYTpTueF3Y
         3zwA==
X-Gm-Message-State: AOAM532cRGcMJ04e07NlPJlJat0mZWaUOquXyV9QHdruTPNSx3J1hQfX
        /r69VnaDJL140+TDCS+iN7WOhzmvONla
X-Google-Smtp-Source: ABdhPJxTkYW6knNzfOtsJ4C2I4fZ9a8Jm9M7oPiCPi8u74WKMdQQARXTB/wrOUXDXzRcvD2bbXMjrw==
X-Received: by 2002:a17:902:6949:b029:e8:c22d:17ae with SMTP id k9-20020a1709026949b02900e8c22d17aemr10752955plt.57.1617943581736;
        Thu, 08 Apr 2021 21:46:21 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.131])
        by smtp.gmail.com with ESMTPSA id n25sm869676pff.154.2021.04.08.21.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:46:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        bbhatt@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3] bus: mhi: core: Fix shadow declarations
Date:   Fri,  9 Apr 2021 10:16:14 +0530
Message-Id: <20210409044614.7934-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

* Fixed the usage of "flags" by renaming to "pm_lock_flags"

 drivers/bus/mhi/core/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index b0c8afe16e3a..22acde118bc3 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -664,15 +664,15 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	case MHI_EV_CC_OOB:
 	case MHI_EV_CC_DB_MODE:
 	{
-		unsigned long flags;
+		unsigned long pm_lock_flags;
 
 		mhi_chan->db_cfg.db_mode = 1;
-		read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+		read_lock_irqsave(&mhi_cntrl->pm_lock, pm_lock_flags);
 		if (tre_ring->wp != tre_ring->rp &&
 		    MHI_DB_ACCESS_VALID(mhi_cntrl)) {
 			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
 		}
-		read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+		read_unlock_irqrestore(&mhi_cntrl->pm_lock, pm_lock_flags);
 		break;
 	}
 	case MHI_EV_CC_BAD_TRE:
@@ -853,14 +853,14 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
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

