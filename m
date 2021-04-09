Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E72359B95
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhDIKNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhDIKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:05:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D03C0613B2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:02:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so5862557edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7P0K3FKgejJxyJ0qBQdn6JCUteyrf/rikuY3jTQzlpw=;
        b=fxzwMak2IjFah+p+7J+qQgZid1/zKU3CMrVNUKRJJDVCLJhlITr10lUi1ZWddP5Gbg
         FMEZemFMn5r2YWXz07TXvcJgBskIAi8J/FHfHWJll5XhJ/oTSdpZFY3yaDfp7qUyZpO4
         0OHpMDdfxM9nme23T+c7kdJUHflipOisczsv9rPk/nhRj+rzbDtq2PX8jXebrQ6SWh2Z
         97iCNgoa1PozWx8TsQcYZ+3X1Jxo2TtXqm71ZBfvGXQo8qLYb4UsZQUNN2nHA7tEqqWk
         ErjJvX2aQmn2y/ZB3XMnDZFxFzghkq0wTcfHbMrqpLRdnoE+l0Pdiki8wHHx4I500xjv
         8vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7P0K3FKgejJxyJ0qBQdn6JCUteyrf/rikuY3jTQzlpw=;
        b=ktyTDlAd11KUYuP+Lk4gFo6H/4NkaEwiMz0EZ+oG6nl5i1RLwIWOBvWjqxCSlCohIl
         IoKlacI3tRLAnz35ODZivNrY98e4pax7CgxeA40ORDwhsFvkTX6ab29JbnUS19cSB44u
         BesLTmarjGgoJ8WcAsn5A2EyJuX2WjQrNcjhXhIWk5CUrmfpl3GzfxJ1V51z+OkzTKkd
         gQCYAsSFLE75se3IvQNy3JCA7UTA9n+LgWcxOHYA8Fjxm6d/f9u+0l6RZl5wxgEFQeJ1
         jIAqGGBdmM+alTDIlESkz/kTunnCGfeaDkKmQ2wLorz20sK1HWx9bqTcLumUmTk0lJHd
         Dvlw==
X-Gm-Message-State: AOAM532rqRDPm6rT4ctLiwbB0l+7qAJVqyCPGPgvHiPto+IkKHyE8Mrz
        7yPtDOiB8+qh+SEJWLr6c9zgUxb6Vq0=
X-Google-Smtp-Source: ABdhPJzWbj+T/lQYp+qk6KX/DONxUPx9r3cMHQ8rIRVUbMnERb3LcQXHeI1FVnDFoMxwHXPquoB4Kw==
X-Received: by 2002:a05:6402:40ca:: with SMTP id z10mr12353968edb.215.1617962522528;
        Fri, 09 Apr 2021 03:02:02 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id i16sm576252ejc.106.2021.04.09.03.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:02:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/11] staging: rtl8723bs: remove unused variable declaration in include/rtw_security.h
Date:   Fri,  9 Apr 2021 12:01:37 +0200
Message-Id: <819680ab87bbe543aba966f1fe47b209d3d8a69f.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following kernel test robot warning:

   At top level:
   drivers/staging/rtl8723bs/include/rtw_security.h:336:28:
warning: 'K' defined but not used [-Wunused-const-variable=]
     336 | static const unsigned long K[64] = {
         |                            ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_security.h   | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index b71f0959108b..5c787e999aab 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -332,24 +332,6 @@ static inline u32 rotr(u32 val, int bits)
 /* This is based on SHA256 implementation in LibTomCrypt that was released into
  * public domain by Tom St Denis. */
 
-/* the K array */
-static const unsigned long K[64] = {
-	0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
-	0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
-	0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
-	0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
-	0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
-	0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
-	0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
-	0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
-	0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
-	0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
-	0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
-	0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
-	0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
-};
-
-
 /* Various logical functions */
 #define RORc(x, y) \
 (((((unsigned long) (x) & 0xFFFFFFFFUL) >> (unsigned long) ((y) & 31)) | \
-- 
2.20.1

