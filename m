Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6740CDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhIOUaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhIOUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:30:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A915C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:29:35 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w144so5822047oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ep/byKh0NuVpkH8Herix4A8TT0fTgaV62jYcvRPVYXQ=;
        b=B0AlQHDVJjoUjcROJnHXZlQlM0RwJAr4Y+2PzuhDaik1A/rJB9fzhBB0vgw0kN0a+M
         hVixW9kpfT0gjBVHePMa235S18n4tEFjje0WnWVXOkZmZmc8EKGUpnF/0uSBRk8EJGCq
         Kxbg34OYV851lA6P2B/D1d0dfAGYYcWyQ4EVdxkXH9g+T34bbna7nNLic/W4iJhmrahl
         AmEiCdUZFJGMQu1CVrMlUNFBmkgGsuVvL+2nC3Jyg0VuQdpALnXyvzgoh41+rgMSt4Og
         M7qvTDNGp3ZqiPQqqsBPAkvsKrHtrZyaaNWCIPGTUx5tbXFFFLC2ctsHby8KQQgMEZme
         R3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ep/byKh0NuVpkH8Herix4A8TT0fTgaV62jYcvRPVYXQ=;
        b=Q48AtmM4aeXiNNLuSUgbYAxogbvGXbMyCs4C+iwuiZB/wc+Kf0KU5dlhP9KvfdPPC2
         P+YLVqqx3rs5ay5QX4Z2uuZekMnUDGtxZedLkDds+GSUlCfRtPpvDQw+FF3MR3msVCZ5
         qGDY+cKRmus4xqijhX/oiEksPuHiOImSJpq9c7PPhbjT8+I81ptT2dqOdHRf0Qu3jI5e
         B+PB5zprTnYa96qxgSspg7BjLbY6sz3uYFAmYJh2MWKKrKR0K4RsvGHVeSSWUTV1DmAp
         FYX0obJN5gIUSGnivyG089u9j/PPWn1mVpNcNYySDE64wy6zNkqS2jW0E5lmXIdSsZJZ
         x/Gw==
X-Gm-Message-State: AOAM532WZ6Q5qqjKw678N18HW2tVAaHGrtF2xZuVJDoSJgtUtawWBxp5
        dhDKqyGkRV6t+xA10ZN4SlA=
X-Google-Smtp-Source: ABdhPJy/5z2ic5/GvSkn/yyqMCItDM65BJjpu8uzY7UN6I+FKmb85kh0rfgO6j/91CwXtoLz19oTbA==
X-Received: by 2002:aca:1917:: with SMTP id l23mr1177025oii.10.1631737774938;
        Wed, 15 Sep 2021 13:29:34 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id l4sm247584oth.4.2021.09.15.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:29:34 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 2/3] staging: vchiq: add braces to if block
Date:   Wed, 15 Sep 2021 17:29:15 -0300
Message-Id: <20210915202916.413914-2-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915202916.413914-1-gascoar@gmail.com>
References: <20210915202916.413914-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rule of not using braces in single statement does not apply if only
one branch of the conditional statement is a single statement. Add
braces to fix this.

While at it, remove extra blank space after a comment inside the if
block.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_connected.c  | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index f367dbe2bc63..1802fd5e4888 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -34,16 +34,15 @@ void vchiq_add_connected_callback(void (*callback)(void))
 	if (mutex_lock_killable(&g_connected_mutex))
 		return;
 
-	if (g_connected)
+	if (g_connected) {
 		/* We're already connected. Call the callback immediately. */
-
 		callback();
-	else {
-		if (g_num_deferred_callbacks >= MAX_CALLBACKS)
+	} else {
+		if (g_num_deferred_callbacks >= MAX_CALLBACKS) {
 			vchiq_log_error(vchiq_core_log_level,
 				"There already %d callback registered - please increase MAX_CALLBACKS",
 				g_num_deferred_callbacks);
-		else {
+		} else {
 			g_deferred_callback[g_num_deferred_callbacks] =
 				callback;
 			g_num_deferred_callbacks++;
-- 
2.33.0

