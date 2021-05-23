Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9031038DB51
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhEWNrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhEWNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:47:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D49C061574;
        Sun, 23 May 2021 06:46:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x8so25719161wrq.9;
        Sun, 23 May 2021 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6UoVs+M+GXbEK+vfTQ5QS4iJpNuK+tJFLeCY/X2pxU=;
        b=CjQLdjk2huDsLPFjg7zYP9ydXHuaaWIN3m+Mf1VC/3ElkxcdnQCn//6CKhefrK4KeM
         pveV03SZ/xQWhJNQfYJs0pedfj7+P/F6JgiJdViY46mm3B765R+RnMlpWsJfehez+ZXt
         k2dZfpCjKRSbrauUa4egfxpEKy+fmVQHv+iMFwWD0YE/Jjv+bgOYRJpAxqaFoBNssqUA
         YX/y+KYspszuYaX+Vt3rfUk8hN7nnS9IPcCSTAyA9Jrl/WdNddZQ5vsc3UgBxXSSIJ75
         ET7dtCH3q++oWer+leTXCkkp/GjRCdCX3WfW6pxISfT8lvUohSZ2p6mi1I5RFKM4cbN/
         raxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6UoVs+M+GXbEK+vfTQ5QS4iJpNuK+tJFLeCY/X2pxU=;
        b=FEZ+AG3nYh54q6ullAfcL7WEeYDdYJOqNZ2n9z2GifPmOoms9TRn99kfRVVFTW1ng7
         T6y9sKxNNWGu7pQX5hhyBDGQD1ssFxetyUGnH2YEIUEvfFGuq2/6PLhj7dpoRUdU3Ueg
         Ci+hXgGcCaSC0/D3T2DQt8L9ACRASJagp5pKGJqpjb1ftL8e7sJHlnTsVLyH67E3rFjV
         q9dQQ0UkMRwZZTrwH4ATbkWVVZby8gr8GussYN4oXSi2J5aqgcRI+LG/8WE6oGoOvfwl
         ozluB8HrJ9TPNLcus1hy7uKydFpIX61boAaFAaSeFMf+Isry43Nmh+1upVWPUIbHDWYE
         F59g==
X-Gm-Message-State: AOAM532RavpV/rp+K7Tq59h4nmCaRulTIuRrftXbdLC4kPeJ0uf5ZeqF
        MBacgvJ/xiN6npCetbXsAJ0=
X-Google-Smtp-Source: ABdhPJykCZECcHdAWK0Qq4kcIS0ikOR341wSf/g3aKkcGVtGehVMb/PVshyVA+QskWc/xWM3L/eU0Q==
X-Received: by 2002:adf:9785:: with SMTP id s5mr2852657wrb.276.1621777574552;
        Sun, 23 May 2021 06:46:14 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id z188sm5112414wme.38.2021.05.23.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 06:46:13 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/3] platform/surface: aggregator_registry: Add support for 13" Intel Surface Laptop 4
Date:   Sun, 23 May 2021 15:45:27 +0200
Message-Id: <20210523134528.798887-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523134528.798887-1-luzmaximilian@gmail.com>
References: <20210523134528.798887-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 13" Intel version of the Surface Laptop 4.

Use the existing node group for the Surface Laptop 3 since the 15" AMD
version already shares its WSID HID with its predecessor and there don't
seem to be any significant differences with regards to SAM.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index bdc09305aab7..ef83461fa536 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -524,6 +524,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop 3 (15", AMD) and 4 (15", AMD) */
 	{ "MSHW0110", (unsigned long)ssam_node_group_sl3 },
 
+	/* Surface Laptop 4 (13", Intel) */
+	{ "MSHW0250", (unsigned long)ssam_node_group_sl3 },
+
 	/* Surface Laptop Go 1 */
 	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
 
-- 
2.31.1

