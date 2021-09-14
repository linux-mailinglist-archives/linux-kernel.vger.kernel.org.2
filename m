Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6F40A57E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhINEk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbhINEky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:40:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C0C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h135-20020a379e8d000000b003f64b0f4865so44769387qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WuAb6MBtSzivvvxQ/9C3pYrE2NS/OY1FoVAPECcMVH8=;
        b=ZS1xfMYO9pAzIGQV/1sxw1crQCmAvV8BSwibxuXO/JZE8LOahY4//M56ZxNpet+iZJ
         4ADvIWZNzVkL8Dp1tw61NtG3LNURXLBS/Lw6bsBRkEx7KJhY2b2EsZ8QeWV3HVkXFrHB
         J6y9WaKDWBRBxx6+1hG1xKGsqG3dzYBA+ltCk0Z4dJcFW4dprd80w2DYeyxdvFhe6VCu
         mstjgRDL0LaiuRG0oa8/k7S6H5IctiQYmoRExDz5+12oiDEC0/dwyow913VYJKTZ/q4H
         GNzuBcJG0VPopyVRn840DnpG3CaRYAVUTWod6ft3JF8y2u8lD3N70MjrSmdJon2lAcDt
         bloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WuAb6MBtSzivvvxQ/9C3pYrE2NS/OY1FoVAPECcMVH8=;
        b=MF0T9HAIb0jxxGBMY0gvS2BsZrqyApVnDBoPKBwmc3IryvxW3agvZeFCQ/etzktipJ
         HWEolp1Fn58tt1ccSuWPZYPiigENFOiDyaBk/kzpJvNaa/x0cyq5INnYCkYIqBzw0EgG
         JAWIBhcEQkn/tR+wJZxl3vfr5oU8a1HpwbzmVApOHuSuki9yJ6SNr1yyRNt2nmC735eL
         RzQ1RvbugKHcaxRtHzuzpO1HX4DdeU9myexv3gPEyiLjSBkUGWiccliuzUpZ8JB8cHNF
         vbbC6dlblQgQJy5n1xssDMCUb++onl7iTwcEVk/CF8Wcp6tqGT+75/0oMTcu6/UwnXha
         uALA==
X-Gm-Message-State: AOAM531YXohzg2+QqydxxXO0wI7f41EBsbxgZIEzSfosmtjIJ+Y7ENUW
        jV2VfUqbeCaHZSED3A0PjAYxTAqVo4KYvtA=
X-Google-Smtp-Source: ABdhPJytExutN3sPJdjCSpanacJQUd1v4hXJQqWst3c99534ajywNwY7lP3B8tRPOWpFgyVBr7R2/M7n+bmDdzQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:48b:108c:f6a1:56f3])
 (user=saravanak job=sendgmr) by 2002:a0c:90ef:: with SMTP id
 p102mr3421090qvp.48.1631594377369; Mon, 13 Sep 2021 21:39:37 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:39:23 -0700
In-Reply-To: <20210914043928.4066136-1-saravanak@google.com>
Message-Id: <20210914043928.4066136-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v1 1/5] driver core: fw_devlink: Improve handling of cyclic dependencies
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have a dependency of the form:

Device-A -> Device-C
	Device-B

Device-C -> Device-B

Where,
* Indentation denotes "child of" parent in previous line.
* X -> Y denotes X is consumer of Y based on firmware (Eg: DT).

We have cyclic dependency: device-A -> device-C -> device-B -> device-A

fw_devlink current treats device-C -> device-B dependency as an invalid
dependency and doesn't enforce it but leaves the rest of the
dependencies as is.

While the current behavior is necessary, it is not sufficient if the
false dependency in this example is actually device-A -> device-C. When
this is the case, device-C will correctly probe defer waiting for
device-B to be added, but device-A will be incorrectly probe deferred by
fw_devlink waiting on device-C to probe successfully. Due to this, none
of the devices in the cycle will end up probing.

To fix this, we need to go relax all the dependencies in the cycle like
we already do in the other instances where fw_devlink detects cycles.
A real world example of this was reported[1] and analyzed[2].

[1] - https://lore.kernel.org/lkml/0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com/
[2] - https://lore.kernel.org/lkml/CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com/
Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e65dd803a453..316df6027093 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1772,14 +1772,21 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * be broken by applying logic. Check for these types of cycles and
 	 * break them so that devices in the cycle probe properly.
 	 *
-	 * If the supplier's parent is dependent on the consumer, then
-	 * the consumer-supplier dependency is a false dependency. So,
-	 * treat it as an invalid link.
+	 * If the supplier's parent is dependent on the consumer, then the
+	 * consumer and supplier have a cyclic dependency. Since fw_devlink
+	 * can't tell which of the inferred dependencies are incorrect, don't
+	 * enforce probe ordering between any of the devices in this cyclic
+	 * dependency. Do this by relaxing all the fw_devlink device links in
+	 * this cycle and by treating the fwnode link between the consumer and
+	 * the supplier as an invalid dependency.
 	 */
 	sup_dev = fwnode_get_next_parent_dev(sup_handle);
 	if (sup_dev && device_is_dependent(con, sup_dev)) {
-		dev_dbg(con, "Not linking to %pfwP - False link\n",
-			sup_handle);
+		dev_info(con, "Fixing up cyclic dependency with %pfwP (%s)\n",
+			 sup_handle, dev_name(sup_dev));
+		device_links_write_lock();
+		fw_devlink_relax_cycle(con, sup_dev);
+		device_links_write_unlock();
 		ret = -EINVAL;
 	} else {
 		/*
-- 
2.33.0.309.g3052b89438-goog

