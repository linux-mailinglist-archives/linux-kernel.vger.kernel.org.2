Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417F236484E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhDSQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:34:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38534 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbhDSQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:34:14 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqF-00028P-C0
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 16:33:43 +0000
Received: by mail-ed1-f69.google.com with SMTP id r14-20020a50d68e0000b0290385504d6e4eso1571226edi.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snr6bOpKVS1nofF6NBC7+ehvgRwGojW903lwvMJmgjU=;
        b=lwsBfZLPa5WnKxQLSEviPSHtDMoOCOUejp+bMun01Gy3l/aiNtUPP5EOdNtZtdDEb/
         yUJzvt6vS4fTBufLqqS/y5VQYvax86+hgWEv69Ibweq114YpSlf9BCKqpvEUSS7L+0rf
         RAwIhY9Qy2sxct3H6tQIEltaCtX2/AK5qEEA+yYRX2EtAWmhBGr+HQipz8UAVGiZAGey
         LMGUr/A1BoSYhNKvkKF0N6SwzJxAyMhcOYbvZg2uR+NLnzY+As28Emz2hb3mm8ZlkM6G
         shVuzzBoaCQIDLlt3CMj/+ZxLsL/XTMz+rVrRo4fm/nsSqz/BAbXIDozD29wypuAfbJ/
         I6xA==
X-Gm-Message-State: AOAM533s2XcJWepSF1LpaIHaThh4tI8G0Eg5fvGv64IslFfmpYqaiChw
        0Wz0nx/ouOLVK4rvmnPxE4SwtBbKPA+owPf/LfPelU+w2XumvZ447JcLDCoq6Qbo+TXtkSpN7GZ
        zlCNXZZqKR8ayS5rjcSdPqp8vMpqnQp1CzMgyMn/Ibw==
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr15217585eds.305.1618850023133;
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwxaqu8Nz38y932354Y2gcGKu9I2RvQcNCKssKJOBhk4VKgjSNbYz6iXMUKUCz+kiKZ1IHPQ==
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr15217572eds.305.1618850023015;
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] power: supply: max17040: remove unneeded double cast
Date:   Mon, 19 Apr 2021 18:33:34 +0200
Message-Id: <20210419163336.64075-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for double explicit cast from of_device_get_match_data()
(uintptr_t and then to target enum) because implicit conversion from
uintptr_t to enum is straightforward (uintptr_t is a integer type).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

gcc v9.3.0 W=1 does not complain after removal of cast.
---
 drivers/power/supply/max17040_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d2053cd0bd13..1aab868adabf 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -486,8 +486,7 @@ static int max17040_probe(struct i2c_client *client,
 		ret = max17040_get_of_data(chip);
 		if (ret)
 			return ret;
-		chip_id = (enum chip_id) (uintptr_t)
-			of_device_get_match_data(&client->dev);
+		chip_id = (uintptr_t)of_device_get_match_data(&client->dev);
 	}
 	chip->data = max17040_family[chip_id];
 
-- 
2.25.1

