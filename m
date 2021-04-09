Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1A35A53B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhDISHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhDISHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:07:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D72C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:07:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e8so6817422iok.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubko48yj8KRHx5tRsMu+2ZVBEaAtK4PcXtBKhVOgg0E=;
        b=L7Ykcs6mEYms5zQ44NxC8mbiJdbu568EeBATs0/Zo1V1/Xzz4rDZoDcbJaOnXS1fYh
         afowk8L+jkevw+lYa88h0e370tc60W0rEjrDp0lpACZXzsO7z8LFp95IQI54ZTUKTxyo
         zdIFpblI87fw77FfuP1DbPznqQRe0fquE/kADvhUgmKDMxKwnb6UWn8cU2EdHdwhuxCC
         tileHzbktqlmNNWMY4K2qpA7rKWSXJ5xhZY39lMb2+44IW9mgjiFXIu0ozocTBURThEn
         73ZYnFdBli4KWPEs+OfXJShrKXDFJ3sDjiwJQWEmT7F5fdLwFe+Tf9Dvq3dTlDf2WUVj
         6i9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubko48yj8KRHx5tRsMu+2ZVBEaAtK4PcXtBKhVOgg0E=;
        b=CDoobsgjj5djHXbtrqxZxEECrrYhb4H/ctoc0lfsBMHmVPNuJhD/ni5ZMNw/uMmtov
         M5/c2clzFu1SmRMLIy4R1owtjaJC5T/Yjr1H9GuOeWvHOtGglFc9+GndrIXCZ0YliZqy
         PCdU2leuUjkhBg5Yko8UjfqgG7Zjk9ZKHDJA+J0UZBzAO9NGCNowYMTKUcbUHBGD/INl
         cgXkRNauunZYhi+cU4M9tUUl+xTaq0ExYeE8AM548Dar2bQq3ayG7wwNnVl4SqEpBFx7
         A+hdwwDs4MCa7TCIr1uXw0LAKo0SyQwP5XtJDmLFZM9pwS49ZUsVSa9de6x+YGnUYG5P
         wmGQ==
X-Gm-Message-State: AOAM531LhGOx4Szqt7MZbasS/4Zwcm0GupwkdiVJZ7JzSy3Mh8X1W74r
        zHhoYrDWtlr/5WOyApIyJTHAfA==
X-Google-Smtp-Source: ABdhPJy/VC3ZtIkRPb3B8rSrq4Iyfpjl/u55V10z5J8d8gl9+RfQgwEjb/JdpUW9hz3a2KfCs9A+LQ==
X-Received: by 2002:a6b:f802:: with SMTP id o2mr12429860ioh.197.1617991647707;
        Fri, 09 Apr 2021 11:07:27 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g12sm1412786ile.71.2021.04.09.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:07:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: update sequence type for modem TX endpoint
Date:   Fri,  9 Apr 2021 13:07:17 -0500
Message-Id: <20210409180722.1176868-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409180722.1176868-1-elder@linaro.org>
References: <20210409180722.1176868-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On IPA v3.5.1, the sequencer type for the modem TX endpoint does not
define the replication portion in the same way the downstream code
does.  This difference doesn't affect the behavior of the upstream
code, but I'd prefer the two code bases use the same configuration
value here.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-v3.5.1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/ipa_data-v3.5.1.c b/drivers/net/ipa/ipa_data-v3.5.1.c
index 57703e95a3f9c..ead1a82f32f5c 100644
--- a/drivers/net/ipa/ipa_data-v3.5.1.c
+++ b/drivers/net/ipa/ipa_data-v3.5.1.c
@@ -116,6 +116,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 				.status_enable	= true,
 				.tx = {
 					.seq_type = IPA_SEQ_2_PASS_SKIP_LAST_UC,
+					.seq_rep_type = IPA_SEQ_REP_DMA_PARSER,
 					.status_endpoint =
 						IPA_ENDPOINT_MODEM_AP_RX,
 				},
-- 
2.27.0

