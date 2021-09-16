Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A9E40E39D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbhIPQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:50:51 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58250
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244370AbhIPQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:46:16 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 143DB40267
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810695;
        bh=Yhq1G2QXar0r4cFBybO4NSb08NdrU83GE13JnS/45A0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QHdhHDshyXPoc4UWXDDNwjIG89n0WPstOlHIeDmhe/SyIAcWFK1fn/wXwUB9kSUzo
         scu1nxq24HwlXWRaOmV20vGgO81k/hIY7wtzRazX+1ZGjFTLWaHJPv2kKdQRrBh3O3
         TMRyJSAXezgbwthpxG5rmlBpGp+u1TvHo+JId5dEXIRFny4+1+vVbtpZohoX6nYifb
         /EyMWsKb9ABnaaiVXs32J/k6ehjAQrXluIZVS3AjxWarXFnsATtM2ikZmjWX7VwHrI
         F1c/CxIfElQ8ZiSfefJ8/NRS/AoJ0cw9ZoXfFdGvFYtCTuzr9FS6zAkVx26/i73zrv
         TaVvvF2UlUJMQ==
Received: by mail-wm1-f72.google.com with SMTP id q4-20020a1c4304000000b00306cd53b671so1028824wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhq1G2QXar0r4cFBybO4NSb08NdrU83GE13JnS/45A0=;
        b=NY/nyasV3WYI070a6W57MOaN9VqSBtffsYauiy2dx6kestwuVe1ZOa4LOveIXum09T
         M7KtmFGPWDTO9It+ynRNESaBF/xmKSjlGhGuq88NiNWSB3wpucm7JVa6nI1o5oRIs1mL
         vN9Mg2kYACdHEk6Y06g61J/0yKJs3HOb4CJbS91bI0lGQUm/27oCltmDgmGk6+IInUNu
         2/dO2kW+JH9g1rVc4n1+E3f6D0vJLg/sRR/PNHQO4SlUMf8vz96w+7n1uh1CJz4HYLqg
         SA94gjXdQTZ3kQ1O44MNFFLB633eS83xD0vHhVwB9sOWuj6lmGsrhYgYF1OIGeNdnCbI
         1GBQ==
X-Gm-Message-State: AOAM5337wiN/SLeqR45NiUcvlNZfExARN0VPQZxA6dvfqT39oHOGVuIh
        PV5j8B9VfXpAl5RAcaVvwQYRW9Ae5cYSC3V4U2S/oMOKT9NqYzA5lhegmuzirv7fzw7nXXqcMfD
        81WdtDagMhazLibnHvrMPtIQXM0S9eLAcaRnA5oGaXg==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr7308613wru.324.1631810694784;
        Thu, 16 Sep 2021 09:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq1vH8eOT/ND9983ROgnkLW8+rrOrnWScKkcM9yJPGmqu5fYfpiRgvk8b/7xrBhLqmDA3GYA==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr7308582wru.324.1631810694438;
        Thu, 16 Sep 2021 09:44:54 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 129sm3747538wmz.26.2021.09.16.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:44:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] spi: sh-msiof: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:44:23 +0200
Message-Id: <20210916164423.134603-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
References: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-sh-msiof.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index f88d9acd20d9..d0012b30410c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,4 +1426,3 @@ module_platform_driver(sh_msiof_spi_drv);
 MODULE_DESCRIPTION("SuperH MSIOF SPI Controller Interface Driver");
 MODULE_AUTHOR("Magnus Damm");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:spi_sh_msiof");
-- 
2.30.2

