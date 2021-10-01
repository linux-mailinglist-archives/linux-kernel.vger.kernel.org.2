Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB341EBD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353876AbhJAL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353767AbhJAL1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:27:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6585C06177C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:25:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w29so14948010wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsIDAReufILY9VHFSQPnSoVNtKesEQVhGHmS/ZGk6bY=;
        b=m92E2iaieXtNEzgumVB8qGx9lnexFJr6/tTdH01cdjZe4OAJNypKDGGvk5oi+zPkLT
         Qhkqhp31Y5/eciGuA8fGat/X8YZURnJYGkWgbQcoD/fJNchmygovG6XMtQKOn01hAscQ
         2U+k5J9p6eGmmfeLOnYpfTEkPGpm0gqFcYcXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsIDAReufILY9VHFSQPnSoVNtKesEQVhGHmS/ZGk6bY=;
        b=i+y5bMZLWa87Q31fWYS4TFD8blNdE3P4K3JMikKSNtREq68tLhKJrHkI1bBooMSpS/
         15TkE3ZhpUxH1NegnkyT/5U2WZtf6sonZlVsKMQIVp6BPOM3D75RRtMdbET25t0tknqC
         D0ED0zuk4VXBzuhow2Dv3i6pokUMLfDjp9AGxWgcaBTydJIF3g5M+woADGn6W9+bhUFM
         aUyCckwW+Kp7naQBghc/n5s7iXv2F6YzwXJKVxPzHQuFmtEGkz7XOHpKXYGZYjmQ028e
         xCMLzAQw+D9f5IHkpp6P+ruUEYQjdCZErIVZQykdi52C9883a2Y+xWUpHNyDD2zNNsAb
         0kCQ==
X-Gm-Message-State: AOAM531PvESmjBtX3V+ztdvOsKKercEiNkfwmpuXL2NH/onByH2BxEeN
        /lpAlKpsdmMPX5nGXUV2X3MMMQ==
X-Google-Smtp-Source: ABdhPJxExrFN3nb57yGGRQ8TCWrkgCkapqXnn1OL2XI5mlFWa2eEvqff7MdNn3sqybBfXZwYjY0baA==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr11761494wrw.213.1633087526228;
        Fri, 01 Oct 2021 04:25:26 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id x17sm5530958wrc.51.2021.10.01.04.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:25:25 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 3/8] media: ipu3-imgu: Set valid initial format
Date:   Fri,  1 Oct 2021 11:25:17 +0000
Message-Id: <20211001112522.2839602-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211001112522.2839602-1-ribalda@chromium.org>
References: <20211001112522.2839602-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial format did not have a valid size.

Fixes v4l2-compliance:

fail: v4l2-test-formats.cpp(723): Video Output Multiplanar:
				  TRY_FMT(G_FMT) != G_FMT
test VIDIOC_TRY_FMT: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 38a2407645096..1813bb29e362b 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1136,7 +1136,9 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	def_pix_fmt.height = def_bus_fmt.height;
 	def_pix_fmt.field = def_bus_fmt.field;
 	def_pix_fmt.num_planes = 1;
-	def_pix_fmt.plane_fmt[0].bytesperline = def_pix_fmt.width * 2;
+	def_pix_fmt.plane_fmt[0].bytesperline =
+		imgu_bytesperline(def_pix_fmt.width,
+				  IMGU_ABI_FRAME_FORMAT_RAW_PACKED);
 	def_pix_fmt.plane_fmt[0].sizeimage =
 		def_pix_fmt.height * def_pix_fmt.plane_fmt[0].bytesperline;
 	def_pix_fmt.flags = 0;
-- 
2.33.0.800.g4c38ced690-goog

