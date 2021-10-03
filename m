Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95A64203DC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhJCUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhJCUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:03:21 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B23C061780
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:01:33 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y28so3429744vsd.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWnB5K1Grj0xQyY5Skv45XzlXt4yBMt+nMNlhoq0dAk=;
        b=kxcwQ5isTHdCrmNEqg2mueB/somw/dnSZ172BkV66GxYsy4NpfHzCbJ2Fx8N9vmf1o
         8nJnAbaCA/cJR6C3dStiK3GIxyYE4rsaL1gV35KDBjX2Ep6luZs2ne5giXf0UoZdzinW
         BBBxq38jFMTTe2ur8J2U3rr8svCoVYMfVrHgWNQLTz17nyqzjP2bN+zK7PWl8UThXCM/
         p8dq1o5C7OI7Z+4qUXFzx3GmUISc/YcsVNa1fUHhvvweN3DL5vo2DC42eoswbV8sUiiL
         nqcIeGambAq/IawRxXDD7TfsojNg3NiUvL1mr5nw9HnqQaq/HBYm4ERkt8eAw+QHX7o+
         /NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWnB5K1Grj0xQyY5Skv45XzlXt4yBMt+nMNlhoq0dAk=;
        b=6YHSZMiN3xG7V1XcAcJg6z7DyCedOCztUOfcKvwosg5siphmS4AoGFEaRNrz8+rZ8x
         m9Y6QMJTY+zCG5hLD0c3aXIjku8QD0Rw7IVnBDcgEYPHc2hcQ8SQ8G4FOtpIU/xZ4cwg
         QEDTwPcR4fEGLPJuk+K7TJCBbb8e4Ay+hbYL2TtxoJlph0T7+81IEExM5N5twNtOiWK1
         0Iv1GdVjYF5ug0cVF7FaBS+YVKH1OKNdeTSNG5d79ShTqu06j/EcHxb0j2O8A7g3pt8l
         xeqobNE99wl7KvN9zrZTP7Ud7+kS7nzfKpSW9+E7HKBYmZcKgH3tChuJpbXxiXDjo2tx
         HbXQ==
X-Gm-Message-State: AOAM530XYlYrRdKvatVCiCAVyQ2kW31lSomKAq1bZc/20+pruiGER3Hv
        qu9b95+b5snX+0boSdqB28w=
X-Google-Smtp-Source: ABdhPJwGIuGvigJRC8FTrma9fSmPm3wosjqCuei6Z9n0gA9efbcU/0UCPT24xg+3XkmSv6NApARWJg==
X-Received: by 2002:a05:6102:3593:: with SMTP id h19mr10540551vsu.23.1633291292266;
        Sun, 03 Oct 2021 13:01:32 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:01:31 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 9/9] staging: vchiq_core: fix quoted strings split across lines
Date:   Sun,  3 Oct 2021 16:58:02 -0300
Message-Id: <20211003195758.36572-10-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted strings should not be split across lines. As put it in [1]:
"never break user-visible strings such as printk messages because that
breaks the ability to grep for them."

While at it, fix the alignment of the arguments in the sentence.

Note: as the line now is:

 vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",

checkpatch.pl emits a CHECK: line length of 123 exceeds 100 columns.

But now the string is grep-able and the whole function call is more clear.

Reported by checkpatch.pl

[1] Documentation/process/coding-style.rst

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c     | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 416110bf20fa..fa65a99ae54a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1499,13 +1499,9 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 	if ((service->version < version_min) || (version < service->version_min)) {
 		/* Version mismatch */
 		vchiq_loud_error_header();
-		vchiq_loud_error("%d: service %d (%c%c%c%c) "
-			"version mismatch - local (%d, min %d)"
-			" vs. remote (%d, min %d)",
-			state->id, service->localport,
-			VCHIQ_FOURCC_AS_4CHARS(fourcc),
-			service->version, service->version_min,
-			version, version_min);
+		vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
+				 state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
+				 service->version, service->version_min, version, version_min);
 		vchiq_loud_error_footer();
 		vchiq_service_put(service);
 		service = NULL;
-- 
2.33.0

