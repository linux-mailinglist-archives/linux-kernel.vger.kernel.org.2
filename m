Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5884429BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhJLDZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhJLDZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:25:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1FEC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:23:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so849057pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DI9d3X9+l3ZGo6X1Ncsf2XOBjXmSJmpYI4yDZ9pqPlQ=;
        b=VhpTPpqEZJq1fmgH6DD3rLFjOgOJgF7ekkJFe8B8+qFD+RjgXN4pFFGCINsfez/EfQ
         mNOiyZdlX66rpGmL9sPdl/aTGmmx51Xx0MNOR34HyienmL85OsIWes/Ut2zcwYO12mnz
         lrCtiYSCCijrzsx50wJgyTtVneK9Tda7L29XAU/9HBiA1uoUsGA5WIOixEq6FgVOi1gx
         k9OnVv/LB/OhLP/9d3uana7GnX73tog7mupLxls7u6oxCHrEi7n6CUTc5vP5Ng1T1S9o
         GEoE3evgArbwAIprCEu19lV9POz5bnNa8iad5yZ440lJcrJbk4Luc9aO9OJTYioJLNjO
         MKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DI9d3X9+l3ZGo6X1Ncsf2XOBjXmSJmpYI4yDZ9pqPlQ=;
        b=WtP6oHVhvD0+dXxd+gT7Lx5n6s/ojXL1G32nxhO8avOevnJofivMNPunwbZf8jbQVb
         pDSPH3cmV7uj2lMhK6EosDZLohiBdUAoWCK+jzV+UtSDeXX4dMHXu47JnrmmcMmiUlmJ
         oOjbaIHGt4ZhJjOa0KVLfleCh3bS1RPeZD2Rfg3MLH1tyTP1aW7pkzDFhDmwUP9t9zcn
         OALByOdBzTTylHTUcm/omcHKAicIria36/eB1RY8tWUShvAjWwZexmn8znJpxA/BN8m5
         MaNT9U+bfx52HwQuOqC4BTxFBMuHBtUdSNfHE/vt3vGAA4ZLX9r8IkXW7CxrYesPtJ8R
         iYXw==
X-Gm-Message-State: AOAM531dk082cG1MyO/M1xdLq2Y/N3nqHj8NoZorDQWpA/ybFvdRT71U
        itYwKN4VikWLxXMjy7guIUM=
X-Google-Smtp-Source: ABdhPJxAjbFUN9Q7FTePIJckgxWGqGMKaeBlPWpgv27Z4pHLaA2+y1e3PNPeGkTNFKar0p/j07Irdg==
X-Received: by 2002:a17:902:c409:b0:13f:1a43:c5c with SMTP id k9-20020a170902c40900b0013f1a430c5cmr19525006plk.40.1634009029389;
        Mon, 11 Oct 2021 20:23:49 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id d12sm9372767pgf.19.2021.10.11.20.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:23:48 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, davidcomponentone@gmail.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH virt-pci] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 11:23:33 +0800
Message-Id: <20211012032333.184581-1-davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./arch/um/drivers/virt-pci.c:192:20-26:
ERROR: application of sizeof to pointer"
Using the "sizeof(buf->data)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..705275c5176c 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
-- 
2.30.2

