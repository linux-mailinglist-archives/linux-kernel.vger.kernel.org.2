Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F69534AA12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhCZOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhCZOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB103C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so5871330wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccGk85Qb+R/2lzURMS8M3ry2sPIqf4RAKxkbH0HWWQ0=;
        b=MQ8AqYo029jcxTkqz0fgQ0hfg9qfIz0zHA/0DYIrzjy5Wy0fxLFqL+KsGKFznObPEk
         CEeJjoFgVL5bXtmaxF6i5/cyoHXom73K7cqUKGzbk9QTmgdbq+teGlkGm4pZr4ZybdwT
         5M4Nrc99xI/Tbls+jXiZTKmShFx2ZtPh/eQjI6vZcIwMU5DXYst5davdCMTcHD8WD9CX
         FH3m7ourYeOpAa8FS3Fe4KlpOlDA7sygkHybN0BncjL7It8RnOPAj60NwvugvEGGShcl
         uq+XY5dFYgIuLxqwRC/ILbZA/qV13dO39oo2VtcPN8ok2bPEUxsODa+6pui5lurU3pIy
         0MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccGk85Qb+R/2lzURMS8M3ry2sPIqf4RAKxkbH0HWWQ0=;
        b=GbfGMJUlA2Uas76t+M8S5lCt/djKzpksQ41wrP2hKdSSAq8R4wnOeX2mmzPIBwAdvC
         Fk2KXyD+TOYYlpBO6AMzVWaENQKBmZdrfsxxBW5KAxrH/jbgLqsxLvWlgxL844MPPb9+
         wE0U9nFihEaTxgQLjmZKlNF+B/NLlvaog8jDM2uT843F09KJMb0rfk9Xhcy9SOmvhgvD
         bVsDftykSCNRoG4ytiD6fRKIqypRnMxrdRjiTJYk+n7hze4Vj6o8JMQpn4LmVwSPZi3e
         DNkLiyRmwlEmhNoDWSRnBgbNAedG11IGRMavSvKucugQH3l7k399QSdmzwRgIZHBObO/
         9xAQ==
X-Gm-Message-State: AOAM533SkWUgTHTNscE0+aaqCIhgbCC6H0w5JyucwPZqdU9RLfhmDKlj
        X+xnKqFClZ/6s501nxSyk0GuAg==
X-Google-Smtp-Source: ABdhPJzNOI+5IVpNAxH3g74ZP94Kypg0a6A8+oRK0jJF2OD8NoyZx0Ghj9YnEuQ1ML1qp6uREg4qkg==
X-Received: by 2002:a5d:4e85:: with SMTP id e5mr15103731wru.218.1616769323414;
        Fri, 26 Mar 2021 07:35:23 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 21/25] HID: wacom_sys: Demote kernel-doc abuse
Date:   Fri, 26 Mar 2021 14:34:54 +0000
Message-Id: <20210326143458.508959-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/wacom_sys.c:1505: warning: Function parameter or member 'wacom' not described in 'wacom_led_next'
 drivers/hid/wacom_sys.c:1505: warning: Function parameter or member 'cur' not described in 'wacom_led_next'

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8328ef155c468..57bfa0ae98361 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1495,7 +1495,7 @@ struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group_id,
 	return &group->leds[id];
 }
 
-/**
+/*
  * wacom_led_next: gives the next available led with a wacom trigger.
  *
  * returns the next available struct wacom_led which has its default trigger
-- 
2.27.0

