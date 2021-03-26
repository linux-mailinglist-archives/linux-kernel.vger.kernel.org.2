Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0E34A3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCZJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhCZJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A901C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so4917251wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGwwT0pzC11+kIcwob060rB+3Es+ykFc90wh+44nCTg=;
        b=c1Unu8+Etr29sYP5S3SdLtnITsKgONw84a/korkFJZZLHgtG3hrL7JuUa9ypXY5Hn0
         7nksviisYwU6Op19WpBW1nRuaRVZ7RgG6aN9OZvyQl8E/Ney0jCBgHXV/OgzRQ1t0twW
         w3/nb4fS2VtgfX/Jxy+XidHTDWtMEYDUSwVRYuFYVyRD+9JI+SMvDmNvMCjE8b8KSvm8
         xwhsukLTXRTblM5wOoyosgzuSb4ZlOdRUHJ8LBw82gtowuai05j4IMhfT6rXW3mDTWgg
         8xvszvWqJCCyUO9t6rlQwNw0nEY0pYEOqU+8eOcYKybXq5MgKVYzzPWtSnlyOHiV3T4O
         NK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGwwT0pzC11+kIcwob060rB+3Es+ykFc90wh+44nCTg=;
        b=ijGA+r1Y/H84t+2vuZnGDMvfgkxQsVbuN1D6UInRS3MAqUMKoymXtxbb7NTwmOH/96
         XxE2coxxhqiQ8VzGVSmBAo+z22EZI16BX2cU5xB+KM4jZQWAnPHJcMeIK1i/0D6jg0rz
         oTv1Qm4mTJU3wLYbu/VmytXRMlEW+R6dWMx3Yq3wkSrtifESgOE/bt5Qwk/CNzKsMpB6
         yGOxnFlffqDX/Ftz1DDaKKcxZ1KlroB4XQyHNLKXooB2G1ScI2Xk6yqS60byisjhsmEQ
         y+eYHu1SOJ6phlPQBM7/yYliRgM+aXlKwiVIvZHdhHiz9jDWwu/A2LwJu3satZ6SGs7B
         Sw0g==
X-Gm-Message-State: AOAM532QoufXP1L9nXOF977fuLhdFU3Q7QMlcV2HxZ4cLBB5aboDMTmi
        BxBkKW4IwIwxr/Bf7/UtggBF3Cz5oIk4og==
X-Google-Smtp-Source: ABdhPJxf1Sdlt0bYaUK4lkEj/yIiAsCwS303Gwrh2T4lN2pO/9tJNCbQddNEFamAR3BbSCSA/TgcVA==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr13601095wrv.222.1616749795205;
        Fri, 26 Mar 2021 02:09:55 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id o8sm1152269wmr.28.2021.03.26.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/15] staging: rtl8723bs: put parentheses on macros with complex values in include/hal_phy.h
Date:   Fri, 26 Mar 2021 10:09:16 +0100
Message-Id: <44f6d3e16bd16581212ae665e0f22925070b2b42.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with complex values should be enclosed in parentheses
27: FILE: drivers/staging/rtl8723bs/include/hal_phy.h:27:
+#define	RF6052_MAX_REG	\

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy.h b/drivers/staging/rtl8723bs/include/hal_phy.h
index 90bb5d784674..5aec04f705b1 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy.h
@@ -25,7 +25,7 @@
 #define	RF6052_MAX_REG_92C			0x7F
 
 #define	RF6052_MAX_REG	\
-		(RF6052_MAX_REG_88E > RF6052_MAX_REG_92C) ? RF6052_MAX_REG_88E : RF6052_MAX_REG_92C
+		((RF6052_MAX_REG_88E > RF6052_MAX_REG_92C) ? RF6052_MAX_REG_88E : RF6052_MAX_REG_92C)
 
 #define GET_RF6052_REAL_MAX_REG(_Adapter)	RF6052_MAX_REG_92C
 
-- 
2.20.1

