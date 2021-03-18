Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947D340393
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCRKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhCRKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:39:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B957C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:39:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y2so1226350qtw.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayz9aKoCpmgg1fa5GkH0c4F8DTmBCEZswDCuyy4H59U=;
        b=VPeK7peaPO+/n0vISlTMqyEBVPghBkM/1ol/hphu+FgdyYVVD4vJddbg/9tMDcbgGR
         kkrgjS5cjIfxCDI2W7qfookjrZm2Qr54yBLwxJm9JeiE4/+ld5YVrUAjKreTHJChtyJP
         LGYUr9Qvrt5u+YF/Ynyrd06aDmbEbmg548EsUt1KEcZqok3jfP0aIb5KyQ0auJydWb2J
         hn4fgLp6rnOPwx/XuAfAFPq6qw55PV+mwzm0t+I6ajSQJrIXhTHG/EvLz1tqWkFfgAdx
         06y9TlKpEmonkFVAnUctoqbEX8kGi873cXytjcrMYHtKqHXt6Zz7RwDD4V5Xvyq0VlWu
         RccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayz9aKoCpmgg1fa5GkH0c4F8DTmBCEZswDCuyy4H59U=;
        b=Yb1+t3mJGPxAckY0855+JTypE+4/AH0ruhHg5nM+6U4UCY5+j6+KVT78pQwbOOwKbS
         aweFvH1VRnGSSYB3OC/kJo6RBDG8YCPfw+zqAci7VCjBZ0pGs0bXdhuk02aXSZn6A4S+
         iVnIJt2xSNbdNTUP0PfPh5ysN26dJ3q0BTDNTdPDjNPcrfiMBQ5kd0cUz2rH4L+WBYQj
         6oa9LFSffLDuVrKiGWB0nVFEIoiKYhfWR4j1TEonJHUbiRRGPBZGyDJUg2578bWLOTo8
         N5rbNGEELF/ROpBcuUkfdmtxkaot6xsGYruixFelXprpRU1OMEkJD9BhZQrwR2yzyMr0
         8T/w==
X-Gm-Message-State: AOAM531vxbyicmylMXYq8Y2QpVlrAsQHH4wYzpqydNNDplhCcqNmi+Fh
        UFUjF6t0o9YGJ5fGgOE+hn4=
X-Google-Smtp-Source: ABdhPJz2sFx7quTsW6EZ/nxZQyM10WClx2kdtxfnDKii5Bcz1/kx8S+pTP5fLGpv3QZ5qKK8cqvUGA==
X-Received: by 2002:aed:38e9:: with SMTP id k96mr3026870qte.162.1616063996680;
        Thu, 18 Mar 2021 03:39:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id 46sm1127507qte.7.2021.03.18.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:39:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm: Few typo fixes
Date:   Thu, 18 Mar 2021 16:07:39 +0530
Message-Id: <20210318103739.27849-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/instatiated/instantiated/
s/unreference/unreferenced/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/drm_property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 6ee04803c362..27c824a6eb60 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -43,7 +43,7 @@
  * property types and ranges.
  *
  * Properties don't store the current value directly, but need to be
- * instatiated by attaching them to a &drm_mode_object with
+ * instantiated by attaching them to a &drm_mode_object with
  * drm_object_attach_property().
  *
  * Property values are only 64bit. To support bigger piles of data (like gamma
@@ -644,7 +644,7 @@ EXPORT_SYMBOL(drm_property_blob_get);
  * @id: id of the blob property
  *
  * If successful, this takes an additional reference to the blob property.
- * callers need to make sure to eventually unreference the returned property
+ * callers need to make sure to eventually unreferenced the returned property
  * again, using drm_property_blob_put().
  *
  * Return:
--
2.26.2

