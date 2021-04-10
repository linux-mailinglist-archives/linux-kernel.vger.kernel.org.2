Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A535AE25
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhDJOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhDJOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEFAC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w3so13050097ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAzntwCjbfe9pzWMYCSEN3auSSVZ1kv4hnQXcYCWrcE=;
        b=kDa+SBSjrsDy7Oi9FFv8lvSn5MJ9rQvI+y3x+1FIB7KRVq6uoCg5akmjXRaehT7gUK
         b9vCBpMRnePpMcNCoL4JNBU/JCAft26kPW+gbkWx81y4X8CED+1sbd5iCmZ2cXXqiDi/
         LZw9dCibHwwrvufZwxxk6ZdWXZ3e9PbyXhjZSAo2pXe1W2iU1ogo1QgElQJFmiU7b+6a
         u3A9g0+NVuyNwQSv9yQn0/EuU9hhqGu7MrpmtG9LFZJqVrcxh5ejhCZy0IjoOLSQo1l2
         GJ3oNJeIUO4D79OmSMdJUx1PbK462chUoF4CjrK0JLzlvk/tICdvWJMaq+WyX/ra/hWD
         /bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAzntwCjbfe9pzWMYCSEN3auSSVZ1kv4hnQXcYCWrcE=;
        b=kStDlhwBKcttwwP707vHr6kSza2WiwEWjTGxI2X+CrMaf+odZz+or2zFufp7OqhMbI
         4DUhUUggYpGcvUve/xekF07uRleCexSAvKmOJ9D3EKicW/aa/TzBFfL5tAd8KJQuCdM4
         Y2uGcGBoqbZM/xd+5C94Aa/t54Ud/9TQoK14aIiJD1onrBx0Ae74Bzooev9LgDs8JmZ3
         GSRHxQ+B3TeJiXNFwAedNnjo5gwIbRzN/qZbtB//z4RTL93hxjNupNF5pbYDOr0sjLxQ
         mISi4nMRx/qLu5q6pgVAVrf8UNG04VyILHjYYrCBtj/Wt1e2PLn0ohe4efux9Xjx1PCB
         za6g==
X-Gm-Message-State: AOAM530Addq9Dkp1kkU8196rAbBuIUKqkrT6Ty9tiu/07d6j+hT8kdin
        HcQYUufRsYrqlECEKCQ3zTcDKM+GlNLlnw==
X-Google-Smtp-Source: ABdhPJxLH4vbWGbhzIDi+6scroD5JW+X/N7IYGqysdt3iNethklKkoOc5QqSBoXkR0UauwlMoraiAQ==
X-Received: by 2002:a17:906:ff46:: with SMTP id zo6mr20287456ejb.123.1618064454960;
        Sat, 10 Apr 2021 07:20:54 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id l1sm3161950edt.59.2021.04.10.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] staging: rtl8723bs: remove empty code block guarded by DBG_CCX
Date:   Sat, 10 Apr 2021 16:20:22 +0200
Message-Id: <b9ff4d7f14decf33064c30b307c3b20494aecbb2.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove code block guarded by DBG_CCX symbol, left empty
after DBG_8192C removal.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 6487aa7bc5e9..dc03a128d439 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2792,8 +2792,6 @@ static void rtl8723b_fill_default_txdesc(
 
 		/*  CCX-TXRPT ack for xmit mgmt frames. */
 		if (pxmitframe->ack_report) {
-			#ifdef DBG_CCX
-			#endif
 			ptxdesc->spe_rpt = 1;
 			ptxdesc->sw_define = (u8)(GET_PRIMARY_ADAPTER(padapter)->xmitpriv.seq_no);
 		}
-- 
2.20.1

