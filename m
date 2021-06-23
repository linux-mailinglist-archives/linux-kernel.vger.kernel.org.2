Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3243B21F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFWUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFWUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C85C061768
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l11so2166068pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weOFYHnAt9XHzyijtFN46zZa/bge4PQn7pFxvS+uscM=;
        b=PINKBfWpr3gvTyJ0eFnAv65n6MifZbR/apDoNhNeYQq+pb7Y+nHfI6/29jpyhKRsrA
         kSmtPGNKM36+xWmlgXqHNtUo2kVWovxkLqFL92N+B8M0nbpRfCD32Nat5OMJ3EJp3QwV
         KrPvrHdngyt40imWa1hgx+IPHVy1nFGR4oZAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weOFYHnAt9XHzyijtFN46zZa/bge4PQn7pFxvS+uscM=;
        b=eT6Ktcp9Nkht7NXS6NBHLg/fPuL7ImrT2vn329i80WNJ7vc4W0zjM2Fo4FLSejzc0O
         3QghdPd9VFHheDhbLXQPWenBHPlp+JD3E5cZqL6lQjcv3yso4gW+qN6tDQzZaiB+Kzpu
         1CssMh5+APOzo6sV4YuH2SYTRN7MLzjjVNKcqr+E+pJQFy7NmiUFcnnZ3AIceHBlM4Wn
         C2Pcaw/1CGLn5srRTwLYzg2b2qVhdo8haqHgP/oqlRtD6/H7DAIiTe84zPX3Nqjk3jwZ
         NyaI7Wpu2umUaxG3CL6PmsRha/JrNa5GxBO4DjJTxDcCda+a+WRSjLuPqb5UL8hrddj9
         h+LQ==
X-Gm-Message-State: AOAM531shyaEwb/HZwvaxPA92stYOap16r+jk1n3HUgSf8j1BevnwCm8
        ftMlXqf2vANHY/aDfoD+tcJxuQ==
X-Google-Smtp-Source: ABdhPJx1ypcWLUnUHJBbnBIjhX9m3ZNAxwtdnMUAu2WOpDwAvnSgoGuRx7tr0mmBARqaMdXFPQlhRQ==
X-Received: by 2002:a17:902:c789:b029:110:4933:71ce with SMTP id w9-20020a170902c789b0290110493371cemr1194211pla.56.1624480788561;
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5sm640523pfe.79.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 4/9] lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
Date:   Wed, 23 Jun 2021 13:39:31 -0700
Message-Id: <20210623203936.3151093-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; h=from:subject; bh=Ug1zxBYqfqGVjk6HZPE+S2IQ++k8iErOOapO5olSeEg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wGnJvmDSLi1MPOx05nkNSD/27SmvDUPYKaSZ+b ABK1bYKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBgAKCRCJcvTf3G3AJhiJEA Ciux3+IGOay7Jw49WbIkgIv0TxSZgcO90q+vD3qxYri5Kve5Gl362F2aW0FCOlOtxfzOnGmC53o+vL mnCazUpoqn0dW/Y15W4dfOo+HoN5/Afr2nMEj2cwPYh7e2v3kQ2/JK4gaqP9mMDegUGCvWynQbQq54 md3YCttGo14SuaAMF9Wgo60xgxde5gIvQadm2WfvXU0BLyeZBBQb/iHJb8A06PBRzIBP06Nu+NmVVS 4gjNsMrbg6ltVcNDZ67UJ4sjzuFEP2hO+bd3d6/D/d7os59xJd11AHlpBYfk1gCBMC4wl/ZHgbOsaY ew49zKobbo1qt1K8F7Yct3U3IZZ9e2Ny/XCdM/rQMR0KlGYK/LXREO8mEubV2DBQzQidihoy2cFwBk 5gEjXn+w2QmsY5GXkuCXxsRXVw90q9IyT0Qt6kyJ44vqmTKpUFpcarqthBP1/2nXx243B73YaVCB12 6nd+koQb1m5NQNvzwZ8i/jObt5py/ucSDlpCVQ/PCl3NUt9sRB0S8MRNKXxgEJuNMGGs/BUSoYK5AE 51LAiLpudvJPuDuLgHUfzx1Ig+tAVem+P/7WoryLM/rDXtXqsXoyyHzBPcZGczV6nPm7xCwdkviySP adfzxjhgaQrqToXPyTkus9c6NYZDhVyUcK6oihTYUAjfRzEQc+F7f3grbaNA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When built under CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, this test is
expected to fail (i.e. not trip an exception).

Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 0e8254d0cf0b..9ff02bdf3153 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -161,6 +161,9 @@ void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 	if (*p == 0)
 		val = 0x87654321;
 	*p = val;
+
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		pr_err("XFAIL: arch has CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS\n");
 }
 
 void lkdtm_SOFTLOCKUP(void)
-- 
2.30.2

