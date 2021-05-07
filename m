Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCE37613D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhEGHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhEGHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:37:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E09C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:36:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m9so8119901wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65d8j8KxAbaBeXVMozPvqbc0VGuCAIdxy/SojbfesRI=;
        b=uxX35QF4aly4LTSsErimFGWmK2vKDX96V0zb23tscREHRcZZgNpOvFDFMDQN/47VkQ
         0wp8QoTQbbQw1c9mGL32g9wl/WMue34hdX6ZvblqWmg4eIGAQbSwlQ44eXdanb0uLWKo
         F/PZ/gTrey6F3SvBhYfSMbqvBU/VN0xIoN1pnooHBS0jKz4dgU0v/2mZFZcDpqS0aeS0
         olBOvqSIe0CTT51oq7nKzEsfSPLwhj67d6AciWghUbSw9nNYUcBZDAx0KEVmqyZ/LuU4
         /3kda48hI/3WOEB/omg1Rul404oIDJQ4/TC0vvxzhX/gSUxHs6UmAXrJoSY6GPrELNhR
         /L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65d8j8KxAbaBeXVMozPvqbc0VGuCAIdxy/SojbfesRI=;
        b=aQwGVa3Qe+O0YDYDzLsyHN/NdSS1JDGiLRPLi/uw73dKwPES4L9nvOe9OzuJSNlbdW
         aHDQBqKRCrJQ8fAZt1MA+k8l0wL68cwwLGsLDpxsOOALkIqNoyFLkbOp0R2+eNx56bpE
         CPI7KFtyqZJLtiTiHUadVRvd5F7CCOsPmzeY/WeayeZY884eSADx6YkjJFHRtFqTlLGO
         ROLLka3oMVRXOPKoy5mc6cDKblXTjWyCHH8S+kciJkMMcj/UOmOkUY/rtAnz4+UnIfcz
         xLP1jeOGa0Hkbn/In++shKLr8//1VhHiTRqBm9Uby1YxGSrK60llQYa50g69ak26T0jS
         TkYQ==
X-Gm-Message-State: AOAM5308+tn8gzGK74ws08VbKhGRWOQv1XJ5GH41Z+4LmwVFzIqRN4RA
        zVYG7YIvm1dMTqkL5nddy31kvK8ZB5jMXA==
X-Google-Smtp-Source: ABdhPJwUcYDdHrWzz6wgkE1dlZla1lAW+KgE3ewuO9V8Hh+cYTI+Crs4EG18DlZw2WT+QdZv2qrPPQ==
X-Received: by 2002:adf:e947:: with SMTP id m7mr10842029wrn.70.1620372966347;
        Fri, 07 May 2021 00:36:06 -0700 (PDT)
Received: from agape ([5.171.80.53])
        by smtp.gmail.com with ESMTPSA id l12sm8363863wrq.36.2021.05.07.00.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 00:36:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8723bs: remove unused symbolic constant _AES_IV_LEN_
Date:   Fri,  7 May 2021 09:35:59 +0200
Message-Id: <ac3f5a400dcb61f46db259cca6979ec41f98feae.1620372584.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620372584.git.fabioaiuto83@gmail.com>
References: <cover.1620372584.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused symbolic constant _AES_IV_LEN_

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 76076c4f0763..83b711c5df0b 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -191,8 +191,6 @@ do {\
 	} \
 } while (0)
 
-#define _AES_IV_LEN_ 8
-
 #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
 do {\
 	switch (encrypt)\
-- 
2.20.1

