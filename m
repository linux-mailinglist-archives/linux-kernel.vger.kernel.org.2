Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918D844EF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhKLWZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhKLWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:25:08 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4079C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:22:16 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id v65so13043733ioe.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9+HbK+YTHePHOpXtIwPV+2M8nlPz7ZK9WcWxIle/6U=;
        b=mIwWb2XCoeYeyi+EfWBZKHXHQQVpQof5ukBsLAVOlNPoE1tzc0mNtvvh+ML41Hkojz
         /9VXZBLYnfX562DQaxr0s99Zi8VB6J4x3OR3Z97BLRvEWGeOE8mc36z1gDEBVdlRtpUL
         dC0dHu1E08TYWXSOKXM02pGZUBbKE+UW9fxF77sIGlptnBMc2F9NABi6G7cjzEfD5b/C
         aEWubFg12MphlH7EE3iKZSzTNgTCc47geG1cCKf3g4GurvjfKH76+mxYMN9QUaIIbMXr
         Un7AUAi/znACIFHugswKWh2Yc9EdW2t2aVVIbd9vk6RjwQhEoaC4M1WkGoLoqskM8AzZ
         gWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9+HbK+YTHePHOpXtIwPV+2M8nlPz7ZK9WcWxIle/6U=;
        b=EKOmqn9Xsu7FgZA1q22QvdEI/KsBVfQAagdw9VZiAm+P2WY8rahHpOS9GaxlM9gSgd
         R477Y0vibdz5PRLKhwkNv4M2EMwODeyuXk0iQ0I1jNGShwe+RmjcDkgPinvRV7yhYbTr
         sswJdOLE/pPUWAivXZfgRMR+pawvcMYPLGwzMboqRH/eIB2GpibwnsZ7Me4sjuU4DxJT
         2xdomOrzmnupB6OTyLzqNwevVw+5Xk7jS75XAMY1q+RByKEjHs78k8KbT9aWkxrAsVdy
         KdUsXM1tk6UvroAnkwov4TH8NpFCwBB0RM5TxM2m4DvsMRrOv2cJFhg7fwNdJ1/5UNkT
         E0Lw==
X-Gm-Message-State: AOAM533t+GKrdC6tl2zViZJcmWLEycbFCn07wVS6WPzfj6KqF3WZc1gX
        Lcpw2MXvQ850Rz72hC9xRvSNJA==
X-Google-Smtp-Source: ABdhPJwgQu+M6BYQWNsyZqz2iiMmIGeKgQJPUg/vkx1V3FC/qVw6nRrtxHWPnHM8u77ch7Rw5sAsFw==
X-Received: by 2002:a6b:7c46:: with SMTP id b6mr12996272ioq.129.1636755736369;
        Fri, 12 Nov 2021 14:22:16 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id y6sm5241117ilu.38.2021.11.12.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:22:15 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     pkurapat@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: ipa: HOLB register sometimes must be written twice
Date:   Fri, 12 Nov 2021 16:22:09 -0600
Message-Id: <20211112222210.224057-2-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112222210.224057-1-elder@linaro.org>
References: <20211112222210.224057-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with IPA v4.5, the HOL_BLOCK_EN register must be written
twice when enabling head-of-line blocking avoidance.

Fixes: 84f9bd12d46db ("soc: qcom: ipa: IPA endpoints")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 5528d97110d56..006da4642a0ba 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -868,6 +868,9 @@ ipa_endpoint_init_hol_block_enable(struct ipa_endpoint *endpoint, bool enable)
 	val = enable ? HOL_BLOCK_EN_FMASK : 0;
 	offset = IPA_REG_ENDP_INIT_HOL_BLOCK_EN_N_OFFSET(endpoint_id);
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
+	/* When enabling, the register must be written twice for IPA v4.5+ */
+	if (enable && endpoint->ipa->version >= IPA_VERSION_4_5)
+		iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
 
 void ipa_endpoint_modem_hol_block_clear_all(struct ipa *ipa)
-- 
2.32.0

