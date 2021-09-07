Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF3402D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbhIGRHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhIGRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:07:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC10C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:05:57 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z2so10849799iln.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNjx9C77fxKJjjnMzzRBLz2JIaY+C4dZcQ09RbcNS2Q=;
        b=cb4FtZ6SBif/ljyw5A0WKK38D5OuY6aF9PnArFV7u9UeRQH3PGA3n0KA9DYXcA2Gg3
         pEZY9xHIXP5OEY62DM63baGgSNDeLFBrTMNE6nKHz039ovopxXzX9YumNf/gOY1PnbOc
         f7rsh6BKYwW9WrGMQKJRry61vGU5Div98jdPOUzng2tqsoK6644ascQwk5sDZUN5MjJ3
         7l3s8uDFDqryyDdZD7jXGtO0gIG0ResuoV3kDI3uboWbNUYKc1OdaOILb96QhW8D0DY5
         mfmh1SdIZhGnJffpQPY4HGcPUt/OTUYTWmCI+/8XYYGLBOJxThtodWOy5TPqKrjEC2Ip
         X3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNjx9C77fxKJjjnMzzRBLz2JIaY+C4dZcQ09RbcNS2Q=;
        b=O23TPJkbsMOu+X5e4Gx569NmUDil8/N0V7c3HylAC5WCDdyLKqf6ic52opQauRwbq5
         vMn0sHAlVtaACHmTzu8zFbuakc3I8dD0m8iiCSeElW/pCMBChgllsNI7acIDnoQA5rzq
         qkLOtVmt5gM1IK/yRkHQUKbWEhjdQHPctnAn1oiu+wCAdrbz992ZINXhKaz9Ma9jQ4Ue
         VKH1kFMk46PyFYKeXoW4lylDb+q1/wa5Bi2Rg3txDHt8M2nttKGTUWc1uSm4dr/TDKlD
         kR/XO8DoaD0+KH4YtbYeRh7TLt5hVfA9lX2OgnVIstBAHwUMV86Jeij2EHzkNAtSuqCG
         VLvA==
X-Gm-Message-State: AOAM531uB1fMpRw9Nt8rx73uxVksb9Q+/OR5ymUOtrCVYQ4zsC4BsJxC
        bnrMEd0N/NpSLlUaRd370fa+SFC5VtqDO38n
X-Google-Smtp-Source: ABdhPJx1+EwFVKgQ/KliZy4TFCcJVc/pDh0iExXIRkpUm04sL6u+odLmSXGSHCWly8tuiVi8QVyQgg==
X-Received: by 2002:a05:6e02:d43:: with SMTP id h3mr12844700ilj.112.1631034356695;
        Tue, 07 Sep 2021 10:05:56 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id y7sm6051136ilq.57.2021.09.07.10.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:05:56 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     pkurapat@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipa: initialize all filter table slots
Date:   Tue,  7 Sep 2021 12:05:54 -0500
Message-Id: <20210907170554.399108-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an off-by-one problem in ipa_table_init_add(), when
initializing filter tables.

In that function, the number of filter table entries is determined
based on the number of set bits in the filter map.  However that
count does *not* include the extra "slot" in the filter table that
holds the filter map itself.  Meanwhile, ipa_table_addr() *does*
include the filter map in the memory it returns, but because the
count it's provided doesn't include it, it includes one too few
table entries.

Fix this by including the extra slot for the filter map in the count
computed in ipa_table_init_add().

Note: ipa_filter_reset_table() does not have this problem; it resets
filter table entries one by one, but does not overwrite the filter
bitmap.

Fixes: 2b9feef2b6c2 ("soc: qcom: ipa: filter and routing tables")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 2324e1b93e37d..1da334f54944a 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -430,7 +430,8 @@ static void ipa_table_init_add(struct gsi_trans *trans, bool filter,
 	 * table region determines the number of entries it has.
 	 */
 	if (filter) {
-		count = hweight32(ipa->filter_map);
+		/* Include one extra "slot" to hold the filter map itself */
+		count = 1 + hweight32(ipa->filter_map);
 		hash_count = hash_mem->size ? count : 0;
 	} else {
 		count = mem->size / sizeof(__le64);
-- 
2.27.0

