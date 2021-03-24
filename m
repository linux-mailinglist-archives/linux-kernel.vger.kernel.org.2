Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB2347F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhCXRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbhCXReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E7C0613E1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l18so20400921edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SaTEj4RTZdOjBa5WGjzyPtQsvCc3pHayG7DFxx2S1o=;
        b=cfvDkL+QyMuw03bMTs6Zs1dlBvGt1Szs9b0ItOn88asw3tEJ23o32vAG2nprNZIdY1
         /siEXJ/WQ8IqsSQyHcx1I0iR8lM5ytepWCfZ29b/VYmt5xsuClfsffRlGXXu2Ao3HHGK
         /A8xxJjIyM0rcKZqZwu6XmEoTk4TTyJ2Pm/stY03leBC8SaxMY4rLiVl3GaragheVwx7
         3rbUlxvMarIcrjo/mUpLDK5Z/Lg5c4WtfbXqflVOhoFvc5QFC2Xmizv/u3gsUUPRfNCj
         MetuLv7tHhqHdP7LNuSsWRgUoSkHggypVZdw9HUkN5rWvkx8uFyiMPZbRJ8K40dglx00
         oqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SaTEj4RTZdOjBa5WGjzyPtQsvCc3pHayG7DFxx2S1o=;
        b=IjXADdG5SyINqJTb28dNNSpXbneGzFgYd+5K3tMSRzZrLr6ofONl9DtZ9IfaHSuCmQ
         LsgufqZVaF97Vsmd7bUVqsIv/If9pFstS4E194iZw2L1LkE2IaLhN5JMO9bQoTZSK9ER
         ugUp19RzSxt6SLgZfZwn7coSxz63vMuklG1utdRxIbVWerIBQCfPwSt3mULbjPK8FEVs
         jx5v8ohDAjb0YyK6851ZXOc1tWqQCA9XNKlSyygeDvwdNLDQtbnuowFpsNF7NgQPBVIA
         SaVifS3Cxk+FeG0nokjT0Xfbw3feieec7CRshwoOberNkvR1K5305NYEwfo8Exs0FHsl
         yARg==
X-Gm-Message-State: AOAM530X6PxtPcshshkbPA04/ZpV0mLQkbKXAtTeeARzdXZ+idmQMpsT
        uOcspgSwuahynzWEdLRkOnZGE2FA/B+YOA==
X-Google-Smtp-Source: ABdhPJzbP13FGjsMEuWXswh25w1dlfhwzJLC/jdccNUJbOu/BhohpWlvimC9u+JtsVmFJmWdMQLkOQ==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr4729387edu.57.1616607257536;
        Wed, 24 Mar 2021 10:34:17 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Masaki Ota <masaki.ota@jp.alps.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 09/25] HID: hid-alps: Correct struct misnaming
Date:   Wed, 24 Mar 2021 17:33:48 +0000
Message-Id: <20210324173404.66340-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-alps.c:113: warning: expecting prototype for struct u1_data. Prototype was for struct alps_dev instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 6b665931147df..2b986d0dbde46 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -74,7 +74,7 @@ enum dev_num {
 	UNKNOWN,
 };
 /**
- * struct u1_data
+ * struct alps_dev
  *
  * @input: pointer to the kernel input device
  * @input2: pointer to the kernel input2 device
-- 
2.27.0

