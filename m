Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7B3E1CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbhHET1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbhHET1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:27:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CAFC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:27:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so6255486oto.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gZ8T2BMcy7dFxCnOjuvGhpm4zXIWSunQxQhmrdzoRs=;
        b=pEKLc3eqGPPGLUiUyLfcyKWtiWNp9WtaO1vB1Ny5vQxrG1sYqH/MEeBiPdQHjTdKDm
         WzfLLiXvcck3Nl+G5P1c3+usbsfGXblQ//yzW6F/hIipf/0Sc09hcY3J2Wcm+WigpuRH
         SwOhL/dDxTolwHwIXsPkIC+dJxm0ygnBqPEXPBm5qnFgDu8yjLs6PM5irU4zUCIQrHmW
         wNQeeHYEpllLlBnEmNpyMeJGr1MKRBiJXha90l2c+Hy2hb5Y4xbFzkei1H1faLekrA2N
         oVAJokE7bzFztF3T+EG8zZfzGMJVoBPTFZ/ofXGCK5HhHKSf58EfW3l67pslDWlsVFrU
         6PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7gZ8T2BMcy7dFxCnOjuvGhpm4zXIWSunQxQhmrdzoRs=;
        b=qpGs+hMBew2q8MsyIv0vTk64VVu0Tp1Bv3WpUEzXSeJPFKSNgoBOR7SKsFKMV5izOw
         nk18Mw0HiUEBzbhFaKh/Tw6On2tJVk76+OrYxYCCLJSwpCC6aka2X076exgQgToMhXDL
         a1wJKgCqbb1+JNZqjjMUWJfny0ts9LkxV4lXIvrcuw++/6tOIGyP+OMNNvhr4zv7S1MH
         hAcT7raJywe0E6RxMw4Pm4maKiPLpu8cxpZLlvzU810IT2g4l//fTDm/2HJJgIi2zv6m
         ICLcZ/c3fZBrFWET1SxH5eekljfVsVK1sjmdhtyZsVyN5E5LZWZJInRsqupG9iaMBlY9
         cZzw==
X-Gm-Message-State: AOAM533bSLFXsqPNDkBC2qhd/51QT0lvbW77OHnmUSi7otQIszIDjl4S
        UJeSxMafJwqaQ4aFeNnfFFc=
X-Google-Smtp-Source: ABdhPJx3GqU8WpPQnjOkERch+zV/hTZrMKNnL28CD41Aj/dgM/ZWFQ7/bH6Bl1HQHWLELpQcVyqrOQ==
X-Received: by 2002:a9d:64d9:: with SMTP id n25mr4825361otl.174.1628191620822;
        Thu, 05 Aug 2021 12:27:00 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id n7sm1143479otf.45.2021.08.05.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:27:00 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5/6] staging: r8188eu: Remove wrapper rtw_get_time_interval_ms()
Date:   Thu,  5 Aug 2021 14:26:43 -0500
Message-Id: <20210805192644.15978-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
References: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one is never used.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index eb993a030953..1d1889539973 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -228,7 +228,6 @@ void _rtw_init_queue(struct __queue *pqueue);
 u32  rtw_systime_to_ms(u32 systime);
 u32  rtw_ms_to_systime(u32 ms);
 s32  rtw_get_passing_time_ms(u32 start);
-s32  rtw_get_time_interval_ms(u32 start, u32 end);
 
 void rtw_sleep_schedulable(int ms);
 
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 2192250f21d4..79f12b0d643e 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -116,11 +116,6 @@ inline s32 rtw_get_passing_time_ms(u32 start)
 	return rtw_systime_to_ms(jiffies-start);
 }
 
-inline s32 rtw_get_time_interval_ms(u32 start, u32 end)
-{
-	return rtw_systime_to_ms(end-start);
-}
-
 void rtw_sleep_schedulable(int ms)
 {
 	u32 delta;
-- 
2.32.0

