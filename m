Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B135FCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245423AbhDNUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:34:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50464 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbhDNUeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:34:25 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWmD4-0007RA-QH
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 20:34:02 +0000
Received: by mail-ej1-f71.google.com with SMTP id g7-20020a1709065d07b029037c872d9cdcso218755ejt.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iWJ3bgZpUCfwGeaD2iQV5boaIsrvYIQwgNIcJKkeRc=;
        b=je7uXCqBRpl44cnDFLYoFm+S/HMP/ia1hCS0uDVDYUYQavNI8QQ+yBG3efbWR9Ns9E
         x6q8OGRClkU0I+H/q3gnmff8kDGUOShNLLgypaqbgGO+htMfcTUsGQZBZ/Vwiab86Z4v
         5VdZcta8i5u2FW6/js99kjrHTmLy5ECRvKeDJWx/AeJAacuguCQxDSbio1HRQrw7mot7
         AcB6b/o6jOg/bWGRqk018OZPHUvd55TaEP98V8xIHvNYzA7/GUiGwVe2Fel2h05pJbbi
         0aRLhugb85xbtPU6g6lRmTSpukyIyHS9RCkSak76MQbUI+D80Qn6QQqbd8Nxb0urh/VF
         EuJQ==
X-Gm-Message-State: AOAM533OQzuTrriGY4AMsT74G9BtE7NUMQQtIQadcwIfrPgHrXBih/yI
        p/DfAR0ZZ6ZKuXALTNzkrEsF+fpnFYZEfYgUl2oyho1ukGqOayiK4oQD6ycPI6QOAkef9i3PotM
        UjqUCk0MJzPV0nSgBfwizIMsQ3Sgy189NP4IUrzhsCA==
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr87958edc.14.1618432442537;
        Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgIg2g0mP+FUvTRFflQtwAfKDR1XJ2BSwJmU+aJUp/4sLcSAVyFpDY3szKBQWx2xkzpd2sKg==
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr87946edc.14.1618432442372;
        Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id q6sm372209ejt.51.2021.04.14.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 2/3] spi: s3c64xx: correct kerneldoc of s3c64xx_spi_port_config
Date:   Wed, 14 Apr 2021 22:33:42 +0200
Message-Id: <20210414203343.203119-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the name of s3c64xx_spi_port_config structure in kerneldoc:

  drivers/spi/spi-s3c64xx.c:154: warning:
    expecting prototype for struct s3c64xx_spi_info. Prototype was for struct s3c64xx_spi_port_config instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c6d7641ea342..eac3c300f806 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -128,7 +128,7 @@ struct s3c64xx_spi_dma_data {
 };
 
 /**
- * struct s3c64xx_spi_info - SPI Controller hardware info
+ * struct s3c64xx_spi_port_config - SPI Controller hardware info
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
-- 
2.25.1

