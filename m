Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACB382273
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhEQBEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEQBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:04:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A5DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 18:03:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s4so661723plg.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P04Mp5QYOtOCf0Wq1drrnM2CQ1CyUVKhqFzoAegTI1M=;
        b=iskUpT4WvWGOst0ckTkAHgyoAwGlPZ2UjtDQ8jwxIMuMCMpJEA2+9/xBMxvHriFfFJ
         KwREz9rM5sh5FzE6V7wESSEfEO/syInkjezZzRXSom1pz2BZ7Vjxk4U562FkPSAwImUG
         Gzee8Ik8zk8wpZAavc3G7UsTuivyGYxMXGCfKEER0xEy67hFOR6pRshhWxpPKpc7IZTc
         +EX7lo2DofIIWmhF7H5oAEi81fpQogqLtXZ8BGDFN2JvexYBuCXzvy3ukPy8VKEwDAMD
         +fzf16DO0U4fF+QBcA1Lb8d+nhpf7PFPIwDBf/0EPchl7Dqpg3DIT3xYYHEcegUcrODr
         kjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P04Mp5QYOtOCf0Wq1drrnM2CQ1CyUVKhqFzoAegTI1M=;
        b=fG2ouFUlB99UZkL+Xq/daHTrOfEbY0kaUAAlAiRBg6oVdQwNWvFh17lM2wGlccf0Dp
         c/IQUgiObjNvKh656LuOj9SWFcsahrZTqx4vnyAGqukli5fVbNmqTDYuSO76FB341pRF
         sdBLZ1TkwKLndeir3N31VGbfS9XWmrqvOptMUHWoE2KwvgOaRoZeoEDmfCKjMlj5lONU
         ki42L4gTA9SUMn+3dYly7MVb0+/ayCnikftl0X2LGAesg97PQCRt0b/DpCA3zi5Uj4KA
         1LV1yN4T2wILoCyNk8VkFdq7FFrmMrX0YlVhktw138WMzfh/wzr9H7qefRtYqppDl7WC
         3brg==
X-Gm-Message-State: AOAM531Zo0kDd4AE05MqsftCu0PcwyJ4k35FW1A8/c3qiyIVDLdg8g2I
        yURlH00prgWFVFDJYYi07LdadA==
X-Google-Smtp-Source: ABdhPJydegjrwmpwpCaDoxu9Ak0qEs4jTsSG4KGgGgJ5Wg3tPcU+K6E+3ZVvFYyXhmKsZpkDJOF1cg==
X-Received: by 2002:a17:902:ea0c:b029:f0:af3d:c5d6 with SMTP id s12-20020a170902ea0cb02900f0af3dc5d6mr12411519plg.45.1621213410663;
        Sun, 16 May 2021 18:03:30 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 187sm8334434pff.139.2021.05.16.18.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 18:03:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: fan53555: Cleanup unused define and redundant assignment
Date:   Mon, 17 May 2021 09:03:18 +0800
Message-Id: <20210517010318.1027949-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517010318.1027949-1-axel.lin@ingics.com>
References: <20210517010318.1027949-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCS_VSEL_NSEL_MASK is not used so remove it.
Also remove redundant assignment for di->slew_reg.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index d582ef3a3aeb..f3f49cf3731b 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -56,7 +56,6 @@
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
 #define FAN53526_NVOLTAGES	128
 
-#define TCS_VSEL_NSEL_MASK	0x7f
 #define TCS_VSEL0_MODE		(1 << 7)
 #define TCS_VSEL1_MODE		(1 << 6)
 
@@ -362,7 +361,6 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 		return -EINVAL;
 	}
 	di->slew_reg = FAN53555_CONTROL;
-	di->slew_reg = FAN53555_CONTROL;
 	di->slew_mask = CTL_SLEW_MASK;
 	di->slew_shift = CTL_SLEW_SHIFT;
 	di->vsel_count = FAN53555_NVOLTAGES;
-- 
2.25.1

