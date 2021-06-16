Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670363A961A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhFPJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhFPJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:29:58 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFBC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:27:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cc2e:97ae:7127:22f8])
        by michel.telenet-ops.be with bizsmtp
        id HlTo2500d51zX4F06lToiJ; Wed, 16 Jun 2021 11:27:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltRps-0009M8-AF; Wed, 16 Jun 2021 11:27:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltRpr-0060ZB-Og; Wed, 16 Jun 2021 11:27:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] of: kexec: Always use FDT_PROP_INITRD_START and FDT_PROP_INITRD_END
Date:   Wed, 16 Jun 2021 11:27:46 +0200
Message-Id: <a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623835273.git.geert+renesas@glider.be>
References: <cover.1623835273.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b30be4dc733e5067 ("of: Add a common kexec FDT setup function")
introduced macros FDT_PROP_INITRD_* to refer to initrd properties, but
didn't use them everywhere.  Convert the remaining users from string
literals to macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f335d941a716e841..3fe585d5a82732e7 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -318,13 +318,13 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		goto out;
 
 	/* Did we boot using an initrd? */
-	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
+	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_INITRD_START, NULL);
 	if (prop) {
 		u64 tmp_start, tmp_end, tmp_size;
 
 		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
 
-		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
+		prop = fdt_getprop(fdt, chosen_node, FDT_PROP_INITRD_END, NULL);
 		if (!prop) {
 			ret = -EINVAL;
 			goto out;
-- 
2.25.1

