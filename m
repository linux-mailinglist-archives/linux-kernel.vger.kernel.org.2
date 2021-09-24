Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4531417641
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbhIXNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbhIXNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:53:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC3C0614ED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:52:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e15so40709138lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTJRT+uzM0lAz165RqeTd1Tx4KIJ3Eki8evDEIFClkc=;
        b=jozqt8pupd8eRYq2mgkuTKUGaUkT9MKLgTv1jddpEfLiIVzs9Hoket0uZiVA0Og3/w
         Ztru2V8mUx4x2/kLUzudFglpVO1URBuD+Wewe3SF44w4JmnieXP0uvPWIWdrN04fineg
         DlxlbDjPOyehZeIKRMuF2NQt377JuWhAGrD/7vVs5Pmezu8IE+HtgurwSvN/lcpzNIHo
         slYQpKTSN2jhxkXrPFyi3aEHB+tmIsUmlgNmST2rUEcobGlGcQAscFoKGUy1GGewZP8n
         C71mbtm7rkkmFK5ciZtrbeIN0xJzi/qDfRGmI/2dw6DNoWwLDAxl6DFMfLTtM1sVwJMx
         UkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTJRT+uzM0lAz165RqeTd1Tx4KIJ3Eki8evDEIFClkc=;
        b=YWatPraxWQs811gAkXNhnH24Kw0K0Lg5eBLwDdqrTiFRicWVw142AxMoiArmR3Tznz
         XYHn2Ybtoss1EjbYkUuy1oUFGfs3iderRB8CkkwCN/GkzvsTGnzTyMmJronVt54VtPHm
         a/a6H5D47Zl03opsdD5XOzGD+4M+ExYNDkZYdgjhswG4FwdxYXNtlyzGIT5N5+6s8e6W
         UchlyrxfU1v2Dj8x7w/SBR7Y5VRfeVW4dYuFN2F6HPlTZeQtBOGGMN/y0ebLzD2v92cx
         2OsQpiTcV0QaIvySiN5VonCXuvZp0HAx2jekecWNj7OJkRKWQQ0Ev+nwJwk75227BstZ
         tETw==
X-Gm-Message-State: AOAM531AWgZ5gVpRtLja5aelkno6ABfK1gGKRxcpyGHkk0SZtghi+1pB
        IKZHoXSOAT+Cca2UEGoEaB+L4g==
X-Google-Smtp-Source: ABdhPJyWzwcC1XcXoAGJaMgHSbn8NtSkr56EHdy25/3nTAqZoPx+MAIUjgb5uVUj4onaErxUKqiwFg==
X-Received: by 2002:a2e:814d:: with SMTP id t13mr11696803ljg.237.1632491530606;
        Fri, 24 Sep 2021 06:52:10 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id v27sm761214lfd.127.2021.09.24.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:52:10 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] media: rcar-vin: add G/S_PARM ioctls
Date:   Fri, 24 Sep 2021 16:51:38 +0300
Message-Id: <20210924135138.29950-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YU2gSJKfsqP+gUci@oden.dyn.berto.se>
References: <YU2gSJKfsqP+gUci@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This adds g/s_parm ioctls for parallel interface.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
Changes from v1:
- use &vin->vdev to access vin's struct video_device

 drivers/media/platform/rcar-vin/rcar-v4l2.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index bdeff51bf768..a5bfa76fdac6 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -527,6 +527,24 @@ static int rvin_s_selection(struct file *file, void *fh,
 	return 0;
 }
 
+static int rvin_g_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *parm)
+{
+	struct rvin_dev *vin = video_drvdata(file);
+	struct v4l2_subdev *sd = vin_to_source(vin);
+
+	return v4l2_g_parm_cap(&vin->vdev, sd, parm);
+}
+
+static int rvin_s_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *parm)
+{
+	struct rvin_dev *vin = video_drvdata(file);
+	struct v4l2_subdev *sd = vin_to_source(vin);
+
+	return v4l2_s_parm_cap(&vin->vdev, sd, parm);
+}
+
 static int rvin_g_pixelaspect(struct file *file, void *priv,
 			      int type, struct v4l2_fract *f)
 {
@@ -743,6 +761,9 @@ static const struct v4l2_ioctl_ops rvin_ioctl_ops = {
 	.vidioc_g_selection		= rvin_g_selection,
 	.vidioc_s_selection		= rvin_s_selection,
 
+	.vidioc_g_parm			= rvin_g_parm,
+	.vidioc_s_parm			= rvin_s_parm,
+
 	.vidioc_g_pixelaspect		= rvin_g_pixelaspect,
 
 	.vidioc_enum_input		= rvin_enum_input,
-- 
2.30.2

