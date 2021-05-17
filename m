Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AB382929
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhEQKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34591 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhEQJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:59:56 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1I-0002Sv-4o
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:40 +0000
Received: by mail-ed1-f72.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so3615429edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7PH32XmV7+F4A06910KpvSpJvecDG2Q1fBgZs/i1VY=;
        b=AvBDeP6aqIxMpMjJMDBavR4+pW50pfURsP8yFAWLibRRLryrjwY8CYQTSYBTtP7Fiv
         mnpNxpWUBCaO5++wyfhQcLbI7IipysF6rdA8nhWgOHaqeWhsi5rR6r5VWl07zmWsrQVq
         wvWxTHBSX9DfmICqw6MrEVHVTP9+f5154Usgqheg4IRDv2geSVvj1VBXtVSpdJCeV1bl
         QUM56DkDQw39Ntutbp4mnC61fAl/qj3BQETVhKG0SaLudusvd7g+H3Hk/H9JO6u6bMoR
         qs9T9kXiFZJWwdCGmUZUmd4N9TiJ1ltSdsSRpOn25uTfJ9nJc68kZCuu5E0QFq+yAfyk
         u9/g==
X-Gm-Message-State: AOAM530FqhFEUYtORYlmYqPEEnrUXMDHPPabbTxS3ppgX48vq4vtyadn
        7khTX1QZ51wEVnZdhQJwEY+Ubg39+Nqq7I0aWjMeoUCZBnViyouohPRITXFAFsUPaQU/7UGx604
        uRGBcFbqrIvEHzVXzi9fY1NH4vdkONF5kTZf53KcaXA==
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr2651966ejx.431.1621245519856;
        Mon, 17 May 2021 02:58:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQQNiOuXZEW8LPP3Os2lkb9T/Nv60FVa83Tye/VGzXvSITGCa6kP10p+w8+CpX1EC/hpunoQ==
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr2651959ejx.431.1621245519714;
        Mon, 17 May 2021 02:58:39 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v24sm2725885eds.19.2021.05.17.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:39 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] uio: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:37 +0200
Message-Id: <20210517095837.81783-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/uio -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/uio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 5531f3afeb21..2e16c5338e5b 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -18,7 +18,7 @@ config UIO_CIF
 	depends on PCI
 	help
 	  Driver for Hilscher CIF DeviceNet and Profibus cards.  This
-  	  driver requires a userspace component called cif that handles
+	  driver requires a userspace component called cif that handles
 	  all of the heavy lifting and can be found at:
 	        <http://www.osadl.org/projects/downloads/UIO/user/>
 
-- 
2.27.0

