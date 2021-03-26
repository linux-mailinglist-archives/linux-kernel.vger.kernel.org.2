Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5075134A3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhCZJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhCZJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:10:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3EDC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so4941724wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWAw6/ltIWDh7kRKJmEogYzueRT49PB3eW+AcRp/xKk=;
        b=Mv9ipFmw1YBuNfEmWuEGYPTuA+N1r/CKGCbJ+LfsVTzJ9NIeBWJ/ExANrB/ucRFMN2
         NFGWbcGDqyf9i6ziuUwkXzpBz3ryqxho8b3ijQYkrgA+FwSnSsysmJ//2nVy+rH8/CG2
         r1LtIsQ2ko5TDqbTT5mNnpnOsVU2myXgZbFWASjqLZpiYp2y1WGccw1Npt62tSLbjI/o
         TVVXFxj1LhnlLLp2gplJGMxv17iwf6/g5jc/rLtWjohnpsArH47FF3eS1ScWLnhGpMfB
         c3GtD3y+GeXncM5LR5x+EIVkbIop6bANysymq/4lTZQBwHQGGGhiG5FNV+dFE7Ha32Pq
         jVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWAw6/ltIWDh7kRKJmEogYzueRT49PB3eW+AcRp/xKk=;
        b=lGvIUtrBWilnX3Z8ceS4MHbAgIkPEVY4/xde5Wqre8rRu6uLIWXEDFW8gDIYbmWIBX
         DlLGXXVHMpgMQ/KiHE7PpFTJJ06svn4yoOsRgUPH862cDkwCTU61qs5ERKl6It5NJyXt
         n0bVYv0xgTzX3eR8pPOdIcCJghi1abyB4TLk6sY0nEzR1JAGQGVFKbVj8nWdBaUtUNhH
         58hU65JtMVyq/gRHb3KC/PP76004vYIihOKmCvkkicsG48d26P9ekiBAnAgvvFBa1YJh
         82ITFft7l51ZGhjX9rHsLtfpxq7WlFAmvkxT6AbnAYoA3P4fjE/JyzD2IbKEt5Fm21F6
         Ja0g==
X-Gm-Message-State: AOAM532dLhPQ5k5pn2ojDV7FdYojEkfbyqDnQRhiatwt2p370ZHx3JdT
        apkM9JkTf071uY5+ZL8jVFm3I8pC4zeQ3Q==
X-Google-Smtp-Source: ABdhPJzxI5PTyiGDq7c5WyKOTQrxI9KeTkiu4NBBEtfqMOy+SiUAJ7riuklJTlxVTKZz77onAqLJ7Q==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr13528121wrm.1.1616749801280;
        Fri, 26 Mar 2021 02:10:01 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id c2sm1714270wrt.47.2021.03.26.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:10:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 13/15] staging: rtl8723bs: add spaces around operator in include/rtw_pwrctrl.h
Date:   Fri, 26 Mar 2021 10:09:20 +0100
Message-Id: <b32111b9ca57f21296c1a33dd7136951800ec401.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch warning:

add a space around that '*'

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 688436cf3610..88e66211e0e3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -89,7 +89,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };
 
-#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */
+#define LPS_DELAY_TIME	(1 * HZ) /*  1 sec */
 
 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
-- 
2.20.1

