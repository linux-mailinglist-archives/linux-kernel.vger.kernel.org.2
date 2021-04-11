Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0785D35B2EC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhDKJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:55:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB3BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:55:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so7172312pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pl6OK6kvb6mtR1DIS3gsdq/VEoxwoRWU6JF/PodSOew=;
        b=d0N3YN4tNx9oMkqNnL2mTPcK50et2G7T6zeuGSrMpDsxq94gMRHbbie7h3ZWOdyKVD
         Or6cCJB67BsxYon+FwH7SqXHf7Y3Z38s5LL7u64sbYVez68Znu3MR8DqNJsudksvi9/o
         4BHKBLzdvgDPylQBVSLI/ox0aCvHarzT7ARinbjVR6S1/eORWlIq8GQSXiCc5qYZwz/2
         S/MX9W6ocBbGCqPFXIqaiWwAji9TQYOabv1DhQCbDNCfLXx/8nCQVIqU1KvUOU2dG71U
         JX/Grp0wmJuM9KOal5YRjKV49WeO/+a2xhuFH2WQfUkNvCmV0xjNjqp9bp+NlLdhbo/G
         GB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pl6OK6kvb6mtR1DIS3gsdq/VEoxwoRWU6JF/PodSOew=;
        b=psmyDbj6yjPb4PqmvYMFQCQHLZxNhwUzWSzDU/s1uW9SIsc1dXaykuyjm+sUmlpXZY
         J5bUDm9fX0UjL4sHtNbny9W4LUB5afR5r87RvPTTaA18afrGqC0fv4MPKjr08BGD6L7f
         OZpZSGg5o6Lz3wN63b8K/aOXha8G+fbatTdaErhYIliuAmLpun99QwkTo7gsngMFgRhV
         DO4luIoXZKFeQsKnYEU38T3wM5kYuw9NnoZdn3l0/oA15vCkoL3XzgYetOAmmxK6yg9o
         TxL1/tXATT69NPtFO/4sYWxxmuhtMvpfCMs5DawIKTk2HYBMqysg3Iv9LyBIKvesjyy+
         Kerg==
X-Gm-Message-State: AOAM5300+VVJWjOPkQFpPyX5w59NtZ3NFjAcpnB9OjRxZwSHNwTpno1c
        tHpvyvhAMW3sxcm8s/0oSrY=
X-Google-Smtp-Source: ABdhPJxnDhI+RuNyD/XseMkfIfLj+g00jRiD8JHa5cn7IW1wlEyJn60iUtjCMCU2DVe/N6X8dkUcrg==
X-Received: by 2002:a17:90a:c28a:: with SMTP id f10mr24210920pjt.15.1618134930010;
        Sun, 11 Apr 2021 02:55:30 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id f187sm6851467pfa.104.2021.04.11.02.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 02:55:29 -0700 (PDT)
Date:   Sun, 11 Apr 2021 15:25:21 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v3 1/3] staging: rtl8192e: remove parentheses around boolean
 expression
Message-ID: <30a330377667aa5043a60ed3cdf1bbb37099631c.1618133351.git.mitaliborkar810@gmail.com>
References: <cover.1618133351.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618133351.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses around '!xyz' boolean expression as '!' has higher
precedance than '||'

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v2:- Modified subject description.
Changes from v1:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.

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

