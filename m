Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8694249A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbhJFW23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbhJFW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:28:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164BC061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:26:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x7so14726087edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlp7ilZ9XrJYAXemHAWV20bbaalkwWqSnHcSYa5By+o=;
        b=l0bVo7mo1rN8iOH77MKJsEIqkmWjWSQbuV1xogE9Dodk3SOKyzNrnvJzJhV8x81+LQ
         TLBXOl+w+jkHZ9EYdJFqUIuao34xZNJ/fE9B55n0GqCBtus7vsm4VIA1qeeSWXrw7fuc
         WIE6ARoXXSbjxaOvx8BQW8jVTMwEQkd67B3T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mlp7ilZ9XrJYAXemHAWV20bbaalkwWqSnHcSYa5By+o=;
        b=D2eIEC64j4UctYMTh9kyvj2cyMgewHVxvWRMLLBp/d5eAF7S56wKQnLHNSV9A3ALev
         YFEZifZBvkf5UeFwSWHOgPJwL5/y6oWuSDBi9hTmXHk358wkWF+61aWM4m4Esdlm+6Sf
         EWStXMV5ZzRk2Ht/M6qu/4np/FBv+mt7LyOWF04o8cjCkeuHuo8P7FhTFBEo905TobMC
         EgT/KvSVJ+gAPdq6PT66PavK8jZBgon85WMSesuWB59NfoIWwwDBnX+5HIWguxgnjYR/
         f8mdWw8xsTs7atG+rRCJ5wAhzO11A51OLX0v3EzyBffumyC+Kb6JiVVpr4zNxrSpLYey
         IIzw==
X-Gm-Message-State: AOAM533Sjc71ZvYRQhdva9FRpF5K2D+k2ShpfVeSYwZQSjsqYSU1V0cD
        tO29qd/KHF33uNbGNnfbJSTw3g==
X-Google-Smtp-Source: ABdhPJw7M8znyJcPes5pDpHdvk7J6DRP/DOs25zDIindrfov+uD3w65d/iYiV/fc8dCgANwhTRlH4A==
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr1068326ejb.3.1633559189248;
        Wed, 06 Oct 2021 15:26:29 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h7sm10557906edt.37.2021.10.06.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:26:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 3/8] media: ipu3-imgu: Set valid initial format
Date:   Thu,  7 Oct 2021 00:26:20 +0200
Message-Id: <20211006222625.401122-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006222625.401122-1-ribalda@chromium.org>
References: <20211006222625.401122-1-ribalda@chromium.org>
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
index b723186d2134..d9f7a854d68c 100644
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

