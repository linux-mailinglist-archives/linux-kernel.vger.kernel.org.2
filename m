Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DDD43E63A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1Qk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Qk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:40:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:37:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1572673pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkruJgvCEKtNeBSTAXmn2WZSAWgjf0MRa1oVEnouC/M=;
        b=X7tHd4KEratHyV1cjf9TZ3xzAajzacshGUPb0/1twCiqXn6CscCL63H+tTB+9gFXso
         wc8/Feq2gDuQskNPyy9X7bR439iQUB0fMZH/As9CE6A7y5T05Qbx1jGMGyCZPFVQ/71h
         XbQHGCVtJZnHWBH4ZM5nBBwBcMqDe85PlYP7hrC+YVeysOzIdOsoerHnKXAqjTmFhsBv
         nCJGJeHI5MOpV2be0rFE3Eck/lCfeUOWXU9iQHJdErUPMgIscQ6TZSs+XUKM2Gzmp5z9
         uxlCP2bTUZstLxYPafkt2+ncYXsQzKKU0Wdj1Y9Jad49DS+Dx1sHRDvdYKsPT7NAYs2q
         xu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkruJgvCEKtNeBSTAXmn2WZSAWgjf0MRa1oVEnouC/M=;
        b=rXRw5h8GysuWHbFSHeRaimZIT7vTJ4Vvb0e2nBp8WavlY4AtMGLwBEEhHRC6ptV1te
         WPi04bZAkI6h6qXwmoFBF89jL5hSlyBVwCKaywQKiIy78RoikyKvN6XfPvR4aiWvXgyC
         7qITB7X9HyMXOCBQrR6qSV2p166W2X9JA8f9VHZT4ZGUz03KXliycMan6r0xF5Qf04FR
         CKKyb8GMCNslrFSngu6NBVrK17H4PZ4bSZ/e3MzaPavcn6pNCkdvoxEihESj6YULFJDI
         ItQLvNpSL0IZsGgeBYC83LS0G0vzSAS3kUJHUFcYsJFHKdGnhIZfDZeHuIS65lRGcLlO
         K72Q==
X-Gm-Message-State: AOAM531WKy1S7hDNa4xIdrA/Ox+3xNDyGCWAXE51tOlgT/z3zWf9fcAn
        TSGgSbj1vBuSoaIVThcE+UI=
X-Google-Smtp-Source: ABdhPJzAA+I1WxBM6NEmBXEEiJJfndd52j2hrja2YR3AE4b0sWzFdJEA/mzD84O6sNsdW5j0zrznAQ==
X-Received: by 2002:a17:902:da90:b0:140:55f8:ca63 with SMTP id j16-20020a170902da9000b0014055f8ca63mr4883894plx.72.1635439078522;
        Thu, 28 Oct 2021 09:37:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2sm4445481pfj.42.2021.10.28.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:37:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: Update BCM7XXX entry with additional patterns
Date:   Thu, 28 Oct 2021 09:37:56 -0700
Message-Id: <20211028163756.4014059-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom STB systems use the bcm7038 pattern as well as the bcm7120
pattern for some of its drivers, add those to the existing entry.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..c61fd406acc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3609,6 +3609,8 @@ F:	arch/arm/mm/cache-b15-rac.c
 F:	drivers/bus/brcmstb_gisb.c
 F:	drivers/pci/controller/pcie-brcmstb.c
 N:	brcmstb
+N:	bcm7038
+N:	bcm7120
 
 BROADCOM BDC DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
-- 
2.25.1

