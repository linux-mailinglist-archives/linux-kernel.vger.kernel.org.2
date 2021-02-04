Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7330F23E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhBDLbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235813AbhBDL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612437930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrAxNKbUv0FWK7BBhhhilrN07Tqfo5INjnGUwYdwxvA=;
        b=GAn28qZ3No3sKBI3+WBMQKg4UwHPcOAxj0aALNEKrMS80hB0A3ae4XNEWRu2VflbrQ7ydN
        s9pJhAzXdPEH9vc5VxNuNLfrm5F+R3I+/60t0AeV2T/ie8I3/MWQTq/P8thBdwzy64E5vR
        WhrwJr7drvLvlYVYZ9LfRCEa2Xbb9bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-rPnL3MCcMLC410HKO7p8Yg-1; Thu, 04 Feb 2021 06:25:28 -0500
X-MC-Unique: rPnL3MCcMLC410HKO7p8Yg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43DE2BBEE2;
        Thu,  4 Feb 2021 11:25:26 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-112.ams2.redhat.com [10.36.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB805D762;
        Thu,  4 Feb 2021 11:25:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 resend 05/13] extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
Date:   Thu,  4 Feb 2021 12:24:54 +0100
Message-Id: <20210204112502.88362-6-hdegoede@redhat.com>
In-Reply-To: <20210204112502.88362-1-hdegoede@redhat.com>
References: <20210204112502.88362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this commit the extcon-arizona code was mixing pm_runtime_get()
and pm_runtime_get_sync() in different places.

In all places where pm_runtime_get[_sync]() is called, the code
makes use of the device immediately after the call.
This means that we should always use pm_runtime_get_sync().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This is a new patch in v3 of this patch-set
---
 drivers/extcon/extcon-arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 72d23b15108c..56d2ce05de50 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -290,7 +290,7 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
 	unsigned int mode;
 
 	/* Microphone detection can't use idle mode */
-	pm_runtime_get(info->dev);
+	pm_runtime_get_sync(info->dev);
 
 	if (info->detecting) {
 		ret = regulator_allow_bypass(info->micvdd, false);
@@ -695,7 +695,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	dev_dbg(arizona->dev, "Starting HPDET\n");
 
 	/* Make sure we keep the device enabled during the measurement */
-	pm_runtime_get(info->dev);
+	pm_runtime_get_sync(info->dev);
 
 	info->hpdet_active = true;
 
-- 
2.29.2

