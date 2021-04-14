Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F335FA79
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352527AbhDNSMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbhDNSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE5C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 18so24853805edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noS6htpFhE5xXrKr2Fo0hbzNkPnB+LkaIWg1CiOcABg=;
        b=WvPSOj0VKYUNNmMj8epu/PxCixr2OutlStvHzCI/+Snq5Aka2T5xfgDCNfc6LWKgi7
         3dXWztuHPedzEubNNHJrbMloW+bRNl1QpCfxXWuXwRLoAZyon3+vywojF4FaauUHOvwT
         1SC1VwQniXH/KN5GurPyihk38rZJMqFxWvwkh5FMSpaTlkLYVZx3WHOxRtJydx5+iojS
         b6+0quj21jvftbY9ISKq8It5hijAeim36LZzzHxgqmJslgwZUakioiJ8YqMEnqJNqCuG
         BKO9GOrdSE4v5n+JkvVyP7PJPdypZ2KAgiSkdnEVAtZ1I4oJqHXgB567jJxhprTkzsNF
         MqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noS6htpFhE5xXrKr2Fo0hbzNkPnB+LkaIWg1CiOcABg=;
        b=VDWxDG2hepIATyvvQW9fYU0Dhp8VtPNdKZFT3Cs1CGi+yL2hB+eOjcy5mmmCCcBKw/
         4NImF224I10Cnxpr3T4HnGfIfaSUXFBau6hhkFd8oTeSgsonyyygDfCOxkNjNR9hwXmb
         sTeGrr5lr+gDpyFK0nERShBdFKTZG7Sm+eYlzZnGU+Yalr4UNCgHzJfDxosYNy0fNmjx
         TBEi/0SshjxbABuAv3zECVJrzYxcd+4uzOch7Life/yP5N7vzDNbm/CW656d2mlVCy+A
         WCIxFvC5lbwjw6/OxA2iSGcrD1AT3z801TtszBceVfA9bowQ+PyZ39syGpocq6I2TdQN
         L88Q==
X-Gm-Message-State: AOAM530GXsasvWG7iXDHrZqplW9/FO1Qp/C5mScHTGfOiFy5IX+wgonD
        eegCOGba11iu4/4esKAE6TQDEA==
X-Google-Smtp-Source: ABdhPJwxA+9pLy8rxD0ajLNPjkVOE9I+E6zRjITvFxSTLTvOZkjksa2nthSaT691y9g2RLj0bSB+yA==
X-Received: by 2002:aa7:c247:: with SMTP id y7mr152482edo.305.1618423908344;
        Wed, 14 Apr 2021 11:11:48 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 13/57] staging: rtl8723bs: core: rtw_recv: Mark debug variable as __maybe_unused
Date:   Wed, 14 Apr 2021 19:10:45 +0100
Message-Id: <20210414181129.1628598-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/staging/rtl8188eu/core/rtw_recv.c:12:
 drivers/staging/rtl8723bs/core/rtw_recv.c: In function ‘rtw_signal_stat_timer_hdl’:
 drivers/staging/rtl8723bs/core/rtw_recv.c:2341:6: warning: variable ‘num_signal_qual’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 668a703dee7fd..f15cd7e395211 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -2123,7 +2123,7 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 	u8 avg_signal_strength = 0;
 	u8 avg_signal_qual = 0;
 	u32 num_signal_strength = 0;
-	u32 num_signal_qual = 0;
+	u32 __maybe_unused num_signal_qual = 0;
 	u8 _alpha = 5; /*  this value is based on converging_constant = 5000 and sampling_interval = 1000 */
 
 	if (adapter->recvpriv.is_signal_dbg) {
-- 
2.27.0

