Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E83F07A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhHRPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbhHRPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:14:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:14:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w24so1847913wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da0DCFGolB9uAM2tKDPuHVOlQ6ovhGIdi2wnEJL3jXc=;
        b=JqZOf7zXT9L88sx2XhatvSar77vpGtprbyBun1lpZtJkBsF+4ehXeieZmHzpi9PLaS
         vnfRTYvY4mLwIWtikv3stTQ73/K8xZZ7i665vDbr0iKXPrKEiUjNRKf1aFOcmJLD6pJe
         t8OKIH6jT3o8Vo7Lzt5QlglKpxiKeJTMDtMdU9Piaz7txTB1P+PrgxbU9Hv25TvZh39P
         HAXJM0cwfE1AEtLDilFWuBp4BjpdqBiOi+Y6/Hwh+aW4loV+2i7cSC3VA47moIWgppLR
         /wRH8qbEZQl2uMvS+eTwmm6zsxfjZJM6QKry80ezpD5cXAoOgL01r3zghpua9u9SFoKq
         ijNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da0DCFGolB9uAM2tKDPuHVOlQ6ovhGIdi2wnEJL3jXc=;
        b=jbgpgoL5DcrNwn6pYUB51XipsxNJn8JUi2Q/B7jKKi8un0ALjmwerNMeXeM96Wo5PE
         Gzldhz2EeKxQb6h1UI64IyDjj/JTe48TP/3GG8+pfHXnyz/Ks/MCzxvI7M0AEARsmzQO
         qqxcBTKnxWKcJByFTLgeItOhDLEYls/QLJULlIeD0V4CcqvNAOw8tNFxfl77sOpfkCx1
         LdaE45MWMsupNOzrq9VfAzpWMqmGY3xN+JwPtO8nDaDqtgTDd+ANtfl5g3DhP7L2FrrG
         pArXtebRexcOoAwBdXN6cwZN/3xSop8Ya58hrjX4/6uWQwWkGCo8f1jC21sXIAkS/6CX
         pjlA==
X-Gm-Message-State: AOAM532IFefOxsP/d9myqXAha6y5Y+O75BoMnvXBi1/VAFZUvu48Pnz7
        BFcKciJm8zUEumu9Sqgri907YYwge3ut5PGN
X-Google-Smtp-Source: ABdhPJznDIbrC67RLd4q1jhvYx2titLrWoxzZktsdZNo655PU1Rk/lZxfAqsbScG+aYG6eBYozaydw==
X-Received: by 2002:a1c:4a:: with SMTP id 71mr9102711wma.87.1629299640460;
        Wed, 18 Aug 2021 08:14:00 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l21sm101829wmh.31.2021.08.18.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:14:00 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: [PATCH 2/2] Documentation: dmaengine: Correctly describe dmatest with channel unset
Date:   Wed, 18 Aug 2021 16:13:15 +0100
Message-Id: <20210818151315.9505-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818151315.9505-1-daniel.thompson@linaro.org>
References: <20210818151315.9505-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the documentation states that channels must be configured before
running the dmatest. This has not been true since commit 6b41030fdc79
("dmaengine: dmatest: Restore default for channel"). Fix accordingly.

Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 Documentation/driver-api/dmaengine/dmatest.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
index 529cc2cbbb1b..cf9859cd0b43 100644
--- a/Documentation/driver-api/dmaengine/dmatest.rst
+++ b/Documentation/driver-api/dmaengine/dmatest.rst
@@ -153,13 +153,14 @@ Part 5 - Handling channel allocation
 Allocating Channels
 -------------------
 
-Channels are required to be configured prior to starting the test run.
-Attempting to run the test without configuring the channels will fail.
+Channels do not need to be configured prior to starting a test run. Attempting
+to run the test without configuring the channels will result in testing any
+channels that are available.
 
 Example::
 
     % echo 1 > /sys/module/dmatest/parameters/run
-    dmatest: Could not start test, no channels configured
+    dmatest: No channels configured, continue with any
 
 Channels are registered using the "channel" parameter. Channels can be requested by their
 name, once requested, the channel is registered and a pending thread is added to the test list.
-- 
2.30.2

