Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29B35EE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbhDNHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347513AbhDNHWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:22:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92293C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:22:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14so4952861pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOPzYhyvJvVeiml9bPQrg6xtoJCGmo6/t9FOb5TdJag=;
        b=jMVDMm76mBSnsuvjoK65aKRcxKQ82DrfuvIEwMueNgXXtO0BwQPLK3gUj9y65eyfI2
         81AadnT3nuyjjiA0hGlfn0O5WYsd7qV6FX5dKtt6bPUx6KQtPXeBbYnKsDRLF2WjqnVD
         7W9mMTHsxtcFSjE3kmO/6Mnxx5h1nKZvtXJCn10E1/8Vit4+LCj9+V4KuwnIcBRAYY43
         68H3oJvzgzb4JEfUqbYBVE5DSFU0qPm27ybKogdWPMqKFwPzF7UhFH7R5CV447NYsL76
         SeK2GXUeiGFt4Kz2//AfbLhRUVwKtShNIctyEBL96iBM/uSR+J/oWIfXYeMMfVAJ7fEj
         mhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOPzYhyvJvVeiml9bPQrg6xtoJCGmo6/t9FOb5TdJag=;
        b=so88ZTJun0wCmwlpjuQ1fxCaOivbHBmZDdqh5wzYxufl3n2ockvzLWKAcJfkTCUqWq
         jd7zRqt1v8lzL+eVOP29533faZktvYNmKb8x0py3YxT6aJvPX+HuD+/VGWVjDd5LHBMa
         ICrF2n0Jt2s41R4RolqBV1gUqdMyHcJFacPwLmW9L4QbSPKeQP9oWCuThlHXDkQzRY5W
         AhyC9ACu00jTlJQ2wCS1hckMAKg52jeYNaWl14v64SEbdKuY8nEL/LylGzAQFrrX9dOw
         VU2p1xyE8gPdd58BGCGIaUGe+5dWr+x7XrMqNvYNkifHYw1pTYjWWEXScOMUmY+J0exc
         tGXQ==
X-Gm-Message-State: AOAM530f4Rr11vTvhLAvMspC/YVNwCNVVGA68PE5JZwy+rZkC45VFAIT
        A58Eyr5Lx+Vd000hg7zmLaE=
X-Google-Smtp-Source: ABdhPJyiVqELxuxWAEiFr6hqPPjXxgUYHZxsxK/2aUz1Kxh1evr7gH6m/jLskN3aFnYY0Ad3YovwAg==
X-Received: by 2002:a17:902:7589:b029:e8:c011:1f28 with SMTP id j9-20020a1709027589b02900e8c0111f28mr35753149pll.35.1618384941156;
        Wed, 14 Apr 2021 00:22:21 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id i22sm16235159pgj.90.2021.04.14.00.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:22:20 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:52:12 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v6 2/2] staging: rtl8192e: remove casts and parentheses
Message-ID: <f23b290c27fdfaf36ff723fc49f486cfdb985052.1618383684.git.mitaliborkar810@gmail.com>
References: <cover.1618383684.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618383684.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary (void *) cast and parentheses to meet linux kernel
coding style.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v5:- No changes.
Changes from v4:- Removed unnecessary casts and parentheses.
Changes from v3:- No changes.
Changes from v2:- Rectified spelling mistake in subject description.
Changes has been made in v3.
Changes from v1:- No changes.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 431202927036..ec6b46166e84 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -646,14 +646,10 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-	memset((void *)(&pHTInfo->SelfHTCap), 0,
-	       sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&pHTInfo->SelfHTInfo), 0,
-	       sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&pHTInfo->PeerHTCapBuf), 0,
-	       sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0,
-	       sizeof(pHTInfo->PeerHTInfoBuf));
+	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));
+	memset(&pHTInfo->SelfHTInfo, 0, sizeof(pHTInfo->SelfHTInfo));
+	memset(&pHTInfo->PeerHTCapBuf, 0, sizeof(pHTInfo->PeerHTCapBuf));
+	memset(&pHTInfo->PeerHTInfoBuf, 0, sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
 
-- 
2.30.2

