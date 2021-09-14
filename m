Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77840BA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhINVjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbhINVjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:39:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:37:58 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w17so415670qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFOWREUn6nPF1dbjd6wIX22KxI3ogfGK/7UecMqtepU=;
        b=jg3VVYrAF1rC/rFJAcn55n8+lDtPIjwOrXSbxG8V5B2QLbOUt9VV7nO+Z08/QlwBwb
         jaPT5ERNI6/m7AuT2Qnd8j2cwdOOnrONAF1DS/LJ4Aw9Ci+CpO3OIqdmU6sX/r1gQOSM
         5am9GGs0z9qCbGEA4GB/SDuw7VDf1S8kbH1ICOswS6gp6b6b2Q6pAPnfSoGBfDdMmtPl
         rq2akVpBM93uiJbvs4Mn32n3AFfwuPJh1z4tGpwOldOZ/NzGDOz/qTBFXdqrE8ceEHtv
         RyzLCJpFC9tbmxuEXHwJ/+0HmXdZJrNdKUTRi7wPdjglHxvRQTqSkh+64HQOBIDC6foX
         GsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFOWREUn6nPF1dbjd6wIX22KxI3ogfGK/7UecMqtepU=;
        b=7/KOtHHqMwav9oGi4G0FQcz8+FIxSVopElGvGgL2SaMnPkcI+n0QTktJOXYhOFmSJc
         sXCmqSGuvofQA37OTYgBoMRulyaWvIuqprf59odqDNzT/9UGXEQM6ELLeJsygdFfaVCs
         LmKUvo4oZJ2Nxe9CojSWrYX8JUR2mtw6sEoJ43gQ76IwixifTeiphfQz46HCVpyLFThs
         dVUI2xiStUcJXw1mj+yrbecRzNrrXI6Tw0N37cptj9jyt3gqGn0Gtefz9aRiTcGfgE0C
         6ZsXsURbWFgJQCWvzXlpK/KpLqDx5irvtQ6DHFvbWKc3ev6qznn7y4DCD5y2Nlx2DN6G
         MIBA==
X-Gm-Message-State: AOAM533w5K2lMGNcFyNnnJo6UMwoOstrBiDN/y9+TYVhbPO3AZobqEJ6
        gKArpzkKDxiPCrgKLZcK9Mc=
X-Google-Smtp-Source: ABdhPJz//yVjuwYxXdOob2M5XM7o6FbU9VvjnzPxZ21PXHH7WCT1xlEon7eiIWrK04qnvvcc2zU+Nw==
X-Received: by 2002:ac8:7594:: with SMTP id s20mr6975586qtq.381.1631655477784;
        Tue, 14 Sep 2021 14:37:57 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:37:57 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 7/8] staging: vchiq_arm: remove extra blank line
Date:   Tue, 14 Sep 2021 18:35:38 -0300
Message-Id: <20210914213532.396654-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
References: <20210914213532.396654-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line.

Reported by checkpatch.pl
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index e8e39a154c74..8f5182df17b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -151,7 +151,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state);
 extern struct vchiq_arm_state*
 vchiq_platform_get_arm_state(struct vchiq_state *state);
 
-
 extern enum vchiq_status
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type);
-- 
2.33.0

