Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D34389A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJXPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:10:32 -0400
Received: from smtp-32-i2.italiaonline.it ([213.209.12.32]:51782 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231569AbhJXPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:10:28 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([213.45.67.127])
        by smtp-32.iol.local with ESMTPA
        id eeyWmj6mkdfuoeeycmWXxC; Sun, 24 Oct 2021 16:59:58 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1635087598; bh=uOI5vCuOV2tfAd2+7pOlCZ4OwSmsY8gQEkJvhPRQhRk=;
        h=From;
        b=fo0oOI411xK0U6FIMl+I1m2izd4s+3hktJzGl8TXZanQvgLdKNksFDTdQQN3mWZ9N
         B8Cvk4KtizrP3hlJLIQhoPltEWMHbTXsEBk8gaFG0LY9LKcqyje/IrKYzG4kqwWK3l
         hyG5t66W2K6rnRPYnZd0tiUVPEuov0XdvMEz+omO5oyw/1bQ0NAxCF6OCcS5KMmqb0
         yi87fyVCrdNMMMn/IiQfrNy+I65909bH+O7JCvwueUO/lgwvOD544KZJiVZg1w00Ri
         oA73RlmD8gzZ9g+EiIbSg4K14Z4RiBuG8TnNzZMJs9gxnTjZEs12lNfN5buOz/XYNI
         Pg7Gdc6NWhVFw==
X-CNFS-Analysis: v=2.4 cv=IrzbzJzg c=1 sm=1 tr=0 ts=617574ee cx=a_exe
 a=Vk63IOK+/LoQucGDvce7tA==:117 a=Vk63IOK+/LoQucGDvce7tA==:17
 a=HtFsc1wawpgt7NxhaP8A:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/6] mfd: ti_am335x_tscadc: fix reading a tsc property from DT
Date:   Sun, 24 Oct 2021 16:59:29 +0200
Message-Id: <20211024145931.1916-6-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211024145931.1916-1-dariobin@libero.it>
References: <20211024145931.1916-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfMVdhLtfg83vJJELVEZQUgLPfSOCgAeUHPnJ0uqOvaJjSPxdNFDp2mVg89wyZw/5MJmQaxRkxAK6NrM9Wp3n7gcol2YLUtS8+/5k5x9fW1Kmt3L/TOvD
 gq2suAyX5umxpBnzBzNhun+cS3rQlQLqxMEXun6WvgCwBpQ0I9okt8PQZLsLNBIJa+/NkkMxVyyAZ3cX7ClDeJdT9ckX2sfaSSuxHt0u6bKso+RMklC0xpqs
 l8KMsnTeJ/4hi6u3IeotF5AXHE1NISWjDQKL7fFtulHaWJrystsPPa9v123xzA3CSfxnTxvGWrcFthBso9dPCg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a spelling mistake on TSC/ADC binding where "coordinate" was
spelled as "coordiante".

As done by commit c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling
mistake in TSC/ADC DT binding"), "the approach taken was to first use
correct spelling and if that fails, fall back to miss-spelled version".

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

 drivers/mfd/ti_am335x_tscadc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 55adc379f94b..53b7a8b7f571 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -141,7 +141,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 	of_property_read_u32(node, "ti,wires", &tsc_wires);
-	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+	/*
+	 * Try with the new binding first. If it fails, try again with
+	 * bogus, miss-spelled version.
+	 */
+	if (of_property_read_u32(node, "ti,coordinate-readouts", &readouts))
+		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
-- 
2.17.1

