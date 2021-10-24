Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72038438C27
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJXVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJXVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:41:55 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA6C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:39:34 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id e5so11163607uam.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QraEw1MMGnwx9JFyFTABlxndaYwZD109U5RjGzZtJZI=;
        b=iAFPIe9cky/Um+h4fO1+FIa0SurP6snw6pXN1do26C7vDer6KwDZj38nDqJJRPnHS2
         +tmhcJC5RGtdyHypd4k8WcJHQ6pC4pWY7Tit6Fx347a1tAZlmrcgi+k2f2IjNUraKDv9
         a1lbho9OwNpqOAXxfqDNHMNsXA3r+C+MLJBvavUkcHxzWETdu/kfrlcCtFPXZPh9wZ5P
         d8DgS18fIJKqguHXaBYj4J0wEyYpVewHGbbaOorllUq07+6KZiUDtXnVufz3u1U2/dO0
         WwmzcW6dmr9Js3y61NgrBxD96bBJGyeetPxnmOh2W94I+ALzY94e10KyNkTwE0AqTrGk
         6jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QraEw1MMGnwx9JFyFTABlxndaYwZD109U5RjGzZtJZI=;
        b=PTawUhk8P91qO73fLYKXOpB/N2CZMeIXD5CwpwEYzlXHn3s/jQ/lTSY3ubIHo26d4t
         7XYhdZBapIar1av9UgAatiB+W+HSOLKdLUrR5+2JIlJf9GNUS7Jq+IsEsS4D3jxRs4Yt
         I8xq8tdAfyGzpKpKydUEzACD8lqzcG3PnDR/t94l+s6vGW0DQOEJdWqmXL4zj51+lYPb
         BGfENvlZJ45429+irhfK6cAceUSA7GjBfWmgSkeceVA24lzEOYmpEt9hBs6WnSi5SFS8
         cvvPWOCMRZa0V0qL6AfjMlhetlBSzAa9aehd6q3rkuP7Sx+m5w59/DEw/P9h0l+r/3Kp
         Z1cw==
X-Gm-Message-State: AOAM5332HRrnwGR93fAHoLarFlDNc1JOFGhoATY2/M0HzNI/Rjr9YY/8
        JG6ytqja+G4Z3dDVrQrW05A=
X-Google-Smtp-Source: ABdhPJygE+1fz6v4hPFhXo1k0yuQUD2l0NVhQv2MwZnMh51zGuIEcJ0lcMkm+x5zpTXwoQtuRHOQvA==
X-Received: by 2002:a05:6102:3a56:: with SMTP id c22mr11776109vsu.26.1635111573193;
        Sun, 24 Oct 2021 14:39:33 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 64sm2046309vsz.15.2021.10.24.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:39:32 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 8/8] staging: vchiq_core: fix quoted strings split across lines
Date:   Sun, 24 Oct 2021 18:38:39 -0300
Message-Id: <20211024213839.370830-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024212844.370379-1-gascoar@gmail.com>
References: <20211024212844.370379-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted strings should not be split across lines. As put it in [1]:
"never break user-visible strings such as printk messages because that
breaks the ability to grep for them."

While at it, fix the alignment of the arguments in the sentence.

Note: this introduce a checkpatch CHECK: line length of 123 exceeds 100
columns, as the line now is:

 vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",

But now the string is grep-able and the whole function call more
clear.

Reported by checkpatch.pl

[1] Documentation/process/coding-style.rst

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c     | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 3af55e78f356..ab97a35e63f9 100644
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
2.33.1

