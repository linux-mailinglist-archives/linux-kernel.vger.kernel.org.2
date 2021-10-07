Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6486942577C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbhJGQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJGQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:17:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F9C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:15:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g8so25073236edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9E5Szjn+y7W/3JHY/8PTahKiMyq3oOWBAZ37nmcUVU8=;
        b=qXYAbdR7JJWmXd1JWxs3ydPa4FebAJP2Jn4T9o88kWDcWNggwOkNK2M3MUAkfjl5G+
         5SAmqZxPkho0WLsFStgsERMh+zVqp3mPpUQPbcILfCc4BuKppCRolpKYe1ZYEFaNBhis
         cZDnx/Mn2h5tE7WGkyA0+gMlSOZZkfOl8nWSkc9KhEHDE9RX7GX9OSbDWOowERrBlyEV
         BSzvbo3D12Ktj2pqv+uWSVxFvVNhfm5Y6JqOIR+L76yEhxG+pIJqaX6zNzbSJKcUKipn
         dzqI/Xu2w0o4O/nromJkRFHdBGTtGNTmKZSPY0WgCXnLZVoW4FP2UxUJD7QF0Sx5Ku4T
         Om6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9E5Szjn+y7W/3JHY/8PTahKiMyq3oOWBAZ37nmcUVU8=;
        b=Mz8XKeV0tUHgFiwbKilNlwnMMVVnMjQJGvlKw32m9RsQ5ZRgsLE5xB0xONC5irFi4i
         RFAMCcnAzQ22tNbfZKrbMfTEIIFCCZlsBvXY+aZ/FybZF3g9XxdW1Pu/B6rm1Wck7Dko
         QOuXKRzTkbiH7JGUm9aFiuMgK50HRCRiet346iLdGeVKk1pCeJDgdJIsavnhkYGO7X9m
         UKxWlJam3Wy1TwuSm3cqiFOuHqZWAClk2G3vlCqO/CmhWAj2QHVn+vWB4llWCvfq/RVk
         ifT2eusjDJpgd4Op6ZJ/YSA1/cYgf4tdb2JPaDPZG6+sSc5VDGbX8FYcxndmCURkh8P7
         mfDQ==
X-Gm-Message-State: AOAM530aadv/1gyDKNO6OqnSB5+8R6qQIqnlurZiNG7khmBO5E5AENPr
        yC7cdzjvKKUoJQfCgHgE5C4=
X-Google-Smtp-Source: ABdhPJyor8yu4eAvavDwJUzhzTnifar3Llb/UAcCLRUKrYYKtan60NQgKRK9eAepC7DDaxHVjIbD+A==
X-Received: by 2002:a17:906:53c8:: with SMTP id p8mr6644978ejo.422.1633623339151;
        Thu, 07 Oct 2021 09:15:39 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id z19sm17859ejp.97.2021.10.07.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:15:38 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] vt6655: fix camelcase in byRate
Date:   Thu,  7 Oct 2021 18:15:32 +0200
Message-Id: <20211007161535.7563-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case function parameter name byRate (hungarian notation)
with snake case equivalent, in card.c

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 3ef3a6e0e6e1..2b2255b3147c 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -56,7 +56,7 @@ static const unsigned short cwRXBCNTSFOff[MAX_RATE] = {
 
 /*---------------------  Static Functions  --------------------------*/
 
-static void s_vCalculateOFDMRParameter(unsigned char byRate, u8 bb_type,
+static void s_vCalculateOFDMRParameter(unsigned char rate, u8 bb_type,
 				       unsigned char *pbyTxRate,
 				       unsigned char *pbyRsvTime);
 
@@ -75,12 +75,12 @@ static void s_vCalculateOFDMRParameter(unsigned char byRate, u8 bb_type,
  *
  * Return Value: none
  */
-static void s_vCalculateOFDMRParameter(unsigned char byRate,
+static void s_vCalculateOFDMRParameter(unsigned char rate,
 				       u8 bb_type,
 				       unsigned char *pbyTxRate,
 				       unsigned char *pbyRsvTime)
 {
-	switch (byRate) {
+	switch (rate) {
 	case RATE_6M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*pbyTxRate = 0x9B;
-- 
2.25.1

