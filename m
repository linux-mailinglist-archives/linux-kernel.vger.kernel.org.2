Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB440CDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhIOUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhIOUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:30:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C14C061766
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:29:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so5290565otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SQzu4YMziYEtKQGqS+FmHBlALDwBAUY8mKyC0ZwRh0=;
        b=GCaKcF+sDRDg86ia81S0byZn6XvSifOGsOIbToWouHeQu75qaXYYF313+PPxe83GnK
         mdN3k8re0i04xTLd//ynX4UL+lIsjxwf0NwxUtUDcUh2+v9izikUtzMh+hED1+RY/WbL
         Ib6U5yUL+aPc+5W7/KfAiSzFAlMKFgTss+rNwNvbP8z4ttqj5Qf1s4BCSg/3b85bsCd1
         TjVQAt+h7TaN1At9htUDRfdoJfw9rTQ4MTfZDqkzoLqfJ/xtaOTciI+oBehGKnWeJOf/
         xat69Jf1qFQu4vsTlAIYrMDLMobcW16U5rwz8G/Imh94JSLm2/qklUr/ur7XCcsSLFnZ
         w8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SQzu4YMziYEtKQGqS+FmHBlALDwBAUY8mKyC0ZwRh0=;
        b=Ni1nh2l6wU/xwjt59G9QNQcMk43xkkFAb3om6er9ppykpth+xM6uX5Zrb/RaGB0ssr
         yfWmN2TwBwboHrTNm4+nHDTwqs5QdI+gA749L37+pevJkUEJy9qfNHrnVpJRA8dvKC3d
         qj8BXc92hMFhz+rAYo4z0s2wr4U1XT0DZEWozeaBG1yZ4VbScAtWeK5KQ9KQrKXyZSEO
         gU7Kx+IczrPrxtIcq17IWC7BetsHzrKtW1LJalifduAlCbYEtdEiIgRGSZFqX3UYsVPv
         up7GOck/xQf5ga+0uVRRKIh0jJQj3O6FZ0h1QXvogMwFOTfGKPp07IAc77lwOhZ21zzb
         QMpQ==
X-Gm-Message-State: AOAM532q0XAxh/jiFzNGmACj3GJNthF5P57GOoId0VJZxvJd013TH2nQ
        WPZZ9wz9XzUWRHONmezTe3sYXB4bnsMiBA==
X-Google-Smtp-Source: ABdhPJxF4D8XOaygWU9C8hsLFFcTyw76Vhli+KyZdU2svSswjdlBe7eJvZ2PRduSuxjesKGSwIRwdQ==
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr1705757oto.296.1631737778060;
        Wed, 15 Sep 2021 13:29:38 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id l4sm247584oth.4.2021.09.15.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:29:37 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 3/3] staging: vchiq: cleanup code alignment issues
Date:   Wed, 15 Sep 2021 17:29:16 -0300
Message-Id: <20210915202916.413914-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915202916.413914-1-gascoar@gmail.com>
References: <20210915202916.413914-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code alignment issues.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_connected.c       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 1802fd5e4888..bdb0ab617d8b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -40,8 +40,8 @@ void vchiq_add_connected_callback(void (*callback)(void))
 	} else {
 		if (g_num_deferred_callbacks >= MAX_CALLBACKS) {
 			vchiq_log_error(vchiq_core_log_level,
-				"There already %d callback registered - please increase MAX_CALLBACKS",
-				g_num_deferred_callbacks);
+					"There already %d callback registered - please increase MAX_CALLBACKS",
+					g_num_deferred_callbacks);
 		} else {
 			g_deferred_callback[g_num_deferred_callbacks] =
 				callback;
-- 
2.33.0

