Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9178E421DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 06:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJEEzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 00:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhJEEzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 00:55:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F5C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 21:53:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so1421145pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lpcd/dIjLX1XzfbWfSb6TmisR3YFI0hYoc80N7VkYY=;
        b=BhgqGB8g17r5OxfsHfDIYnO7ToRyWkNnL85cxRnFnizGIRfe/9x8l5X5hU8nKLz+ZY
         HsFPQ61tW8MntttqiVH/xXzvFYuwzs8KyoEF0g53UkB2pkqB4Ph82wcd6EdUYb0JGFwy
         bps2xyQHAbImvP851z8re3BufkUhXRoDgfVxQhNCGNgHFtFEwK2NGTNEA4M7VqyM/NS2
         mQyDtwOxhoPevOjCFyu8pJcqm4crd8V6mFO9VwtYq3HJV3jxk8QAJmO1OpsJpjFXaGhK
         LYpvl9Jqs2zxkvnd+L9gsNk+xvugMpBJI65MErYsaJ0NBzvTJGMLOxbwpSUTE3Ol50es
         mpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lpcd/dIjLX1XzfbWfSb6TmisR3YFI0hYoc80N7VkYY=;
        b=uLkcl2/TFX5uqvL9jshsDvSRAP2yi7ijvmUMszKIMDi5BL6slLeLXOtf4cyMD7wMLp
         H3RQHE4W1+9qPDegKyy//iUy1FTwBiGt+tjpepH3jrU05ki6ihZLwT9nV2Lf/UCcrlj9
         dFgN9nZ7WJyBsbjSAhEUY3wBZyUqPMJy7sG3HugWOfJBCzS7SSWKAbRK7oGM0QiIPaht
         p5kOpPDUUoPHJPLJASUDt9Eo4+HMdf9PrBnwKbPdD8RiBGoMoq50hzfpRgiRtrrm7Dm9
         oz1LljeKAQDF9JK1pVBo1D+cOuUCmkY0wUGPISYR6FIxybYh5nS54/Ccd8rsfKgIw/N2
         UTAg==
X-Gm-Message-State: AOAM533jmqKRXY0FZITvCTLpgPd0quIdtxlJzmTLjRLPGSdmHdrxJfC7
        371ixNJ0vN4D7N9oYmalYmc=
X-Google-Smtp-Source: ABdhPJxiLyKrha7hOr7TSfdw329+HXtI4TnawBipdk6FTVxXB+3vU6ujtzp9sRk8CqcgD+7vQP8FvQ==
X-Received: by 2002:a17:90a:29a6:: with SMTP id h35mr1331262pjd.188.1633409596779;
        Mon, 04 Oct 2021 21:53:16 -0700 (PDT)
Received: from unconquered.home.aehallh.com (24-113-252-168.wavecable.com. [24.113.252.168])
        by smtp.gmail.com with ESMTPSA id g22sm19006046pfj.15.2021.10.04.21.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:53:16 -0700 (PDT)
From:   "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
Subject: [PATCH] nvme: hwmon: Do not create min and max values when not supported.
Date:   Mon,  4 Oct 2021 21:53:06 -0700
Message-Id: <20211005045306.1429931-1-zephaniah@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mushkin Enhanced Pilot-E 2TB (MKNSSDPE2TB-D8) provides a composite
temperature, as well as the over temperature threshold and under
temperature threshold settings for the composite temperature.

However for the 5 individual sensors, no over or under temperature
thresholds appear to be available, any attempt to access them results in
an error.

At the moment, that means that reading from or writing to the _min or
_max files in sys (as lmsensors does) results in an error.

That isn't horribly user friendly, and we can detect this situation at
initialization time.

So in nvme_hwmon_is_visible, for the hwmon_temp_max/hwmon_temp_min case,
we now attempt to actually get the threshold data, and if that fails we
return 0 to indicate that the data should not be made visible.

Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>
---
 drivers/nvme/host/hwmon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d712920..063f8aaddcd5 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -164,6 +164,10 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
 		    (channel && data->log.temp_sensor[channel - 1])) {
+			long val;
+
+			if (nvme_get_temp_thresh(data->ctrl, channel, (attr == hwmon_temp_min), &val) < 0)
+				return 0;
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
-- 
2.33.0

