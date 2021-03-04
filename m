Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7515632DCCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhCDWNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhCDWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:12:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69424C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 14:12:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dm26so13472166edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/pPDOAIiRjR7lEs29siBxnpMbhMpFCg4qL6RvapyuQ=;
        b=ZvgjxCFdW+xEIJQRTSrZL9RG99WKcuzdTurrplaWC8+EC8MZwlMwU+OBT9Nm8QNzO5
         NdOoYpYInzinJHNu6McP1uHtYkzgOrhNUi32Us+kUjDel5XCS1sga1lOsHnl9S6lAqYl
         N+2auUjyYr0kuUMvKyhGGBAlXCZ08f4U1dgJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/pPDOAIiRjR7lEs29siBxnpMbhMpFCg4qL6RvapyuQ=;
        b=MKpwa20dm6zBjPEDU+qZ9z6j3ZxpcMP+4CtGDIzUlVzXl+0evRb+v16Miove3wdwRE
         hC/YZ5S6E8sHCzRXtRIDzcZfh9bYbgsf35+2WPbFTVh9IYK7Py58TDYjxC8N0NL2Rk33
         2xnLvoLUWf8QY5NWnEN4QVeVpwI0YbThgpL+SQ+7N9H33+wBWLahPORSlWObZfCzeX3Y
         v9kh4FEuNhOvPVc4ujkMS5Q3CiNHfW48zSyEAfM0v/L5sXVQ+6zff3tegfACSZ3Sgz5l
         j7TFpi8ypROtJkp0vkpz2GNrzrX6AnC7u1f6urBpzLoVp4yPaR4E3cVtpHWjKogAZyxJ
         7BhQ==
X-Gm-Message-State: AOAM530ZtIrRixKcOI3vPsOi4W8L0fwFknE5+FKGQKUiBmFrItHGsCQ7
        YaOBLSFREA3nZ/hz9DMstgg53g==
X-Google-Smtp-Source: ABdhPJy3H4qGxTqJAT6Dy3t671giI6caxeE5c2SF84vG2D259IJR/Gin3MwbgSzzwbdGCsregOluwQ==
X-Received: by 2002:aa7:c889:: with SMTP id p9mr6615207eds.82.1614895972167;
        Thu, 04 Mar 2021 14:12:52 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id q22sm362099ejy.5.2021.03.04.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:12:51 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: watchdog: add optional "delay" clock to gpio-wdt binding
Date:   Thu,  4 Mar 2021 23:12:46 +0100
Message-Id: <20210304221247.488173-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304221247.488173-1-linux@rasmusvillemoes.dk>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210304221247.488173-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[DO NOT MERGE - see cover letter]

We have a board where the reset output from the ADM706S is split in
two: directly routed to an interrupt, and also to start a ripple
counter, which 64 ms later than pulls the SOC's reset pin. That ripple
counter only works if the RTC's 32kHz output is enabled, and since
linux by default disables unused clocks, that effectively renders the
watchdog useless. So add an optional "delay" clock binding.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
index 198794963786..527be6b30451 100644
--- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
@@ -17,6 +17,10 @@ Optional Properties:
 - always-running: If the watchdog timer cannot be disabled, add this flag to
   have the driver keep toggling the signal without a client. It will only cease
   to toggle the signal when the device is open and the timeout elapsed.
+- clock-names: May contain the entry "delay" if the board has logic
+  that delays the reset signal from the watchdog and which requires an
+  external signal to function.
+- clocks: Phandles corresponding to the clock-names.
 
 Example:
 	watchdog: watchdog {
@@ -25,4 +29,6 @@ Example:
 		gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
 		hw_algo = "toggle";
 		hw_margin_ms = <1600>;
+		clock-names = "delay";
+		clocks = <&rtc 1>;
 	};
-- 
2.29.2

