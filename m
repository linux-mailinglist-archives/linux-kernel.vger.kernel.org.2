Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD943B13D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhJZLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJZLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:30:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C8C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:28:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so13948380wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGTPimRUuQbXsjAfFE7Aj9Gc6Sbu9jVHcvTKPzpMRu4=;
        b=IuviMdSjZoRXW1PJrQe9UBhSVcEm7ke1qGcg1WIWDjEbTHDYTdNUMIgd0OlPxyO3Ep
         hZsa3KIE/HlJeKw7BlbBbdUEFJfFWOvCIVQp+5PBDhT7GqEt3b6jU+w3En0/9LKmeoAs
         1MZdqvlmhJhaRhZWb7ZApWiNMkebcM3P9nfSy3poHtRzOUjbeBcbprLIHQK6FZRNoFFd
         6dP6G+wcPGAF2sMXkZumMiZFOzMV9fzrRF7vqC2G2bgmh9wYfQhQED0qpRGtPmr4AtC4
         2aQ/oQRbe1dSJWL2OPQpwJAEEweW+2HldSxZLBTO7gzVnnHyh6SbQUwjRhOlgI0XK63A
         G+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGTPimRUuQbXsjAfFE7Aj9Gc6Sbu9jVHcvTKPzpMRu4=;
        b=T1p62QYGqKJz/A35+3qXi7i+lb1gqGQVQVheJCh5wQmSsuCVrc5CIbiAOGZBt4EUws
         1ice8p9kSFI+jgqYH+c8zHcW8voXTgv93emvlLmjLeSGm+dFOFbFGaTcz4WJuqGLxJBS
         cVRQGwrYlDCr7pRqDo6+/f8I4Xar0PEi4dXJuhsigahbYTMq6VkSLki+PSoM61VRAGFO
         0XlwgSP9k7y2ZLBf8OxWLht71a0pyth7tatrnOr9LJnN234j+MotN28Hi7WLxjdBBzpK
         9b6c9aLtNNc2ASa04Vks8O72WcOo1iLyLJZj9A/yc67xQ2IlKeO1ODroct6YXw14Qtn0
         JZUw==
X-Gm-Message-State: AOAM533GEeUi7ClUaZOseT+/VMF+rw+T67d878I/EPa61ET8jzkR6Khc
        yoC3OBiItaVacRJu0sxCe54=
X-Google-Smtp-Source: ABdhPJz32JLoL1jJ6kI3SgRClrG3OUb/6s1YV6t+rLNL+YuvzOPoEnuWWLafwZCAs1iX5qvQuCF1Rw==
X-Received: by 2002:adf:9b84:: with SMTP id d4mr29199200wrc.393.1635247680130;
        Tue, 26 Oct 2021 04:28:00 -0700 (PDT)
Received: from cerbero.fritz.box (93-41-150-160.ip82.fastwebnet.it. [93.41.150.160])
        by smtp.gmail.com with ESMTPSA id n11sm9288810wrs.14.2021.10.26.04.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:27:59 -0700 (PDT)
From:   Mario <awxkrnl@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Mario <awxkrnl@gmail.com>
Subject: [PATCH v2] drm: panel-orientation-quirks: Add quirk for GPD Win3
Date:   Tue, 26 Oct 2021 13:27:37 +0200
Message-Id: <20211026112737.9181-1-awxkrnl@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes screen orientation for GPD Win 3 handheld gaming console.

Signed-off-by: Mario Risoldi <awxkrnl@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index f6bdec7fa925..f6177c1d9872 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -185,6 +185,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 3 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.33.1

