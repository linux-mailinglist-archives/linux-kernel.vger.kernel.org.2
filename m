Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14D33EA90F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhHLRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234251AbhHLRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628787782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fA6rYJ8jGaz9Q7oV+LT1wgeqyltB1zkMp7DyaXUnHo4=;
        b=ZcklSGrmt70Rh1u8SQloaEgFQbU+7nJ5yK/V6dbSMqhXCgpUOlfHo3rnRhXSmyDWKCsETz
        KWngt3Yo2bEY1WRDKrlbpcpsqmSntFO3lNgU6TP/KCwRJGtDNNpJ5eyXUExz885bAHtYKB
        gkSB8HRJWVmkKsAq5HfTxpVnmL5jBFw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-KfwXg3bnOAOEerLQQyaZEg-1; Thu, 12 Aug 2021 13:01:55 -0400
X-MC-Unique: KfwXg3bnOAOEerLQQyaZEg-1
Received: by mail-ot1-f69.google.com with SMTP id i9-20020a0568302109b02905090e0df297so2544678otc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fA6rYJ8jGaz9Q7oV+LT1wgeqyltB1zkMp7DyaXUnHo4=;
        b=d/UJAYjCIC1AWVi9kSyK7S6PYx80K5ycTah7XtYcFZS/MXXGFkLbcxoYcqXigzcYYx
         nsy2OwLjX+7odjPMKX3SxxMr+A9P+kTalqoBIuwTAr1Ac8AQoKKBhacqYt0YuB+F98hK
         PwKIkHoKxzdFE8+wWjYh852SIuHuoGepkfxwL4JAlhwNNSOWEmBs1KuFT2QFMGlZc9cj
         s3A2BRFuGbOpr8FWZP3qthxuKvpY6MawfV9ohTTPA8F5Ckm+nL/Ys0NgMFhGpAyLisr6
         e3Mw2rvA/X802xQ6Qq01UqnTib96shk7Yv29GIkaQ674t94btHw2ha2U4FEhY36ILsKH
         uwgg==
X-Gm-Message-State: AOAM5321pguFgoAmoyPQZ2sfHyngIgw0B1+LbGoiKKmi7Q9rRei7pwbo
        RTghUNjPO7i0AE8ksNYZhLn4lAELKvYqfRkXPZElkAEJ3yNMJ0dwWjFbb1HogWaSxno0c9ZooPw
        NAn3fWz7DnDt2ugM6fu8D3lC9
X-Received: by 2002:aca:34c4:: with SMTP id b187mr4171750oia.139.1628787714954;
        Thu, 12 Aug 2021 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfv3Cg/zLBaCtKA1k94ILYil5i/BhCl7FUKSc481O7mxH6K3v5j81NvUZQFAfzy+CDHmaQiw==
X-Received: by 2002:aca:34c4:: with SMTP id b187mr4171739oia.139.1628787714820;
        Thu, 12 Aug 2021 10:01:54 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f8sm321336oos.4.2021.08.12.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:01:54 -0700 (PDT)
From:   trix@redhat.com
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
        ville.syrjala@linux.intel.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] video/hdmi: handle short reads of hdmi info frame.
Date:   Thu, 12 Aug 2021 10:01:46 -0700
Message-Id: <20210812170146.1046885-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Calling hdmi_infoframe_unpack() with static sizeof(buffer) skips all
the size checking done later in hdmi_infoframe_unpack().  A better
value is the amount of data read into buffer.

Fixes: 480b8b3e42c3 ("video/hdmi: Pass buffer size to infoframe unpack functions")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/adv7511-v4l2.c | 2 +-
 drivers/media/i2c/adv7604.c      | 2 +-
 drivers/media/i2c/adv7842.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511-v4l2.c
index 41f4e749a859c..2217004264e4b 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -544,7 +544,7 @@ static void log_infoframe(struct v4l2_subdev *sd, const struct adv7511_cfg_read_
 	buffer[3] = 0;
 	buffer[3] = hdmi_infoframe_checksum(buffer, len + 4);
 
-	if (hdmi_infoframe_unpack(&frame, buffer, sizeof(buffer)) < 0) {
+	if (hdmi_infoframe_unpack(&frame, buffer, len + 4) < 0) {
 		v4l2_err(sd, "%s: unpack of %s infoframe failed\n", __func__, cri->desc);
 		return;
 	}
diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 122e1fdccd962..d688ffff7a074 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2484,7 +2484,7 @@ static int adv76xx_read_infoframe(struct v4l2_subdev *sd, int index,
 		buffer[i + 3] = infoframe_read(sd,
 				       adv76xx_cri[index].payload_addr + i);
 
-	if (hdmi_infoframe_unpack(frame, buffer, sizeof(buffer)) < 0) {
+	if (hdmi_infoframe_unpack(frame, buffer, len + 3) < 0) {
 		v4l2_err(sd, "%s: unpack of %s infoframe failed\n", __func__,
 			 adv76xx_cri[index].desc);
 		return -ENOENT;
diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 7f8acbdf0db4a..8ab4c63839b49 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -2593,7 +2593,7 @@ static void log_infoframe(struct v4l2_subdev *sd, const struct adv7842_cfg_read_
 	for (i = 0; i < len; i++)
 		buffer[i + 3] = infoframe_read(sd, cri->payload_addr + i);
 
-	if (hdmi_infoframe_unpack(&frame, buffer, sizeof(buffer)) < 0) {
+	if (hdmi_infoframe_unpack(&frame, buffer, len + 3) < 0) {
 		v4l2_err(sd, "%s: unpack of %s infoframe failed\n", __func__, cri->desc);
 		return;
 	}
-- 
2.26.3

