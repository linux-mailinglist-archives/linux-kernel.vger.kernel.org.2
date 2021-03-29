Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119A834C1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC2CAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhC2CAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:00:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C045C0613B2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 19:00:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y2so3657570plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 19:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXmpX1Ba7zilYfDg6F+tuPGtDeVeYI/YYDUBGdsu7tk=;
        b=AxRGEDFyw/UtTuPO5DVJUZJe4AEJ0El99ECXhiG8HGGJOCiObbxXdzUtPaaMwrV9/Q
         DolwwYdicOco7JpQNIkAYVO94NuH18DIAeb6g1gLzZJCo1vHv+57tNtTAMY3cA0+Mn6t
         hstCX+2gx8/aW+3c3l6297BAGnTTxKEsPTr1ur1gm69T1kicmQrbUHCSRjg/kblNG50b
         /TfghkHYG2E4/EqUUuxjW5moyIRbdHmtJ2SyJSOSR1XGPsNdnYXpkDC6FXom704pGPrv
         WLKKuytpa4ex5XldX0/Q+gYUMsJYHdhRyxYYkKYtY1zreVTLN8WucwgunzPfnB0znz7c
         QaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXmpX1Ba7zilYfDg6F+tuPGtDeVeYI/YYDUBGdsu7tk=;
        b=kPhIYonZaOY2Dx9sCS7CxViTkpzNB8fAb0YEIKSWd+4+X5RX3wfgqDP1AtrPNPM0HP
         B+wDlpOPu3BiQJqHqJiz4e8cclrK57SkwraQ3ELAIo6aAv8X9r0e0dUK/3M0xocapi8j
         ETYIW65U7EFY9yXezQ0r9Kg9PDwVKypfxNRl5bKWpqKiUgZ7Xxje5cgnrbGoyglKBW7N
         JKbcPcMzqfuO5ZXBseTBSxkjW3cs0fkZJl05QeMdbqc7WywUWUcwehTjDZwLTYVoVOk2
         c8DvGxTcqCxoBolFRkZ9J1X2Mx05mpMTUov5fYIVwA0RDiBla0Q1Im1cR4k/sjNZLZkK
         JnKw==
X-Gm-Message-State: AOAM530GXLZJh0gq7q3bR/A6XuipAKAZRQQtVd9HED6ctjkfZLY/7mJ/
        ajC0yWi1/V0lAdKTjSTiQm4DzQ==
X-Google-Smtp-Source: ABdhPJwsqAXpJ1UUfDcfY9udZQbv53YVF+GAQNvtzSr2Pfm6MH2KKQ3MejypxRUKBNNz0r3tKYdctg==
X-Received: by 2002:a17:902:442:b029:e7:1dfd:421a with SMTP id 60-20020a1709020442b02900e71dfd421amr15134386ple.7.1616983202837;
        Sun, 28 Mar 2021 19:00:02 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.19.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:02 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] MAINTAINERS: Add entry for PENSANDO
Date:   Sun, 28 Mar 2021 18:59:37 -0700
Message-Id: <20210329015938.20316-13-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for PENSANDO maintainer and files

Signed-off-by: Brad Larson <brad@pensando.io>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2a3633b719..272c7a7fde75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2246,6 +2246,15 @@ S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
 
+ARM/PENSANDO SUPPORT
+M:	Brad Larson <brad@pensando.io>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/pensando*
+F:	arch/arm64/boot/dts/pensando/
+F:	drivers/gpio/gpio-elba-spics.c
+F:	drivers/mmc/host/sdhci-cadence-elba.c
+
 ARM/PLEB SUPPORT
 M:	Peter Chubb <pleb@gelato.unsw.edu.au>
 S:	Maintained
-- 
2.17.1

