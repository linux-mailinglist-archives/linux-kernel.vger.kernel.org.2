Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9435EDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhDNG5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbhDNG4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:56:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D3C06138D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:55:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e2so5254477plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PcanKz2JI3sv6qcdkfJn/3M37tEs8B/qxfDD8BezmTY=;
        b=AUC7XDuw1TQ1ZTbpzBOPu7fqFtP5txh9v46VtMvQTctw1GAWRarUdtmQ/5eOBOrHB1
         SBlSTJWkBxyTyT4ZtAM0vKA/ittgWiSZhGSipQo27TnJJ/z5GXvjMqdlkthGfOiW4rpQ
         35oPn775XC9E2IQwvgD29RbCy63ATQUaJ0WsJxfUqKBvffiLXYsIe1wq1gIYgN2uiXuv
         eUYKUVD3ra0NU9iO1fGYieOm1LEFt0O8DR8K8zgrRlIyRdkAU7DWxX9fYZKEzn/zoTpp
         8l00yccjLSGj7IxapSScQNOKPicP3x3wur9Sies+y/vctusQxr9wjHJQ0awMWaxLZBBB
         4K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcanKz2JI3sv6qcdkfJn/3M37tEs8B/qxfDD8BezmTY=;
        b=ngjAOdUcdFUTyZx7ZmlD0C2G/2ics0QbONTtboynZXMPR/illqDe2kxwORKUIl0TEC
         UaRIDdDW++PxHlKxmUxHxfVnSinlX87VmgcYt3EUrnaHjqNO8Y4ANO02J5i+e9mSmUzz
         9lcGvMGBTBGa7PmCUYkTi4fvHeyJNDqdl5xYQSKlugNkDtbI3kFe3+4F1QpZb9uUzBP5
         gd3w9PCIEW0rQRZ3Zrn8Ar8/XDZSsnqhdIRYNh70rgjBgLhsPq1CW7peeRVsbpoAoXO7
         7wAV4mjdEP5K+lpAXqjVIgSS8qH8VutHQxsFsj51qAt85ZGda3I5lHlS4d1cqMtWiorO
         yLyQ==
X-Gm-Message-State: AOAM530MPxe11bNngfHPTfxrwomD9cXvllXFavOtdFgpt4NtYuD3O1w4
        Obg+FehsARYujvtu7Jc6hJ4=
X-Google-Smtp-Source: ABdhPJxCWD/wDaDIetW79z2KKktAfpfDPU2N+11k34hNMq2GvHJoLMR5wU8Sl7SZ6ZLta0zfKiXCbQ==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr2037422pjr.179.1618383350348;
        Tue, 13 Apr 2021 23:55:50 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id c129sm14470541pfb.141.2021.04.13.23.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:55:50 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:25:41 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 3/5] staging: rtl8192e: remove unnecessary blank line
 after close brace
Message-ID: <40f72a84750f402c342b4685e0a2f15d27875c9a.1618380932.git.mitaliborkar810@gmail.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618380932.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an extra blank line after close brace '{' as it was not
necessary.
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v1:- No changes.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 651441a71646..b6805908bbbd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -492,7 +492,6 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
-
 	u8 i;
 
 	for (i = 0; i <= 15; i++)
@@ -685,7 +684,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 void HTInitializeBssDesc(struct bss_ht *pBssHT)
 {
-
 	pBssHT->bd_support_ht = false;
 	memset(pBssHT->bd_ht_cap_buf, 0, sizeof(pBssHT->bd_ht_cap_buf));
 	pBssHT->bd_ht_cap_len = 0;
-- 
2.30.2

