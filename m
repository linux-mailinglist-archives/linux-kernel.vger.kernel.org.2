Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12B3A4A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFKUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFKUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:41:46 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B01C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:39:47 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b14so6330042ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyNK4kzyW6w6CpdFLaV1AjbEu9O4dvUnAZHNcKqiDrc=;
        b=Pg6BXOoHn2/9V19Rwq7rqEsrnCWv/wINZ2Crxj6EZOVsyTbEte0oSWJUDUN4QPowsx
         g/pztumsI5nh1Dlyw2lxMFUZ/l5FXEOB2lDNRBain5Zss2o9hx0B/MLJUxsuDjlsqZDk
         ADnmLOReBBO+aUnfOmm/jKltU2Z/twUfDG7oWxTMY5y4msmfXk+9ZMyUA3OiuDWFd8h1
         CCsvDMF8RCr6lmD6bRUffB1yy9XeSFK3ARQoEEX3fTQKHvBAYH3S6w0jnKS6n50BSD6v
         zY8OAMEMIF4Qyj+h3b7fYob62Hd6NuT2n2u+fQPFKNLpjveOsHm8zSxxCz6xOfrMVTCn
         mnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyNK4kzyW6w6CpdFLaV1AjbEu9O4dvUnAZHNcKqiDrc=;
        b=WYHWT9EM3hCmqtGVkYXNJvPcpit98yAVaFIFu7JpUk61paPL0Tu0iQcKPKPDabm0FA
         rI0oYUGk6XS26kECJplhyQGcroYYPzjc8td8SRExjDGviPntcHZDJj/654WPQ9U3+TOL
         ozxu5jML6R33vAq7c+fY7uZLktMMTJYctLx9hr8JLNPYZmwnR2a34QLcdYaggRjH244T
         0b8ZbLz9PIDud7VqPfFtUjdsXJAoB5kPcn71oxJGEgicQyhF7RQBCcdgA5ptQ8fBv4r+
         XVXt9Du5OByzsjHEDJf/tkcPFprD9u0SWlalJbANTuZpI1CgNaikW1Y4jiNxNi/QjHWF
         5NxA==
X-Gm-Message-State: AOAM531+Ngqr7zIKiBsDnQnIvUFIQowHEMu3TwKo+TLX3HRyZJBROkZF
        nnQ6n8++/NdGNMjnPw9535bxgw==
X-Google-Smtp-Source: ABdhPJyk5BDQBq0j915kjddYCBbv2JdtomLXdF7v+yF8koRygJeWSGKbnyieNTm2Vy+xGzFVsdknug==
X-Received: by 2002:a05:6e02:1248:: with SMTP id j8mr4603939ilq.217.1623443985751;
        Fri, 11 Jun 2021 13:39:45 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id y9sm3761544ilp.58.2021.06.11.13.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:39:45 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     leon@kernel.org, bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        aleksander@aleksander.es, ejcaruso@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: ipa: introduce ipa_version_valid()
Date:   Fri, 11 Jun 2021 15:39:39 -0500
Message-Id: <20210611203940.3171057-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210611203940.3171057-1-elder@linaro.org>
References: <20210611203940.3171057-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define and use a new function that just validates the version
defined in configuration data.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 9915603ed10ba..cbd39e4667a32 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -639,6 +639,27 @@ static void ipa_validate_build(void)
 #endif /* IPA_VALIDATE */
 }
 
+static bool ipa_version_valid(enum ipa_version version)
+{
+	switch (version) {
+	case IPA_VERSION_3_0:
+	case IPA_VERSION_3_1:
+	case IPA_VERSION_3_5:
+	case IPA_VERSION_3_5_1:
+	case IPA_VERSION_4_0:
+	case IPA_VERSION_4_1:
+	case IPA_VERSION_4_2:
+	case IPA_VERSION_4_5:
+	case IPA_VERSION_4_7:
+	case IPA_VERSION_4_9:
+	case IPA_VERSION_4_11:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 /**
  * ipa_probe() - IPA platform driver probe function
  * @pdev:	Platform device pointer
@@ -676,11 +697,15 @@ static int ipa_probe(struct platform_device *pdev)
 	/* Get configuration data early; needed for clock initialization */
 	data = of_device_get_match_data(dev);
 	if (!data) {
-		/* This is really IPA_VALIDATE (should never happen) */
 		dev_err(dev, "matched hardware not supported\n");
 		return -ENODEV;
 	}
 
+	if (!ipa_version_valid(data->version)) {
+		dev_err(dev, "invalid IPA version\n");
+		return -EINVAL;
+	}
+
 	/* If we need Trust Zone, make sure it's available */
 	modem_init = of_property_read_bool(dev->of_node, "modem-init");
 	if (!modem_init)
-- 
2.27.0

