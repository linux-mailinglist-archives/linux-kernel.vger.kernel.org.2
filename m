Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA63B1AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFWND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhFWNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:03:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D105C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:01:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n23so1588431wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffHHvblSbftugRKNFHdCEz54FjByJU5jPBUJvQCLlKQ=;
        b=oyyFAIRvKscBPkw8wh5lHltPrhJujf66ARDgrmsGXfZZkEDnR9EdbD8p4USEHKep9i
         pNglgshUvSTw+JnANym/3qKYIOOJUShQiguybMK3lGMupsNjn/g5Sz1v880K5SdKsc0H
         PBmlcEi95+urYSkMZzW+hRQl5NiBJOGtVb4l+jfsJ4HNSeQGLOFRQ6pU3nmwoMmWNHyp
         54ANU6cb1slIPjkqZAx1c+EjOvf/jEPbZoM1Vh7eyeQQnZtfanHfQyVzT9DGIPWg+LFQ
         pZcxER23meMDlHIEIYG9Z0aU90B3F6oDeN+smOBEHofDrWumsII0Swobb9Diwf0sHmrZ
         ZWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffHHvblSbftugRKNFHdCEz54FjByJU5jPBUJvQCLlKQ=;
        b=nUQaJkfh/lj7kJ63meEbZePcW50IJkZ8OCeAOXzOO30U7YSpzTWbtQuHuw6289fr8O
         hBq3yYqCt4tXkAA8alXfEWya9s+KhI+iWImrueMKXDG421tJ2On2V4WJ3+k4TFCjZ1ws
         2tWpmj+p1pCudoj3mTWJA5jXZgOfS77h9VOxeHN/Jx0RdGnTODyfzgrzwRJhGb7F3uKN
         IVMKgMNrf6boB0xjuRJoZMEENAFVi/WIQKqSqQdANwpiEZ5HI3gcijJvKJ2PFsRIjISJ
         DwUH6EDABFeC/s0csoub8KyplMZL3LtiE8Rct5gTrMMh+pv49rJZmIItlz7s+WvYxtFJ
         JBDQ==
X-Gm-Message-State: AOAM531W5FhRuopK/HNtTx0HfghcVSbFrXziVH4dacEZ42CEfZpymchE
        ZfCD7Et//HfseHZyB6Dcjd4Tiw8xiLPfMw==
X-Google-Smtp-Source: ABdhPJyfp7sk2hIwqXsoJm9h+R+fkogfD0djsKDKd5eRr/WPRXfmRcg+OEudeCqk5SS3L7Rs+t7V0Q==
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr10878368wmp.77.1624453265743;
        Wed, 23 Jun 2021 06:01:05 -0700 (PDT)
Received: from agape ([5.171.81.217])
        by smtp.gmail.com with ESMTPSA id c8sm1946696wri.91.2021.06.23.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:01:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: convert function to static
Date:   Wed, 23 Jun 2021 15:01:03 +0200
Message-Id: <20210623130103.7727-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function chk_sta_is_alive() is used only inside core/rtw_ap.c
so remove the prototype and convert it to static.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 23bbdf084631..3e2d8b735fc8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -164,8 +164,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	pnetwork_mlmeext->IELength = offset + remainder_ielen;
 }
 
-u8 chk_sta_is_alive(struct sta_info *psta);
-u8 chk_sta_is_alive(struct sta_info *psta)
+static u8 chk_sta_is_alive(struct sta_info *psta)
 {
 	sta_update_last_rx_pkts(psta);
 
-- 
2.20.1

