Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040CC3FE7DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbhIBC4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbhIBC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:56:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BAEC0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 19:55:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p69-20020a254248000000b00598282d96ceso744211yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 19:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tjSyGojTOT8uYCifLvLdr4amA8l8CDhQi4qAmFSjHg8=;
        b=NUaF4WJ6oZa5lpk/IiiIJ0R3QbFs2N3ApjmoemgvLZkF2vVGNK1ttkWqATbJVTg2R3
         1dR7jf0TtWVEkcENrRJqt2NFC3IYu4Uufevgq2aM1OzOtkhKjbpj62a59O19dplK+5NL
         r8tQw626ubHYPXeRUJafN9ubJQYNkXglCC/UgrWI/SE8fzmhwKoLS5o6AZQ4JUv6cjX8
         Ax4/og6p55XQKqEb2zj76gPWC/xfNSvaXugCuG4CtquiuhC2axyCuVlAlwElb3bJRqBd
         ciqf8Li7nDtv+42zKvi40yvQ6W3Ar2obFSY4LUhptC/stQU1TfsLAGg2FtBrUgFFX0QN
         HWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tjSyGojTOT8uYCifLvLdr4amA8l8CDhQi4qAmFSjHg8=;
        b=N78MhW1BSiMw8mSTVGZi6dG0z19mkn+tXP9d8auQSlJ6dGM8nRqmnO5D35mMHP6ZvM
         13rxaKQQxecRoJ/ayUOnPcT8W66KrWr9JoRxktFqA58Cn6RdxoNwki2IC0BOr19JU7tc
         6AApQgwvkOZ7QXuCAc+wuqTLk5wSR35uUOkRbozZ6XEyeYEKWAm40T75s1MSHx8+pbjg
         v/EIqyKi1IL0VcQD79Y3s8aiL6GZYkO9D2Z6x6vTjHFLSNJmzObwuCinMLtYbBQJBclp
         FGDL1vwBhWVkM49JT9RJFisvTKKaFVpB8Fy8EcVZ8cMRFxD6T39cL1fvyii6ir5YG5WA
         veWg==
X-Gm-Message-State: AOAM533et3Dvb7p8B/Rn8ohgE3JXniGE30ebOWecGfLycOx5NglQpvCZ
        lOO5UxSRY/HxIG9rqQYL+q8OX0D03OVKaO0=
X-Google-Smtp-Source: ABdhPJyc1/FZExAbR1nIydLj5ad1RBb0+ykfyYU2JXEXQOtJcQqi7SJtFMPOeSkQkh9TiI23NXiJ6yeOth8BWIk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:17e:f0b7:5862:e47d])
 (user=saravanak job=sendgmr) by 2002:a25:2142:: with SMTP id
 h63mr1586569ybh.70.1630551336984; Wed, 01 Sep 2021 19:55:36 -0700 (PDT)
Date:   Wed,  1 Sep 2021 19:55:27 -0700
In-Reply-To: <20210902025528.1017391-1-saravanak@google.com>
Message-Id: <20210902025528.1017391-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v1 2/2] of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want fw_devlink creating device links for bus devices as
they'll never probe. So mark those device node with this flag.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 74afbb7a4f5e..42b3936d204a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
+	/*
+	 * If the bus node has only one compatible string value and it has
+	 * matched as a bus node, it's never going to get probed by a device
+	 * driver. So flag it as such so that fw_devlink knows not to create
+	 * device links with this device.
+	 *
+	 * This doesn't catch all devices that'll never probe, but this is good
+	 * enough for now.
+	 *
+	 * This doesn't really work for PPC because of how it uses
+	 * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
+	 */
+	if (!IS_ENABLED(CONFIG_PPC) &&
+	    of_property_count_strings(bus, "compatible") == 1)
+		bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+
 	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
 		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
-- 
2.33.0.259.gc128427fd7-goog

