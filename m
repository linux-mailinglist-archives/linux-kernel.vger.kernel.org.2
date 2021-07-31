Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636583DC1E9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhGaAYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhGaAYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA56C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:23:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d8so13333326wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8H37xNBSGIOnEvnHiZeZ4kxx2fU5DnigwTZak5GvhE=;
        b=a5DYPIUfI6Hpoij2rPQILYPEQXmyEye3/2iJosZA/2S4MUojH0cRfZUkgg5lbJ+v7K
         W9DBypGr3WFegDWZjCd16To0kaVdQLYL0kRgyPyygLgAQEpdlHUunQbnogY3El3Nb7xC
         B9iYKm/zCyty7bxq1Fvzo4p+lhRnbG5DqmQTueoPU2Plz3mjRCTeEGXKM0puKYCCklIc
         PuKlWgPBnZTIM7V4kKjzsQoHwITb9HQw1mObsF95o6pIa1W7ewp77sT4250QmHQypesJ
         8cWwwXcegtMtaWqinfzjrL8G2aIilUZVCvz9mr7osgh5R+NYZ0nNjqRN/L+iJiZf2gcX
         SR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8H37xNBSGIOnEvnHiZeZ4kxx2fU5DnigwTZak5GvhE=;
        b=Pj9wmCu9uei0tHSzVKWTFlKYtt9Ln+xZxRvd4d+3LuXcSzCZVEkYucP8CHjEUAGgZF
         aVXo0LfYCaTmSzonRgrCIkbV5VF/KVLss0cyVvIV6jElc6qggAGkWSIpF9d+9Ya0azFN
         5/HJTmGY+ztWJh3CrK+QgDypvs86uYdrGXdCxI69ElYWxAdPkSXRoVK9EJsdlTY/dRxj
         KyrinBEiHcHCZRlENgOnkK1n+NRhL/7v4dRdkvp9GIX9vskSOv+irDzzjTWiPxakwmh+
         k/vBFib1YcLyMwnSqzH9qEio6inHB2mzxzHZcth0AKmAW8MTbZRXhl97FyYOtiSXk64d
         YBCg==
X-Gm-Message-State: AOAM53148G3NKkh7CitOGiEM/OgcGkfwj6V0cLXqjGWMXQB9XN6fDFkf
        8Od0leXK9YjxH7ZZc9mufFSv+g==
X-Google-Smtp-Source: ABdhPJwDkdf8OJcGyKC2Cxp/oDXdvW3TL1CRL5nlkIxm3uVANXKggvAXGj5f0L41/DC5EdZ0l5/DAQ==
X-Received: by 2002:adf:d22f:: with SMTP id k15mr5791331wrh.335.1627691038418;
        Fri, 30 Jul 2021 17:23:58 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:23:58 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] staging: r8188eu: remove ODM_RT_TRACE_F macro definition
Date:   Sat, 31 Jul 2021 01:23:43 +0100
Message-Id: <20210731002353.68479-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE_F macro definition from include/odm_debug.h, as
it is called from nowhere and is therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index c11d8925952c..ef0d6b84b2d5 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -90,12 +90,6 @@
 		RT_PRINTK fmt;						\
 	}
 
-#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)			\
-	if (((comp) & pDM_Odm->DebugComponents) &&			\
-	    (level <= pDM_Odm->DebugLevel)) {				\
-		RT_PRINTK fmt;						\
-	}
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.31.1

