Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB836484D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhDSQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:34:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38528 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhDSQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:34:12 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqE-000283-3P
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 16:33:42 +0000
Received: by mail-ed1-f70.google.com with SMTP id cz7-20020a0564021ca7b02903853d41d8adso2202820edb.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJFDAj6TYp7FZZ9Zf4ZhG/lOPFtwU6nBh8dkTxsEpU8=;
        b=mAps+P5gcJkf0CyCJa06SXjjC0ionWZ44UIHIZ0aSFyTgJmihPS/RZbsJ5vsdwS260
         iP8ANt2exj5tNmGnqq5pLm6bLifkeItVyc4ZomXgEJP41QEdDssfPNvtCbFuscdBGkES
         yFKtJXO0ekQrbLyQfwIOIRWcEgjNIA7H088s5ndmMrbui1bLvTogE45GObhWc6k5GUS7
         71KjPGaM2LSxO5Bi4/EU8zp7OyRSuVjHtCxA7WjFnpzYsDryON5cdfhOZNo1L7t4i3yK
         y35Y53wH0I4zjgxvS3xpL6UPpI3KOfY6hAWl08ubDPbbER1D34ktxoNaR7MnIw0eisay
         ciPw==
X-Gm-Message-State: AOAM532OJQ5PlzP5lxueG1Y106ItmE6HKBExUoi8AjHKxxUpiYU2KkQM
        tB3UoJNd1S2TzbRRhcRIt5EZ9SH43ONSmRGDtgKtQJFzfsdw5elXW6WldxxM5Z1nbguW+by5H6r
        giSsl7ZFyW3XB2tCPGsxMKqD6K3oPc8Mx2ZFfD8haRA==
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr23186446ejy.216.1618850021747;
        Mon, 19 Apr 2021 09:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUor1TH50RdkNQ0brGoOfZsltUgbORXKk/u2PaE6e5BIAtrg/yKQPZA5J2g9XQ7h+mSE+6NA==
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr23186432ejy.216.1618850021640;
        Mon, 19 Apr 2021 09:33:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] power: supply: max17040: handle device_property_read_u8_array() failure
Date:   Mon, 19 Apr 2021 18:33:33 +0200
Message-Id: <20210419163336.64075-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_property_read_u8_array() call should not fail because it is
preceded with device_property_count_u8() and check for number of
readable u8 values.  However the code is more obvious and easier to read
if the return value of device_property_read_u8_array() is checked.
Otherwise reader needs to investigate whether really there is no risk of
using random stack values of 'rcomp' variable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17040_battery.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d956c67d5155..d2053cd0bd13 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -268,11 +268,10 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 	rcomp_len = device_property_count_u8(dev, "maxim,rcomp");
 	chip->rcomp = MAX17040_RCOMP_DEFAULT;
 	if (rcomp_len == data->rcomp_bytes) {
-		device_property_read_u8_array(dev, "maxim,rcomp",
-					      rcomp, rcomp_len);
-		chip->rcomp = rcomp_len == 2 ?
-			rcomp[0] << 8 | rcomp[1] :
-			rcomp[0] << 8;
+		if (!device_property_read_u8_array(dev, "maxim,rcomp",
+						   rcomp, rcomp_len))
+			chip->rcomp = rcomp_len == 2 ? rcomp[0] << 8 | rcomp[1] :
+				      rcomp[0] << 8;
 	} else if (rcomp_len > 0) {
 		dev_err(dev, "maxim,rcomp has incorrect length\n");
 		return -EINVAL;
-- 
2.25.1

