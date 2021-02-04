Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D931003A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBDWkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhBDWkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:40:23 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A9C06121D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:39:31 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d1so3771366qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fMDPsdN1ZsR+zEXg9vJD+kFHk1s81WX1B2VgmiFlBCo=;
        b=MAmgbOjKXaBWS7djx2mdWRSZ98QgM3rlXCkM86ik/O9X/8oYlnPDa9CtfraqsbgPqO
         WoljRA21yWpSvHYvq+Hy01ZLLm7MYcWJO4Z4tEseLwyYvcMtI0LUx3kdN5zjhekFP4LK
         6qEN17ZqoG1GG01w4NbXPrydPvjhT1G03dKFIr5h/VxmOPP6Jv9N9s+lvQ2h6GUqTORx
         9bCVRqcCMk3/a7zvTFBHVYwDQQpW3ViEFlVRVRoiZ1HzCL2aPeNQ0QgW44ycCJMGHRD/
         TfiAtRCiibAOlFHb9k7McuoML+mrxnoLWmFr0nDHEUwLbtND3TglXYhopqIDnoCE+OAd
         C80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fMDPsdN1ZsR+zEXg9vJD+kFHk1s81WX1B2VgmiFlBCo=;
        b=DH8jnOa7NKTF8OvFTJy5jKKhaWNTXTXHZmNBZpimc/4uw0DZlfV66cTd6PoSJuEBR2
         7gc7ZCkgfmKGoxOgsFLn/mFMWHmQeC9HGnnFdc70NCeG40evYNGw0bM17vLs06M/ou63
         lu7uuW9yFPaTziS8rdvJ5p8rkTcJUOwCNeSbl91HXNfPjskWjtdkJvUU64FISPA1dibD
         5NIzMMdxLlCf6SrrPMYB9qNkSXv1eWidTcZtUc02tcbFiISQqeqEmXbXigUtAu3qfZ40
         4LCrSYAuozb+uOcPbVE7euQqWv5KrBcP+06B9hYvnvUoJYjSdsR30y2CAVA0qNx3vhxG
         3qFQ==
X-Gm-Message-State: AOAM531/c1LzSOQri+99oesFVktQhiH/ff9Uw79rLOct9Gm3bYNZT8A7
        4X+kk9sFEWBjcVGRlhoAxhLoLznAI4ZHl0Q=
X-Google-Smtp-Source: ABdhPJxhVr7yY1fkv/ewbvEN7CQ67yRYV2bPFegGbTAbHjj78kRnl1GnAY45xPUMROpcQrCKMrdNw080x8xteZ4=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8475:2f1d:e8b4:f65a])
 (user=saravanak job=sendgmr) by 2002:a05:6214:b33:: with SMTP id
 w19mr1710735qvj.35.1612478370681; Thu, 04 Feb 2021 14:39:30 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:39:19 -0800
In-Reply-To: <20210204223921.1693487-1-saravanak@google.com>
Message-Id: <20210204223921.1693487-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210204223921.1693487-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 2/4] of: property: Don't add links to absent suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver core marks a firmware node as not a device, don't add fwnode
links where it's a supplier.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6287c6d60bb7..53d163c8d39b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1103,7 +1103,9 @@ static int of_link_to_phandle(struct device_node *con_np,
 	 * created for them.
 	 */
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
+	if (!sup_dev &&
+	    (of_node_check_flag(sup_np, OF_POPULATED) ||
+	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
 		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
 			 con_np, sup_np);
 		of_node_put(sup_np);
-- 
2.30.0.365.g02bc693789-goog

