Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9209E376891
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhEGQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:22:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51210 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhEGQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:22:36 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lf3EN-00089M-Es
        for linux-kernel@vger.kernel.org; Fri, 07 May 2021 16:21:35 +0000
Received: by mail-qk1-f197.google.com with SMTP id v1-20020a05620a1221b02902ea88445e01so3363045qkj.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEwpl+e3d0cM7xieF+8lt3QhbZrV0cBIC8uccroyXHs=;
        b=g5UnpyWR3+tUjXZACe9jmbU5Yvoh/3+n9PRb84BfImprj3TSj0BCdNu2p477tUxx7r
         f4XDxgvJ8jZwaDBGRq4lG3QkwN2kjLS1zEX3w9/5YncMuLo96m0ajnqmdhjwCbgs6nZx
         1vD/GeE8tQFK42l+TMyTVzM/54xD47GZXKCUZxTOyn3HvUJlVJh2pWZ1uC7JiZ5K+Mdr
         1We9vJ5YSvumg4zH8PS4X3stE/fldG8s65aLqhSVbpSbUESuQ4YjHLNa5XoDn/2nt0n2
         J5nS5sbMksy6y1AqebjzEPLp3VTBDN3nZAbGzhiIPfzhB7P1XA6YpWVqaROJFTWGqKVp
         ExnA==
X-Gm-Message-State: AOAM533hg+yR3Fn6BJVNiV6IQZBIDInTKUguHeIai9+F2xXj5Z//AtlH
        QTvqZ6jt/fa/UAAEgxvIU3HngulYwmghB1GgItWgXBV1FHL6VSGTsftsaNql9zpF5GbXfonyVmN
        Fz/DgMT3MYEK/jUlQ36ZeiojZkN1SvkgP6voXNkF0cA==
X-Received: by 2002:ac8:5a46:: with SMTP id o6mr10093283qta.289.1620404494590;
        Fri, 07 May 2021 09:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwndiNIlAr4EYeCcBxKjh2kdc50Sh+P2UpllV1BwJlou9m+rQMwsW/WZZsiQmT+FzwleDgc3g==
X-Received: by 2002:ac8:5a46:: with SMTP id o6mr10093263qta.289.1620404494363;
        Fri, 07 May 2021 09:21:34 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.1])
        by smtp.gmail.com with ESMTPSA id i5sm4991869qki.115.2021.05.07.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:21:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Matheus Castello <matheus@castello.eng.br>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RFT PATCH 2/3] power: supply: max17040: simplify POWER_SUPPLY_PROP_ONLINE
Date:   Fri,  7 May 2021 12:19:26 -0400
Message-Id: <20210507161927.105862-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
References: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was reporting POWER_SUPPLY_PROP_ONLINE via platform data
functions or '1' if no platform data was provided.  Since there are no
platforms using the driver with platform data (no board files with the
driver), the online property can be simplified to always return '1'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17040_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 12854c87df53..d51c3443d732 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -219,8 +219,7 @@ static int max17040_get_version(struct max17040_chip *chip)
 
 static int max17040_get_online(struct max17040_chip *chip)
 {
-	return chip->pdata && chip->pdata->battery_online ?
-		chip->pdata->battery_online() : 1;
+	return 1;
 }
 
 static int max17040_get_of_data(struct max17040_chip *chip)
-- 
2.25.1

