Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301F038F18B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhEXQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233859AbhEXQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=bdNMm5kW2ZvdHUaSawyZ1i2uQbWVxnJCf9si7jFRNcJWD9bLvZ+H8m2d8j6AgjTXEH5oq5
        JOu4xfm67p+i0jh+77CMnid29+wPDOb9v30mH3k+V+gj6HFiUoOjHdbnCU5TaTWi43vTPc
        tyVSi68bdgZWXoap00VmO3neU8DWXhw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-7cXQ3rw-NKG_tRWNEkJ0zw-1; Mon, 24 May 2021 12:28:26 -0400
X-MC-Unique: 7cXQ3rw-NKG_tRWNEkJ0zw-1
Received: by mail-ot1-f70.google.com with SMTP id v16-20020a0568300910b029032e3cb976e3so12764274ott.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=td2jYVGm5fuIYDBkeW+xJ0hf7GuJTwY1E6UiZyvwbZvYjqJUHg+Xr7m1SziNgb+XyC
         w5o20D/X2wBTYvnOYJXIzZc1SQxQjQ/hpLTKzS6vczem757BVVdY/F+xBAm6N2f9KCO9
         QgPbcpawmiYiDjdBAQ8Icn7RTY+hBDxIOKEIZecyoXxy41Ean1NKlYRV3n6XB6epBRA5
         Ty5CCFEuEK+/I980+4/+9GiwpIOXPum6gVw8Ugd6hOYrwBaJAWeKYJ2mjD5zd85UnDOs
         hE+bbH3UF4Fcq3Xlf6xEYuE+sN1zUQ7hW0FfHOieeLjwcjmuvjLF/0arlHbgjrjM9OSY
         xc2g==
X-Gm-Message-State: AOAM532OYn5y3Vv7sya+TfZTpGBON5A3j9c8s3JAjEHyMFBipfmotdXe
        3ie3YGpQhZpOtHBxshjeieYnTn71eUHTgHGC0rbcJy7kBwW/jgBnWk7w2ctAeo2Ym64vBVeeM4I
        CrDSn71/QcWn5mA1xT6Ts2P/6
X-Received: by 2002:aca:3e57:: with SMTP id l84mr5497080oia.146.1621873705668;
        Mon, 24 May 2021 09:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwklRD51VQJ2boXV9RmzIVTiIT/5yzbDq5MtMCaKY1kh4wUL3gIuAn+Hw2CK1YyK+AnVw2cKA==
X-Received: by 2002:aca:3e57:: with SMTP id l84mr5497073oia.146.1621873705547;
        Mon, 24 May 2021 09:28:25 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w13sm2691232otp.10.2021.05.24.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:28:24 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 4/6] fpga: defer checking for update ops until they are used
Date:   Mon, 24 May 2021 09:28:20 -0700
Message-Id: <20210524162820.2221474-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Which update ops need to be used will depend on the
FPGA_MGR_REIMAGE bit in the fpga_image_info flags.
reimaging is optional, no drv that does not need
to remimage should be forced to provide stub functions.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 4263c9e94949d..5247703a3743d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -369,6 +369,14 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (!uops->write_complete ||
+	    !uops->write_init ||
+	    (!uops->write && !uops->write_sg) ||
+	    (uops->write && uops->write_sg)) {
+		dev_err(&mgr->dev, "Attempt to load an image without fpga_manager_update_ops\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, uops, info->sgt);
 	if (info->buf && info->count)
@@ -579,10 +587,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->reconfig.write_complete || !mops->state ||
-	    !mops->reconfig.write_init || (!mops->reconfig.write &&
-						 !mops->reconfig.write_sg) ||
-	    (mops->reconfig.write && mops->reconfig.write_sg)) {
+	if (!mops || !mops->state) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
-- 
2.26.3

