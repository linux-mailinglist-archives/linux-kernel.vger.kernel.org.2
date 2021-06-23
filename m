Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181883B2035
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFWS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhFWS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Htp54BK0JGPxX8hRg4+dCEnU8CurZfr6H6uRpE1E1JA=;
        b=PQohWEzUeo4ylOm5qkoE2x5tBeLodBYyrbZsC0rC3y+85O8kuQvswEGmngClkidBQ7UAve
        l9vxYwgi/mH4+VO2hNCdCBsOZLQM+G2dpMrzvENmGneCrDcChNb5BDk7sBhRL99mGm54nb
        9lWP9tbt32imaYOjK8DXXFUv4zykXh4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Bkr90Gb3PZ6lx5qg1DTuRA-1; Wed, 23 Jun 2021 14:24:26 -0400
X-MC-Unique: Bkr90Gb3PZ6lx5qg1DTuRA-1
Received: by mail-ot1-f72.google.com with SMTP id e24-20020a9d63d80000b029045ea018532dso1822584otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Htp54BK0JGPxX8hRg4+dCEnU8CurZfr6H6uRpE1E1JA=;
        b=kEGYQ/2wXVCWBezjTJ79POnLzLeXC4tijMKflg7vlR0yn82vosstM7cLcTjLHlwEv2
         AgnUlsH9B8hmDlmsAza71zEImZgGblnMzydPWshjSO6b6+KjUxMyyv1+WV4FF7s5QoLT
         x1jxYHhUUJhDcf0qe7QfkLhYcQOaafjnrd0XTzWbwHuSHvuiKsJKCiwkhliSKiTYDnhM
         14/qsqNez962Zp+/bmh7wbt6BmZBooaVa846klzcIXdPQzk0F3otHddSkk97/u718sf4
         EZm7RFvKn/Dtj6rl1sy6kBTR9bMIx9uSljE3amZ08jVka9WOZhT0fBC3q35sxXVMhJH8
         M9RA==
X-Gm-Message-State: AOAM533QMRmha3B4afJ72rcW8B/YrUCCmf1FsORfnXWr+MACLfT6fY29
        Iuxg07TcPJS3D2YQAIwWvYjG8RdzlcKia+zyOLKRRCib1JycjjU5Ierm/YbfvSvyaInjYhqXf+M
        LqCq2AB6Q3vR4bstr8L5vE7XG
X-Received: by 2002:a9d:4006:: with SMTP id m6mr1091549ote.130.1624472666218;
        Wed, 23 Jun 2021 11:24:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF6Hb/fcM8IvALNCl6D5hK6kIQQYZrMClGzUljQpEiNs53aD0YD3Vsj5TzZ9p5+6KcUhipMQ==
X-Received: by 2002:a9d:4006:: with SMTP id m6mr1091530ote.130.1624472666056;
        Wed, 23 Jun 2021 11:24:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:25 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 1/7] fpga-mgr: wrap the write_init() op
Date:   Wed, 23 Jun 2021 11:24:04 -0700
Message-Id: <20210623182410.3787784-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
write_init() op if there is nothing for it do.
So add a wrapper and move the op checking.
Default to success.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index ecb4c3c795fa5..87bbb940c9504 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
 }
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
+static int fpga_mgr_write_init(struct fpga_manager *mgr,
+			       struct fpga_image_info *info,
+			       const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
 /*
  * Call the low level driver's write_init function.  This will do the
  * device-specific things to get the FPGA into the state where it is ready to
@@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = fpga_mgr_write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	int id, ret;
 
 	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
+	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
-- 
2.26.3

