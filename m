Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C574403AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJ2UDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2UDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:03:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF8C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:01:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bm39so4474534oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHumhMIUr438aWWlrs+78cdgsF1iUwE1HgS3gt+l/Ls=;
        b=qSwRjZWjohXQH7S/AeV/tL1D+waYUomj9nwx2FRu9gr84XTV+znEdx3TbITF/Fc3sz
         RlulexcGv2ic9dbKiDvM786MBVDSLC0zfCO7j9q5kM8rHP0PDlr3sA0D7kt1hBvRtJd3
         tHLUoGaCdkk3Q1M2aSeYi8TKIg9RkhTPevPa2equkrz0iPhp+ajmqcZKSZoP6Eg7zy8V
         IcdlVxBvbpRmqQCZqdP3thsz14hIPaV+lHmidDNU9DKpj6T8vYZHHrppF5PXbUtHPz3O
         UWyzrfLa19f3BLTKDOPCYrlasARJyQqML7Qi2A7yXi/qyNKiQyXhz7xmx+joEORhFvKW
         Sgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHumhMIUr438aWWlrs+78cdgsF1iUwE1HgS3gt+l/Ls=;
        b=dlS66PAE1ovQzrr1nP755h5gErTFGfQoNYwXyQKq/l1+48FZzg/REX3luPXKQX76h4
         PHwpQNa4d9QdJwgtQQD2ToVk7cgCw3kSOIC0/6I525oOU+pnbc2BCnDS6lJqGp8m3V5z
         3PTcJt4ARjdfVmdSWm00jSPFzkwZp6HK1H/2G7dPXkrPYTMwgrwGdg9KW1EiznvJUPcQ
         mFMN71wxZbfea710Ap8m9d9lGTjgmD/IroMfBYhZ80aRDs/C7E+Piw52OKzc4yJGkwu/
         jq4DwqfFWVLcuMxodqw4ZJqYCu/SsR2jVV+CJ+B90UE9iBbDxqx1oUX7KVuNjzOlgxyQ
         2EFg==
X-Gm-Message-State: AOAM5304UlBwW7G/z/F7vcWKxNmb/MNXLVJEl0t3aDSP0zg1npfTLk9K
        EWLr+u3a++jRcdFKJMiD7XA=
X-Google-Smtp-Source: ABdhPJzeBQkPFaHl2wBYEVOxaarNNmQ1BtUFuNj4uSlEJXQcPIQL5Evmiu4WHVAMmvGxXGLHJPlR3Q==
X-Received: by 2002:a05:6808:23ca:: with SMTP id bq10mr9944414oib.6.1635537672112;
        Fri, 29 Oct 2021 13:01:12 -0700 (PDT)
Received: from localhost.localdomain ([181.23.79.14])
        by smtp.gmail.com with ESMTPSA id w5sm2180498otq.46.2021.10.29.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:01:11 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2] staging: vchiq_core: get rid of typedef
Date:   Fri, 29 Oct 2021 17:00:12 -0300
Message-Id: <20211029200012.45986-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typedef BITSET_T is acting as a synonym of u32. However, using the type u32
directly makes the code more readable. Furthermore, typedef should only be used
in some cases, [1]. Hence, get rid of it.

[1] Documentation/process/coding-style.rst

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v1 -> v2: improve changelog specifing which typedef is being removed.

 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  | 6 +++---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h  | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ab97a35e63f9..7fe20d4b7ba2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -711,7 +711,7 @@ reserve_space(struct vchiq_state *state, size_t space, int is_blocking)
 }
 
 static void
-process_free_data_message(struct vchiq_state *state, BITSET_T *service_found,
+process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			  struct vchiq_header *header)
 {
 	int msgid = header->msgid;
@@ -767,7 +767,7 @@ process_free_data_message(struct vchiq_state *state, BITSET_T *service_found,
 
 /* Called by the recycle thread. */
 static void
-process_free_queue(struct vchiq_state *state, BITSET_T *service_found,
+process_free_queue(struct vchiq_state *state, u32 *service_found,
 		   size_t length)
 {
 	struct vchiq_shared_state *local = state->local;
@@ -1981,7 +1981,7 @@ recycle_func(void *v)
 {
 	struct vchiq_state *state = v;
 	struct vchiq_shared_state *local = state->local;
-	BITSET_T *found;
+	u32 *found;
 	size_t length;
 
 	length = sizeof(*found) * BITSET_SIZE(VCHIQ_MAX_SERVICES);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 3e50910ecba3..53a98949b294 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -74,9 +74,7 @@
 	((fourcc) >>  8) & 0xff, \
 	(fourcc) & 0xff
 
-typedef u32 BITSET_T;
-
-static_assert((sizeof(BITSET_T) * 8) == 32);
+static_assert((sizeof(u32) * 8) == 32);
 
 #define BITSET_SIZE(b)        ((b + 31) >> 5)
 #define BITSET_WORD(b)        (b >> 5)
-- 
2.33.1

