Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4298C34B793
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhC0OZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhC0OYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:24:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9BEC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o16so8439740wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsiW3CmcCaVO2OVq6Ce62U9J/kZUCHAmiDQmSX6AIO0=;
        b=lqd2kXRCZWsJoOBXe2EY3IbDSKTTXWnlyNVVnMAlFgU4QlAhirpIbg0t0jFHDVhYdA
         rGVgE2wdklH86JW3ENrMIN+rHMriREBj8BoJ5NrY+5Xh7PmBCAODKDIkwHQkmC4hME8g
         2c7OYh3qBsUXCLKL3v8l2x4zUEnTZrPAdMJZFOHE/V2/Sz1X1Ab7CX8wbDLKpcQitnhi
         baR+jU3jZmpkeIkru5+wOd1VCjMQQl+LSqn68HHnV3OYi/rfL60YdPom9NYibeqYOmLB
         DGc+Z0w1npNSHPhcwKsEf88kSle3q2sZfNVdhMLmbOC7JagCYKWRMhQy9tLbexSWp7+0
         HjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsiW3CmcCaVO2OVq6Ce62U9J/kZUCHAmiDQmSX6AIO0=;
        b=rrNlashRqPueVEqDL4nZlyegtHbOdEocuoHgvOw6t8OJp28FYrYIbTOEPq/kKp/d+F
         kajtUd8LuHc/jdpcgYJmAYvfPscenJt8+d3/PNtsMws2zq0y8M1aFX6aDdVnPBUmtJ9A
         w+T78f70mvhQcoJ8CLorGIuZH7tAzeXE0vqlxO559m5nzNazgXkvEl9wBSMI87ZVGYcn
         MDsYRPttFQId/h2RJU++n+KSOxPKOGx9+FvzA+aVy7TZ1L8iaU7wYz6Bzjv/ET1OPgSW
         Sth6eXWQcy341DyPpRLgD9905VdF7G+9NAw15wX5sQjUY01WEPOHtI0SuDcK2YIwS+mb
         EzSQ==
X-Gm-Message-State: AOAM530z1pCAcyCrWmeGC++EeA6WTl0t/0tUsT+bf5WBxjI58mPE+x2t
        5y9l5pUfHpz5oK3gbSkNfMI=
X-Google-Smtp-Source: ABdhPJyuY1o+Q3aKjzvFae2GBAhMeZowVNYUx51UPVYYK3j2Ij1h3uvIV/qCgFuL80R66Hl+dCgEew==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr19540289wrt.280.1616855086131;
        Sat, 27 Mar 2021 07:24:46 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id j9sm16161576wmi.24.2021.03.27.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 03/20] staging: rtl8723bs: added spaces around operators in a macro in include/hal_com.h
Date:   Sat, 27 Mar 2021 15:24:02 +0100
Message-Id: <20e455aef3b24a46dafe32a8bb46804f284e3c1e.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added spaces around operators in macro expression

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 55f9caee6610..a1e1b76b5d8a 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -180,7 +180,7 @@ enum rt_media_status {
 #define TX_SELE_NQ			BIT(2)		/*  Normal Queue */
 #define TX_SELE_EQ			BIT(3)		/*  Extern Queue */
 
-#define PageNum_128(_Len)		((u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0)))
+#define PageNum_128(_Len)		((u32)(((_Len) >> 7) + ((_Len) & 0x7F ? 1 : 0)))
 
 u8 rtw_hal_data_init(struct adapter *padapter);
 void rtw_hal_data_deinit(struct adapter *padapter);
-- 
2.20.1

