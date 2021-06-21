Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D553AEC39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFUPZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhFUPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:25:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i24so8812308edx.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3r07y9YpsFP6j4d+xRWFs7X9CG/fq7/6JrKEYt5N5o=;
        b=CHABTvlmyx94gAxeZB5YtmGfeA6XVooApQ/DywwdzYNjdpPELUHddLQekNcNyesLkL
         Gf+rfbqW2gTjqwBNOZOFZiU/fAuqKqi5S/19FRyRU/Lr/uRGnmFw/HT8/y8mbAvj8M/g
         3WnsIij+jTn3x1LLYjlqiKrHR/RsCgi+rvwyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3r07y9YpsFP6j4d+xRWFs7X9CG/fq7/6JrKEYt5N5o=;
        b=TnuC65zHOMpFfYM1tiTPG60E7CO2ka+LVXg7OLmjI75uGf8bvzy6m+8rKIE73OthGz
         j5VMw+Ch9MoowJbb/2wDwMlNnnEkJkkwwc55vvNGktZN0KVYlUR1MM2HK/HnnsQYRAxd
         s0l3IIFj87CyS5L+fzmtiluoP40fY9AL4YXlrU+WPBWjLIGA9ZGL4ZH5oLQegTKfOsyD
         YtiylKIucQAWOeQicyz7T2B+DUQOsOk5tPF35hH50vcbt8eAHASiCEiVbAmw/AI53wXA
         aO/6hQNbCZUgkjmsw3GpV9/qQRiR3bxwyXKpOu5eVLg4LEbnCc7DTerTOUx8A6CvvyAO
         16Ww==
X-Gm-Message-State: AOAM5333k5jOUGMaaCF+ofaCf5gdZS8sYuJ6MuQBBEkCvtSRQSrSq/MX
        ZKDjChUAjHq0a/q4gf3omTp/lA==
X-Google-Smtp-Source: ABdhPJzUJHxyH3gAr5+sjINmrbjx11wFZWfZekatWANxoZQ4LpKR+YPkhYw2YxZYuD+unZfaNFeSbA==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr22094953edb.187.1624289012404;
        Mon, 21 Jun 2021 08:23:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id q20sm5021079ejb.71.2021.06.21.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:23:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-mtd@lists.infradead.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC 1/3] mtd: spi-nor: core: create helper to compare JEDEC id to struct flash_info
Date:   Mon, 21 Jun 2021 17:23:18 +0200
Message-Id: <20210621152320.3811194-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check will be used elsewhere in a later patch, so factor out the
logic to a helper function.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/mtd/spi-nor/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bd2c7717eb10..6a1adef0fe9f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1850,6 +1850,11 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_xmc,
 };
 
+static bool spi_nor_match_part(const struct flash_info *part, const u8 *id)
+{
+	return part->id_len && !memcmp(part->id, id, part->id_len);
+}
+
 static const struct flash_info *
 spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int nparts,
 			  const u8 *id)
@@ -1857,8 +1862,7 @@ spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int nparts,
 	unsigned int i;
 
 	for (i = 0; i < nparts; i++) {
-		if (parts[i].id_len &&
-		    !memcmp(parts[i].id, id, parts[i].id_len))
+		if (spi_nor_match_part(&parts[i], id))
 			return &parts[i];
 	}
 
-- 
2.31.1

