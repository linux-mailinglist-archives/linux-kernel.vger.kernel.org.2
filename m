Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6F3EA907
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHLRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234160AbhHLRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628787721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lzfndhflF+wd6yiYGmCwi7SKf8tfaBBXC1snuqNvgik=;
        b=ClUqEg6QLnO8Fg8rzWXKYT081iKwOttuDvqdZJVsdVCkWoeJV+SJ+O4CTDelYsWobdXxQJ
        OhqmtDf5/OXwf2N2bCb6Mka40Szb1RoUXzzPl7pPKTi9CBL20+Nsa7zdMTyBR2+b3gX/l/
        TtBC5+vHEXA+qdj9QP39vGaNQQlPtDE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-V9mShWM3ME-7pxdYm-5xxQ-1; Thu, 12 Aug 2021 13:00:57 -0400
X-MC-Unique: V9mShWM3ME-7pxdYm-5xxQ-1
Received: by mail-ot1-f70.google.com with SMTP id q5-20020a9d65450000b0290510db97edd8so2532804otl.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzfndhflF+wd6yiYGmCwi7SKf8tfaBBXC1snuqNvgik=;
        b=RIcmd/MnpGKPoSsGYch0NOIUfx1VvDJgGlUaWuc7PYf05tWlLwR17JKeODMOJ6vPg3
         Nv3259fV3Fo0mFfKztgbf9wl5Ta1sE+0A72yt2yBFFt+MdEtjw5iVlXdd51k301s6Hbn
         j33seX2iZC5oVUOGj5OEhSpPVCB8a9lL7mVQMdvQWgcKr3Ir2rWXkOZxPg/opQ8rIteH
         z3fYNSXgwxC55RaVzrdkt7I60tw5cSqEiwul/DDcJBKOplGJpbBpKfjlSNX1btDUCDkC
         VP3JnT1SBvbsWJ29B/GKoA5YUyraEbqLUqaMqLCU3jC65ZxizdLbMmIG9H/yAZU7scbh
         4gfQ==
X-Gm-Message-State: AOAM530ZugQ23uT/KOoSeyYWuxeVYpmABf6qhGhaVLBj6Rpd3KHdbgVN
        uUFIuEf+weauN3LwtZsTZA697N/V6KYLKOC2KvBHsMeJiml+Ue9RlF8AAVeZoBzG8Zj8O+v9aa+
        s4rANHFkL7LD+k5NsIUxCkKGq
X-Received: by 2002:a9d:206a:: with SMTP id n97mr4153366ota.247.1628787656516;
        Thu, 12 Aug 2021 10:00:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLJG+qeojkPAWrgQnIckkIT0lYWQZF7QBKca/wrMOL4142OtxbdL+wDGfvvHhTpw7wuRL3Bg==
X-Received: by 2002:a9d:206a:: with SMTP id n97mr4153342ota.247.1628787656245;
        Thu, 12 Aug 2021 10:00:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l9sm733981otr.34.2021.08.12.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:00:55 -0700 (PDT)
From:   trix@redhat.com
To:     tharvey@gateworks.com, mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: TDA1997x: handle short reads of hdmi info frame.
Date:   Thu, 12 Aug 2021 10:00:43 -0700
Message-Id: <20210812170043.1046669-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this representative problem

tda1997x.c:1939: warning: 7th function call argument is an uninitialized
value

The 7th argument is buffer[0], which is set in the earlier call to
io_readn().  When io_readn() call to io_read() fails with the first
read, buffer[0] is not set and 0 is returned and stored in len.

The later call to hdmi_infoframe_unpack()'s size parameter is the
static size of buffer, always 40, so a short read is not caught
in hdmi_infoframe_unpacks()'s checking.  The variable len should be
used instead.

Zero initialize buffer to 0 so it is in a known start state.

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/tda1997x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 1e2a263be9335..0b995424cb346 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -1248,13 +1248,13 @@ tda1997x_parse_infoframe(struct tda1997x_state *state, u16 addr)
 {
 	struct v4l2_subdev *sd = &state->sd;
 	union hdmi_infoframe frame;
-	u8 buffer[40];
+	u8 buffer[40] = { 0 };
 	u8 reg;
 	int len, err;
 
 	/* read data */
 	len = io_readn(sd, addr, sizeof(buffer), buffer);
-	err = hdmi_infoframe_unpack(&frame, buffer, sizeof(buffer));
+	err = hdmi_infoframe_unpack(&frame, buffer, len);
 	if (err) {
 		v4l_err(state->client,
 			"failed parsing %d byte infoframe: 0x%04x/0x%02x\n",
@@ -1928,13 +1928,13 @@ static int tda1997x_log_infoframe(struct v4l2_subdev *sd, int addr)
 {
 	struct tda1997x_state *state = to_state(sd);
 	union hdmi_infoframe frame;
-	u8 buffer[40];
+	u8 buffer[40] = { 0 };
 	int len, err;
 
 	/* read data */
 	len = io_readn(sd, addr, sizeof(buffer), buffer);
 	v4l2_dbg(1, debug, sd, "infoframe: addr=%d len=%d\n", addr, len);
-	err = hdmi_infoframe_unpack(&frame, buffer, sizeof(buffer));
+	err = hdmi_infoframe_unpack(&frame, buffer, len);
 	if (err) {
 		v4l_err(state->client,
 			"failed parsing %d byte infoframe: 0x%04x/0x%02x\n",
-- 
2.26.3

