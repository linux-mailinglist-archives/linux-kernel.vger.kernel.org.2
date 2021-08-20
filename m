Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265743F2739
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhHTHCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbhHTHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:02:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3DC061796
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:01:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s11so8229323pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUMawJHmaVN55KeOYmXXMpF4IBtsM0ibJxP9InePT3U=;
        b=cfe6F5qj4Jt8nPTB++3EMFD13LSQnCt5W1T7f+nwsURdPyOaoxWkxK7ejV+/TjBlAl
         286JuFT2TbviR0Cs5FyNTtow/dF8i1BlTSzUO6wkREDHIv/DCE/MHXI4bHAZ2mbjvPhh
         uYIpW50HZ5tT7/oBPSXBEBvY3oQAID92EeidFuzrMgQ/BBeD5EHPm1CFQ8rggIBs9cqF
         Cjq/kSSiQJVH9FZgkARy+9qk/tViJXQ8s7yzVRPtEW8EQZt4mXf2nQaLgQjj93U9tocp
         MEzYx91Bton4n8yRa5xhzSE0OTpzrv0sqqwwCnzOjRgs+5L8CWzViJx1ycpYOC6EkaRJ
         DS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUMawJHmaVN55KeOYmXXMpF4IBtsM0ibJxP9InePT3U=;
        b=j6bqONxyPzuAbPXiCYctF0C+6IKiolqjLNjBsFQsSBn3Z3HB2S1IRgFU74e3T37j8B
         zFlogV0xbAphAlDbY/Zsli/NaicmL3Z5I10tos3cBuVOwA+WPs49owpiVO73jcdcrs3H
         K9NDZUtsBvaXQ5uC+tIIlGNu6dP55YIevnl3kmakUrpZZSGNEUc622SQkffkWDM8HfMT
         +4Pq0Ty/RCusx900hwRiX4ppBNu62lJxlQArszo/svJjc+PaqwK4aUBQ0B3hfp8RMQQu
         kXFFp6lwOnR/SpHH+JfE4HlNh0njDWKnA8sevCSa0MplAmvntPI/XnfmoaH3X1pju6Gg
         wzsA==
X-Gm-Message-State: AOAM530GKSfNmUsVfv6v8MFTJ9k0GIb/BkkrCSqRHFm8tlPH31nIQfE+
        aVHd3gM4EpDSHullwNc//aW5LA==
X-Google-Smtp-Source: ABdhPJyeGT6KbMX012SXazmmab55jR0ikCRDZYBVmA0rKhnqaVvU8NoigSCgtzgl1Nc867PUNRYxvw==
X-Received: by 2002:a63:125f:: with SMTP id 31mr17473334pgs.98.1629442884410;
        Fri, 20 Aug 2021 00:01:24 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id hd21sm10539997pjb.7.2021.08.20.00.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 00:01:24 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 1/2] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 20 Aug 2021 15:01:12 +0800
Message-Id: <20210820070113.45191-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
 <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on. Add support in the driver for this.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db9d0b86d542..9a644433629e 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -45,6 +45,7 @@ struct boe_panel {
 	const struct panel_desc *desc;
 
 	enum drm_panel_orientation orientation;
+	struct regulator *pp3300;
 	struct regulator *pp1800;
 	struct regulator *avee;
 	struct regulator *avdd;
@@ -511,6 +512,7 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
+		regulator_disable(boe->pp3300);
 	} else {
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(500, 1000);
@@ -518,6 +520,7 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->avdd);
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
+		regulator_disable(boe->pp3300);
 	}
 
 	boe->prepared = false;
@@ -536,6 +539,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(boe->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
+	ret = regulator_enable(boe->pp3300);
+	if (ret < 0)
+		return ret;
+
 	ret = regulator_enable(boe->pp1800);
 	if (ret < 0)
 		return ret;
@@ -767,6 +774,10 @@ static int boe_panel_add(struct boe_panel *boe)
 	if (IS_ERR(boe->avee))
 		return PTR_ERR(boe->avee);
 
+	boe->pp3300 = devm_regulator_get(dev, "pp3300");
+	if (IS_ERR(boe->pp3300))
+		return PTR_ERR(boe->pp3300);
+
 	boe->pp1800 = devm_regulator_get(dev, "pp1800");
 	if (IS_ERR(boe->pp1800))
 		return PTR_ERR(boe->pp1800);
-- 
2.25.1

