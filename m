Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF4F364733
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbhDSPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbhDSPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:34:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D688C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:33:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so2262480plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6C2ypx1ltTtAbaNb1djC1piRseYP7dsd7kJM0vd662s=;
        b=Qoi9lv3o1Ko56QjAVFcNOHsmAPb7DFUAABLCuRfkITyjvV0bqYJxkIUnH3ar3AXZCv
         7nLFlRSy45HRQ27c42CnVU0IivkzivxpGBMZgrF/yeujfCrPrG3vPTYkqbGpQKA9uEpC
         Mj171RG6/IL+F7+us2tZWtNfATiDzlHrDtU5VuHafDgOrKbW17zDvQSwrdUsCcwGvHEP
         argcqPGM2cSQq99+ROrED2aW7aoD4/fZjy53eQjtzmPWU+MMl+cWTWCPsbJsWi+q3HKH
         ksqHkqNeCPB4Trzq1EU0Bufg7QlLHnpkUrQcMHZgGVIFecu3uyv75P9q5Q1NB3rRK55k
         mOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6C2ypx1ltTtAbaNb1djC1piRseYP7dsd7kJM0vd662s=;
        b=BHUxBD7f8oibdJPVinDXZC2jI0+sKwHyMgVTy7qRSzKtmZ6kZ5RwcIQhhkSGcVWLid
         DJIK5z+451/8qVgMSTlujDW7QQW/HDB3RFPVDvM9IT3MZpRpII/6SPKTfmh7glW166NK
         xKijAP8bIVmU0q6cred9hC0FUMmmWRAAAHJPmwJLSTktLllpy5s2GFhTbz5g/kPBdsIh
         H6vl6ZZY5peb6W96oKJiOtI4w1Qvuwko6i4qdLBkNGoV5oP9Vaz1e4iDFptPIdHjDvDs
         IjvQGKUxmSkm2tWGBLM9pQ4IoTTQTT55GL2YX2Bgex2FEtQzx1rrC6v9UQAd4wn3sEbz
         Oa9w==
X-Gm-Message-State: AOAM532HsxDrk4cGif4k7dX2UFQ16CyCBsPtw4hA6F2pHKva+FvXu6uX
        ZsLWLH9qcEw6npvhPUXHqLE=
X-Google-Smtp-Source: ABdhPJxtAI5140A9y+4SLkqFlgO0dJnegwBF+HVfZdViH9OQHRi/CUpN9bL0+FlGeTp+jtVIfaU/Rg==
X-Received: by 2002:a17:90a:7897:: with SMTP id x23mr8624574pjk.133.1618846433453;
        Mon, 19 Apr 2021 08:33:53 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id d3sm15694597pjw.35.2021.04.19.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:33:52 -0700 (PDT)
Date:   Mon, 19 Apr 2021 21:03:48 +0530
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     eashishkalra@gmail.com
Subject: [PATCH] staging: wfx: silence symbol 'wfx_get_ps_timeout' was not
 declared warning
Message-ID: <20210419153348.GA22782@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon running sparse, "warning: symbol 'wfx_get_ps_timeout' was not declared.
Should it be static?" and "warning: symbol 'wfx_update_pm' was not declared.
Should it be static?" is brought to notice for this file.  static keyword
should be added to prevent this warning. let's add it to make it cleaner and
silence the Sparse warning.

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---
 drivers/staging/wfx/sta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 12e8a5b638f1..d855d87c2102 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -200,7 +200,7 @@ void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 	mutex_unlock(&wdev->conf_mutex);
 }
 
-int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
+static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 {
 	struct ieee80211_channel *chan0 = NULL, *chan1 = NULL;
 	struct ieee80211_conf *conf = &wvif->wdev->hw->conf;
@@ -230,7 +230,7 @@ int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 		return -1;
 }
 
-int wfx_update_pm(struct wfx_vif *wvif)
+static int wfx_update_pm(struct wfx_vif *wvif)
 {
 	int ps_timeout;
 	bool ps;
-- 
2.25.1

