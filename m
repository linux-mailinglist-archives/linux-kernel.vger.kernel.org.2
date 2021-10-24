Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF49438C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhJXV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhJXV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:28:12 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BFFC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:50 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id bc10so4211396vkb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gFBvsyo02xfQlMrkGMRUgpYnVFylPr5PKSD1wmXbLg=;
        b=Btk6kwxqQBLlK2Kl1khbLgAVTUIw/lZRbLWOD2RLGd7WdFpR+i3lWlMwVbIT73D6pE
         +ffDRnhLxgOkp8fMksTJJYdzx/4C4UjdjZMIocEWKVNQbjhPPkvh96UKo9HO3pqfO5JA
         fLNXcazO86z9Mo3Riwxc71eZBfmo73bRBKKma7/15l/5SSV3O+EOc7Lrcj+j1Y9eKAKU
         4eiW3YN98a8pezB8OlbMaiKS/Dz0ooL3PPvXq6ek+uaL97wszk+kgDcOyWmzkl7B/EcH
         HKdzHlIdo6DK2JdAZeqmv1KZNUqpRLIg2zPk2UiuwZF8iK9rV8LjsS8jZG6ccY5LtE7m
         lyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gFBvsyo02xfQlMrkGMRUgpYnVFylPr5PKSD1wmXbLg=;
        b=f5vEuK418AqBr8DPdHc8QHmxc4MOk0L8qxA9t/bpzt9HMgx2aKXy7xYQ9lwBojxpA/
         9j8luzjNVl2wRZ1knXQmEMIgz2bqNxwaHeJoCMEwg5XO9WjW5/nAHCbaOa8lBBdCLeqN
         LIe9D+qOXr7Ut6soKmQ9hS6xVcSowdfeiLtYq7zB2MBPGtSNKnyzEjaE4C2ZqA1AqlqI
         G6KiEE/DCbOVs3CbuVFZv43q+ovUwUeG6fVFc4IM5A1nLG5SRpgp5bqENLoD4pQMjdcb
         HMC57nbusjcYv2A0vMhZnGXL0Bn717ll9Zig41eugAZ3eFjMgl+Ss3hNbBRUXqUeFZeK
         V6Bg==
X-Gm-Message-State: AOAM530Hv9ohFMfeQ+WLBcy2WUctfDxT3gtjhN3RyF9Q5YPtTdpwbZpP
        YMmLF1Uoy26N4NC7mVH5mWQ=
X-Google-Smtp-Source: ABdhPJz0+9rGWIupGWw1BBWoq7paoigHka6FgVu6a5eE9CkFAsLrbRIM0DXSjLR2QI+XyOQjQzWFCQ==
X-Received: by 2002:a1f:7d0a:: with SMTP id y10mr1004095vkc.12.1635110749736;
        Sun, 24 Oct 2021 14:25:49 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 45sm8847869uaq.8.2021.10.24.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:25:49 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 3/8] staging: vchiq_core.h: fix CamelCase in function declaration
Date:   Sun, 24 Oct 2021 18:25:19 -0300
Message-Id: <20211024212524.370078-4-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024212524.370078-1-gascoar@gmail.com>
References: <20211024212524.370078-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming function declaration to avoid CamelCase use.

As this was already fixed in the function definition in commit
801b1aa002d3 ("staging: vc04_services: fix CamelCase"), the current
change make the names of the variables in the function definition and
declartion match.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 893b07698268..383c3bcf787e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -622,7 +622,7 @@ extern void
 vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
 
 extern void
-vchiq_log_dump_mem(const char *label, uint32_t addr, const void *voidMem, size_t numBytes);
+vchiq_log_dump_mem(const char *label, uint32_t addr, const void *void_mem, size_t num_bytes);
 
 extern enum vchiq_status vchiq_remove_service(unsigned int service);
 
-- 
2.33.1

