Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC59A40E3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbhIPQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:52:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53344
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243791AbhIPQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:47:31 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF8A240286
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810769;
        bh=TkTHOhbG7+Cs8KGkPzHFU+IfRiM3V1/WUAdUOTTHlrE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mMnCA+/kscSnPsUCIRZcQEDwgBNdIn+/tSkJOdpsjzs8cBcXFuwXiJ1rPK4EAmZMW
         d4mEPwtk/B9uG6hJDPJcLCzWaQ+pnV/3hCZSCPItEz4A30teXdL4SjhG7039CPVx9T
         dj1nKM3W4cS8gL/J7Dw9NsqRhxfqMiQ1TxNLqgsUZDZh0NglnFBZuxg29J8V1ZJfdM
         etYcHe2u/E8UnEIUYUIr/9ZORIx7j9xGSexOw+8kO8pPlAiJVzsvGrpXZbJLfHH1cF
         ngkEXMJ3ONRlT8C3mcTSq2JAIESbIejwSeA6do/eJtcayrV2wDPBXgUwwmwpSIMNVY
         nAmZsla72X52g==
Received: by mail-wr1-f70.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so2659578wrq.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkTHOhbG7+Cs8KGkPzHFU+IfRiM3V1/WUAdUOTTHlrE=;
        b=5/bUjYjK62XSCosx+SVuJ5xD3rSOPCbC+nwnAdt/66/o0oDyxF6zI6pgqp15UNXMHb
         7y3C2/87w3ENMv93FyIVJXMukekoA345t+iDb2PzD5+gnQWICSLHA2EhFzqQXD7Wb2rk
         pg5oNvuQPCTrbROXDzz1OltT5szrz6mqAL8iqMdwPrCuryJqEkehlvW8+wzmpOot3zZ0
         5T3Zmf7oOQAw+Q621n1xgjGc+6QNdoI43psz51Q5gPbqllC4TtiEIpzeolzt3xI3aLkk
         MRw8XDOA+X8m54K+GFbosLpos3DX0VgwQenb7ApSb8Qca59r+rVYBcqIBnTnEVwHOHK3
         2wlg==
X-Gm-Message-State: AOAM531SusUmfzRYsxVoADRVN97kYLEeH6xVR7/yv2BG/Qou0e+LLSWY
        Uw/16kfj8y2HBEFTir1m/K1qjyGk5bNlhNbxrqGZslonDfQl28Hcy+bgFIIHc3KnqNEGjYCBymo
        aMbI3aN+QO6EdPsafS05t6krT6FTzof5wSB8QPnB6aw==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr10746887wmq.0.1631810769631;
        Thu, 16 Sep 2021 09:46:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyW+OkIKkP01ToiSTSOU4G0hJjjzBqvO2StScpKKfwwlhY9dJZUVxfnRqcLlXIIqO+lwZLbw==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr10746871wmq.0.1631810769456;
        Thu, 16 Sep 2021 09:46:09 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l21sm3718194wmh.31.2021.09.16.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:46:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] rtc: s5m: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:46:04 +0200
Message-Id: <20210916164604.134924-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916164513.134725-1-krzysztof.kozlowski@canonical.com>
References: <20210916164513.134725-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/rtc/rtc-s5m.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index fb9c6b709e13..4243fe6d3842 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -861,4 +861,3 @@ module_platform_driver(s5m_rtc_driver);
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
 MODULE_DESCRIPTION("Samsung S5M/S2MPS14 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s5m-rtc");
-- 
2.30.2

