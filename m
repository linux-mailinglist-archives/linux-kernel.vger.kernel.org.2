Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1438AF34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbhETMw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbhETMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E46C06137F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t206so9069455wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCsMWnOdNyAEXy3Xwg18ukpwjZaK7jtI0nwmBPLPlX8=;
        b=lW0prJfk4a39jMa9lG9l/NEXqi6kk1rpHg1+HfFeYUcm6MqRAGRGjdESf8jw8ueVVW
         o4LjLLYh6/U9DOVyBSPw3AdsW7hDA+uE8lR2PTvRQBnHeZCz9EexgN+DHy3o1Tu7uZRk
         Z5cI+tgdmlm8n73rTiBGaplxKpeegN3tgpwWknBg0zy3vLRKgFilnpbCVhCiPlza7EE5
         sdNtFliXgY2UHgy2CSo7ANCoChwic2c44eUjugrWxn8L7fIK0P3g0bp7sNxS7+3leUlC
         FtP+ONGi0TD7Gac3mKQBxa/5AzGBvaAVNC5aSddCT1mwFjEabFRHXYu4P12HDwN2IW8+
         72ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCsMWnOdNyAEXy3Xwg18ukpwjZaK7jtI0nwmBPLPlX8=;
        b=LQ0SSejgs8CHiZxD+SUTdHjgWJqTyh3JfAybAdx+qbSOn0G8soMdI2X2ODACYs1fSW
         BBVqmKnGlzpii9tRlinDah/G81Dt147JH6OMiPRnmVtgZzxuv38isQm3BS3OF94Ujgry
         jNmXhrBWD+R33h4LALJ1UhGVhyAUjJefpUraer1aXDIUb0AeSADSu+qIHW91bxlnpu/6
         nwa09pd9eTRIDJVKNu3ZJWJU057KvVfNqVZoxqTUc2UPIkq/oCHDhYn2tMJF6q0PoyWW
         XVQx7qa/UNE8qR1lCO5X/TSfIBTRx+bFWWvY9rr+gtPU6CG7spp0GtVzg1Bx3GiR+D3V
         3wlQ==
X-Gm-Message-State: AOAM531ptEMV+ITUTwEtI4dq3Af687ExRpfToRPeXcv5rs2AELrUK5FF
        fjDA1bwGL6Ngr0/YImTIE3JPXg==
X-Google-Smtp-Source: ABdhPJy1JTtR9MLjS6DEI2bGC3VACS2NmTId84lFdfjz9khUItajmu40581FJxqBPEN+BRSVXIiwqQ==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr3850503wma.21.1621512852519;
        Thu, 20 May 2021 05:14:12 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Jerome Glisse <j.glisse@gmail.com>
Subject: [PATCH 14/16] char: agp: uninorth-agp: Remove unused variable 'size'
Date:   Thu, 20 May 2021 13:13:45 +0100
Message-Id: <20210520121347.3467794-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/agp/uninorth-agp.c: In function ‘uninorth_create_gatt_table’:
 drivers/char/agp/uninorth-agp.c:372:6: warning: variable ‘size’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Jerome Glisse <j.glisse@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/agp/uninorth-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 62de7f4ba8643..ee67d587cad1e 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -369,7 +369,6 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 {
 	char *table;
 	char *table_end;
-	int size;
 	int page_order;
 	int num_entries;
 	int i;
@@ -383,10 +382,8 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 	table = NULL;
 	i = bridge->aperture_size_idx;
 	temp = bridge->current_size;
-	size = page_order = num_entries = 0;
 
 	do {
-		size = A_SIZE_32(temp)->size;
 		page_order = A_SIZE_32(temp)->page_order;
 		num_entries = A_SIZE_32(temp)->num_entries;
 
-- 
2.31.1

