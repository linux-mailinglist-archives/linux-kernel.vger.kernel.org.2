Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953D436FCB5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhD3Opb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhD3OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED0C061345
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u17so105745102ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXGJ6BJNTyxC31APtHNNGgHRV6GpZZQxSZgzKX376VM=;
        b=aNtbLLbf2Q6SlzpKcWsgRebLvwn4zi/d589NGuMeRYyZh3RP7FCPHSaCSinheiYAy9
         18QCLBDdRW58unZGIiFrpRZGZJO2KMJELaGccyw5SPcA+g1Fc6dAz2RgqYbYynQciOc9
         /nt8Cc/9MciYXiU2lSHHZdtrjqYMJwgsb93bqeC/bGVNF7O5UPnLr4RBrrrJQfFc4Qx6
         27TfZiTu0Ke6My7QKTrXe9JhigcVc04ffGUVKO3O5oVLVRNVcZisju618/6bed+VS3/U
         66vkN+DlS+GUH2XPy5subtLFkd6Ct5PuMcz/zLBBT4/XlzOT1vyHl8DJCDPffOuDZxPb
         Y43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXGJ6BJNTyxC31APtHNNGgHRV6GpZZQxSZgzKX376VM=;
        b=a9zN2+3rk/ZkIARq6en5Riiri3IJ1Hs+Imge59hdPQ6vQPD/e6Z0Rm14IcFlpThuOK
         hhzGV4jGejqhf5K3LO6Pk6s+b1OHatg3srvFTl6KUaoND7QUipiVtMdXHAHd7kb6fIsn
         DOXtTmv4KrUurVS12jNiaU6R0YHPe0WvNOjwIxYaZdDMbprg+OqC1j/RaIdwgt8of3yF
         AigA5ua423oxjtBU0KhfYtbLU8M8rsguLTSxHlA2mJ4CZxDJKEsG4p8tsnVCzWXsWVvv
         5ha7kujX27O1zYWLviDzhpp0qo6Qa7kIbOP9rk/nAPLHmztykLX8biavqTnj03cWZmXT
         eKGQ==
X-Gm-Message-State: AOAM532Ta9xbRIrNyD16P0uBrbEn6vDBPdnwY1W6jLa1gFshXvAoVIKG
        dhKYJicpPwBk3QHFVGEFNUIFaSuiLYc=
X-Google-Smtp-Source: ABdhPJxlBaxATSJ6RL1VJK8aZe0xlGAYAbrKJVCwzsUHoR9XelKXA/xCuWyaVFezkScToe5DzJVauw==
X-Received: by 2002:a17:906:5811:: with SMTP id m17mr4732877ejq.221.1619793868446;
        Fri, 30 Apr 2021 07:44:28 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id pw11sm2047716ejb.88.2021.04.30.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/43] staging: rtl8723bs: replace ODM_RT_ASSERT with netdev_dbg()
Date:   Fri, 30 Apr 2021 16:43:39 +0200
Message-Id: <1b5da18835320ed9f312acdc01553bbd58e28bf8.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace ODM_RT_ASSERT with netdev dbg.

Marco ODM_RT_ASSERT wraps a raw prink and prints a message
everytime second argument is false. This occurrence prints
always, so replace it with netdev_dbg()

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 0027ce211619..fcd3f97e7df5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -552,7 +552,8 @@ bool ODM_RAStateCheck(
 		break;
 
 	default:
-		ODM_RT_ASSERT(pDM_Odm, false, ("wrong rssi level setting %d !", *pRATRState));
+		netdev_dbg(pDM_Odm->Adapter->pnetdev,
+			   "wrong rssi level setting %d !", *pRATRState);
 		break;
 	}
 
-- 
2.20.1

