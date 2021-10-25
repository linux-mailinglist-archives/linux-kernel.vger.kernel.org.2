Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2094398A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhJYOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhJYOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3194C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso9582528wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FoRrI/ixSraN3mS0iMWX+7EoDluMijUSgMuujW8zXZ4=;
        b=PN/or73n3nh1F/9Pw6w9aWByTFLQTjikp+yPEd7f1yb/zsVtGMfkOwui8zVJf3Ngl5
         /37yVh2f2AsKX5cTVXIIU6s08JP/5Iz7etrT05h5eHNm4FTd4qwMn+8ELiaeP2YY6ZJ2
         euP0c+3V3FOpEXJUghbCWWzHX0fX5NMqVxQ/T6xvL8wVtqgZNFY4Zdcnh+L1iam4bQJD
         fbumAf99RCRfSXos0bhVtw0y8becFmJDrO2+C0FKUZbT6vYqRGQKqbk7BG1/ODkjz4pt
         x6HyA9bReXaDWjxvqIFwvHQrSIHrW8l0sDbha4QGn9VXMEECCDG4irvfnP7YbzO19Jlw
         +GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FoRrI/ixSraN3mS0iMWX+7EoDluMijUSgMuujW8zXZ4=;
        b=VSYx2hEwprLw7xwMBRMNRkGT+F3ezwFwRsTPtgqgx57uP1xk1Jv6rDUb+6hFMMzEKJ
         0Mw4sELs7UaKImkTHJNT5RWNMj3oOxLbufVS6PotvvJzijZQMAS9vhTyPMGGJo5gA2jw
         7Fzb+L9xakWa86Rxge/nCtlsq4twyVrbzKfXzeNoyT9FJuqvIPrIfqw6gcsKzDY5jG1m
         EboBpwqVB1DhtF15YPOh+copizCNLVXCFPXCSSXm90z1BrhCxLJh4OWZ4ZfwZVwJkxmv
         nb1GgMfK6dYVqo2yQwqcprfB4VLlyyeK7GjiZ4HhuZPqlS8AT6FzzPzAScb+x9Pf716f
         SqXQ==
X-Gm-Message-State: AOAM532Z3mQrKM735i9n/sI7FvjzYBb3ob9zXgzyOFchuSxkUIrL61Z7
        rC+hPJh3P7XO/+8n5e9lInY=
X-Google-Smtp-Source: ABdhPJyvcpHWsUahunSfKfyOrdfCHAj3AazZh8hXbyCTJQAtavFC40AYvhCXwoNC54IPhErVenBDLQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr15179803wmg.85.1635172334641;
        Mon, 25 Oct 2021 07:32:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:14 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 2/8] staging: vt6655: Rename `dwAL2230ChannelTable1` array
Date:   Mon, 25 Oct 2021 15:31:28 +0100
Message-Id: <18e1857c02edd1dbc81ef7e5b00e42e7cbce4710.1635171518.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635171518.git.karolinadrobnik@gmail.com>
References: <cover.1635171518.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with the kernel coding style, remove the type from
the variable name and do not use CamelCase.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <dwAL2230ChannelTable1>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index bd6927151120..866734ce6195 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -68,7 +68,7 @@ static const unsigned long al2230_channel_table0[CB_MAX_CHANNEL] = {
 	0x03E7C000 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 14, Tf = 2412M */
 };
 
-static const unsigned long dwAL2230ChannelTable1[CB_MAX_CHANNEL] = {
+static const unsigned long al2230_channel_table1[CB_MAX_CHANNEL] = {
 	0x03333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 1, Tf = 2412MHz */
 	0x0B333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 2, Tf = 2417MHz */
 	0x03333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW, /* channel = 3, Tf = 2422MHz */
@@ -578,7 +578,7 @@ static bool RFbAL2230SelectChannel(struct vnt_private *priv, unsigned char byCha
 	ret = true;
 
 	ret &= IFRFbWriteEmbedded(priv, al2230_channel_table0[byChannel - 1]);
-	ret &= IFRFbWriteEmbedded(priv, dwAL2230ChannelTable1[byChannel - 1]);
+	ret &= IFRFbWriteEmbedded(priv, al2230_channel_table1[byChannel - 1]);
 
 	/* Set Channel[7] = 0 to tell H/W channel is changing now. */
 	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel & 0x7F));
@@ -703,7 +703,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable1[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_channel_table1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
-- 
2.30.2

