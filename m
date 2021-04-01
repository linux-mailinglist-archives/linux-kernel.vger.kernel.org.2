Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0335121A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhDAJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhDAJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F191C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j3so1134321edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3T+uihbktGxCHfya3V10ZruR755TNbcOJbAcg/SlH5o=;
        b=EJH7mPmYZkeULTzHgHmmydx5AFSP9LgdoXpu0mpfdIleUQ4rW3b8Q4kyJG9lCE5zm1
         voqm9tavc0yDuPU5fX+cp5XPoclc785g6ya3nX+HpZhzuQ4tGJNvCe4wamuJP+IeWmxY
         9pDXsPOwQk0gPEokMfYK6H69mK6d+JUiAuJOcXhMjdkpbjwNltN1MErvLft9emc/Qoma
         c9E3pBLqV8CMegyE8ceJ2CXMZ8ArchPCVx33OlN+WYFoYncYjwSsTDDPVv+NUPJz+a8u
         CiFim9byp+mM7FHYtxsXHcHpaMIi4KVUX0cNBbTWORO7Jio2AKWBYVj3gjIKumx+amp8
         CJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3T+uihbktGxCHfya3V10ZruR755TNbcOJbAcg/SlH5o=;
        b=J3/TeHQaXy+LhMewCmz6V5msynALPyUDBQB8QPfuCfWMa8RSfldaCdFiXRjcswuYG0
         DBQPVOrFO63erth966JcMdfNBujywhLtdiGYaif09dIrA9vnbnn2Yf+pEeZ3r1KpkyRH
         UT+fIrYaIhcQvpinhieLUupiLZy+O+fK21hmY6OEccXT0KTrxO8oYQGyAiTA08LypUr6
         cWssK4T/XQbcBOZdoA6ShGyGCq4YI/jLfx841wvI12Z0aWf17H2l80OPReuB0hll/4mU
         9PY44zsk2nP9t46ekSzNQZ2WS6BW2zcx/+nRKRTNi0vQ6TQt7sxVTpmopz6I1pie7ZtZ
         6A/Q==
X-Gm-Message-State: AOAM530FyxP7iv89LiHuKyvRlvofd2mVPQqmljD+jT80T2984FuBrdkP
        L5pf8vGeeSV15wAYFkBUlWjTq5mWb4k3Iw==
X-Google-Smtp-Source: ABdhPJyNisnWPowSHrSLvcMXQeImXODL6PmShYY87Men0zc9HMQPtUnS/9c74QJB+z9e1oT/MEg23A==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr8604164edu.100.1617268945471;
        Thu, 01 Apr 2021 02:22:25 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id r17sm3240709edx.1.2021.04.01.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 38/49] staging: rtl8723bs: remove commented RT_TRACE calls in hal/HalPhyRf_8723B.c
Date:   Thu,  1 Apr 2021 11:21:08 +0200
Message-Id: <37d2f9e27af11d02f65c9bab4009f2f8aedfb44f.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE calls in hal/HalPhyRf_8723B.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 12f0e3601531..c36513812d9d 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1847,7 +1847,6 @@ void PHY_IQCalibrate_8723B(
 				bResult = FAIL;
 				break;
 			}
-			/* RT_TRACE(_module_mp_, _drv_notice_, ("Switch to S1 TxIQC(offset, data) = (0x%X, 0x%X)\n", offset, data)); */
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
@@ -1864,7 +1863,6 @@ void PHY_IQCalibrate_8723B(
 				bResult = FAIL;
 				break;
 			}
-			/* RT_TRACE(_module_mp_, _drv_notice_, ("Switch to S1 RxIQC (offset, data) = (0x%X, 0x%X)\n", offset, data)); */
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
@@ -1950,7 +1948,6 @@ void PHY_IQCalibrate_8723B(
 			}
 		}
 	}
-/* 	RT_TRACE(COMP_INIT, DBG_LOUD, ("Release Mutex in IQCalibrate\n")); */
 
 	for (i = 0; i < 4; i++) {
 		RegE94 = result[i][0];
-- 
2.20.1

