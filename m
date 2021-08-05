Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B53E1CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbhHET11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbhHET1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:27:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC54C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:27:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso6236576ota.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2GkonpAjzQlhehYjYguHvSSepjeMUJwajjpApl9URk=;
        b=W23+wiO5tB+1OZ4oOv00K9e+qwTM4+xZ+P7BVed3D2ocK1prqmZ8PxbFCn4BjpH2zD
         UgT7nMQY3uwWTZsgvVesP2pL1oN9TEexyatyWy45scoQJyUwQZFNRHQCVwV6ELQNguZG
         zl7WWHnszZt58bqeJ+WcOuqLaTdEhg72IMhJkeiWoVm03tgkLqmptdunWZqfXBezgdg2
         GAt8+Uplr1bL8FOrhLlDOIbKPPMwL/zVSOxY9oUcgLQ5sjFR/f6+2uby2iOzosgVA186
         8REAhmNCAG4s5stxmsUToIlo4FvKkmrZ/1H8npSZbZyrEq5oQTkYwXj+6r0A8OAhIYim
         M8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+2GkonpAjzQlhehYjYguHvSSepjeMUJwajjpApl9URk=;
        b=Fia4iwgNpmHkSzKFbR7gEYWdYeuuZSq5R0Tqll2oAtF4qUWq+6Jv3V5/rf05Pa36yi
         lszVpG3EnZNMNDbzMXA9Kw0NZg8l/mNE1F1f0JrMz0YS8BXidwT2v5WM5mD6tanag5Su
         /RQoZ3/GPwNY2pkDMKT9364Ok/melfYo0ky+p8SZ+Ai+5XNLW5MPhZExjy6mQSyRNBOC
         UqUffokQEYpiTuf+EcQkDeV8q3eJHVlleycxMURlpld/JcUUTzYMbUuIHFHckZogjwWx
         tVNhWO5qKw53DHEW9KeVPklpdF9K29+SicN0Ny5aOpDBIhOnBMJs6iEPaIl/p6VwWzCP
         JqGA==
X-Gm-Message-State: AOAM530WKVjQC4I2gxttC11zTfiO+ZEBgkJs7GFabGZIlcZ2SNw0yKFM
        /H0w+4qcPXan91vkzBU5Dxs=
X-Google-Smtp-Source: ABdhPJwWQwMCrKmmuzV1VF7+FHaetNl3cJrnXurZuRmf3MAgkZieDvvDhHtnLOC6g2ym3BjJNnDqdg==
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr4817944otl.85.1628191622003;
        Thu, 05 Aug 2021 12:27:02 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id n7sm1143479otf.45.2021.08.05.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:27:01 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 6/6] staging: r8188eu: Remove wrapper rtw_sleep_schedulable()
Date:   Thu,  5 Aug 2021 14:26:44 -0500
Message-Id: <20210805192644.15978-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
References: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wrapper is never used.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/include/osdep_service.h |  2 --
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 1d1889539973..7e002009f9a0 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -229,8 +229,6 @@ u32  rtw_systime_to_ms(u32 systime);
 u32  rtw_ms_to_systime(u32 ms);
 s32  rtw_get_passing_time_ms(u32 start);
 
-void rtw_sleep_schedulable(int ms);
-
 void rtw_usleep_os(int us);
 
 u32  rtw_atoi(u8 *s);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 79f12b0d643e..9f097f2b3ddd 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -116,18 +116,6 @@ inline s32 rtw_get_passing_time_ms(u32 start)
 	return rtw_systime_to_ms(jiffies-start);
 }
 
-void rtw_sleep_schedulable(int ms)
-{
-	u32 delta;
-
-	delta = (ms * HZ)/1000;/* ms) */
-	if (delta == 0)
-		delta = 1;/*  1 ms */
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (schedule_timeout(delta) != 0)
-		return;
-}
-
 void rtw_usleep_os(int us)
 {
 	if (1 < (us/1000))
-- 
2.32.0

