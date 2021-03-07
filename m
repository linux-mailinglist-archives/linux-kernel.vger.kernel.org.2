Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB40533028C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhCGPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 10:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231731AbhCGPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615130314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzHOpklWoyzo5455UA/khOTp4eW5fY99G5JNuR2m4gA=;
        b=WkDN6Q/Dm+jjB7eqYI5S2MGnmbOvDTV3xbMi+lrrVYKsRqheFnVomLM+UxC2Nb0PmSnmQE
        8HaojQ3FayIaJo5oDwAQ3lshivr8blENLh6/dcS79pZO+xMPdt6BgbR4ePHKXSDzTYNIL+
        tXQ5h8Uwd7La5jAxJW2BvQ7ATiMv2uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-_vmd6kuPOR2W338ov4OX9w-1; Sun, 07 Mar 2021 10:18:32 -0500
X-MC-Unique: _vmd6kuPOR2W338ov4OX9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A960F1005D45;
        Sun,  7 Mar 2021 15:18:30 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A43D60BF1;
        Sun,  7 Mar 2021 15:18:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 resend 05/13] extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
Date:   Sun,  7 Mar 2021 16:17:59 +0100
Message-Id: <20210307151807.35201-6-hdegoede@redhat.com>
In-Reply-To: <20210307151807.35201-1-hdegoede@redhat.com>
References: <20210307151807.35201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
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
2.30.1

