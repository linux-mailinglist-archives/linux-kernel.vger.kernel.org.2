Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5C31E8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBRKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhBRJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:22:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41D5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 01:22:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so2106062wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aX/bNkP4QxZHef1wuHRDIoy68LBSmgsRibOTvBGlINE=;
        b=L/BnypvL9THTX0KZhWTKp4IRSirvi3m9JYun8pmwvSx5NanvrZGCKkO2GgYl72+gxa
         DiNhDkBL8T/SjEY04j6sQLadVgDP0Mq2OBPOnM9IRgMFIoArFaBIn5Qfq5nw4ykgE5Ni
         KekQbblqaBPL2wDGurzqESlaZmwNYDWOjJTNyH44K5xoOqnn6ft5Xx+kLXXDaWLWwPyz
         CunSyQ8AR1c8IoYMv0qt1DzoChFOGivNiLglQDIuejceG8rD1lMSIS13lT6B4BwuU9Q0
         SyoI8QduWu5GRmnqK6NoWZQeNlIxPnMg8kDzYAnizR1dupxSvoZsmYq87R9UfpV9ZvU7
         J9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aX/bNkP4QxZHef1wuHRDIoy68LBSmgsRibOTvBGlINE=;
        b=TU43nqnraggGXrPkfx7o0PGl0hNFFumstfgjstlYe1d0CaM1y9vrUStIqw+t++mCfn
         jD9l9meXwmKkz2L+9gQjqAYhFzWQx9Taf3cHGgpO+cw8KStaet9KUi/6kziB+NzAVZ1/
         Ypwkm3vtvFQhU+wt2rz39hnVq/BoiZxFnfBwlZjBrjemGTPTmVvYPQUvApskWiUqdIIt
         F+ymm50XgOcRJKaFa05IiUVavQ1AGVWVThzDBHxbYqCWB9A+4MJansb6qv/f1TmDzhzh
         ZgqWp9WqsSWnWcmdGBZXu7UN1nGLVmSEPWNZhMY6IP6GuDhjv9az7MtPfGfMiDo6C9Fy
         7RsA==
X-Gm-Message-State: AOAM531M332WixTnCUGX7gjahtyUz/zDAiA8uVmFB/Yb80Re/tSfq9io
        aqOjjPRvh5lwN2XsUKR+oG0=
X-Google-Smtp-Source: ABdhPJyj8xpNiVfMb6N+d/9wb4Lie3ISntTThXTyfS83PoFBVobPxqzSTgA6VylA1dXI12GMLi8w1Q==
X-Received: by 2002:a5d:5149:: with SMTP id u9mr3401833wrt.348.1613640124563;
        Thu, 18 Feb 2021 01:22:04 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id a9sm7697402wrn.60.2021.02.18.01.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:22:03 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:21:54 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        johannes@sipsolutions.net, arnd@arndb.de, kuba@kernel.org,
        gustavoars@kernel.org, wanghai38@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH] staging: wimax/i2400m: don't change the endianness of one
 byte variable
Message-ID: <20210218092154.GA46388@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is wrong to change the endianness of a variable which has just one
byte size.

Sparse warnings fixed:
drivers/staging//wimax/i2400m/control.c:452:17: warning: cast to restricted __le32
drivers/staging//wimax/i2400m/control.c:452:17: warning: cast to restricted __le32
drivers/staging//wimax/i2400m/op-rfkill.c:159:14: warning: cast to restricted __le32
drivers/staging//wimax/i2400m/op-rfkill.c:160:14: warning: cast to restricted __le32

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/wimax/i2400m/control.c   | 4 ++--
 drivers/staging/wimax/i2400m/op-rfkill.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/control.c b/drivers/staging/wimax/i2400m/control.c
index 1e270b2101e8..b6b2788af162 100644
--- a/drivers/staging/wimax/i2400m/control.c
+++ b/drivers/staging/wimax/i2400m/control.c
@@ -452,8 +452,8 @@ void i2400m_report_state_parse_tlv(struct i2400m *i2400m,
 		d_printf(2, dev, "%s: RF status TLV "
 			 "found (0x%04x), sw 0x%02x hw 0x%02x\n",
 			 tag, I2400M_TLV_RF_STATUS,
-			 le32_to_cpu(rfss->sw_rf_switch),
-			 le32_to_cpu(rfss->hw_rf_switch));
+			 rfss->sw_rf_switch,
+			 rfss->hw_rf_switch);
 		i2400m_report_tlv_rf_switches_status(i2400m, rfss);
 	}
 	if (0 == i2400m_tlv_match(tlv, I2400M_TLV_MEDIA_STATUS, sizeof(*ms))) {
diff --git a/drivers/staging/wimax/i2400m/op-rfkill.c b/drivers/staging/wimax/i2400m/op-rfkill.c
index fbddf2e18c14..a159808f0ec2 100644
--- a/drivers/staging/wimax/i2400m/op-rfkill.c
+++ b/drivers/staging/wimax/i2400m/op-rfkill.c
@@ -156,8 +156,8 @@ void i2400m_report_tlv_rf_switches_status(
 	enum i2400m_rf_switch_status hw, sw;
 	enum wimax_st wimax_state;
 
-	sw = le32_to_cpu(rfss->sw_rf_switch);
-	hw = le32_to_cpu(rfss->hw_rf_switch);
+	sw = rfss->sw_rf_switch;
+	hw = rfss->hw_rf_switch;
 
 	d_fnstart(3, dev, "(i2400m %p rfss %p [hw %u sw %u])\n",
 		  i2400m, rfss, hw, sw);
-- 
2.25.1

