Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AD3DB5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhG3JKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhG3JKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:10:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB8C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:10:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id e19so15580151ejs.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpbDiJV/Na2P3w3G7ZGi4FHd+w20lWJcijkHVW1cIVo=;
        b=UDMukiA5PiEWaHXiI+7Cum5PgIcR3OkOUzd3du/a01n7lpXoth30fK1+KKiz+g/2E7
         Qp5Tjl6ChFGrgYYPRdjwGcpyl+NcDwCreJ5vGD0aihELz+VuQLBr+3ypBn7oFb0YqISH
         jqeWBIENI1plBHgu/WL18AiMMdHkgztXWy2II3GiZT819bXBTpv/m7HAnPEiZQKZ3ClR
         1Zwtwf7HL6BNno0jfhQhpDlvZJY4+BZdWmNeyRk7FSqwui2TAaNSK3qukJvS5NaJKvy/
         o0S69QaBeoU4KbFOBnqb5p540q8OyZFySPhjC3UbO8BEwZ6MDY1m/y/MGoMRvzCDL7gi
         Ga8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpbDiJV/Na2P3w3G7ZGi4FHd+w20lWJcijkHVW1cIVo=;
        b=WmwVdd9LvKdMRIBOQCqOmHvEPfSvRlamCiuuTr0ZDILy5ZcAjp8nEdg0EMn1jkmxoV
         eLxyPOyHgGuG18RjJ/6u7Khx4AGZLmFE+gH/z9qCBJofE/dEI3UfxzZ8nMvgT2zRx1cJ
         pGuNAT/KyKk+ccVOX2XHW1X3jEFHbL/zA/lgrg5cErI3qmjCuns5jXNGRp0rUz9djD9y
         T6izvo6S78WxeJJNzezK/XkPdRt0VHb6yuA3pASCag8Nv99xCBkW4PZ1rs03dQdE2Boh
         z26bC3vr8spQhpmxyhT93BWmcjWCN004AyW1h+Nsn3LG1CQF7LVVVv7vVwpjsJBt2ZHu
         hK9w==
X-Gm-Message-State: AOAM532CgyUXKzrkDKCPeH0mLHapUxC+Re/6jaLujk89f2ERf8n1NMZq
        EXKeiRvGFQ61rYPvrgoFuUw=
X-Google-Smtp-Source: ABdhPJzbUNmWQdV/pEBoKkHIImqmIIF3ollktxxiNFq7yXeMlZCLQo2WnCkmEkYN4GdaMycWQGQHnA==
X-Received: by 2002:a17:907:160d:: with SMTP id hb13mr1575364ejc.489.1627636234859;
        Fri, 30 Jul 2021 02:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id da23sm417665edb.34.2021.07.30.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:10:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: rename parameter of odm_evm_db_to_percentage()
Date:   Fri, 30 Jul 2021 11:09:47 +0200
Message-Id: <20210730090948.32759-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730090948.32759-1-straube.linux@gmail.com>
References: <20210730090948.32759-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameter of odm_evm_db_to_percentage() to avoid camel case.
Value -> value

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 6afe3f9bc47c..51ae02805149 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -77,12 +77,12 @@ static u8 odm_SQ_process_patch_RT_CID_819x_Lenovo(struct odm_dm_struct *dm_odm,
 	return 0;
 }
 
-static u8 odm_evm_db_to_percentage(s8 Value)
+static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
 	s8 ret_val;
 
-	ret_val = Value;
+	ret_val = value;
 
 	if (ret_val >= 0)
 		ret_val = 0;
-- 
2.32.0

