Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67244B928
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhKIXCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241481AbhKIXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636498768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HsorBG3OhmC1gdGD3R/J+05rQPjLba58q4aGElHCbkY=;
        b=dogYiZiBKC+hjrIzAHPM2XiuUoUzD44dEg+nIyDD3H0uzABFf/bJlmVSGZjMFDMoa/bBif
        zucRDBf/6f2BWORe8lUu5o14k5ei7UHfYtbAKklZIB70lJEyBgMC9bRdp2gg+bMi7dR+DG
        UFMaq9XPNY18uaH1uFG4CcNZjqivCBk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-XbtcXuMLN6GAfNdLK6id5g-1; Tue, 09 Nov 2021 17:59:26 -0500
X-MC-Unique: XbtcXuMLN6GAfNdLK6id5g-1
Received: by mail-wr1-f69.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so63314wrj.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsorBG3OhmC1gdGD3R/J+05rQPjLba58q4aGElHCbkY=;
        b=FD7W344+vEsCfzaUbXGiGQVx1ccg7JvL1tqSONnXTjs0GnpjEs9utOMZELLe0uSWKy
         0M8ggvy6PFIWRXqk96Vfbj6Mh9tUuKol8p1ljMb0UkXF2tgxMlhkPvA3KA+5EvGocEoz
         V5i8eb/5vE/3Fv/Dbu+Z+IcaCIGSgKVqlWwvxSagdSjpeSfZpp9z594T4aK6TuTXJr5y
         y0m2h0EvtzdAmJ4NTHVN5QFh9ve9C0Wh2FvcYkGIGglffWWEgerUEzG3qnYqvv75L8MK
         poStL73pDf2J4eNtRaPdDjLK7NZrh7RPUXGuNj7tCFuviB0r20PVdLJWJv6U0hoz61/7
         3bmw==
X-Gm-Message-State: AOAM531jROf92+rethavUyKfnkq1SB1CZKqG7yuXSh99E1sqBNa1IwFe
        HvGQSPxfFcHu9Z1lB8MI3YfmArNaPEmMHkRGJBwPQk3mrblAJ+6geTa41VCjST+ej/wcJ8oxMuA
        nSv4xf4RyJW3gWymvBnhdNJS7lfTCASvQfhDTjgm02VHaQkwjnCp7PhtCyYOo3M8CJ81Ogn9KD5
        g=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr14014127wrl.24.1636498765590;
        Tue, 09 Nov 2021 14:59:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEHX/T5zHdYk+ugheuyRiCbyChIuGARQoiUGw6w0JBvfOLdEYpkxN9RISrWa+2z4RDPRVKCw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr14014098wrl.24.1636498765414;
        Tue, 09 Nov 2021 14:59:25 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i17sm3926884wmq.48.2021.11.09.14.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:59:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] spidev: Make probe to fail early if a spidev compatible is used
Date:   Tue,  9 Nov 2021 23:59:20 +0100
Message-Id: <20211109225920.1158920-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Device Trees don't use a real device name in the compatible string
for SPI devices nodes, abusing the fact that the spidev driver name is
used to match as a fallback when a SPI device ID table is not defined.

But since commit 6840615f85f6 ("spi: spidev: Add SPI ID table") a table
for SPI device IDs was added to the driver breaking the assumption that
these DTs were relying on.

There has been a warning message for some time since commit 956b200a846e
("spi: spidev: Warn loudly if instantiated from DT as "spidev""), making
quite clear that this case is not really supported by the spidev driver.

Since these devices won't match anyways after the mentioned commit, there
is no point to continue if an spidev compatible is used. Let's just make
the driver probe to fail early.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

This patch has only been built tested. I'm posting after a conversation
with Mark and Uwe on IRC.

Best regards,
Javier

 drivers/spi/spidev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git drivers/spi/spidev.c drivers/spi/spidev.c
index 1bd73e322b7b..4cfa250f16d8 100644
--- drivers/spi/spidev.c
+++ drivers/spi/spidev.c
@@ -751,9 +751,10 @@ static int spidev_probe(struct spi_device *spi)
 	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
-	WARN(spi->dev.of_node &&
-	     of_device_is_compatible(spi->dev.of_node, "spidev"),
-	     "%pOF: buggy DT: spidev listed directly in DT\n", spi->dev.of_node);
+	if (spi->dev.of_node && of_device_is_compatible(spi->dev.of_node, "spidev")) {
+		dev_err(&spi->dev, "spidev listed directly in DT is not supported\n");
+		return -EINVAL;
+	}
 
 	spidev_probe_acpi(spi);
 
-- 
2.33.1

