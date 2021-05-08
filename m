Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FA0377078
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEHHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEHHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:52:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE1C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 00:51:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so6836413pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+LUtwfRs66K7/usQVNOuvgUZ6bVUtHjhJJe+YZ0tm4=;
        b=XzbrTyXsIlZx9V9LAzHOxJrO+jh9aLJKwppP2Nt9laYQ+LNhzh6wrB57Cj+dGr7deP
         XHxqWIA8tICdBbMisUzEyQiWjL1X5ClxrOJk49vSLdo3Bbsh10Ly36w56q+cWMdXMWa0
         wM5WTHq1uoDYuKILe1IFvWycmLPNy314FE8QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+LUtwfRs66K7/usQVNOuvgUZ6bVUtHjhJJe+YZ0tm4=;
        b=NfcBFBfetzEIiCMKH8yqjcosjJAN8iw9V6GMIY78PhAoRYGq8IXspqVBKXZHG4tI/o
         HpCd6yu0RSrCYwD/j24AYGmvp0qT0Oyk5KGX7D2EXriFl0RaNgppwBj7ZYcyNAC+ec7C
         boKz6z48M1aES+uruVGpfqVPCCnz+TC3azdVyp9vlvZU2jqKihWjKjg51Ct5LLPmd7o8
         EERkJeFPu6f1UBw0p5JQ6Yme5B41OetibN5VrY1QAmZigHaH1Ah0/jXQqL6ULQAX8IA3
         WXsc9S2+nd08Id0OACniyukzvjz2PXE5Bp5p7uUV4WHNEpGqE2zGv/t//ufoUiwgtz6m
         ghEA==
X-Gm-Message-State: AOAM5327bRYwmm7eDywDtpLs5Nbot3YynsLXHH84teRP067uzs9164vv
        kPoPmmI/3zoEdrtperMXBNYagg==
X-Google-Smtp-Source: ABdhPJw1M68FCMCBHQWrUE9x47jK+e4cOkD+yJZlFNG2fSj5vu+SjSzR2lLT81gpnUIqLeunnKxQUw==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr29138284pjr.47.1620460314132;
        Sat, 08 May 2021 00:51:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ab8b:4a3d:46ab:361c])
        by smtp.gmail.com with ESMTPSA id b65sm6345091pga.83.2021.05.08.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 00:51:53 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jairaj Arava <jairaj.arava@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [RFC/PATCH 2/2] ASoC: rt5682: Implement remove callback
Date:   Sat,  8 May 2021 00:51:51 -0700
Message-Id: <20210508075151.1626903-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210508075151.1626903-1-swboyd@chromium.org>
References: <20210508075151.1626903-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's implement a remove callback for this driver that's similar to the
shutdown hook, but also disables the regulators before they're put by
devm code.

Cc: Jairaj Arava <jairaj.arava@intel.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Cc: Shuming Fan <shumingf@realtek.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This is totally untested, but sending it in case anyone is interested.

 sound/soc/codecs/rt5682-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 8265b537ff4f..52a6fc56a232 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -280,6 +280,16 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 	rt5682_reset(rt5682);
 }
 
+static int rt5682_i2c_remove(struct i2c_client *client)
+{
+	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
+
+	rt5682_i2c_shutdown(client);
+	regulator_bulk_disable(ARRAY_SIZE(rt5682->supplies), rt5682->supplies);
+
+	return 0;
+}
+
 static const struct of_device_id rt5682_of_match[] = {
 	{.compatible = "realtek,rt5682i"},
 	{},
@@ -306,6 +316,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rt5682_i2c_probe,
+	.remove = rt5682_i2c_remove,
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
-- 
https://chromeos.dev

