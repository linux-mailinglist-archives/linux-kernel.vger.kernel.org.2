Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D461634AA09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCZOgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCZOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4908AC0613B5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so3121409wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SaTEj4RTZdOjBa5WGjzyPtQsvCc3pHayG7DFxx2S1o=;
        b=YYE41tgmks1szX8Y1bR3nupGt01CbJK5hySL9qrXdTmsJ7+++1TBQi+K0Q4loXrl+b
         ggEyIdSV/O3aTSGuQa5gpW7HCNOvGG4pRhlga3TQZ6GMkX/sAdlRXyP7So29PlkBF2QD
         yqezQFHKwzU5du6L18QCyjIHDfPCi9r5dI7K1r+UzUfR8HJL/1ECB/m0fAmuyuFNRVPA
         XXIbP7dCYCG1GDyGlSNXgXq/+2Iky09szLpz8JUF49HdF2zvDiaE7+5UH1L7LUGNaUji
         dkrGaSU9pyZQSI5+GKPeD/1rBCEm29oEZDVb03TfNDQKIMBsFZUBy90umgS2hLs2GHxe
         bY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SaTEj4RTZdOjBa5WGjzyPtQsvCc3pHayG7DFxx2S1o=;
        b=XHxIzxLz/0Cit/X1FNZrqNcxxhaawTCtYSJXA9/EQ4UmuQEh50ZMAlJY6mRM6JOU7s
         hXiRAKaLYE5mhkmD+sjhEnTfaRe9dZKFmay7kZ+shf0k6ktSSjfvp0VWTjdjQmjwNoOS
         GECm6yXmbiQuOeYql3Oxjidmhb7p4T+Vx5MbXb7KGwXkxM1OuoVi4DRMqBz8qhn893e4
         1zKZlyzICPRtZPSM/bokCANLxhqIGJn6/drgpOAfX16xoK90i+8SXX2aYqzmXO+XNNn6
         zZo5anHu8ww6Pj2+13eXSRjw+YFWnWUdMws8MPL3iOyxvwjIJPIloh762icuQaAhEBUv
         uJFA==
X-Gm-Message-State: AOAM531K+1GmdhK5i6vct+FvmcGrM6jOskQQNtVHeL+/3i5soIbgl4iG
        YIzMcpH6blx+GJJpAq+4ClGC6w==
X-Google-Smtp-Source: ABdhPJz5f/KrNiqbesoFd5oKM3CYtNcIMzjaUKyZXEZWay2H6+zQTJ7SicPowiz8MnzODgFqK3MLyw==
X-Received: by 2002:a05:600c:4a06:: with SMTP id c6mr13421638wmp.35.1616769311064;
        Fri, 26 Mar 2021 07:35:11 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Masaki Ota <masaki.ota@jp.alps.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 09/25] HID: hid-alps: Correct struct misnaming
Date:   Fri, 26 Mar 2021 14:34:42 +0000
Message-Id: <20210326143458.508959-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
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

