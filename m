Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7FB4114B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhITMnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhITMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:43:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B81C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so67330965lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hr7++l5WuIJ3QbTb1muJLIYeQhycvVCwIfK8xwCK0lk=;
        b=nDLfjWYlYoJdQDKQVkel8PQOrJt2sQoW4MYJA3uqAsNj59p9NbFuwlUokwasgQHucu
         7VEjc4T0sqUhLEubj8xk5UHvL+XYRKgmCRaHjAM19BwHP/2fdqokZeTfQwslqKWoUEsV
         i/J0hdUos3p3PEQ84D2/iJ0VMrK5lm8I3sR66ovnlB6NZTjvch6Thb0K53KbPVEryUbb
         85gGt3QdgXVtAaF0e2wtR3HAg0XKdUJsEXkv5Z+JmETfWN1wtWCadYtAtsrqtvHey4BU
         uHiehJK1sg9Eb1puxisTNfq3wEnNDb7cbWNVUix+Z7RFZRZXwEAJEXEzDITXj/OaINZ/
         4FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hr7++l5WuIJ3QbTb1muJLIYeQhycvVCwIfK8xwCK0lk=;
        b=mGIstnUJm78j7EI7gLHxZ1cO0QJMAjfCH6s9GD0r2UY1uzF0rPzrBcX6dtfYchSklV
         FBauDvXmQmRlDC0Xdfmypj2b5pYgJzDwy98mW2y5nlFNmiEmx5LGFH5p7+amhFGYLAeu
         FlGSIU6TpCqXRzQ3Y12v5DTw/M0RGF2vJsTEAgqgjTs5EGra8xx9bG8CRGOYC5rJx+ht
         ZON4vnxmNF2qR9AfVN/g32ojbkL6QrxJWTVTwmFMb+8wDNOhWCNYPbuI4ibeHBXJsG94
         u5IGsOtDco2B1o3Q4VoNYjGsAL11tx9y1rs7GB/CyOIYvdvHQP0d+X7jBZGYEMHsfb07
         StTg==
X-Gm-Message-State: AOAM533Uuw+bl7dASk+jnJmXQHGJ1baUAhlX0+vyCwW30/GkEQDA+0jd
        M5/wEY8bozG6AbawgeKQ9b0ylA==
X-Google-Smtp-Source: ABdhPJwoadCgb7r/qWWgGsAlmHH0LQz9izuJ5mTYhJpd9dpLOLSNCUkppvO6+7N7MNxy+hsNTWCTeQ==
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr18180477lfr.295.1632141727145;
        Mon, 20 Sep 2021 05:42:07 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id v1sm630944lfo.308.2021.09.20.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:42:06 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        dinguyen@kernel.org, p.zabel@pengutronix.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tn@semihalf.com, ka@semihalf.com, jam@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 1/3] dt-bindings: mtd: spi-nor: add n25q00 schema
Date:   Mon, 20 Sep 2021 14:41:39 +0200
Message-Id: <20210920124141.1166544-2-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920124141.1166544-1-pan@semihalf.com>
References: <20210920124141.1166544-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schema for the n25q00 NOR flash memory.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..efb3c5e05c5a 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -18,7 +18,7 @@ properties:
       - items:
           - pattern: "^((((micron|spansion|st),)?\
               (m25p(40|80|16|32|64|128)|\
-              n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
+              n25q(00|32b|064|128a11|128a13|256a|512a|164k)))|\
               atmel,at25df(321a|641|081a)|\
               everspin,mr25h(10|40|128|256)|\
               (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
-- 
2.25.1

