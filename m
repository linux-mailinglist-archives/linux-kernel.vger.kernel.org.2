Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014F132EC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCENxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:53:06 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42531 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCENwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:52:53 -0500
Received: by mail-lj1-f177.google.com with SMTP id k12so2810788ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 05:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNai2Yw7gKaekPw4n0fAnGfRJ1e7puAzt8Afq4+GVMI=;
        b=kxh+0rUi2URoZycTzoTJy4H6QEVhbZmcejnNOpwO6AqocwK4K2X5ceDlpWFd2ggkao
         O49W38lENVa3Twq4wuF5/K0II5ofjA60gr24DQz6Dp+K6Dz8jHBnLsTUUQSGhChHbx6g
         iYPB76aYr/benMyPVXN992rFzY0zIG6sBMTUAgufJHiaYOFjKX9xiKaVGtXJtud8C7Uw
         ctac1YNDHXbFs9hfccsINFD90tE08t10w0EFVLPMt8E7D+K5MrZuRUg6N6J3wsTOMINH
         If16RX8PFdNvbKbWfJVzPdHoVmgWKkYkFWFp6WUQ7gF/UrhLVwc7QLgGhhbKr0zFyX9Y
         Gq9g==
X-Gm-Message-State: AOAM530NT19TG2fpqVo3IgviJFwOMjAMz84NgHTdiYs+cOlTq7wwG/el
        p3W6i8ncqOLj7nweIY7DyBM=
X-Google-Smtp-Source: ABdhPJxA2WqKRv/N/qROZsN2LbIesf98LuIyDjtZm6YjkmWP2ir1FxmBwdYk2FnRQx+Pz5Nzsw46Zw==
X-Received: by 2002:a2e:2f0c:: with SMTP id v12mr4951981ljv.367.1614952372673;
        Fri, 05 Mar 2021 05:52:52 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id p9sm319517ljn.16.2021.03.05.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 05:52:52 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Denis Efremov <efremov@linux.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove duplicate pstat->hwaddr check
Date:   Fri,  5 Mar 2021 18:50:01 +0300
Message-Id: <20210305155001.61951-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_MCAST(pstat->hwaddr) checked twice in a row in
odm_RefreshRateAdaptiveMaskCE(). Remove the second check.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index f2a9e95a1563..5e432f1bc150 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1114,8 +1114,6 @@ void odm_RefreshRateAdaptiveMaskCE(PDM_ODM_T pDM_Odm)
 		if (IS_STA_VALID(pstat)) {
 			if (IS_MCAST(pstat->hwaddr))  /* if (psta->mac_id == 1) */
 				continue;
-			if (IS_MCAST(pstat->hwaddr))
-				continue;
 
 			if (true == ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level)) {
 				ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("RSSI:%d, RSSI_LEVEL:%d\n", pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level));
-- 
2.26.2

