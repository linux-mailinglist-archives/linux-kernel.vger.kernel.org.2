Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD03989DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFBMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:44:27 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:42626 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:44:20 -0400
Received: by mail-io1-f47.google.com with SMTP id k22so2332454ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZomBGs4eHViKX0lomLvHZXS684AyWHKwDi/uxcM0kfk=;
        b=X/OqE2o/bDI7oS3yDQ3/ISNF9qRVnYqvKykmcyzPbDDb94BR02haXzQnwZGjreaWqf
         m/YnjyDqiop5o0bPRHxBOj0a9Tm4dkeHAWTM7Ob6c7HqQHRclsjFid7PrIBQKAc8tFL9
         yU/gwEIYLrYo0GLzo/lEiiul37BCpn+8loGB5O8UhJ31f8Xin0fAOoehhaQlcL+c1koO
         utTUzEqwRZe5SpQs/YsVhnXQEamdOHEYZa3FM1rhpq7CeCiiJez72fZX2OrbkgrkztiC
         jgOLUCYqjwM8Z4iqFvWiCGryV6RmWhDFSkryaIt1INIWl5XceOEihUKH1dCdE8tGccr+
         5pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZomBGs4eHViKX0lomLvHZXS684AyWHKwDi/uxcM0kfk=;
        b=max+Q8EXZSn0jU9qtqt5ivW/kOx8hIPltpLssArvv/MJOt4n5hwI4fdWDyQqPJ3axF
         UX5so15VrE9z/BYUlADtDQ5RcTTfBmxqaa2WWYYrAC7uhMOqZZW6+m6zK7ShEshjYnqO
         cDrVP9IIIi4HqBL/8CAv8neGA08nHuJwm3r4s78p3xtA+z81ofBbrX7X+yItpBGvayVT
         mHgbhq9OQ0pjaRMspiRgmX9cvZHSqstwDedK/1EZoTuWvMZDD48ueJ8ck1XjCOkIZZ7p
         /jeoXOUs08UrOcxFCynbkiEDmH2KpnBJ/ftJIzjiEg/Piv7UnFB2imgq8eEvmeikB/FL
         gYCw==
X-Gm-Message-State: AOAM531aFwhlXo75QDeZKU2tXaMc57bledjVLPVa14ReWoaua4snDdgF
        g1lWJXm+BH3HjBVh5hLWE1t5Gg==
X-Google-Smtp-Source: ABdhPJyl3TdOjVaDYeCNJudukaN6g7+7WsMc1L6Oap/XgFtv+sAKgWrlxsF3XVnzfzUAnVC5bjARgQ==
X-Received: by 2002:a5d:8501:: with SMTP id q1mr25531804ion.66.1622637697713;
        Wed, 02 Jun 2021 05:41:37 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id v18sm11087054iob.3.2021.06.02.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:41:37 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        sharathv@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] Revert "net: ipa: disable checksum offload for IPA v4.5+"
Date:   Wed,  2 Jun 2021 07:41:31 -0500
Message-Id: <20210602124131.298325-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210602124131.298325-1-elder@linaro.org>
References: <20210602124131.298325-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c88c34fcf8f501d588c0a999aa7e51e18552c5f0.

The RMNet driver now supports inline checksum offload.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 03719fb6a15a4..07a81b73306fe 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -88,11 +88,6 @@ static bool ipa_endpoint_data_valid_one(struct ipa *ipa, u32 count,
 	if (ipa_gsi_endpoint_data_empty(data))
 		return true;
 
-	/* IPA v4.5+ uses checksum offload, not yet supported by RMNet */
-	if (ipa->version >= IPA_VERSION_4_5)
-		if (data->endpoint.config.checksum)
-			return false;
-
 	if (!data->toward_ipa) {
 		if (data->endpoint.filter_support) {
 			dev_err(dev, "filtering not supported for "
@@ -235,17 +230,6 @@ static bool ipa_endpoint_data_valid(struct ipa *ipa, u32 count,
 static bool ipa_endpoint_data_valid(struct ipa *ipa, u32 count,
 				    const struct ipa_gsi_endpoint_data *data)
 {
-	const struct ipa_gsi_endpoint_data *dp = data;
-	enum ipa_endpoint_name name;
-
-	if (ipa->version < IPA_VERSION_4_5)
-		return true;
-
-	/* IPA v4.5+ uses checksum offload, not yet supported by RMNet */
-	for (name = 0; name < count; name++, dp++)
-		if (data->endpoint.config.checksum)
-			return false;
-
 	return true;
 }
 
-- 
2.27.0

