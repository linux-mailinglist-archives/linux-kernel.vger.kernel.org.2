Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612B641050B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbhIRINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbhIRIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:12:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 01:11:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so18944520wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I0jcC2Su8d4wIhHItiadcLqrply5RR3Vd1Gurt9GSRs=;
        b=UcZL9sEWvQ5JVT4YGOZ4TS3qFdPdIkM0viO7FN2rHd5FzCcaSnYv0ifNp5uiD1FdbX
         E3NXVQ0lqKNzsDUVEUT6CCaoAqbzJvtNOb72P84H/NfvE3fOBzMxmquzpyCbU72XriAS
         o2sLM1yNBI90AGUjR/EwAbq7/2npwHlQtGOqMQJmq7q1pShRAnBXcGRf7AkM+bMjLkcD
         pvAwXFW4K59nFcLP1F2MOb7Oamr15Q/4QclEF2RsjnPyDZqCBQ59MiNkkXepOA2bV9RB
         ROhDxil5/9icFprRLgusH3zB/SH13V+v5ghNbLyJrRnfCZoJQ3jnFwvQKW910l6S5OFc
         M+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0jcC2Su8d4wIhHItiadcLqrply5RR3Vd1Gurt9GSRs=;
        b=andWEkjuRGckv4uNtxfV2O0CivIVKxqooEEnDqkmAjRr2p/CmY4oQgxSzXXzad6K1f
         fCyBflgX6yW8SjoxZSdbl413n7n8tMxNWclmlgpVns854ItX0A5LSi/2xyn4jj8S2wY6
         hSiCXaRrD24AgozOrD1qMnIXnLoh5Q8Kdd2LEkNCUGWJ5kWrV2iH3AxZxJ0+o3TmmwTj
         HseIEuZrO47uz1ZezoD0gDYmXsX7a7efCK23DgX9dHkT9m7I1GlbFYeo6Ya+k075gp66
         EUrC+wXL7jqke220xErvfcu/kFlIoaQDdr8io4VSLKqPEkgNhCgB56LVR8Ry14DzSvmb
         OWaA==
X-Gm-Message-State: AOAM533r8ddRdGrc22hSkqShjXE12c2sjfcbZ8m1pNzwQZLgwEN/iHLy
        t9LjLy9wfVFPM0xoxilBgSUwrv+cDij4TA==
X-Google-Smtp-Source: ABdhPJxtuu2TYPeOHkPytgfWQSXeh/haNUP1dPrhVkPe/F43jsHi9yrNlqGfWWENI5RbXlIGQOHNRQ==
X-Received: by 2002:a05:6000:1562:: with SMTP id 2mr13895503wrz.36.1631952691417;
        Sat, 18 Sep 2021 01:11:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id d17sm8918760wrp.57.2021.09.18.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 01:11:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: clean up indentation in odm_RegDefine11N.h
Date:   Sat, 18 Sep 2021 10:11:20 +0200
Message-Id: <20210918081120.2798-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918081120.2798-1-straube.linux@gmail.com>
References: <20210918081120.2798-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up indentation in odm_RegDefine11N.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/odm_RegDefine11N.h   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11N.h b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
index 3e2fd6b1c793..82a602b39cc7 100644
--- a/drivers/staging/r8188eu/include/odm_RegDefine11N.h
+++ b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
@@ -10,14 +10,14 @@
 #define	ODM_REG_RX_DEFUALT_A_11N		0x858
 #define	ODM_REG_ANTSEL_CTRL_11N			0x860
 #define	ODM_REG_RX_ANT_CTRL_11N			0x864
-#define	ODM_REG_PIN_CTRL_11N				0x870
-#define	ODM_REG_SC_CNT_11N				0x8C4
+#define	ODM_REG_PIN_CTRL_11N			0x870
+#define	ODM_REG_SC_CNT_11N			0x8C4
 /* PAGE 9 */
 #define	ODM_REG_ANT_MAPPING1_11N		0x914
 /* PAGE A */
-#define	ODM_REG_CCK_ANTDIV_PARA1_11N	0xA00
-#define	ODM_REG_CCK_CCA_11N				0xA0A
-#define	ODM_REG_CCK_ANTDIV_PARA2_11N	0xA0C
+#define	ODM_REG_CCK_ANTDIV_PARA1_11N		0xA00
+#define	ODM_REG_CCK_CCA_11N			0xA0A
+#define	ODM_REG_CCK_ANTDIV_PARA2_11N		0xA0C
 #define	ODM_REG_CCK_FA_RST_11N			0xA2C
 #define	ODM_REG_CCK_FA_MSB_11N			0xA58
 #define	ODM_REG_CCK_FA_LSB_11N			0xA5C
@@ -28,7 +28,7 @@
 /* PAGE C */
 #define	ODM_REG_OFDM_FA_HOLDC_11N		0xC00
 #define	ODM_REG_OFDM_FA_RSTC_11N		0xC0C
-#define	ODM_REG_IGI_A_11N				0xC50
+#define	ODM_REG_IGI_A_11N			0xC50
 #define	ODM_REG_ANTDIV_PARA1_11N		0xCA4
 #define	ODM_REG_OFDM_FA_TYPE1_11N		0xCF0
 /* PAGE D */
@@ -39,9 +39,9 @@
 
 /* 2 MAC REG LIST */
 #define	ODM_REG_ANTSEL_PIN_11N			0x4C
-#define	ODM_REG_RESP_TX_11N				0x6D8
+#define	ODM_REG_RESP_TX_11N			0x6D8
 
 /* DIG Related */
-#define	ODM_BIT_IGI_11N					0x0000007F
+#define	ODM_BIT_IGI_11N				0x0000007F
 
 #endif
-- 
2.33.0

