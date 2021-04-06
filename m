Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46C1355421
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhDFMnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243076AbhDFMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:43:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B465C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:43:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b14so22463355lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jTrDPPAFiLJk6tDPgw2eOrS8B79LVV1U/u/3lEC2RNM=;
        b=hvkP6l1BivsGO6AiN5Rr5cn89tLh14H6VrlAHoR3NGLzigf6VTaz4dTAs9cf59qeMs
         3vx5669y4PItdM15UGr8bC2PH522xFQpg2kQ1bbxe6SWNCR7CuZ6PUav6rjroeQ8aNQ4
         Nwb4uMEJHXtOnr4wdejX+/6ZXm5ZGT553cvvNiWJy5/vOwopEvbLI+z1aaVaSxhBTjw/
         jl4uYRSMPHNWak2Aajrja+mRSeSMqe8yL1rKxGZMOPQIYRKdGjPd6je/Pzh1vFk/pojS
         UeAaOUwARfH0grpAeDXGF9w4h7tYcxbj0DzRKjvBGCOf5Ngid/U4nIFIMBBkgMiuscjs
         T9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jTrDPPAFiLJk6tDPgw2eOrS8B79LVV1U/u/3lEC2RNM=;
        b=ESOqeybDKg80fwxTTcZuxRXj2m2/2y/jp2EYcJJETL6xI+xIroKXQE27lEmfjncYMP
         rSZKA2IdRNPgVqARe4sBWFuv+OK2Mzc5DY+9rFaEW1JXR/fw2fboUvmv1R/8GRZ/RqsC
         fl5AMvYwEchDPWNm6tdLKnCKN3USzqkla709hFFJQmdcurGfEFxoNPqL3wsRLOT74fsv
         UxtkSRGL8iWdjgJIqeijAB9+s/WY2hHZcdRv+UUlLTx2tcPnm9kUaO6KO/RfUuaQO8Cg
         Nqd6XZDmUf1aN218uS+v9yKmnp23yJvPPw9tJPA9TEGaW92JwWOXsxMa4NEnmXby5F2E
         AWWg==
X-Gm-Message-State: AOAM5332WoA+x1oo9VuZYr/XVc8lpgex3oJCH/zwVNmDQdPQAeaYoBoT
        T4G1ZnoPbmuTv06X/xDE8lM=
X-Google-Smtp-Source: ABdhPJyCIPdHimlGD1pZu8QHgGQcP5o3w7+4RT3QxU8BRQjG9y/t7grgUXRUROtJUJ4FPbFgzvAf0A==
X-Received: by 2002:ac2:53a1:: with SMTP id j1mr21109137lfh.298.1617712980572;
        Tue, 06 Apr 2021 05:43:00 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id u18sm2138265lfu.103.2021.04.06.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:43:00 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:42:59 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: greybus: Match parentheses alignment
Message-ID: <20210406124259.GA96537@zhans>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match next line with open parentheses by adding tabs/spaces
to conform with Linux kernel coding style.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/greybus/camera.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index cdbb42cd413b..5dca585694c0 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
 }
 
 static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp)
+				      struct gb_camera_configure_streams_response *resp)
 {
 	unsigned int max_pkt_size = 0;
 	unsigned int i;
@@ -378,8 +378,8 @@ struct ap_csi_config_request {
 #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
 
 static int gb_camera_setup_data_connection(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp,
-		struct gb_camera_csi_params *csi_params)
+					   struct gb_camera_configure_streams_response *resp,
+					   struct gb_camera_csi_params *csi_params)
 {
 	struct ap_csi_config_request csi_cfg;
 	struct gb_connection *conn;
@@ -783,8 +783,8 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
 }
 
 static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
-		unsigned int *flags, struct gb_camera_stream *streams,
-		struct gb_camera_csi_params *csi_params)
+					  unsigned int *flags, struct gb_camera_stream *streams,
+					  struct gb_camera_csi_params *csi_params)
 {
 	struct gb_camera *gcam = priv;
 	struct gb_camera_stream_config *gb_streams;
-- 
2.25.1

