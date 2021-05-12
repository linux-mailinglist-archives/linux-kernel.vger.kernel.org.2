Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD137BF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhELOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:02:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58764 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhELOCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:02:03 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgpPy-0001iA-Q2
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 14:00:54 +0000
Received: by mail-vs1-f70.google.com with SMTP id g28-20020a67d49c0000b0290226baf5716bso11211665vsj.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u38nZ0pTtHkniDD+jsScJheTZTLEaNhZSOY8TVKmDRU=;
        b=Zp8WNXtLuFLkdkqUZhGvtd6GiDdvfoqjqFTNmUTUS0jbIbab9U4rDM9NnwEDFVdgze
         I6rNnPr+uIIhj8dE9tJUYD/EJWdV0bMW5HIR9cV93CUsyD7Y7fD67NCUo+aQ9XkqHH//
         s4hq7UWUZzVcvpmx7GtbMJG8/eigT0u+/iu/OVuFf/kCXAlbtj5crpi6yCmyHjzPXwNv
         CUQuygFW26ApPbWOwyht2t+vgMCTkuamJ5LZ3pxBPtz6gERExBjIj7C1Tl0yaQmMVdDY
         w9t8aGTafAypWlsJLUY1e/dXAs38EI6W9AoKg0X8DGVc6xLgZEY9wMIHd1kgUkOeBh96
         E7zQ==
X-Gm-Message-State: AOAM5301GRg05zKfygMAeFxyr9qR741/ge3OErkO3bMq61cJ/hBbV7Xt
        cXvD7Uwe/fLD+zvmMDXKcB/iRx7J2Onhi5nocDVm6v+VdoDIzfXaVU9OS9ErxXRm/o7C161f0iZ
        8vYn8YtjxXQFbNW2MwvIslGTPKS+x14IB07gRDKee+A==
X-Received: by 2002:a05:6102:124d:: with SMTP id p13mr31050546vsg.21.1620828053628;
        Wed, 12 May 2021 07:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytaTLOcSZA3NzpgsIkFHShdPIHNDYEqFobPbJyqY0n/46iR+at+Pd1cdk9ox0eBJMtmUkyMA==
X-Received: by 2002:a05:6102:124d:: with SMTP id p13mr31050443vsg.21.1620828052929;
        Wed, 12 May 2021 07:00:52 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id y4sm804927vsq.27.2021.05.12.07.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:00:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Charles Gorand <charles.gorand@effinnov.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] =?UTF-8?q?MAINTAINERS:=20nfc:=20drop=20Cl=C3=A9ment=20Per?= =?UTF-8?q?rochaud=20from=20NXP-NCI?=
Date:   Wed, 12 May 2021 10:00:46 -0400
Message-Id: <20210512140046.25350-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Clément Perrochaud bounce with permanent error "user does not
exist", so remove Clément Perrochaud from NXP-NCI driver maintainers
entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index efeaebe1bcae..cc81667e8bab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13208,7 +13208,6 @@ F:	Documentation/devicetree/bindings/sound/tfa9879.txt
 F:	sound/soc/codecs/tfa9879*
 
 NXP-NCI NFC DRIVER
-M:	Clément Perrochaud <clement.perrochaud@effinnov.com>
 R:	Charles Gorand <charles.gorand@effinnov.com>
 L:	linux-nfc@lists.01.org (moderated for non-subscribers)
 S:	Supported
-- 
2.25.1

