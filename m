Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4323F3B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhHUPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhHUPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 11:15:52 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA2DC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 08:15:12 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so22240741otf.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkGMZ34uMM076CqdGEC8S8YY15+qTIP2Tw/OLNLYTmg=;
        b=mcKvIw9yRGBgXT5GXZOPFt2skeigfvum9BkdU3kIKKPgqfCfWX19WZd7sJ+rmTUimw
         5jRmhN06NVSEi8DN3GDJFaR//YwBFOvRaao4HeZicSeZCFiUMcmPiN6wtkaHRfcK+cRI
         Vtrb9yGPzIBy4aSZ0BeePZqEN1yEL4U9o+8j2U+uhxNxsTIocMUTS/KQirkgVOf3OJe+
         j7V4TiZOt8zCoE+YSXlzz8oATGoCnm7orTJuw8DsSauUROWY4eII7VdCmDQerFrQsguY
         F9aC9/Zh7rSKqOCGS0TFSMX/KU2tg4pkUKKSP0KXaNHGwju1PRFO+syvW2HvM7f9riJS
         xJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BkGMZ34uMM076CqdGEC8S8YY15+qTIP2Tw/OLNLYTmg=;
        b=Ihcf7rIEveTp738tU5SjlD/6G/S01Gp+84/BYFSQseUChDhIoQJw5qiIg92xlGrtiE
         HHk8BgjVkRQc3cvlarCsPmiekfA1NFwbjmXuOg3C8mFtj/arElFzNYTkpPXzuSHZXwBk
         2LbYQRu28LaAB8oDeJM2pU29Eiqtq1/UvkV0fhAYgnOa1IbCLcfCiv/hVF//mN6fPPcA
         Dl1LqbW+pa9iyx6tylyENFfFJHyOVXq+ajzCYRzQK4xKB3DkkN2rYzQXx2EvqcnDmbD/
         5W6cbyG4d+XMGdxKZp4ANfpdmxprOfgVxKVGdbG4o+yENfhNE+VotXQXpx+uFwDdoYd/
         w7Xg==
X-Gm-Message-State: AOAM530do8vXAcoYgKzDy+DugnrbfDFjR5OWB9NCI1J6pAHQu4XGJwpz
        0AdEYtnAitbWnHaLUmEFXPU=
X-Google-Smtp-Source: ABdhPJyggAEmiw3FC6imvIiDWMlqQhavkFEGcST1kyML3a6WN60sILSwH9g8rc7qcFitKivh8BqxfQ==
X-Received: by 2002:a9d:1b5:: with SMTP id e50mr21789096ote.76.1629558905296;
        Sat, 21 Aug 2021 08:15:05 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id c14sm2326897otd.62.2021.08.21.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 08:15:04 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] staging: r8188eu: Make mult-byte entities in dhcp header be big endian
Date:   Sat, 21 Aug 2021 10:14:59 -0500
Message-Id: <20210821151459.26078-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 16- and 32-bit quantities in the dhcp message definition must be
big endian.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
This patch will set up all the reset of the endian warnings,

Larry
---

 drivers/staging/r8188eu/core/rtw_br_ext.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index ee52f28a1e56..62a672243696 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -640,16 +640,16 @@ struct dhcpMessage {
 	u_int8_t hlen;
 	u_int8_t hops;
 	u_int32_t xid;
-	u_int16_t secs;
-	u_int16_t flags;
-	u_int32_t ciaddr;
-	u_int32_t yiaddr;
-	u_int32_t siaddr;
-	u_int32_t giaddr;
+	__be16 secs;
+	__be16 flags;
+	__be32 ciaddr;
+	__be32 yiaddr;
+	__be32 siaddr;
+	__be32 giaddr;
 	u_int8_t chaddr[16];
 	u_int8_t sname[64];
 	u_int8_t file[128];
-	u_int32_t cookie;
+	__be32 cookie;
 	u_int8_t options[308]; /* 312 - cookie */
 };
 
-- 
2.32.0

