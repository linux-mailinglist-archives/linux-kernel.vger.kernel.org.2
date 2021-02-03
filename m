Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7308F30DE32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhBCPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhBCPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:30:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA58C0617AB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:29:07 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so25694467iow.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktpO/jSmoOx5RVisI52DM6PeD/6jBsQ5/HisJypSEHU=;
        b=ihyMBeZHOYDRwhA97Y0VNZOgqPLUdd6gsZglBawAKVdApJXPCH/lhyadqr+oE127v9
         K6/FiukWucBm8B9tC7LnshCTCphoaFBvC24l8GRkKXlMotsytnouOt+GqsxIY4L29Abl
         WAKPZhfTJvWI2RHAHxT9jUtDvX3Dkf7n2JfYWiDy/e5dFRzH1vHhct/AShg24zZoC+iW
         8RxwxsWLIhjRqmmZGZLNq/dVGjA+A9YvrVNKEJ1gI2jDXBTTbMYfZ6b0paX1ru5OF0dD
         E7MQothzZl8yGZV+2Y4zOUjRg1csaOFrBx2urW4VyoaSpl5QqM36ZeKIaTk3FLdlY3uv
         /4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktpO/jSmoOx5RVisI52DM6PeD/6jBsQ5/HisJypSEHU=;
        b=cFgm/3Z26BkJFW+LT3crvb5EAV9tl1eP6fjwG432kRlTNenUdPuw+p6x8Ytka0o54Z
         hyk16QRKDAEAR2/A3XU8QNkA5U0jc3Lq1olYTUyiouWSmMcXfunasdMYDZlQiw7hWqZd
         M9azf/R8Q0TlEGwZwL/hQdxI4VGr0FNuT/pNeTURuEZodWU1J74FkXjtNJLtSWh8vrkc
         Dk3YiJN7dpzlq4Az58bN/PoDx/51bzlJZjS8l+4podLY9Tyvi+o0LrBildw+gxEyWUyX
         0ISr1O/NLNnb/tqq8tWcvBRuaNHpoEoPyjJpOBCAPRbMVT+jutq5IHo7urqePEbCAp8j
         Ki8w==
X-Gm-Message-State: AOAM532X6BfUQI4CSODGrIk9rXdfTtkOcmTpT2maQJaTvI4i1znjd732
        4jquMC91TBw3aww1UfZyn3C/HwFk3BhbKg==
X-Google-Smtp-Source: ABdhPJwVrKkfnIfJ3CqiS9OOtUlmZVeuA2jWkUayO93w1sLPsIMpVPLS9cnvDTMji4zlOmPdZtwfyw==
X-Received: by 2002:a05:6638:271f:: with SMTP id m31mr3456968jav.23.1612366146675;
        Wed, 03 Feb 2021 07:29:06 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a15sm1119774ilb.11.2021.02.03.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:29:06 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] net: ipa: get rid of status size constraint
Date:   Wed,  3 Feb 2021 09:28:54 -0600
Message-Id: <20210203152855.11866-7-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203152855.11866-1-elder@linaro.org>
References: <20210203152855.11866-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a build-time check that the packet status structure is a
multiple of 4 bytes in size.  It's not clear where that constraint
comes from, but the structure defines what hardware provides so its
definition won't change.  Get rid of the check; it adds no value.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index bff5d6ffd1186..7209ee3c31244 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -174,9 +174,6 @@ static bool ipa_endpoint_data_valid(struct ipa *ipa, u32 count,
 	enum ipa_endpoint_name name;
 	u32 limit;
 
-	/* Not sure where this constraint come from... */
-	BUILD_BUG_ON(sizeof(struct ipa_status) % 4);
-
 	if (count > IPA_ENDPOINT_COUNT) {
 		dev_err(dev, "too many endpoints specified (%u > %u)\n",
 			count, IPA_ENDPOINT_COUNT);
-- 
2.20.1

