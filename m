Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B035FA73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352348AbhDNSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhDNSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57EC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so32832399ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiFxgSEqTgqvpN/6rEF5LuPK8ZpGPJBCmsVOLf+H4TI=;
        b=dWDlUzIaEecZuXyzX2auQ7K2GDDh6Fuy4mfpI/+fmEywR7xsWgFplnLRahSpMkXFIC
         /GZIBTNiqETVKnkPR1ipOI9ftaaBAaFt0kUw/6B1LESNStGZeEcKjiMAvviZXZbInx5B
         tIoo6l9ISJMoscS0ZYxMMN/4n5TXGGQXVeD0dhFadipOhJo0L2kiDAOZrSekBCFT8lpO
         0FwVhorVOcu4SZ/moJ92tahviJaOUTA+wFTHMDkJA7v1GdAgNDVVGlo85EXfkIb7Amon
         VFqj5I2gcJfLBzmNeBgQXp/2eZBQX5vFw0VvlKeP/h1Zg8nUPaB68HKbixCX8vg6MMOv
         Ygeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiFxgSEqTgqvpN/6rEF5LuPK8ZpGPJBCmsVOLf+H4TI=;
        b=XFOazL1S3mr/YeZqaWEj4+W/Yk+6z6Y80QUVJxTRI8dxybNmssa5+a/GpZiYioAig2
         Y7UthWX5Q9EofNetuDAPI4A2o0nV8nQlY/QdXbydKMyLPFMR1uflfERHom2UkxCWuugP
         sOWBEzYn+3T1K38aHcJZ6wIL145NTBdiChsZm9I1qRTu2jTbhQvtwmGC2EXmWggHcV1r
         a9vMFhrsazoQ7SQt72NBWDLgb/P7TXP+M/whd8ad90uybALIcWf/kggMDJM1d3mBrYuX
         xWeC3papwJs7zNb7MLvqbOqxkMZ2lHLydDAPlwC/9OM4pyA8nb5OFF4VkB4EIiNYIjMG
         RGXw==
X-Gm-Message-State: AOAM530jZCmARnJmd3fXFexulE9+IRv/3EI7xfszwrheq5W4Htd0c7Rl
        1BqchWyUNLJesfE4xy2CkAlQtKpsj6nVnA==
X-Google-Smtp-Source: ABdhPJyf3jKmIugKWrWCcbYYue+Pr0N4ia5nQTJR0QeXlas7BfMBSdE/CzzYZQx0vpGwr+En59Apwg==
X-Received: by 2002:a17:907:20e9:: with SMTP id rh9mr118018ejb.523.1618423904123;
        Wed, 14 Apr 2021 11:11:44 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 09/57] staging: rtl8188eu: core: rtw_ieee80211: Fix incorrectly documented function
Date:   Wed, 14 Apr 2021 19:10:41 +0100
Message-Id: <20210414181129.1628598-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/staging/rtl8188eu/core/rtw_ieee80211.c:11:
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c:778: warning: expecting prototype for ieee802_11_parse_elems(). Prototype was for rtw_ieee802_11_parse_elems() instead

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 7a706fe11750c..e88ebe8891fc6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -765,7 +765,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 }
 
 /**
- * ieee802_11_parse_elems - Parse information elements in management frames
+ * rtw_ieee802_11_parse_elems - Parse information elements in management frames
  * @start: Pointer to the start of ies
  * @len: Length of IE buffer in octets
  * @elems: Data structure for parsed elements
-- 
2.27.0

