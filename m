Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210735A9F5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhDJBf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhDJBf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:35:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBAC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:35:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so5809492pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AmH+UMyc1cUAc4hzdn/oSiz/QnBV7R1v32Iys4DOp0s=;
        b=M8B463kyH+a1W5utxKfyOtivuPkCqs7onqXldRTgrHV18AjrJ2/Uyfu6dgIxjuyvul
         SnyfibvyXDqFSEcHjxvHdirLL7j91yqJ1yb1QIRaXmkzODWdpgbuV+4A6pxuABqIQ4KV
         8zBEbNGx89je4ikUkD6ot1pmV6y4SVL6LZxvw18cZEwn6/iKWbKtS57Aq3nEmVXqMVAy
         l8kRS8ytZG63jSXQJcWdAT5EeseNwwIEvtx8YKq/y7A/BhbKiVNkr4SMTe4KqY+GAJVW
         3Eu+IHozQueMbFfIt+koiJZBc8C8j333DaiTKiuIpXkkd8PmECvH3+n72ZDIor3K6oG1
         FoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AmH+UMyc1cUAc4hzdn/oSiz/QnBV7R1v32Iys4DOp0s=;
        b=bTkRb+VmFE0s+8YuL0slpkBrJOcl3W73JlCDELV5XmJgLksq8434IqoAvOQ+0DLT2P
         eRBwRwcMXPAgoII1Ab4q+3Fz9+mkEl7WG2z9kfk+GASKsWohf8nIhFhP8zdGPdGKSbxU
         9yCbMYohkXdx7z/tAn6CC90HHIaTqgv/BeEb3l1Bn3d5HFtSet/qfeViDM6IAAU4fTaz
         6x+W6r5lMpsz3YgNTWK7ywqBdW1fZMncq/VG4gkLd2HgRYXKoPW4daGyG4PfWHismGT/
         FYRdo0yNPh22g+XhBwCGdar1GD0h1pS8tRxEITatRsjEHTD9udbiq8gaTrjYbpl5fG8C
         2reA==
X-Gm-Message-State: AOAM530jGyD7x9otxY7dxWtf7L7E1+8Nno1PnqrSkWTiI99R1+1f0TLN
        apyAZo7AsV059nv5eIBssyU=
X-Google-Smtp-Source: ABdhPJwTde34qNXCq6fW6I4cIgzIH+xEe09llhnZzIrZkL+1Aj9CKxWjrRLmhzBpG35A1QHuc3ZFOw==
X-Received: by 2002:a17:90a:20c:: with SMTP id c12mr16288412pjc.224.1618018513395;
        Fri, 09 Apr 2021 18:35:13 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id j188sm3352388pfd.64.2021.04.09.18.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:35:13 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:05:07 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 3/6] staging: rtl8192e: remove unncessary blank line after
 brace
Message-ID: <YHEAy+SVBJQk0HDB@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an exra blank line after close brace '{' as it was not
necessary.
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e188e9e6b11e..0ded86da1562 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -492,7 +492,6 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
-
 	u8 i;
 
 	for (i = 0; i <= 15; i++)
@@ -686,7 +685,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 void HTInitializeBssDesc(struct bss_ht *pBssHT)
 {
-
 	pBssHT->bd_support_ht = false;
 	memset(pBssHT->bd_ht_cap_buf, 0, sizeof(pBssHT->bd_ht_cap_buf));
 	pBssHT->bd_ht_cap_len = 0;
-- 
2.30.2

