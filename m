Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A460532E63F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCEKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCEKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:24:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:24:13 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id l2so1059124pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oms5k2GecNDKeVMeIwpNOTm33olso5jl5qcGN9vIFVk=;
        b=rkq4psy9siFz3w2OMgw9jdTuaMXO3f5TojWSTgW2r8KBPulpjaFdMZr96JnPH06MBf
         pmMSeE++AxppcV04hZ36+pkWOE2r7dhPiT0z9LjUG2cXFb9GDporclI6GVYgwXq89WIJ
         NTNofa567uUPalRq0gEGxdi6Zag1EkCWwexvGQeqAFKpZoYP2cnv91W1Np9NYcvx0Dmm
         Lwxt/Qc6hVoTa4ikY+v/8EosIvGbJFzGP1srKfJ5p198f3X5mNeLtTWz6MOy8NYq3VV1
         EYrKzPGR5qobp8vD8uo+nsby7XcNhon0yBt13HXfHcsfEHHLjb/Z5chdiTiPj37t6SqS
         qNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oms5k2GecNDKeVMeIwpNOTm33olso5jl5qcGN9vIFVk=;
        b=qJHZ3vHItZphuBPz63aS82/QqunpY+mZT6eMzg73HKEdLhTkLObDlaFPnqBiRYF6VH
         R95urRvjaZH+dgJk5FXf94gCHM88jACbyWh6M7UAqYNIXN9hJoM+fwkY2omw38GfNG3m
         oPorTv5AOijgqf3cJidhUeWX5X0UZ7XvI15DJVpPwbHxJG+Jqidmzu1eCRBYy9acWr2j
         Y6Bb/LWx8Ydf8I2kIO3MSxMx//0ptoiU4x3WI6zfNVLv+tUNh/x+PX10vrsOGihmR8/r
         zatTaSg8bxJ41nBjWxs3nB+eCAXclayLPI8hYqXrMa9TgN9F1Mq387WLuC6zLSrY1lV5
         AvsQ==
X-Gm-Message-State: AOAM531uOTMEwIo4ayiUJ/F25BEEnUn4Lh4G3Ba1seycVopFqYAS07mJ
        zCISg/OOEz8dgc2PCQO7xoM=
X-Google-Smtp-Source: ABdhPJwn4rUCoq+feRHmE9nnVxTffYPG3r7M/AXzf4lZjR81/+vOLwgABpn6E+ScHi5yUnGaXRDAjw==
X-Received: by 2002:a65:458b:: with SMTP id o11mr8009966pgq.416.1614939853197;
        Fri, 05 Mar 2021 02:24:13 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id w8sm2011574pgk.46.2021.03.05.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 02:24:12 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] base: dd: fix error return code of driver_sysfs_add()
Date:   Fri,  5 Mar 2021 02:24:05 -0800
Message-Id: <20210305102405.14940-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device_create_file() fails and returns a non-zero value, 
no error return code of driver_sysfs_add() is assigned.
To fix this bug, ret is assigned with the return value of
device_create_file(), and then ret is checked.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/base/dd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..f94bbef95258 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -413,8 +413,11 @@ static int driver_sysfs_add(struct device *dev)
 	if (ret)
 		goto rm_dev;
 
-	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump ||
-	    !device_create_file(dev, &dev_attr_coredump))
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump)
+		return 0;
+	
+	ret = device_create_file(dev, &dev_attr_coredump);
+	if (!ret)
 		return 0;
 
 	sysfs_remove_link(&dev->kobj, "driver");
-- 
2.17.1

