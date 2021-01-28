Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07C0307578
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhA1MEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhA1MDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:03:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFDC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:02:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w18so3840924pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmaZv/BWIehFfP6lA3rx4Nelqr7DgDNARDpwDoj4YWw=;
        b=AiMiZ9iXwmrxk4P95b9U8GekaBKB/o1gdsMjk4YnWqgah2oA2eV7zHAPBAKyhhdUzY
         e8WSBKe1vIWd9+DeOmeELypV1DhTAVPphBNWSZtLWA0gixZHRBvMBdAkLuU3ktNYRKJU
         cRN1gcE1CsTWPaG72WNwIMpCDLisO+lPvu/T/fmoGNQV7St+u0w3HSFK24qipX5SKobu
         RDKxMsYWfTqiFmW+SdNah3Q79xBYu8q4Nw6tApqSAcROjO1RSmlwnnaEO33VmnAzzB7A
         EjRJQvBDyByJNQC6UzHtOr8yjImtkyODwSRmWz/62LCRhbdpKpnpW6+BbpjQU8dvh9pz
         IsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmaZv/BWIehFfP6lA3rx4Nelqr7DgDNARDpwDoj4YWw=;
        b=kVLBg0mph2Cgy8oGNYsYlZKD+sMpQ/rxEgVOL/TLWEHcEEnld6RYzf336GJlzUWumk
         4M8AZrx7FNNFr9fRlANQDaR09eUtLLyp3f7tJCPctnzW9t6BDBuAtzOCPHxdGhTGCdBS
         M+VBUEXV2cVMTfR60Obr1/XpesBo3n21Jht0BRymxBKyttxkgw2qiOgLgGHoMswoTP2+
         r3fVPY9XE6EcSmaC9dYRQ3Ljuh7G5HVG1lMSLrm7Yteq+nwHNpQgHTdLeclrZCy01nQw
         nkB22j+y5PJapUCtbwUP1TvnCbr6L6/ZZRVrG0k72vYuAwLCPgQLzUSZ5XJDtRoloLRl
         zTiA==
X-Gm-Message-State: AOAM532/ru+Z6mosn8G3ltz5dJqymRWLYI1h46Op4W9zLecaFkAinzr9
        K+d5vP8tYn3hPZOxQDv6QhEe+g==
X-Google-Smtp-Source: ABdhPJzw5+RBbFqHjrw7OiVFzB/SdO270BhGevAOOUoslyfiJ9zvIrHc/gNsOsTPYMaJiqDQqCSffQ==
X-Received: by 2002:a63:db0d:: with SMTP id e13mr16077752pgg.343.1611835325021;
        Thu, 28 Jan 2021 04:02:05 -0800 (PST)
Received: from localhost.localdomain (118-171-131-72.dynamic-ip.hinet.net. [118.171.131.72])
        by smtp.gmail.com with ESMTPSA id y22sm5605782pfb.132.2021.01.28.04.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 04:02:03 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pf8x00: Fix typo for PF8200 chip name
Date:   Thu, 28 Jan 2021 20:01:51 +0800
Message-Id: <20210128120151.554411-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial typo fix.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pf8x00-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 827da25466cc..9b28bd63208d 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -529,7 +529,7 @@ static int pf8x00_identify(struct pf8x00_chip *chip)
 		name = "PF8121A";
 		break;
 	case PF8200:
-		name = "PF8100";
+		name = "PF8200";
 		break;
 	default:
 		dev_err(chip->dev, "Unknown pf8x00 device id 0x%x\n", dev_id);
-- 
2.25.1

