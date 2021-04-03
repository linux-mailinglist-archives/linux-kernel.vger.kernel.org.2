Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9935333B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhDCJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhDCJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F154C0613A7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso513148wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wv9UQx8pFx9EKn1LAk5Wrb1T9ZM1NP2AqUIoiI8Ejp0=;
        b=GgcxVrIqbzzGZUKn9kCk2bTk6pfsX1KZlAOJoztPZ0twS4YJ7DdP07HqspINt1YVbS
         DMYtFbgNwJfUwsr13wEROlA4mHe6UwHa3vYM/JkVP5xOXkOD+B/9QRXhFenTbshLd+yE
         Ly7s9mSur4JIIYmbwq4WlEFaZrJMAO41pbYi3ROAOB9GWe7gm/evTycuy4tNAHyfqFEH
         t8LT75OxQUpCeBLXS6NWCxFoeQgdajumX1Kwp2ICt6T+SRj4+O0rez1j4yKHDpmoA38h
         l922dg7ZKcv77qdeFnlgvvhziCBpqzJdYF1gu7BV2uFVkZAFsr1ju5fQ6YfTbWI3/6uT
         8pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wv9UQx8pFx9EKn1LAk5Wrb1T9ZM1NP2AqUIoiI8Ejp0=;
        b=iARFJPLtBxVDseoCSd4PrzydqyYG/pJHbiWJLbR6Q+WgJPBYyMUf9liMcaqNf0duEj
         XlG/N46fdO+tfkvIyOHIPjHaIVnn3Zx/Lk9GcI6DzzpR4mDmsBhz01+HBh1W42r6iden
         FlNZD/dqiidBu7reZXtrRzrD2beYOBL9LMQ0WVW65xXgIm8Px0FF0G/W4La0Ooi8YKAP
         r2YdCZJPGYK5+0a29gWBZqqlaIqyO0dmTt7Ale3GjxIS/rhOqzFIPUU6Q1jTOM9C6zTg
         DXvMInZA9EMP9pLLNAxaoRDQfbWtJyTayl39ERBZLpo6IxuTFx4KTnUBGX39m+311YLR
         mgNA==
X-Gm-Message-State: AOAM5339kCJPvk7Tuwss6zcHMO1t4O2ZowKcAW1R0jKYyHf3mf0KUFNK
        Qpx8s/LfuKK5adxDsjOmB48=
X-Google-Smtp-Source: ABdhPJyMYoHNiowzK3hCN2vAsR/aRTO/ohL/UTZiBtgTBZHRJnTvzcSle8HARxu3XIusqPED/M3ESQ==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr6857363wmh.78.1617441287466;
        Sat, 03 Apr 2021 02:14:47 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id o2sm14843788wmc.23.2021.04.03.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 21/30] staging: rtl8723bs: split long line in core/rtw_recv.c
Date:   Sat,  3 Apr 2021 11:13:43 +0200
Message-Id: <915095ed64d5322b51fec8f9c2146acbfa6944b7.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

WARNING: line length of 113 exceeds 100 columns
110: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if ((psecuritypriv->bcheck_grpkey
	 == false) && (IS_MCAST(prxattrib->ra) == true))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 953351f896c3..c8a13d733c98 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,7 +378,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if ((psecuritypriv->bcheck_grpkey == false) && (IS_MCAST(prxattrib->ra) == true))
+				if ((psecuritypriv->bcheck_grpkey == false) &&
+				    (IS_MCAST(prxattrib->ra) == true))
 					psecuritypriv->bcheck_grpkey = true;
 			}
 		}
-- 
2.20.1

