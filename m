Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52AF3EF7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbhHRCR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhHRCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:17:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 19:17:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so1344907yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 19:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aU2NnwObR3/vWQ4u0/POg45Aj6bfAktvg+f1Ed8jh+w=;
        b=bxi5ittgZ9mh6tcLPQQ7b9xUAIQ5/sLpcM02KaNvoCL4gJIPPX3Z3AueLjCuJNtlYX
         bBdQspNsklXJydkvS4K7yps7zltGdUPqKdfcSdBwedGg4hgNLxIIug+jkDhHt3h29nQ6
         2FAPCUnIhg47FOaRL349BwJd7jZegB9zvyTykjmnjBXLQcpxfvWFKqUt6x5USFkllvH4
         W76Nr+B9pptPsBcmKdBb7wjjT1z4lCcvvMVsy7InCcVxXt8YxMzcfRRzFRN6YKRUYuNl
         oMsE+25A/M4yW1TvA02Xfz543hK+cLNgNOyg38dopSRGMJdX0OPFpF5YqnRBbaAYhT9v
         J2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aU2NnwObR3/vWQ4u0/POg45Aj6bfAktvg+f1Ed8jh+w=;
        b=S5bEedkEfROAE+dUEVc0l01Ox8Q46XsW1lwMntUNBgqPFinVlpSVtJWd7qZYqBOO4R
         tnZQtahKKc+RRoQUvegbW3dIVnxNRPzqBF94KFaEhvRHtdVo4iFMTMgoLK7heX3oJDAp
         JQtWBy2x0TAPZaE03DTgtspq5pv0JbaCOLM7HbaJff7qPSFSBgzZxWL93JVSk/tgTo/L
         Hq1ubbGMAMOVi8sKtGW4I+Tm7yqtUut1jXbf1DwvGP3YSI5Px6dhXi4wSpfcxxhaD6rn
         PsCHRlXOfISUU+9AjdLs/lkdjrKJRTDCU8mTH5yUpDtkBzppBSs0Th/nCKByzFQPTdSV
         5luA==
X-Gm-Message-State: AOAM533vj2YZ9OvrN8FFRQwWYOTYaNP+Lrj7TvfXPV/9R+sDMpGVXr/f
        j8AtSkeTEoFTio+Qj7eizPhCCIwjl66OebE=
X-Google-Smtp-Source: ABdhPJyNfDSXQfFmt2nxKDc75KDdbk6WVOvx/5kOmOksyJitPli2Kb36pRWtwSBAy3X8HxRS4q7pOAJUl1iexME=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7750:a56d:5272:72cb])
 (user=saravanak job=sendgmr) by 2002:a25:c712:: with SMTP id
 w18mr8231275ybe.390.1629253043246; Tue, 17 Aug 2021 19:17:23 -0700 (PDT)
Date:   Tue, 17 Aug 2021 19:17:16 -0700
Message-Id: <20210818021717.3268255-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2] of: property: fw_devlink: Add support for "phy-handle" property
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows tracking dependencies between Ethernet PHYs and their consumers.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
v1 -> v2:
- Fixed patch to address my misunderstanding of how PHYs get
  initialized.

 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 931340329414..0c0dc2e369c0 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1291,6 +1291,7 @@ DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
+DEFINE_SIMPLE_PROP(phy_handle, "phy-handle", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1379,6 +1380,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_resets, },
 	{ .parse_prop = parse_leds, },
 	{ .parse_prop = parse_backlight, },
+	{ .parse_prop = parse_phy_handle, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
-- 
2.33.0.rc1.237.g0d66db33f3-goog

