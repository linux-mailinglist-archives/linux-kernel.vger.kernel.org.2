Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5230335FA68
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhDNSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhDNSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A5C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v6so31523462ejo.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gbt21eDz1ux51dDRM9MoqUrelbAbvGfR2phsdgoe2Ao=;
        b=YKgeyjeacYVFEOHEJdyPIwX8GmVd+0fgY+s0NCuKaTCVcz3BxVoRZzOwM51phkAVI0
         fuhkx/ad3ynSmA1jRaDJ7qqbKg/VDm9B0fpf6sdZff0zJK5VP1lhP5X/gC/pPruOmQ5C
         De87VKH4KcDlRsj/npdgu0kVfzULo5G1yVAxMQa+ZLoFykBLrc91RzQTyEqR0LuN27Xk
         dwpOyb+we9aMUzYWYQzaRcZUwDWIUppnd7ApyQRRvsJcNAynSHIyA0uKJ73lcVleweLn
         1B3CoL75AUu8mhaeGEjD2YUiGbz6AXPWaQrnhksGW14OVrfvPec53aZKu9s29Ks0RZBd
         D7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gbt21eDz1ux51dDRM9MoqUrelbAbvGfR2phsdgoe2Ao=;
        b=UoPL2GyvoAVHDhciQNYDTmvqhaZ7B0y4nFnaRtYQ3inwYe/uuigZcI23oC6ghBBP/7
         FBRc3cyzlGi38e1/NwTj3+t/y4wY23duS5ilDTNg0jvCDSDcqs2DiMxUuJrD7TvBopJ3
         9YKGnsjTMQ8mEtD2Q/ZkXwWhHCinIbM7gomjjD1cKhSTFz/8jrj/w/6+os+lLd+MkVYT
         MS+PZy/+VRWr6XZikw2LRUouCkGGKvgCVRo6L20aqDReGnoq3dD21+GWnVZOsHwH6xBy
         VgbGbM8kZiOwQCYyCAJ1jwljPzA818ZR+/N/e0E1/ETNNX/UNrV4CilvBDA9P/MTFQf8
         R2VQ==
X-Gm-Message-State: AOAM530h4sFSIYEPTTaQsiW9A5uX+6qYikKJrZMMTkgxmzluD0HRuNwF
        xib/bUjGFn0fjHNNQobFGOll8w==
X-Google-Smtp-Source: ABdhPJzvFYOudbT5j/JPcLbvtNb0DGNTrjSbjbSE+E+gZP8b+TC4DybEHUjZEMvOoww0x/CBfaWmwQ==
X-Received: by 2002:a17:906:1e8e:: with SMTP id e14mr124239ejj.399.1618423896479;
        Wed, 14 Apr 2021 11:11:36 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Robert Love <rlove@google.com>, linux-staging@lists.linux.dev
Subject: [PATCH 02/57] staging: android: ashmem: Supply description for 'new_range'
Date:   Wed, 14 Apr 2021 19:10:34 +0100
Message-Id: <20210414181129.1628598-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/android/ashmem.c:189: warning: Function parameter or member 'new_range' not described in 'range_alloc'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve Hjønnevåg" <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <christian@brauner.io>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Robert Love <rlove@google.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/android/ashmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index d66a64e42273a..8ee4320a5dc6d 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -179,6 +179,7 @@ static inline void lru_del(struct ashmem_range *range)
  * @purged:	   Initial purge status (ASMEM_NOT_PURGED or ASHMEM_WAS_PURGED)
  * @start:	   The starting page (inclusive)
  * @end:	   The ending page (inclusive)
+ * @new_range:	   The placeholder for the new range
  *
  * This function is protected by ashmem_mutex.
  */
-- 
2.27.0

