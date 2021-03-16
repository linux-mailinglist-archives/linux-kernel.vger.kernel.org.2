Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B055033D3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhCPMb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhCPMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:31:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:31:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n10so22498883pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3o2kkYmr7ZVyqzaKWLAdUBSqmSmqDvuOlKM2FxLC6ts=;
        b=kyr1irYF9drnnk8v7Fr2W7vt5JpQ3DrpzwHkD8Z84SjjMvNhc0CeswecAWrXgc4/AY
         0vkMMupDtJ06w+pHJ46L9/iR8uwon2zebhS9WyjTDEDQ+hm39N8EZqYwux0XS8MvxGLW
         WyQp+6l35dqexr6XMc01NB/COSNcF6Ck8aLLOagE4JH5GeroqGxUQg44f3N3HgBxJqWw
         2lbVmjsA09spKjSnNWkPDOY/P68Mhcp1HwtVNIOuekFbyWhu1vFko4qp34em9Fb5xkwd
         uDvGXZkiSXMHFDe4wkek9eL1loJcYcVOAmG+0AgTb/Z3THL6OWt8venagDfQYRHEkXOj
         IDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3o2kkYmr7ZVyqzaKWLAdUBSqmSmqDvuOlKM2FxLC6ts=;
        b=cnNDd6aofNK5EPpWlrmIMBkv66RKi/q8naEqqCaLDPE1hec5OB6uN/es6wyAPjOxeH
         zUb/n+NA5njfld0niE8B8IHL/WQ+U6bxbAOpktclL2vpa3w+ttZoo1aFx/OzXTxfPYxw
         ycGBMOzH8q+Q+sNHTQCDj2M6XI20cC8c/tkZHk6xvLR4FBt58nD2XGaR/eK+6/CIrLGZ
         rKfrvSTv3wpcJxzZbppRGOLG1n2EbtxUBJGjyaW8bxSiKJW8mcnDnISuGsJNY7JRwGZl
         Tn6OcIhqCz55o9xc/09CQnXTZooACJhhtCFXWqCZUKyVGktM1+iJnPp+O1KjMGC3u3Ou
         DxfQ==
X-Gm-Message-State: AOAM533AmIICNrv/JZUH3IgdXvRlBwRTSFvUjz8faqxXyYOkoZylyF32
        kOYdkXvOmm7nzk2+xyJw5Io=
X-Google-Smtp-Source: ABdhPJzDi8XY4F26y3Bp9A7bbNktXqH16BztPpaJp+cdOSh4qeM6vMHVPcUeqWvDsBEgEcrnQWjeHQ==
X-Received: by 2002:a62:b515:0:b029:1d6:aba1:e22 with SMTP id y21-20020a62b5150000b02901d6aba10e22mr14809918pfe.47.1615897884983;
        Tue, 16 Mar 2021 05:31:24 -0700 (PDT)
Received: from shreya-VirtualBox ([49.207.217.47])
        by smtp.gmail.com with ESMTPSA id p190sm16122596pga.78.2021.03.16.05.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:31:24 -0700 (PDT)
Date:   Tue, 16 Mar 2021 18:01:18 +0530
From:   Shreya Ajith <shreya.ajithchb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, d.straghkov@ispras.ru,
        dan.carpenter@oracle.com, straube.linux@gmail.com,
        ross.schm.dev@gmail.com, gregkh@linuxfoundation.org,
        bkkarthik@pesu.pes.edu
Subject: [PATCH v4] staging:rtl8723bs:core:rtw_wlan_util:fixed indentation
 coding style issue
Message-ID: <20210316123118.GA2312@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the indentation of the else part of the conditional statement.

Signed-off-by: Shreya Ajith <shreya.ajithchb@gmail.com>
---
v1 -> v2:
Changed name in signed-off-by to match name in From.
v2 -> v3:
Reverted the change and changed name in From instead.
v3 -> v4:
Corrected capitalization error in From.

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

