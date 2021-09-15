Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E116140CDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhIOUU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhIOUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:22 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E5C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t4so4895681qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfYd+b856xF2znmD8vgv1lw332UND5JAV7Y9/ZlVnqk=;
        b=k7fZAN97lE5ze7C04Wg6etzrSao88Z9OtgDKyk/eluPgGMtFifQZMQwiQa6TBClJkg
         31YNla82F1B5i60Pq5+IgcQuOht1Nv+bgVJqG5zb0kQRVbtpB0fu1I0d4+XVJILfh0D4
         8VVDLb4dlpEq1aJCz3aw2gWMjC4wkPjgEIe4LwYqj0oDIzqhXHobAzYWo3KkiF6y27av
         SObKjSxZ5dZ45MnSZRepS7RTTB5AMqw7K0eYsBSfY0N1QuxDgu8D2YuvFpaDW2A1sguK
         JUdgKWqPAVE7amr2JqNXhkUImtOIfu5xSGAh9KykCzMpYgqSyMmIOTn9QxRiTbzJRGB7
         kQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfYd+b856xF2znmD8vgv1lw332UND5JAV7Y9/ZlVnqk=;
        b=xcN74EIk2lNt2zFzoS8GcgMKFVCABtbiNZEivH3/uoj+UvZm13+dw1w1A/gAV9ImQ4
         mOyp599p1d5L1e+/h/44F5HY0u1GH44UGnXeJCVPe4DoDQNL8bXkZ7WKe2xxPq/Lr23K
         ShbTKckiLRieBTHKxXwZE21HqCVecn63x2FMKVTpmrqfbsY+2OJseSFBh+oqz2u1BPn3
         1JXz7wYmRQBMn1mEcLQ5ixJ5z5wqFii76Vncdqqet2XpS45Bv/yioVItmJ+eVD7CPCnw
         Ydd/6amaes4g1IsM8J/ardynxTQix5KYDMcqONlQHvk00ED6TuqhZ5GGFw3AgKpZGL4B
         aqrQ==
X-Gm-Message-State: AOAM533mQ/nr7CMcwBzubkjQrWLcAO77fA0MU0BLXp7I5WA+kTv2RE/q
        L8YgPLk0aQ8gg+SyVZdICzc=
X-Google-Smtp-Source: ABdhPJzgD5iWxrGAhpj9ZBFHXfLXvzfkcHSZDD9ZwGxbqTm4bk4nk6PvrPyvHDkf0W86eoXiz2RBNw==
X-Received: by 2002:a37:9947:: with SMTP id b68mr1828225qke.56.1631737140010;
        Wed, 15 Sep 2021 13:19:00 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id g8sm752834qkm.25.2021.09.15.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:18:59 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 2/7] staging: vchiq_arm: remove unnecessary space in cast
Date:   Wed, 15 Sep 2021 17:18:19 -0300
Message-Id: <20210915201824.413202-2-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915201824.413202-1-gascoar@gmail.com>
References: <20210915201824.413202-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl, no space is necessary after a cast.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 22de17f64ed2..e8b84b2b1ac3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -337,7 +337,7 @@ create_pagelist(char *buf, char __user *ubuf,
 		down(&g_free_fragments_mutex);
 		fragments = g_free_fragments;
 		WARN_ON(!fragments);
-		g_free_fragments = *(char **) g_free_fragments;
+		g_free_fragments = *(char **)g_free_fragments;
 		up(&g_free_fragments_mutex);
 		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
 			(fragments - g_fragments_base) / g_fragments_size;
-- 
2.33.0

