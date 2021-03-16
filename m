Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8133D36C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhCPLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhCPLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:55:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7889C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:55:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x7so8640005pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jWE9eh2B2TDFsfKZq6plW/Qgh7fGvrwGQEU3uEE1lDE=;
        b=M1exAiX4O77an0oYe+7mH5vA8CmSpcAOX3UebdGH0hQY3Bk/F3e2Gj9VHKb8EGYKwA
         Vz6rXa50w42/WEvGpRDM+5QUvQT6MWA0CEaaqkTATyl7GPrVoSCDs9dmhy7rqzZU8i7d
         Rb4s3HKbHtaDUtbLelJxUl+oPX9EeKl3p4sTSWqzgz68ZC8duNVOPlHDSLg2cJUYHR9v
         ZqxQUj8uEGI7QUXcM9RYMAghcZzAqAjWfxEnXP6/P2jMPwEsNtb7Y1uy5PgU9VwWn1s0
         HoefiT+yZ3PuM5J0S3MFWtGgHKIgZdX8f5yIhFEFWoUfgud6yqYUSYXYnMtuo8ptIJAu
         O6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jWE9eh2B2TDFsfKZq6plW/Qgh7fGvrwGQEU3uEE1lDE=;
        b=UQb+rUPSCx6gKCKD03eFceu2K5ShIv4gP/vD2MfY5NCuRJlsww5NOoUKv00VOlP+JT
         /y6SCLCHikqC1ixbfkPRNYA5fFiAWQzmCIze3wk8Zqff2wcMe+AUrDzVOoGNnPwQJGN9
         C8LsVbN8axSEyBQWFFTn+GTyh/yBylCj37OCYJnnujBSSYo+MPIR696Nr9zNRHS4pL5y
         nwzo0xI58fsY85p4k/ExtiprfaxgLvTj01sefQAfUhzbTXfKfd1DXyUjtwtGFUtLKpZH
         LS9RZ8CcdaiXo/imHMONH7b5ffQbtg6+fJsBCFVkVF9MLe6GAg0jnNJDSVPzkyPKUICi
         5Zjw==
X-Gm-Message-State: AOAM532VqPMOtzhEq0rng0R7MsTnjIoG1e8fjajvLO7Xz8sgaH3eMho/
        2o3coAvIhPYz0Vme0BXT/Go=
X-Google-Smtp-Source: ABdhPJxVyIZEOPrvRi25YXD/IyvAy2fWxwhWnVNpLCd4x5ADgBjDh0crpLd4NJwWkC4mgvR46wv0vQ==
X-Received: by 2002:aa7:8d92:0:b029:1ee:75d1:c87 with SMTP id i18-20020aa78d920000b02901ee75d10c87mr29268650pfr.9.1615895705397;
        Tue, 16 Mar 2021 04:55:05 -0700 (PDT)
Received: from shreya-VirtualBox ([49.207.217.47])
        by smtp.gmail.com with ESMTPSA id u66sm9271455pfu.186.2021.03.16.04.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 04:55:05 -0700 (PDT)
Date:   Tue, 16 Mar 2021 17:24:58 +0530
From:   Shreya AJith <shreya.ajithchb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        d.straghkov@ispras.ru, dan.carpenter@oracle.com,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        bkkarthik@pesu.pes.edu, gregkh@linuxfoundation.org
Subject: [PATCH v3] staging:rtl8723bs:core:rtw_wlan_util:fixed indentation
 coding style issue
Message-ID: <20210316115458.GA2302@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the indentation of the else part of the conditional statement.

Signed-off-by: Shreya Ajith <shreya.ajithchb@gmail.com>
---
v1-> v2:
Changed name in signed-off-by to match name in From.
v2-> v3:
Reversed the change and made change in From instead.

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 975f2830e29e..4b5afaeac916 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1760,7 +1760,7 @@ void update_wireless_mode(struct adapter *padapter)
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
-	 else
+	else
 		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
 }
 
-- 
2.25.1

