Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93A040D47D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhIPIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhIPIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:30:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D055C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:29:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s16so1478590wra.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRXWDzzmmi7hgEkppSE9hHSKWfVi/Hf7zbRE1ZVJpi8=;
        b=hftX7bZJVgWhT3vC1yEc1hoFpLXQYhBzlTOvTAXD4KJtPzhMFZQg01tlN9YSqJW/WP
         TECiE9bS0t5+b6X5EXb2iUQxruWq7iEtTSTa6fZFQGsdv+AEsnKXs6dMJS8tURyW5fcy
         m9n/MXmvKtmWJiaVadQXg4LIFHjyNFyk6ZKq2aTbKbS/9GvP1i3s1iV20GUBhvGDP1Ce
         Z8pB1JtQbcVLUlTsjJe19GwKXFx2rmMHERNMjPknMyq32WuNoxRfDpLKPG6D2SfYquRL
         ZJz5a15zhGC4GA/xwublCEsklCHb0FO+jAACN3HMS+H/3fiW8qBU0voWWWGcZPzD8FtO
         +t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRXWDzzmmi7hgEkppSE9hHSKWfVi/Hf7zbRE1ZVJpi8=;
        b=Fd+JqcpUIeSjFtLumzCMNvTw3P75181BtCdKFb0rRiH1pTtlMt75cZfYs67Ej77BYh
         EqhDMXaGJYRHJXQsxcMXAoOcKqy2jZ5qIFbRnPv2DMa0VBXD+jIBdFfGAONssNaswKHM
         jaknRvqD+5c0zNO1iJ36vvdb0gTTCZwurzphrXDCDB69rBIohq8eiPCH/hm57Zj32EGv
         0qucV0ZNIvpTnwZUIbq7U6EgojMqt7TURACQuF88ocwzf5VJZWhA74AYw9DjdLPyihrq
         LjLH5oxbK/Em306IohEZLttt9dUJ5CbsY/0u3v/vjcXsOyk+kF6PV5I860aadpWo/rmq
         r5ww==
X-Gm-Message-State: AOAM532Seu1DGXCzO3UKBs5Rmb67X76INLTQD3aIc6fX+quz+9YfEM3Y
        CeoZQE/WtcuS4TL2tSOFGW8=
X-Google-Smtp-Source: ABdhPJyoTnULr8CPcm/HkeUXT9jMsGe1PYvaz4XMrlyPHmGEiESimgRpRHJoS1f5rh+3w9/sLExjvQ==
X-Received: by 2002:adf:f683:: with SMTP id v3mr4747566wrp.423.1631780956709;
        Thu, 16 Sep 2021 01:29:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id d129sm7458079wmd.23.2021.09.16.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:29:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove RaSupport88E from struct odm_dm_struct
Date:   Thu, 16 Sep 2021 10:29:06 +0200
Message-Id: <20210916082906.25294-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916082906.25294-1-straube.linux@gmail.com>
References: <20210916082906.25294-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field RaSupport88E of struct odm_dm_struct is unused.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 4fee0e9e0df3..265583a43494 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -847,13 +847,6 @@ struct odm_dm_struct {
 	struct odm_ra_info RAInfo[ODM_ASSOCIATE_ENTRY_NUM]; /* Use MacID as
 			* array index. STA MacID=0,
 			* VWiFi Client MacID={1, ODM_ASSOCIATE_ENTRY_NUM-1} */
-	/*  */
-	/*  2012/02/14 MH Add to share 88E ra with other SW team. */
-	/*  We need to colelct all support abilit to a proper area. */
-	/*  */
-	bool	RaSupport88E;
-
-	/*  Define ........... */
 
 	/*  Latest packet phy info (ODM write) */
 	struct odm_phy_dbg_info PhyDbgInfo;
-- 
2.33.0

