Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60D35B188
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 06:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhDKEed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 00:34:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55E3C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:34:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r13so1099733pjf.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tpbh3OLJP7GzXz834H5t3FrywBGf6oRqD5Ae5cfpG3s=;
        b=I0QQ/fbJ7F8M6Mkn+NLUKLPFkaxNvIhFjfvZWWoSNptyA3PORW1ZisjL6b51O9HYJQ
         1/tMdZD3x5rNaf4t5uGDL+Dk4b+tnA9fvdTjJPepk9zmY/yWn7LSFjWeEyg2pz021xoB
         EkRK2Xt0nfJd5JZmbiuiRf0I2VGG6w+t8Lga4aqE6wD0sGFk0NkIfSK2bDceCwKUmlDF
         65scfnUNTk+iYK6ZFIejgtGlwPt3gw4n+kplIXjpZMjSK8IF9BSJMSz4SnDvCnaZ5/zK
         jWoInYNKY7pTqQvibGoVIxoGm+fUZKSUpcD+BGB7JxSZ0sR07duy0Bi7pIxKXBafnwB4
         kGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpbh3OLJP7GzXz834H5t3FrywBGf6oRqD5Ae5cfpG3s=;
        b=H7YvUsZINyj8b4ixapSbAIJpW7JX1g08ExE3Sm2OdTCX2Syx4iezbW+wMoPc6/c+5M
         3MUVQ8c6687N35L+udHJOWkMbTu6yILxKu75AmwsJ0KZCfFUJSzWHQHKGm6Uh1y1m8t2
         G5NM6sJBhXATcjBRVDaXt+epUGWHInNfqqmU+SJFqmVEcNCl+98P2mepfDeMuzNEzOCY
         AyBTP0tRtbunedI860xjngUu82EbkhJ0Tp9vLwzu9PL843h9VO/B9NHZN5vW77lhCafo
         MYV0SZtXlh2yrTd0pAPC99ef+mpftX67KSC5wiHiG4qRTPJwsXKeXs89QPOmS/6aWSj4
         MZAg==
X-Gm-Message-State: AOAM532MS2y18DCvW8HVDmiRxcV94sOOUcJQRnsP/Y6D/2TKbsLpJVVa
        XjFH8U0pSgooXWoUsxTldso=
X-Google-Smtp-Source: ABdhPJxiElbSxzkNdQ1VnYLd1eXlGP6Zeo2viBDcigA4Cn6pmuTMv/kAWU69Xd1seKKCOoYPDW1+zg==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr21766301pji.103.1618115656222;
        Sat, 10 Apr 2021 21:34:16 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id a65sm6297511pfb.116.2021.04.10.21.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 21:34:15 -0700 (PDT)
Date:   Sun, 11 Apr 2021 10:04:07 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 1/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <e6302e0a8dd47c903dc82fd28e73f5ccf786a0b6.1618110617.git.mitaliborkar810@gmail.com>
References: <cover.1618110617.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618110617.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses around '!xyz' as '!' has higher
precedance than '||'

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v1:- removed unnecessary parentheses around boolean
expression

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b1fa8e9a4f28..431202927036 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -276,7 +276,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	struct rt_hi_throughput *pHT = ieee->pHTInfo;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if ((!posHTCap) || (!pHT)) {
+	if (!posHTCap || !pHT) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and pHTInfo are null\n", __func__);
 		return;
-- 
2.30.2

