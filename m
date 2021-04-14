Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0972F35EDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349724AbhDNG44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhDNGzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:55:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:55:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso10305149pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=li/8LTcZkYP0ij3luXshJf509WGvz+vVGqh0dawSB0Y=;
        b=CcYSUiBXjtY32bAijX+00uCERZVfR0ijx9r1mHi8Ke2NkNbFFCsmfPQ8XDwWUqx6g2
         rq8l6ZNbB+1ewED7+Qi9G90cPQGpEsFjL5PdMB8j6vCCmuhkEMQCLKopK6As+fVTG64m
         XbekHJ3DhmR5E52lYa027XFcozyMBagntE6FGWwhzu2V8nGFCrC1/R1cqsXK5ZFUPL4L
         MEjLGP1aNosfz59+SRuWyFFssvwasyWF8Xp37Y3kSkFVLz6AkTgZ4/eUpudLFStqLqpB
         i70B/CiFfRkx/kLs0WHCKs4FGZDTohnhIRzsOfuaFR9mEJGSKpujftlsjTNWe9kAi790
         4JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=li/8LTcZkYP0ij3luXshJf509WGvz+vVGqh0dawSB0Y=;
        b=U62BlAEnX9XQoyUt5staEpgS2K38Zpr2DYmFAJqOSmhaDqnIIov3+EHMQrgQLRZxta
         rOkPcSGmIbC/Dzl2Hr1Erf8oIYB6KxPHhLI4vD+E7vs6+gi4HDjaIyxfSJiCaViVtw0S
         4qwY3fLQff5q+KE59ns0L0Dd3EKpXIOJvvat+hBos0dqhgEkBM7R1Fwd79rKeztm0r4A
         Ys1hz/7D/GE8bEafEjBAUBGyFNu0b/KgNOkRfotE1h1NBnhnBa2/Fv/UUCs4WGIVQ0q+
         B7WR1USoRqkYS3JjJCLIR072EWPG7Inppf4BhuH0VUcXULaAQHg1zxp+lX6ki4SvY0QM
         a+4Q==
X-Gm-Message-State: AOAM533dp82zRiN6unLDPZJdMImJq/2XzL5V4CQeBBlDxh+MiHbDCFCR
        0EA4foOuSz41pP8TxAEtNH4=
X-Google-Smtp-Source: ABdhPJxmr/Xq5zQXhlTBNg/eAp5Z2ED+EB5zmUKnDQulrDhO5eh1YrrmtMa9R69f5oKi05gbc9DLog==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr2076708pjb.46.1618383330372;
        Tue, 13 Apr 2021 23:55:30 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id k4sm16677159pgm.73.2021.04.13.23.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:55:30 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:25:21 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 2/5] staging: rtl8192e: remove unnecessary blank line
 before brace
Message-ID: <cad6a7885f30dcfabaf1ccab1fd0644416fea194.1618380932.git.mitaliborkar810@gmail.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618380932.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an extra blank line before close brace as it was not necessary.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v1:- No changes.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 --
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b74c6ac817d4..651441a71646 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -263,7 +263,6 @@ static void HTIOTActDetermineRaFunc(struct rtllib_device *ieee, bool bPeerRx2ss)
 
 	if (pHTInfo->IOTAction & HT_IOT_ACT_AMSDU_ENABLE)
 		pHTInfo->IOTRaFunc |= HT_IOT_RAFUNC_TX_AMSDU;
-
 }
 
 void HTResetIOTSetting(struct rt_hi_throughput *pHTInfo)
@@ -445,7 +444,6 @@ static u8 HT_PickMCSRate(struct rtllib_device *ieee, u8 *pOperateMCS)
 		break;
 	default:
 		break;
-
 	}
 
 	return true;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index b14ed3534ffa..34b00a76b6bd 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -192,7 +192,6 @@ void TSInitialize(struct rtllib_device *ieee)
 			break;
 		pRxReorderEntry = &ieee->RxReorderEntry[count + 1];
 	}
-
 }
 
 static void AdmitTS(struct rtllib_device *ieee,
@@ -253,7 +252,6 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 			    pRet->TSpec.f.TSInfo.field.ucTSID == TID &&
 			    pRet->TSpec.f.TSInfo.field.ucDirection == dir)
 				break;
-
 		}
 		if (&pRet->List  != psearch_list)
 			break;
-- 
2.30.2

