Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4453A501A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFLSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 14:23:03 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:36397 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLSXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 14:23:02 -0400
Received: by mail-qv1-f44.google.com with SMTP id im10so17468987qvb.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9oAAhhR1hjmXaKhdSjE/z7oNVThq6q341+U+T0q1uo=;
        b=Iglrcm9IzKV2LkOwmVFFysbDdMVJBMOrlqfQTj5omAgGxNlaxbRHY/LhArTMz5nXu0
         FBCHQxn3aal/atB5lXZCoZUmCUHSnnJlRqiWQTn8C1klf8I8ZGQR8LBIzMbzIoDXAgYl
         OX81MIpQYNmJvYPnmqlOtolRXjCX6d5C7qHhsg17sdb4oqsFbNQzr9Wui4qeOwGEF1N2
         pJDWn76NbRC20TqSzkuCgVGNjp4BFL2AMRL2aS7Sp+3bqhRpLParWAj/1NlZrYRT7TKz
         IEzkOzg1PxKZH4npoazBCNO0GAx0W6Vqve/yYMRFuAKTSlEr5LzBEdDkK6N3WWbXfJTr
         l9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9oAAhhR1hjmXaKhdSjE/z7oNVThq6q341+U+T0q1uo=;
        b=Ky/l9yZvq3qLkW3EXJtIUFG7kH8Y4YSo4wuZxq0p74yY2NoCwctLLrUu4XZhqK4098
         kHiI5y4IfywTH15JAtu4PWQ0H7Rtae9kOU1aH0t7VoFuX6AFHn96FnkY81eCuYd2mj1a
         ERGD8pmS8MQ1FJ4z9qGGDiyTTtkM6rCzNIW7HQ6HKP/meBe1MUF0nNm5GQVT+ns0K6GW
         tvrBaoH1SSbqOKvzy5HdYHZbkT/r2xlqjqRbfsQf32jbs+Fp0pvstj/RDMfvZYAZwSU6
         hbAk80pJDid6Hd5SkG265pHjKTSYJhqMUfwKi89kHVZ4UKM9iZwlYC4Ycu84niSZt5c9
         PmHA==
X-Gm-Message-State: AOAM530DNYpHBQdsF26CWZd14G7KvI95ywRgs9gjk5Kp5sZOiFYuTuMj
        7isDl+wOfzbosw0Ega8zmOi2og==
X-Google-Smtp-Source: ABdhPJwDsAO48aJ4fsqd0ev7co262nUg8lkBnrElWZfMrkKQyei+WKlDndkG/wYFoQEJOUkGmceTJA==
X-Received: by 2002:ad4:566f:: with SMTP id bm15mr10873676qvb.54.1623521988258;
        Sat, 12 Jun 2021 11:19:48 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id 7sm6966045qtu.38.2021.06.12.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 11:19:47 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, dan.carpenter@oracle.com, gustavoars@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove HW_DEF_ODM_DBG_FLAG enum value
Date:   Sat, 12 Jun 2021 19:19:42 +0100
Message-Id: <20210612181942.33817-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HW_DEF_ODM_DBG_FLAG definition from the hal_def_variable enum
in include/hal_intf.h, and remove its usage from the switch statement
in rtw_hal_get_def_var inside hal/usb_halinit.c - this is dead code
and no longer used, now that ODM_RT_TRACE and include/odm_debug.h
have been removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c  | 2 --
 drivers/staging/rtl8188eu/include/hal_intf.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 3e7f184ed39a..e3f3868b0b65 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1850,8 +1850,6 @@ u8 rtw_hal_get_def_var(struct adapter *Adapter, enum hal_def_variable eVariable,
 			}
 		}
 		break;
-	case HW_DEF_ODM_DBG_FLAG:
-		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
 		break;
diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index 39df30599a5d..2e3e933781eb 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -117,7 +117,6 @@ enum hal_def_variable {
 	HW_DEF_RA_INFO_DUMP,
 	HAL_DEF_DBG_DUMP_TXPKT,
 	HW_DEF_FA_CNT_DUMP,
-	HW_DEF_ODM_DBG_FLAG,
 };
 
 enum hal_odm_variable {
-- 
2.30.2

