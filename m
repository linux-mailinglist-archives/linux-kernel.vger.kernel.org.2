Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFC3EBF49
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhHNBOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhHNBOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:14:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83409C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:13:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so12484181pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkp5EdF8JGGUL9Fj5dPILwNGE1Ih8YlWbFZXceS3klc=;
        b=uIIR8e+eVgkgXKMT5Z8N2ocY/YPRP2SmO8qGm2VygwKIk8v/s0gk7sHFBfOajHHQHV
         x5gvKqP0J5P+VbwbG2axqXd88v+AAu8WVNFCkwY+6to6iosxs9rLktSRPDxF/8GAQ650
         2o1wvUCL6jlIto7O3B2JyDoNSuLQUCDzDxzJj2KEo+I3AJpPqn0QxnpnlFAVrCCJT6wo
         S8BMI+CpPFjVRCTFYdTOToBn7rrDBgWaptYQ5bvw8MZ2QK9OZnANJh6r/OHhoFVPT/cs
         zGsRzDMidaZmaiYu4ka2yLb3M7jhZtDAPviPV7QIWeqecXK1Wv0gP3ri8HjJEBK6d/vl
         8BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkp5EdF8JGGUL9Fj5dPILwNGE1Ih8YlWbFZXceS3klc=;
        b=ZQquW83i+Spl72WrU6Hu5Pl5GtRdIe6J39xm27RJ9oD4kz0P81cFLW/eLAWURoUJTb
         TEkfh5JVACHPPGfkTUm8tFYLVDuCudcAskFh/UQnSnCSB8GBD8KRPkSdv52hkTBqaUGS
         UfzxRzqjz0G02jFWYSRsa0HzpLiosb3dr1rZLAsoMiQymSHHMtPSXaXro9o+BWnwjEAd
         dEpkw3CKmuzOaPHBmI+W/GFrkp7bSzG/IWNnZAAo7emlYQkz0Hus5SgmRYGGX+A3TDAm
         vJRS3P6HjDyWOSN/5fQyB/Sj3QBPp6IfQETZFDO2wyOs2a1MNhOekERv4p9jMfD+eGTo
         71OA==
X-Gm-Message-State: AOAM530horjZcMg2UeVuMzP3sjHH9npXR06Z4uQBflFCV3w5K+/bVwj2
        6A79/x/xAqcs/iSX2yvPrGs=
X-Google-Smtp-Source: ABdhPJx8GmytcYeNUJoLJeC2P8mkrFQipWlkCPLfI8EAQ9TybqESWsl57QP9tgzX605KqvNf3H7ccg==
X-Received: by 2002:a17:902:850a:b029:12c:8da9:8bd2 with SMTP id bj10-20020a170902850ab029012c8da98bd2mr4085938plb.58.1628903613158;
        Fri, 13 Aug 2021 18:13:33 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id t1sm4292407pgr.65.2021.08.13.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:13:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] bus: fsl-mc: replace in_irq() with in_hardirq()
Date:   Sat, 14 Aug 2021 09:13:19 +0800
Message-Id: <20210814011319.5147-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 drivers/bus/fsl-mc/mc-sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index f2052cd0a051..42662beb09b2 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -248,7 +248,7 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd)
 	enum mc_cmd_status status;
 	unsigned long irq_flags = 0;
 
-	if (in_irq() && !(mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL))
+	if (in_hardirq() && !(mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL))
 		return -EINVAL;
 
 	if (mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL)
-- 
2.30.2

