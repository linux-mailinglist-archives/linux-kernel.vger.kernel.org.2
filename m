Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAF7395668
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhEaHl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:41:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60644 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhEaHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:41:04 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncWC-0003AB-Ms
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:39:24 +0000
Received: by mail-wm1-f72.google.com with SMTP id w3-20020a1cf6030000b0290195fd5fd0f2so2870580wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edJlbbhDO28RmalfYtPxF+agVQnBc9uKOzw55MZRkiU=;
        b=TG8WmsfkOcxAJnh2zLBpcWCOrZ2pagvfnoAGgcGP8c2vpv5gIatSa2DuKFJcqD/kZ/
         kDUixYYkkD3cXmyjNLDqIAaNiB2KQW5TYXQU2CNPeAXmaV2F7279iOz9w9Sr6gxyZ5Oy
         HYiytOr0vu/Z1cJOQ8bHhpJnK2+uqP8uuXV7kzwZkP00WFtPEFIupr77OpDcsxHwXRYh
         GPVw0Jg58Ou8NQ3PaLoAzEYxZ7uLC0rOj7jgEhB+hD7caERdccBIyiQTEx99Fyc++LOU
         qZfmLYQ0LkR3iyN1uk8hrYKFJ2a4WimIZDfPwvT3XkNzsg8oU/lWojvPT6E/UQO5Pfu3
         XWPg==
X-Gm-Message-State: AOAM532O5YrXmf+qihNr7MiCHbCsFfz/QyWnxYyp7qZ1aFtZV3cbaXhQ
        DgUW7Exf5dZL1Pfdt71bRBUbNnbCfq+zHkMa9oyH7bo5TyTOyNvqzOU3t5zTCaQIfJJJ6f6ZZ3z
        RDt9R3jk2LT4I7QjRB6D5oDwcvbJOBUbrf705IQNK6Q==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr20361119wrm.212.1622446764458;
        Mon, 31 May 2021 00:39:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhrRG0xVTTRKmEPbpAveb22Wz/57NL6TRG+5R1+rJ9+T+fewiXUT5mJUt4uwtoCVIYndAGjw==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr20361115wrm.212.1622446764356;
        Mon, 31 May 2021 00:39:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id a1sm9168911wrg.92.2021.05.31.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:39:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 11/11] nfc: st95hf: fix indentation to tabs
Date:   Mon, 31 May 2021 09:39:02 +0200
Message-Id: <20210531073902.7111-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
References: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs to indent instead of spaces. No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st95hf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 0d99181b6ce3..2dc788c363fd 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1057,8 +1057,8 @@ static const struct spi_device_id st95hf_id[] = {
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
 static const struct of_device_id st95hf_spi_of_match[] __maybe_unused = {
-        { .compatible = "st,st95hf" },
-        { },
+	{ .compatible = "st,st95hf" },
+	{},
 };
 MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
 
-- 
2.27.0

