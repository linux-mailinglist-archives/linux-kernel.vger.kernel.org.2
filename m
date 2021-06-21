Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A030D3AEC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFUPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFUPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:25:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FCBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ho18so29470727ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oYLvuc0V/S18yIQqWdLV5JLc1q9E1OswQM3F6JOKZ0=;
        b=UqsNIBwvMkUjmMMyqiqLP/LM0W9He4hmM1FkQIFZ8BOoTeCguIay3GYpQmu+q9Q7Ri
         AUhZPBuul3kzzu/h69CbfV2YeeDl2gMvUbRI2cLn2Oir4/MduckfZUXcPNRgjltG6D51
         oULuTXtFlLr+JsLvRsFVnSHq/FTcMbdTYKnDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oYLvuc0V/S18yIQqWdLV5JLc1q9E1OswQM3F6JOKZ0=;
        b=s37ePliNAmp6QnU41YNbcDkbxnE2SfAeQ9+Vj7ugptbrM/sqAFddCmRA1XXns0Nq4t
         gm+QrbAAkQGWj7iCHrsmobucWFRzi7xZV828gjBdjmVQva+XJS505dKTv84VIajyneDU
         KMqVJnfcN+ItfI+el+FvMyx+zPsiag7btyWgzq5Ax+ScY70R+pLoKJRlOGLj7lfx8Rk7
         unsMNH8IBuCoY2Ch8Mk9T7IPjDN4/zLvK4Z4lZl4XTHEJhVIaMaznQgT7Bg5yd/3UJot
         9nMsLTkiGmJ+/sx0iHiNCsdaYNDbwEplpW0IJwx9Gnk9e2KiVUv37uqIenXcnpOQlBIP
         iJvg==
X-Gm-Message-State: AOAM531SMUUmlHafS9b1CFL80NvJq0F5DITP01OwJRly0XOM4MtCBdvt
        +hQcXMDs1zSUjr1k5yXRkCPR+w==
X-Google-Smtp-Source: ABdhPJxxBfJTPLWxmXhGqokZJ1ETiQC3lDNJcxZUnyLmDD1MBtbba0rW5okm+/gZm1m5FXjEOJZz3A==
X-Received: by 2002:a17:906:914a:: with SMTP id y10mr9073079ejw.235.1624289014431;
        Mon, 21 Jun 2021 08:23:34 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id q20sm5021079ejb.71.2021.06.21.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:23:34 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-mtd@lists.infradead.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC 3/3] mtd: spi-nor: macronix: add entry for mx25l3233f
Date:   Mon, 21 Jun 2021 17:23:20 +0200
Message-Id: <20210621152320.3811194-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has the same JEDEC id as mx25l3205d, so people will have to
provide a correct compatible string in DT in order to distinguish
this from the mx25l3205d. It cannot be done at run-time by parsing
SFDP tables because mx25l3205d does not support SFDP.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 42c2cf31702e..8afbdb7c21b4 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -40,6 +40,9 @@ static const struct flash_info macronix_parts[] = {
 	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
 	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
 	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64,
+			      SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ ) },
 	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
 	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
-- 
2.31.1

