Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDE4152A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbhIVVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhIVVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:22:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95523C061574;
        Wed, 22 Sep 2021 14:20:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so10871290wrr.9;
        Wed, 22 Sep 2021 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=CsEV1+cmn95PxWDVCkkcklf6Fg+sq2sl8U8wO+GKv78=;
        b=qN0/EA/eVvLzwaa2M0ReXbQzxdWnMoDiUxF80IfjLD5DrIiK0Tv2STvYwePlMv70Qf
         xyc1/icFZdmN6uNiK7axTctOlPIDxNURvW/zDihTs4EEf0Zy4VjoWaq/nVTjuOPJtQQd
         0ZMO2ZYEKP6kMn6yUGWcYggIkygywYNh8lD+ageXkCj8i/5jyhNJ4WyiWx3XW99vqXOv
         LCUykxhrD4HXJ6+tN/CXuV9xWk5G8p3Ti68L67QPZaWqEMXFFDaXc8+bVuiAibp8Lg1Y
         uSLAOaPK9X8Irxlwn6RGneeFJLaYDs5jeI5X3l2bw3jI/J/xqbeuEXno8PQtgFgHkfRO
         oaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=CsEV1+cmn95PxWDVCkkcklf6Fg+sq2sl8U8wO+GKv78=;
        b=sYOGrAnqTiftKbxnRtwXK5HQccEx2WSoXyH9mWQSPifsrIOWQDvHSEKdkbYpR6q+No
         AW+DJhvT/MEiqFdSq4jHgNiiP6RyJ1oHX/3X0b4zXQOHPrf8qGsWEfR8xUaEIf9IAOWe
         ZZwRD2ivhSfG7sXwQhjT1q+odM0+ld5rPtInfULvNMF3aD3kRyprV9YPJc36nkWYX2M3
         3h6P1D9LbyGc+Ag/SkvGsi7NgX8GmY1BvtZvFFMl6IKhuga7DEWQz7uK0m/++auKeFTe
         O7exoKL2Cr81cyOBinnJGure7R40KTDDTRbqFmOTw/3ilLV5dGB339RqVA2yuUHgpT9k
         vz8Q==
X-Gm-Message-State: AOAM532Gxe+29zVu9CURYltvpKaeDGsWYhFJvCbrHLUePs3LaB0T2GTl
        ZnLX707n7HOZJsZ/Kuwm8KCoMcYrZkI=
X-Google-Smtp-Source: ABdhPJxmHsPEPhjTikq0HLDexoFcCIvBSp1JWPm3GPSh6bFsKcFxAYpuY316gaWZfXQBn3oVib2X4w==
X-Received: by 2002:a7b:c217:: with SMTP id x23mr1089179wmi.192.1632345640228;
        Wed, 22 Sep 2021 14:20:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0670a283da159592dc58.dip0.t-ipconnect.de. [2003:c7:8f4e:670:a283:da15:9592:dc58])
        by smtp.gmail.com with ESMTPSA id t23sm3451263wrb.71.2021.09.22.14.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:20:39 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:20:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: usb-skeleton: Update min() to min_t()
Message-ID: <20210922212037.GA8110@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:
WARNING: min() should probably be min_t(size_t, count, MAX_TRANSFER)
+	size_t writesize = min(count, (size_t)MAX_TRANSFER);

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V2 -> V3: Added change history missed in V2
V1 -> V2: Added subsystem and driver to subject line

 drivers/usb/usb-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 2dc58766273a..d87deee3e26e 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
 	int retval = 0;
 	struct urb *urb = NULL;
 	char *buf = NULL;
-	size_t writesize = min(count, (size_t)MAX_TRANSFER);
+	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 
 	dev = file->private_data;
 
-- 
2.25.1

