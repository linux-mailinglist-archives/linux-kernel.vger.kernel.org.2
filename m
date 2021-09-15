Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC740CDF1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhIOUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhIOUav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:30:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:29:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x10-20020a056830408a00b004f26cead745so5284586ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoVVooistygyhZh4JdyGmVYpdIyp7cTYMGqCLCSTLY0=;
        b=GLh+YyiPdeP971yf2WMJp6qlI1tEFoeWedmD3j5EJABG3/wl06rNX3hGpliIQbAPJi
         37nPcYTAMCdNOFefeDyFRRFlPDq7gg9gswDQ08Cam39BZ0e+TX3CTVV2TLMCuthtBfWh
         bZUVTOd1uwq2kDf3E/quJX/fNZnJLea8FpvSK9VkLUrPOgO1HOwLj5jW6WFms8LS+GAt
         vvK10OU8oVqiThwTiy7P962tCwFNb+87hGr6yn4kg7OcLSLt0q/f3dnbx3RRTYwDOXKI
         c8vbb0poNNnYvtbfes5xhGZ+0KfC9jb3xMSFqf0unz8otO8yuEnc10iqlQWAeAKtJAeY
         2Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoVVooistygyhZh4JdyGmVYpdIyp7cTYMGqCLCSTLY0=;
        b=fyuO87VM3jNOqq4ffES519dD+tcpKIcI9cdJ5HDyhSnCx2d6fcgN8/SBd9lR2d2Se0
         qsAgkZPP2IV4Tf4CvY1o/Ev5rtV+YKaxcbsapRJM1clK67gt03r6wigsBCBg+oOwYC+5
         BSEBZvyjrm0Y1lbJomHzIFymso0pZBKkoyFQKzaxL8zcP7iZveaLYvvokOySg23z21Z4
         0AB/s99QP6sQ0uJM3YOqNiQ2P74H3cX3U0lDJ/mVYK/aDhF4A1WxpqE10ixoy5ydQplN
         FRYAvJEzMcp5oHG16AK1BeDPHxHXp5cXJQW47Sf+zEqhOC0BFA/3vJiDUy3GUpzW+wFJ
         VZEw==
X-Gm-Message-State: AOAM531HyHWsHTBnoQraeVgnQAiQQKeNGdyfMpy0ohzZIMjgiiTyxFdu
        4pmfHnnN44NKOeXqfxHxYSI=
X-Google-Smtp-Source: ABdhPJzcrfoUuffYTAAYHUwkorhtRtauEj17pThrWLsC5z1Xi/NCJnQYmOoCOv0J7b6iCpqCzMoopQ==
X-Received: by 2002:a9d:6094:: with SMTP id m20mr1704121otj.380.1631737771796;
        Wed, 15 Sep 2021 13:29:31 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id l4sm247584oth.4.2021.09.15.13.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:29:31 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 1/3] staging: vchiq: remove braces from if block
Date:   Wed, 15 Sep 2021 17:29:14 -0300
Message-Id: <20210915202916.413914-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary braces from if block.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_connected.c        | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 83502f5f3a33..f367dbe2bc63 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -17,9 +17,8 @@ static   DEFINE_MUTEX(g_connected_mutex);
 /* Function to initialize our lock */
 static void connected_init(void)
 {
-	if (!g_once_init) {
+	if (!g_once_init)
 		g_once_init = 1;
-	}
 }
 
 /*
-- 
2.33.0

