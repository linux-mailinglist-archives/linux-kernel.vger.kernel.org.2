Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6508935D5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbhDMD00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbhDMD0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:26:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:26:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso8279645pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cp9Q3q4NFkapY3F7PFjTBCPu8I2/yhix4VA8BHzZzls=;
        b=jyL39EPKMRbMkF0H8rbw6NZX1+zZgJP8rqnJ9V6W7SeaX1Fw+PMHo6LHRRnE71F2xP
         bZ/6MQNeBhJTo1CzCfmYpLq5c2VubtyUZr0eiQtmNy2RGP3QU+wu/ca5sMZFgXLQuK95
         i6gRCxHKrHH2qCctRZJRKtDFah5eRxFykDujHolvqAodLegAzHmvJFRej3zVNy9rgwtU
         kz/gLWmS3UJ/T0Hrp9OQBYtoKT6nM4qy6B1PQ6oQnMoAavfe2PhjnkL7nbSGS6yNNCPI
         w1niRXACKkVIzC2zt3lRl7jkhwVgTPPIKSC7ftfHuBNpC/mMdNLn2ZE3tbu6Uryrn5UO
         3zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cp9Q3q4NFkapY3F7PFjTBCPu8I2/yhix4VA8BHzZzls=;
        b=cGbKBqlz8n4sgSWmMGb0JM+oT0kFLlqQj4Oqw1abRH8mBNITogm8oFENSf6vM0ftYt
         XFJV6xcIlFZA2T/1MjqCksFBS35d1HPWB8Ni69TXWAS8vKC3XV//NyTZzn5Bplch1lWZ
         rm4W4+U+PGYCWNnf/trh9viSeK+O8ICnji0WLNxMdnn1c0X9Me/QOs7Ruca+PvZ7RnKc
         rbP+yi5ECt+LnLRtXCXaQ3BO6SITInwKvqMdXr4xfP2V4Ek5OHTnZ+bPsKhevDKquUq4
         XFqSg8hFuMIlEpJhpuA6lILPPIqafADEgw9xLVZhE40819YtkszHRpW7Qg84t6rp+r3d
         tZtQ==
X-Gm-Message-State: AOAM533r5zrk6TaLq+e/YGdEzaYugNgkM5YXAj76V8TgopkwVAnSAHm5
        s+DiBVu5k7Ij6EDlvFSwZFbEqRUwIwVB2w==
X-Google-Smtp-Source: ABdhPJwPBj4usCtQBUi8pHfrA3aalNYSfLkG0mr4ylFDBqGGii21/i1YneBshIqaxZsHVc6efl6mpQ==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr2490713pjp.227.1618284365145;
        Mon, 12 Apr 2021 20:26:05 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id h19sm11284507pfc.172.2021.04.12.20.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:26:04 -0700 (PDT)
Date:   Tue, 13 Apr 2021 08:55:59 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v5 3/3] staging: rtl8192e: remove casts and parentheses
Message-ID: <4a26a0e155e3ea1ed48aad5a1df4b543c35346f5.1618283232.git.mitaliborkar810@gmail.com>
References: <cover.1618283232.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618283232.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary (void *) cast and parentheses to meet linux kernel
coding style.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
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

