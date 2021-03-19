Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9A3414D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhCSF2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhCSF2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:28:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBACC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:28:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 30so4441672qva.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K+wNlQSjYGdwMRgFTYMCggvXCyk3Gg+SbWXkZpmBvE=;
        b=osatwVuMR/uoO2GLkbPyEiHomEDNpwp61bZjC4b3HzAcKkV1Pnct+3H9QYpgJH+SPv
         3xYCHfot4zGl88wyHgyMXebuV74SbZQCoLhOiWYzR75/ToG704cVOeTI7fi65mHF0Dj7
         XDeYtuF9jTFY6ZHiJP1PLTK34lBrGdxVoHDPEs46/DRk7zuG48lBovk8OpINh7H74IU8
         dPhV/rQLBeSlBzjxcMVSnCDeGfZGHiHp9BfGgahXUXEpVGAJPgAv41fTZ59LZQomO95c
         I2WQamqBafjq0pYiTW89pWAD0sQefGIYj0kVwOi0DKFqVuD0UUZyO1WNsQNXusgDmASA
         sF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K+wNlQSjYGdwMRgFTYMCggvXCyk3Gg+SbWXkZpmBvE=;
        b=HtuS+g6KrmUIZWg+yl1uaVxx3NwRtrHVxh5tNbPuEJ3IIJlM/vg9EoYaQko0SsQ+Zz
         /WGn2yesQHvCwrDHsw0uU8BKpWpcAEekdzAWi1e9qME/RBgkci+EsFRI6XQqBX2pm4Rw
         dPBo9UhxwRtHvgUV7ui2Js9F8dds30dh3guSywmjS5/FPRla49pt/B+LbKvco8lma3MK
         /BJZI7t+yPrARynAon+ZgSJjcGfImokpbbmJ21GtCIoEhv0CpLsaW7/1RFH0eu5jffsf
         T8P5wB4GqaRQb3rlFJewGrkq2NdSF2CphC999UvMn1wI68+LQ5UqvIatD7XKEtZqmoEO
         0jvw==
X-Gm-Message-State: AOAM532PA9ef38iIsxAOFS1SKvg0pU4WzB8pR9FDGCVB4Jfub874S/ID
        6RNf05nJflCbLYHvbQuvSX4=
X-Google-Smtp-Source: ABdhPJyZO60M+4sOJt2W6uah/Chg/QtiqPXxAQdHgedqUBt6LK16u1DV1W0E/JyQ2HqQKTG4xAm7FQ==
X-Received: by 2002:a05:6214:b27:: with SMTP id w7mr7818178qvj.34.1616131702362;
        Thu, 18 Mar 2021 22:28:22 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id u11sm2900032qta.91.2021.03.18.22.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:28:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     zbr@ioremap.net, gregkh@linuxfoundation.org,
        akira215corp@gmail.com, ivan.zaentsev@wirenboard.ru,
        rikard.falkeborn@gmail.com, unixbhaskar@gmail.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] w1: slaves: Typo fixes
Date:   Fri, 19 Mar 2021 10:55:54 +0530
Message-Id: <20210319052554.966-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/mesured/measured/  .......twice

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/w1/slaves/w1_therm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 976eea28f268..d3b4ceb07622 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -63,8 +63,8 @@ static u16 bulk_read_device_counter; /* =0 as per C standard */
 #define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
 #define BULK_TRIGGER_CMD    "trigger"	/* cmd to trigger a bulk read */

-#define MIN_TEMP	-55	/* min temperature that can be mesured */
-#define MAX_TEMP	125	/* max temperature that can be mesured */
+#define MIN_TEMP	-55	/* min temperature that can be measured */
+#define MAX_TEMP	125	/* max temperature that can be measured */

 /* Allowed values for sysfs conv_time attribute */
 #define CONV_TIME_DEFAULT 0
--
2.26.2

