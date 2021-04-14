Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2646C35FA91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352720AbhDNSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352447AbhDNSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C054C061346
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so32778822ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUdWG5FHd5Fjvw6Pjugvqx1bowREGQJryGXXbFCODjY=;
        b=bef+djPOXAmMm+4YcLddwLCZztLyc5xpFhwEpXQdZhXfbgSd0FOTQQgWDYaEhx3qPH
         y/FrG5UUQjevdrMM7KLkaL2NfobH7e5trnpK5hamEQMCMo5wxYIUMOIdMNh8JjwD91Vw
         jcZ8NcHMHA8+ayrM/+mVLkoI3VEyrB4voyxH1OkKFB/kSnyr03+l1BuwBMUeGuWQtRzC
         Lih1N9lBHMUt0oyx4q1fZMkmy80nhqkwShe74VgIeyw6BEjI1+UNU4m0BjLUpc4ox5dX
         xomWtBSkduDzUhqBxS6nZ7K0GF4Vz2bDG61Oz9JmB5bnFOIya/OQU4+1R4J9Y58s0kgk
         w4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUdWG5FHd5Fjvw6Pjugvqx1bowREGQJryGXXbFCODjY=;
        b=CkmzmkpwE6IlMN8PowD50IRJZduQ1Q0UO+OzN88Nj5bVMaBy3Yp2IC6RIyMjoq4mqf
         gx6KLoKNEsJ7fEpjOTMV8LlXwhGmIPxzsS8BY4sxiXtbgX4igaBsiWsUSD9m3m6+3e+z
         MbXczyX9dPVf8xbXZSHM7C1NUWymomX9CuEgYTOdQzmAqbiSc+nJ4VP6P9UDGQ6QewQt
         fsIq5LQjzVr70ggQtGgwqBBIKmiAw5FvEHLXOmtd6utn5d7Byt4Ihr/LHGvwLLwetWm9
         aUVLT1xYyrQirNyk+UcVJKTCThakO+cMfRo+DKnF1bTzNP4lx6pWiZhIf4RfBzq0IeZu
         ygqg==
X-Gm-Message-State: AOAM5305QSgvTAWARVLJ1+hhjkTXskcVI/z50e7ANkYaooG+y57kqW5d
        RndUmlc0yuwxH4kNtsr4eD+rQw==
X-Google-Smtp-Source: ABdhPJyrMRu92D4/Iqh4o8OUE9hog0NW3b4dYOXYcT57SYq9MZdMAjJN/N65etNA89kbasxgPwnDLg==
X-Received: by 2002:a17:906:7206:: with SMTP id m6mr135829ejk.281.1618423935084;
        Wed, 14 Apr 2021 11:12:15 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 39/57] staging: rtl8723bs: core: rtw_ieee80211: Fix incorrectly named function
Date:   Wed, 14 Apr 2021 19:11:11 +0100
Message-Id: <20210414181129.1628598-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c:889: warning: expecting prototype for ieee802_11_parse_elems(). Prototype was for rtw_ieee802_11_parse_elems() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index d8513acf4911c..e341789954b99 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -875,7 +875,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 }
 
 /**
- * ieee802_11_parse_elems - Parse information elements in management frames
+ * rtw_ieee802_11_parse_elems - Parse information elements in management frames
  * @start: Pointer to the start of IEs
  * @len: Length of IE buffer in octets
  * @elems: Data structure for parsed elements
-- 
2.27.0

