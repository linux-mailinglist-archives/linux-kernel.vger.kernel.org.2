Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2C3EB189
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhHMHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhHMHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:32:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EADC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f5so11916261wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JK6AIVzUO9DbuoCqA+FhRGUI2/Fje0it6om2E5yc5Hg=;
        b=hxriBC0VFRQpijbFyzIgThzSFKqciJFeg/Nm6VYRHW6h+7jNe5jNOpAz5ZJKc0X0nO
         yEigQqruLbJuHOJiXU0Jo/y4smreAo+u7HzPW7cfQhbKVJcrsHpPzBOYfrVbSiexfD0w
         5dCByINmeFyJBGfFIWnGRnQVKsIVnLXQVyUUH571jGYKSoCDStwdUZxiFrCq874b03z7
         idy3apnzoyWk+QBaI+/yjP3DR3BASx2p/ETNcO/jU3CsgJT0Pl1Pr4wqxViG7WzqC1wI
         UibKlhlEe1GPEcO/lThEm3ByXQ/kTCQ0JCO1QcIZo7YvK87Gia+lLjKFzX9FN41iaZW7
         pvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JK6AIVzUO9DbuoCqA+FhRGUI2/Fje0it6om2E5yc5Hg=;
        b=t1Y7NEB6H+4B8ynaPe8iDgIxl+EPI4EkVEqD2hOo/HNZEx8KB05+8KcYBj3lUUubkz
         hrTt4ehMXtJ69Z02vZelB2unB6kQwI2P3Ss+T58Ao/987u5C2TpY5tHUGI7drPDQcABS
         La88jQ9/2673wL1iH3cRvpjU0sUWwdf8F7uJ0PGEUqALxc872rXdEdmtnrPDFIWLDte7
         vE5x7uY51W1Mfi5MlIWmv6eb2J0JBGqWeU0ZhTh6hP3EoiIxX/FiA3fP/sA78hXDRbpg
         bfdCBtK2hHfQJ/p9xC3a0qSRtSShs0qWYHwP5QYArUwZGm0HtVlpHj+edLa1yRtXn1Zp
         FhSA==
X-Gm-Message-State: AOAM532zm6IZbZ9xlJBftpN05oiBanlW/WxxQFkAECpbO8uDYD9u/mwz
        W5dP21avxmApLIcAG5mN8To=
X-Google-Smtp-Source: ABdhPJwuuyZmPoPqUdi19c5/TFnBCD/LLNTUWdGHhywyr6s1fElPxFE9SQzytKCR1Pg7JXPfr8LUHQ==
X-Received: by 2002:adf:eb8d:: with SMTP id t13mr1473721wrn.4.1628839922192;
        Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id k12sm697406wrd.75.2021.08.13.00.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 00:32:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: rename parameter of Hal_GetChnlGroup88E()
Date:   Fri, 13 Aug 2021 09:31:08 +0200
Message-Id: <20210813073109.25609-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813073109.25609-1-straube.linux@gmail.com>
References: <20210813073109.25609-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameter of Hal_GetChnlGroup88E() to avoid camel case.
pGroup -> group

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index d3345fa0eb60..07ba5f0eecc2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2060,20 +2060,20 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 	}
 }
 
-static void Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
+static void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
 {
 	if (chnl < 3)			/*  Channel 1-2 */
-		*pGroup = 0;
+		*group = 0;
 	else if (chnl < 6)		/*  Channel 3-5 */
-		*pGroup = 1;
+		*group = 1;
 	else if (chnl < 9)		/*  Channel 6-8 */
-		*pGroup = 2;
+		*group = 2;
 	else if (chnl < 12)		/*  Channel 9-11 */
-		*pGroup = 3;
+		*group = 3;
 	else if (chnl < 14)		/*  Channel 12-13 */
-		*pGroup = 4;
+		*group = 4;
 	else if (chnl == 14)		/*  Channel 14 */
-		*pGroup = 5;
+		*group = 5;
 }
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
-- 
2.32.0

