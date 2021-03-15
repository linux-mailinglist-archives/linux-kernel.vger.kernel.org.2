Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3687333BF53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhCOPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhCOPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:01:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3BC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:01:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id w11so7915263iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qr6M9k58brJYdvN05SKIsQmxlwEePXhuPBmSxDhzvoA=;
        b=YDcwyse7Foo6mbEoUuV3/jrtAcNKqtoN92aFs3bRNaB+KM+sWqyyU1UkqeKjrKPa4J
         yKfrLOY+6I0yaWfe//LWJp5CitOIkoLBXfysdPxqhj68FLXyFwUdh0o+HKsSHhSZKKny
         hlCs7aLND5/CcQH/Ya30/eYfLckNJ41UWkasOl0VQUKmSMx8d6TIAZW4L7rLwEj6INPr
         D15exDP1M8orEZoA4FBHBGVXKksHLBIy8a/EJhYAzB9nvtzzUhMbYtxu4Nt6zB3OuoBI
         hhzZdkebUgFd4tUEp80lL7ztogDjctyoZaPI1EBqVUkB2ZXgSMScA48BLsa/FtCjZjPk
         CPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qr6M9k58brJYdvN05SKIsQmxlwEePXhuPBmSxDhzvoA=;
        b=hfaNa+c+Dks+eOemwKjgCbpwuBKAAdW7O10nqZ92i+gJGZep/EJQlgNCXy3+RI26xq
         WGDoLI12E2SH0STkSpv35BIMREZL0Tlno3ZqzqR6At57Z5je9zkx0CTXV1rPQhw0zfKR
         9JD3PKdYgZSuc5Ur+OJCa+iww01nWV4+nt36Z7hnJFxMse/ayJEnJOqeZe+cnbolyvQg
         Pz8Os06MbhwwIXsDGY06WUOGNg1H+2b5Ku8cpB5cQg1dfQTYBvari+bzp89cIayZas+g
         4AHlcus2N5lo+DtMXhhAe+m4huR2IUY0HHxMX1mYnqrIoN1/x8P2Q8D9P6vsreriqwhQ
         Gbbw==
X-Gm-Message-State: AOAM532oTzgrk/8ge8SC96g4KdkvUEj2k4B4X7eW/w1LlqX/fRxJEboi
        mseC8W2l15jdoul5A3tmaw/Kqg==
X-Google-Smtp-Source: ABdhPJwx5+BZaYgUGnaQ7vn8gu3PFXP/bv5pmAQ8GqiJ9ZDK+DLN8UHQ/pWj/BD1X5D994ooKqfUPg==
X-Received: by 2002:a6b:db15:: with SMTP id t21mr7558473ioc.133.1615820481764;
        Mon, 15 Mar 2021 08:01:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f15sm7987692ilj.24.2021.03.15.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:01:21 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     alexander.duyck@gmail.com, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipa: make ipa_table_hash_support() inline
Date:   Mon, 15 Mar 2021 10:01:18 -0500
Message-Id: <20210315150118.1770939-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In review, Alexander Duyck suggested that ipa_table_hash_support()
was trivial enough that it could be implemented as a static inline
function in the header file.  But the patch had already been
accepted.  Implement his suggestion.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 5 -----
 drivers/net/ipa/ipa_table.h | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index baaab3dd0e63c..7450e27068f19 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -239,11 +239,6 @@ static void ipa_table_validate_build(void)
 
 #endif /* !IPA_VALIDATE */
 
-bool ipa_table_hash_support(struct ipa *ipa)
-{
-	return ipa->version != IPA_VERSION_4_2;
-}
-
 /* Zero entry count means no table, so just return a 0 address */
 static dma_addr_t ipa_table_addr(struct ipa *ipa, bool filter_mask, u16 count)
 {
diff --git a/drivers/net/ipa/ipa_table.h b/drivers/net/ipa/ipa_table.h
index 1a68d20f19d6a..889c2e93b1223 100644
--- a/drivers/net/ipa/ipa_table.h
+++ b/drivers/net/ipa/ipa_table.h
@@ -55,7 +55,10 @@ static inline bool ipa_filter_map_valid(struct ipa *ipa, u32 filter_mask)
  * ipa_table_hash_support() - Return true if hashed tables are supported
  * @ipa:	IPA pointer
  */
-bool ipa_table_hash_support(struct ipa *ipa);
+static inline bool ipa_table_hash_support(struct ipa *ipa)
+{
+	return ipa->version != IPA_VERSION_4_2;
+}
 
 /**
  * ipa_table_reset() - Reset filter and route tables entries to "none"
-- 
2.27.0

