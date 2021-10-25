Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67664398A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhJYOen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhJYOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y78so5653182wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+z/ZcoReYlIJ2lw4E6zEFrJlcdgWlKqR/PEXpbV0jM=;
        b=c5N5lccctg9plGihtX+N67paNhze1WZdjP2QwnI5NzwvGbFDif6mEOJhif7BQjNDPk
         t8WXA1LwbIiYV/aUPog/YZ4+zOelQO7sElg7hckVd9/eVKJ1MmZ4RGYVX3Q5kx2/VUeY
         QrH+a1dlA8xAc+p9zWXpyGIVdDzwXMKxygwDWfxU5j3g0opYLC3T12jnxQUHC9M3Tp7m
         NySuBuiUZVdWUoisLwvKEBJ/6zm5CfIJhcqN2LDW2c3gNHltPGdtGLcmxcT5AI6Bu6Wk
         VKlmDvsda04hFtJGr1z7Xpu6s/jW6OPLQDaWseJ75q0f3/6XQFmR7qkhKYI4A8AudLDO
         NYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+z/ZcoReYlIJ2lw4E6zEFrJlcdgWlKqR/PEXpbV0jM=;
        b=SOkBe7/U1I5tKmEyVEeftnC00Uo8SPqXih6MquK7qN1wkUFT4eJ5WrcDZhefxiph7h
         wc9HCLCZywolnBzwxcGCxOLYFUQUeeuEqfVrIlSRCrme//QfGtF9ylOYlFQ9d+yASzGr
         +DJBJZyFMWlftDZURCd6Gz72VpeiRgabe9AhBlQsThcCpge4JyCJt0knW3ai/wrCVkFq
         NVQxMkzUVIeBl9oPoJNJoXIwF7I8j5aPFdrhjbTQrsSWuh+I5lxtZbTTCRSBfvyebfas
         fVMm91it75r1Wq5zvPV9jnbHTMyS+RWAcUMsCXDjPAR/HRxesHo0qGSC1nh7tOKplqOn
         dGCA==
X-Gm-Message-State: AOAM533wMBc/4Lw8An82bfZ7I+f5NsiE8nHl7JJ6qmkxpcgSM9cpKj57
        jRlnvTlCpdiPEZCOalolc8Y=
X-Google-Smtp-Source: ABdhPJwUgOwYsaaK3lzD6UmOwcrEE/14iUIL6PVhS6+LI1VJxr7jc9xQQDPhTBNwKNdJnYxEdXMpXA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr14762190wmi.11.1635172337582;
        Mon, 25 Oct 2021 07:32:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:17 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 3/8] staging: vt6655: Rename `dwAL7230ChannelTable0` array
Date:   Mon, 25 Oct 2021 15:31:29 +0100
Message-Id: <c05a9a1928e84cbbf375f1bfb2dd2ba31438c842.1635171518.git.karolinadrobnik@gmail.com>
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
  CHECK: Avoid CamelCase: <dwAL7230ChannelTable0>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 866734ce6195..3235585a67bd 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -195,7 +195,7 @@ static const unsigned long dwAL7230InitTableAMode[CB_AL7230_INIT_SEQ] = {
 	0x12BACF00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* Need modify for 11b/g */
 };
 
-static const unsigned long dwAL7230ChannelTable0[CB_MAX_CHANNEL] = {
+static const unsigned long al7230_channel_table0[CB_MAX_CHANNEL] = {
 	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  1, Tf = 2412MHz */
 	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  2, Tf = 2417MHz */
 	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  3, Tf = 2422MHz */
@@ -463,7 +463,7 @@ static bool s_bAL7230SelectChannel(struct vnt_private *priv, unsigned char byCha
 	/* PLLON Off */
 	MACvWordRegBitsOff(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
 
-	ret &= IFRFbWriteEmbedded(priv, dwAL7230ChannelTable0[byChannel - 1]);
+	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table0[byChannel - 1]);
 	ret &= IFRFbWriteEmbedded(priv, dwAL7230ChannelTable1[byChannel - 1]);
 	ret &= IFRFbWriteEmbedded(priv, dwAL7230ChannelTable2[byChannel - 1]);
 
@@ -722,7 +722,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTableAMode[i]);
 		}
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable0[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table0[channel - 1]);
 		i++;
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable1[channel - 1]);
 		i++;
-- 
2.30.2

