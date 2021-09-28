Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A041B567
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbhI1Rvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbhI1Rvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:51:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C220C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:49:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d21so59331668wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=uFr7uJ6KTmQJHmnmWVFZMG4UoPxJgzcyn7oJlR9xeQQ=;
        b=SJTcdRCleu7Daht4II9AJO3dVz+rTcFkDf49xOI+wT/VIJKZzNHKsgblSG3pNmnfaJ
         bPu7KPipyta7CdcFAdsQ+rKuyeIVXZFrbK8+I8zRdVWvcwg+yfVjKXyRztT/sMydKY98
         lTtODbtii5IQDqyoBpFlkJqYTKOtBrqx6WQaR1ldBHCgZfdIJNBGpLbBOI1d6iKGYTCY
         jmuo5h8e2sSSDp6QLAei1HfsxRfVWDj9t53PcQF6Q0dQ+8vSwwZ4gSCHQ3Go9Ni2fpCx
         Qm/psewlxWwGvDZilWpRRnaWTpXenSbMKWb+Sf6HePDu0S8OHFdrmDqJWB0CNphQz8A3
         7C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=uFr7uJ6KTmQJHmnmWVFZMG4UoPxJgzcyn7oJlR9xeQQ=;
        b=gmdk9cYg4MZ8TxedY7HofIwqUAeUZJIsViw3xq956n8AMWYLXfhB6Ug03IQz/QKj3U
         /FBSVjbnl1I7qbpkfM1OhmaH11LgFNhgO8wI/yjJiMe/0DGc92VpMIRJhCt3JBME0xTF
         ciVsVL6Pxw6a1Dc/BQDNowIJ1pXscUwgi/yRO1Civ6B6A7IgDDc05GfUengb7RkZI2ph
         rVTuyBVkvYPRqntwuQ0mKsaxFhT8hGBDrAZ5SQOH1eBuApdToZpjWyjt47N4QC2Krrrg
         p6wzE1WTCberhxVm2rmaD72GX7iAsRsj57hnLSI8byUg4mdY6ZwSG4kx+wRxt+xqQLZZ
         agHQ==
X-Gm-Message-State: AOAM531ZY/02wBlumdTgblpGgE4tLTrTXzOf6a0lDP59b8t+9XeAUMVw
        zK2/NLsenw8DP6MBgm2klB3qlyXmcvzW7ZVU
X-Google-Smtp-Source: ABdhPJwEBRGCaKUntObz1k4pORmlCt+poei87mFhOC0V0PsMONm542siibdV5ivqyo8fjpAGy7lvmw==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr1692594wrh.105.1632851389668;
        Tue, 28 Sep 2021 10:49:49 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c7:8d80:3ef4:ea92:a665:e662? ([2a02:8084:20c7:8d80:3ef4:ea92:a665:e662])
        by smtp.gmail.com with ESMTPSA id w18sm5038791wrt.79.2021.09.28.10.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 10:49:49 -0700 (PDT)
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   hallblazzar <hallblazzar@gmail.com>
Subject: Subject: [PATCH] staging: r8188eu: Fix misspelling in comment
Message-ID: <5174112d-d0a5-e908-aee8-7d494914e89b@gmail.com>
Date:   Tue, 28 Sep 2021 18:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
looks misspelled by accident. Help fix it.

The original error is as below shows:

CHECK: 'followign' may be misspelled - perhaps 'following'?
+Set to 0 (HT pure) under the followign conditions

Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 94e02aad96b7..205168f960f6 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -744,7 +744,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 /*
 op_mode
-Set to 0 (HT pure) under the followign conditions
+Set to 0 (HT pure) under the following conditions
     - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
     - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
 Set to 1 (HT non-member protection) if there may be non-HT STAs
-- 
2.25.1


