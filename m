Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD935FA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbhDNSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352364AbhDNSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8B2C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r9so32818462ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8jxM6S/XYO0Pc92+s2uo/rwCS9+bnrmj4sRd9nZNb0=;
        b=p3oup2wgTENGD6cBcDzZikivQec6VBMJdGZ9BX+jMhOlbJdb0mxsNzQ8xy5au1UGcL
         xxYYkaZ4EHzvhUBFzM87qJ2CWbNhW0I2z/P8SDANTo0TAtSdbV29JH7mQVQeBjV5UHip
         EROQwmkS1cbUdV2w8bCFzKtEBDo2dLaEj9KG9UzzXmaK4sCs6tvH4LdDWzNfp0X0fVTA
         Qbfv9PPiQiVG1GW+bJQT9ZL49z6IREPi1ggofsabQOCQqrF1+VWjCw8Hz5mBRkRNpLHO
         GwbFIa6bWeg3G+NL2bXtNQ/PgUl927xTbWYgk2kSOxxHnSbaKUdhkex+cPcHl9SNe9G9
         lYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8jxM6S/XYO0Pc92+s2uo/rwCS9+bnrmj4sRd9nZNb0=;
        b=Vv1kM7V3fJukK5h9mxMpo8R01uppP0Zj889FY02cmlDEc15He51aGu7NqYYHsqJ/pk
         DHDaavIFWK7OFw0X0ZLnMCZ6OsB9azT3gmLgJL7UJ61HF6nfDLzt4GwpsntR4NaEm0dM
         BQrvY/1Ss65faWbBHkPdgqxJ2iPRC5skkPBjLo+wpmSLoKipUkMQ4dVx98v4CiKbfgGe
         nXk2N4zzMZnmUTHUrbrQwefO1lZf9fpAAEvlCyvqM4qOo3IFUK+OTRMS2eicbeTV8tTQ
         Vbe4c8SVGnJE6jph4wV78b7rBKnEHLXWExtKuXqfxtZFEonrHluNgS4t+BpHYskkhwHy
         EZ2w==
X-Gm-Message-State: AOAM532Z0pVrS48y02tCvsc20yajQzxRlJx1jXlkTkhcu25ZbiRtXd9l
        J7v2HOEmCXibRymAVYvpDJqSmA==
X-Google-Smtp-Source: ABdhPJx7lfv2ceXJQvPUlXl3aRywYg0+nv6iP3zbHvnZRua9guDLaAEkLyT24E+5Fi+/e5cASAUeYg==
X-Received: by 2002:a17:906:4352:: with SMTP id z18mr125882ejm.387.1618423925895;
        Wed, 14 Apr 2021 11:12:05 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 30/57] staging: rtl8723bs: core: rtw_ieee80211: Remove seemingly pointless copy
Date:   Wed, 14 Apr 2021 19:11:02 +0100
Message-Id: <20210414181129.1628598-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c: In function ‘rtw_ies_remove_ie’:
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c:259:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index ae057eefeeb36..d8513acf4911c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -239,12 +239,10 @@ int rtw_ies_remove_ie(u8 *ies, uint *ies_len, uint offset, u8 eid, u8 *oui, u8 o
 	while (1) {
 		target_ie = rtw_get_ie_ex(start, search_len, eid, oui, oui_len, NULL, &target_ielen);
 		if (target_ie && target_ielen) {
-			u8 buf[MAX_IE_SZ] = {0};
 			u8 *remain_ies = target_ie + target_ielen;
 			uint remain_len = search_len - (remain_ies - start);
 
-			memcpy(buf, remain_ies, remain_len);
-			memcpy(target_ie, buf, remain_len);
+			memcpy(target_ie, remain_ies, remain_len);
 			*ies_len = *ies_len - target_ielen;
 			ret = _SUCCESS;
 
-- 
2.27.0

