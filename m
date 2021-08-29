Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F913FA9F2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhH2HfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhH2HfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 03:35:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE061C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 00:34:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so11713841pjr.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rNBZsqRJ7sa4jw3snokI5dgLfCm8tugTaRJ5CIejBq0=;
        b=Dm2H49KMf8j0JXlHRKQ9ytI3sqTvTgYyeX6jrra2h7aR4/RNNLu2h1yRD7Yosp5bJV
         upqmr11UgxRQpD8xUbltTH4YojLPRbkh7RPUN/DZwNy7w/sqnA9prPHhtdBvHyN0BN8T
         lQZT+Qe1z4gMIydI1HLUf/EPDiwVtfQlgQ1C7+jNGnzaWngYXTTBFnJB2B3hcCUUNBBe
         eIBdYhnfoG/dNfBLKTq6aWPoHFNywFX4FaE8eFPWRs+9ZOuLMaE2mF/XpgkwfG3lUWcY
         ZHRLgrgH6DqLXD1OlM3hP3uYbTY40syiQMhW0AllGMswzl/toDZXkwb3wp2brJzNgcQS
         KKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rNBZsqRJ7sa4jw3snokI5dgLfCm8tugTaRJ5CIejBq0=;
        b=Z2llhhX5KYexzcAABLoyXAvHUI788ClF4j3EUa5jfeaUh3VnF8OEZycPYqF8/rKlhR
         TQ/jFG9AYQ66wxkt1dmcG9hTE7s57OMce4BnahiMKur4rhKzA8tmNiSyCsHNif1YcPO0
         T5JzXShYIpvffyMQFOmYmp7OZdaTVAsdUfYzVCNgV4WHMwT+p+mjAz5i12z4JgUGl1rT
         Mb1euPl4i49qjGSmdve9AUB6FFEfkugLJj1glBn/ZLBo1WkeZG3iBemlR+LtstvngbZr
         4mBJK0fk6aprQIvSZ/l2kkJeoH8IsSK/7Je0i8DGbPcV9YbCmu+JoAxJSMbhBy7O/ulR
         Em2g==
X-Gm-Message-State: AOAM531N6XyPwgso/wJ03v9FlTvDck8wZFhB26PXfvHvJN+wrNtEnk+O
        ORV47MzluVl1U+yx6TgCuIk=
X-Google-Smtp-Source: ABdhPJwSk5MbWVucehftZPaXxbAzo+mGxol6dbNojKUdm7c2HxjSsHv9txv2vn1URtiAyN7RcstLNg==
X-Received: by 2002:a17:90a:2e88:: with SMTP id r8mr32311223pjd.169.1630222468075;
        Sun, 29 Aug 2021 00:34:28 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id a23sm6262239pfo.120.2021.08.29.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 00:34:27 -0700 (PDT)
Date:   Sun, 29 Aug 2021 13:04:22 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        ross.schm.dev@gmail.com, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v3] staging: r8188eu: core: remove null check before vfree
Message-ID: <YSs4fvzUw1PK4C9+@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NULL check. NULL check before freeing function is not needed.
Correct the indentation.

ChangeLog V3:
-Added change log.

ChangeLog V2:
-Correct the indentation.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index f6dffed53a60..c3600cb1790a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -155,9 +155,8 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 		/*===============================*/

-		if (pstapriv->pallocated_stainfo_buf)
-			vfree(pstapriv->pallocated_stainfo_buf);
-		}
+		vfree(pstapriv->pallocated_stainfo_buf);
+	}

 	return _SUCCESS;
 }
--
2.32.0

