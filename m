Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8084D326FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhB1BHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 20:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB1BG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 20:06:58 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B1C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:06:18 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g8so9291675otk.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNDK31GfhaZ5nts0uVy+F5CRFC//iVXkXv+G42hpuP8=;
        b=Ac80NqiiAcpgSuoKUgfjMVQuUa8+QgeTvAwGg5NsOzb4iI/OhPBzXCFRWfgQa/XZkZ
         Q1/C0iK2q9t7xcN9xiGEqVe9h+a4RYGYnqkD2NyGc6WkxMcJaWg0bG2mmJrps6bnMnCQ
         qQe3H8wzHGzbbdbEtPbqHCSDPzHMbOX6LKE0lN5RYq9e5aySt0SB66t0LVRRDoAZ6VTY
         L98YdbdEPsaCOi5Ido+w62EK2Q5DEsMpU6CxSsmibxmGEj8tFSeU+Am1KXtAcqd15p3y
         6ll0o9CtjEl4qNOULsXnLvhzlul5e3LuOJG6zkYNHrYLDfgdPLc53MPlXVHqMBAMUxgf
         nuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNDK31GfhaZ5nts0uVy+F5CRFC//iVXkXv+G42hpuP8=;
        b=YxevSQVWbtVBSTDtvqAq81rBg10fbewfAUgnAM0x4MUwbzHx41l//JyqMVk/ZZYic0
         w35uQzVBs/7+/Hi10gPZP8busK5HstzXxFX+pdcbUJv4I4mYy4J1rMtkPETGB5XNbz9e
         Bg6b33fgIOs88xD8kfo8RXORcajf1JcDKya0R8CvRIQWjteJKwGGX8vOqXordkErVFdO
         4ApjGCcZdMSHWd40ZDVVg0lR1hAy3L6k0xL7AkY0lPOl2nswI44r2atNQaF2FjJE/8UL
         UBWGQn4gWx79935HBlVnpvH9w/QrS7eJcceCYxosqO3LH9Uaz8Cv46jhN0ESwUi87uZK
         3BDA==
X-Gm-Message-State: AOAM533A19otSJ6//eG89Hz+3MgLLdfDcU3ZwJ3TTl9+2bCRZJZS7IqU
        EqiqkpDEakbgEbFoAhCyWIQ=
X-Google-Smtp-Source: ABdhPJw24NON9FnAIXdf/3n8JglhXjh0L3cMsGVdSoxzZy197BpVCIbF9KwZOLjUlgeO7XzfeWNlnA==
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr7867664otr.356.1614474378004;
        Sat, 27 Feb 2021 17:06:18 -0800 (PST)
Received: from elysium.agostinelli.home.saggio.net (2603-8080-4208-0193-f7c3-366a-30e3-d407.res6.spectrum.com. [2603:8080:4208:193:f7c3:366a:30e3:d407])
        by smtp.gmail.com with ESMTPSA id k18sm2870332ots.24.2021.02.27.17.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 17:06:17 -0800 (PST)
From:   "Darryl T. Agostinelli" <dagostinelli@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        "Darryl T. Agostinelli" <dagostinelli@gmail.com>
Subject: [PATCH] staging: rtl8192u avoid flex array of flex array
Date:   Sat, 27 Feb 2021 19:06:14 -0600
Message-Id: <20210228010614.162998-1-dagostinelli@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Undo the flex array in struct ieee80211_info_element.  It is used as the flex
array type in other structs (creating a flex array of flex arrays) making
sparse unhappy.  This change maintains the intent of the code and satisfies
sparse.

Signed-off-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 39f4ddd86796..43bb7aeb35e3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -951,7 +951,7 @@ struct rtl_80211_hdr_4addrqos {
 struct ieee80211_info_element {
 	u8 id;
 	u8 len;
-	u8 data[];
+	u8 data[0];
 } __packed;
 
 struct ieee80211_authentication {
-- 
2.29.2

