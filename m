Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD15318B96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBKNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhBKMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:42:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7EEC0613D6;
        Thu, 11 Feb 2021 04:42:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g6so3995251wrs.11;
        Thu, 11 Feb 2021 04:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtFZ+ysode8Xi1WRcTgeQ/GmeL5uIuE9pL6MZ8vd2tk=;
        b=LeUQKnPdwGFXMMCh42bauUrMAG0o/uP4Plr/v1Q1wJ1vzrH3AX3i6u1RaLPcz5idLX
         09DHqTgu/Fp0FXdk87K3y4maKSc+zkHswsJbFojiqPwlWVQwfS+Wbc8kSQ6RdlLHidKV
         4w4mJ2NR2cjmCT0djL5NvydexMBxXTJWT6crqNLf7mjlaqQeNgtO2H7aOwNyXfIDXJ9E
         twH4gya129KR6UYmZNFtfEUuJPUX8p4OydMkanUyNNV8GP5H5VzqeF3U15IZD2dxfAXB
         ITldAKr/Tj40Q/DIAywCdE7OA0iX88k4VfPTsv2uZe68KgcOsv5FtONeJMkgB1XYt5ut
         IbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtFZ+ysode8Xi1WRcTgeQ/GmeL5uIuE9pL6MZ8vd2tk=;
        b=WRIou/3FV/baGgFZGi/KaPlWUqM/j0+DQ2/o0XGr3uT1zxfZ9yM4cOAU585GILA1l1
         iy16OGtybaoFhi9mQvSv1hYTSg/2p4DWumnbxO/BBF7WfeJ9ROsrkP589N0xMS9+od+C
         aLN9WowIn/U2Bx0DW+OvEikQlAsxILKGoicS8Gk9+3X1yFk9uw3cMZDwt1ZKlFVl6aBX
         Y3zJSOusBZuWpS4CnCt8xRsUqemzR2FzHkvRyfvPeRcAbgIGMRQZ+JxsUPQUHX1meezP
         s4AeexHYlp2NLgaU7B///mPIx2FOEDLCuwT0430FeM0IwEY5hg7MFOdD4zKF9v9LyPtm
         uoEg==
X-Gm-Message-State: AOAM532hzpTueKvChT4Hw0q3TqAJ2rHNqvWtzTIPDh1vzGvJvV/nGNBp
        k9eQtJ7rLDeawjXeX4R0YUfh6CbIqE8FuQ==
X-Google-Smtp-Source: ABdhPJxIEiquzBiL9X2r1/AEeGI0+b6t9u5snGJfTycACRLWyedjDPN1ZKcckQNJOInIzGP7nctWew==
X-Received: by 2002:a05:6000:254:: with SMTP id m20mr5615671wrz.300.1613047321520;
        Thu, 11 Feb 2021 04:42:01 -0800 (PST)
Received: from xws.localdomain (p5487b829.dip0.t-ipconnect.de. [84.135.184.41])
        by smtp.gmail.com with ESMTPSA id s12sm4754222wrr.29.2021.02.11.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:42:00 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linx.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
Subject: [PATCH v2] platform/surface: aggregator: Fix access of unaligned value
Date:   Thu, 11 Feb 2021 13:41:49 +0100
Message-Id: <20210211124149.2439007-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raw message frame length is unaligned and explicitly marked as
little endian. It should not be accessed without the appropriate
accessor functions. Fix this.

Note that payload.len already contains the correct length after parsing
via sshp_parse_frame(), so we can simply use that instead.

Reported-by: kernel-test-robot <lkp@intel.com>
Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Use payload.len instead of getting the frame length directly. Note
   that payload.len equals the frame length and is already correctly set
   in sshp_parse_frame(), so they are exactly the same thing. Makes it
   look a bit nicer though.

   I did drop the ACKs/Reveiewd-by in case you want to check that
   yourselves and since that's essentially the whole change.

---
 drivers/platform/surface/aggregator/ssh_packet_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 583315db8b02..15d96eac6811 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1774,7 +1774,7 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 		break;
 	}
 
-	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(frame->len);
+	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(payload.len);
 }
 
 static int ssh_ptl_rx_threadfn(void *data)
-- 
2.30.0

