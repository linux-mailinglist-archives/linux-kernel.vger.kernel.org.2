Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFE4249A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbhJFW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbhJFW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:28:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3536C061755
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:26:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so15371729edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7odANBHAWb0MKUE6RXoy8eaBQaofMXLclz0gSYDBnCk=;
        b=A7woCrFTfUf/nTKHASUT0blTMZZ9Za5LvEE6q7CUElPVVOdm9PgOsAWS9PPJ6OjhbC
         0COvc27TYKm08Pj2wnnfKGY+Dgklms89lcAz7230MHCIJvGndcJFbtvpc0YiJ6iRRDad
         PkRypdCeTS7keqtGjx3dyEg4tRGKtHX9R9nxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7odANBHAWb0MKUE6RXoy8eaBQaofMXLclz0gSYDBnCk=;
        b=QM27FhXtjD9uKMcrSfvGHCy7euYLCVeN0weJ6tpue7/5h3oVhzNuPLcAOpQQJzYbDN
         VSVVNHKqR5JT4OwjnpxvPs8tKT4ZMRkY2hCYaqSH/rWcxps/R0jc31M7a8uWLkuAtiwc
         vhReNxCQ8VtLW6XiRJhEFFtVJHgBqQ0YGmIkW+/7uqjilaOI0UpZMMxKKbk5iOfP9Dbo
         60sOt3uI4Xpx5oxs48fiCNcT5StsG2aVD70GYK1Jzgt2jpqMaWsCobnCcyk5hw3Tasxd
         D6fDz4Bv8Ihca2MjFFuZwt5N9CoHbEYLlXku0YL3xOJniIdkwMuy3aqwCUE23PTWuNc8
         f/OA==
X-Gm-Message-State: AOAM533scYsLHRmFAbwqT/8GhfUywJ8f2RZMsH+lHE4IaFsbhIg1cTee
        CieURmaYoxwi6/2rJqxE5+u69A==
X-Google-Smtp-Source: ABdhPJz1sJZxLBj/p55hGzqe4/VdYCOHXXuT2g0Ti8bM9hh7UrbG3qo93hsBx5cLXRiqf80/PekqWQ==
X-Received: by 2002:a17:906:774f:: with SMTP id o15mr1071833ejn.200.1633559190318;
        Wed, 06 Oct 2021 15:26:30 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h7sm10557906edt.37.2021.10.06.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:26:30 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 5/8] media: ipu3-imgu: VIDIOC_QUERYCAP: Fix bus_info
Date:   Thu,  7 Oct 2021 00:26:22 +0200
Message-Id: <20211006222625.401122-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006222625.401122-1-ribalda@chromium.org>
References: <20211006222625.401122-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus_info field had a different value for the media entity and the video
device.

Fixes v4l2-compliance:

v4l2-compliance.cpp(637): media bus_info 'PCI:0000:00:05.0' differs from
			  V4L2 bus_info 'PCI:viewfinder'

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 69ef820619ab..0473457b4e64 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -592,11 +592,12 @@ static const struct imgu_fmt *find_format(struct v4l2_format *f, u32 type)
 static int imgu_vidioc_querycap(struct file *file, void *fh,
 				struct v4l2_capability *cap)
 {
-	struct imgu_video_device *node = file_to_intel_imgu_node(file);
+	struct imgu_device *imgu = video_drvdata(file);
 
 	strscpy(cap->driver, IMGU_NAME, sizeof(cap->driver));
 	strscpy(cap->card, IMGU_NAME, sizeof(cap->card));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s", node->name);
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
+		 pci_name(imgu->pci_dev));
 
 	return 0;
 }
-- 
2.33.0.800.g4c38ced690-goog

