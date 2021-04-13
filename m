Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B3F35E112
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbhDMOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346280AbhDMOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:11:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0501C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c15so7670376wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzC9o1o0ixYi6KaDWY1ROlCOIjizjCzFaIisDwi93jA=;
        b=AjqC7NnTumKdnkqksajoC/+27I/jmvb7CpNcND4yph3S5YRl6lbeHqJGwfRnWlkg0J
         n7TLfUoFQgxmk0b11WnhKOA/rl3FFraAdVB/5ODdBanIC3Q15Cigisng0l9zyfmzHAn3
         EQnlzex9vvupi7kYneX2grW6QNVldg7a8HOPygECvDQ2LCwYJVTF6bu20KNWom2XVhO9
         WW3cdIXWRoVLZ30HrBM0jJ6IE/VXHDxHMnclcJFva1I6V1pF4CFj0lX9uOY+4kNtX8bj
         hZ+PzamVXRcblDa8cjFroUsfo0G5jiMbPN04eI/qcrQ4eIJw8/7QBEoBJcNp7a5Bu29D
         f3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzC9o1o0ixYi6KaDWY1ROlCOIjizjCzFaIisDwi93jA=;
        b=N1U7UV+SnwVFex163g/F0EbOcN8pVPX1FCXgUJw8mJYu4D3cNqRmoTz59+oTcagbAO
         CfnFw7MytLz2YuORq/l+rORHDPuWnTWoRtXVF9+6ZjZ8E+R8irTR7KJ1rcamVp6v2oAL
         a24AyWLEdtVbX1AldvTb2X5CJ30Vf7Rh/YxP2DhdKoYw51psTbUARqbIzZDwyotdJbaF
         l6XmQGBbAmLc34+qYO6L12MMATCjFTDzhvNxr7nIPUty+yW07GLGmfSiVJEjl7aQYs4b
         qPpJGPzWLJ2SvdYfTeQhvbFdI8BH7G9ltlcbDvbOV5UgPTr5EkJaqRg25Ohu7eQnWtRG
         1D2w==
X-Gm-Message-State: AOAM532/1SNYObGK0LkZ+1LlnQ1gPCwtbCPBjkeMfsSBderM7/AiCnHB
        rZO6e/4NIOxUoRde0d07Ek9Qm1JKDVr0/A==
X-Google-Smtp-Source: ABdhPJwh491G5m7V9l1l4klrj8KgHm55jZ0xL2TlOTb8oMz+Bl5QvQlPr1gBzfZRjF7CKIj2EgH/fQ==
X-Received: by 2002:adf:f844:: with SMTP id d4mr19224032wrq.203.1618323055321;
        Tue, 13 Apr 2021 07:10:55 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id t20sm2484713wmi.35.2021.04.13.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:10:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: rtl8723bs: remove DBG_871X_SEL_NL macro declaration
Date:   Tue, 13 Apr 2021 16:10:41 +0200
Message-Id: <412587ee7cc21572b68af564dc58f738aee2338d.1618322367.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618322367.git.fabioaiuto83@gmail.com>
References: <cover.1618322367.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DBG_871X_SEL_NL obsolete macro declaration.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index f1b37d511f27..12873c3d801d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -181,15 +181,6 @@
 			seq_printf(sel, fmt, ##arg);			\
 	} while (0)
 
-/* dump message to selected 'stream' with driver-defined prefix */
-#define DBG_871X_SEL_NL(sel, fmt, arg...)				\
-	do {								\
-		if (sel == RTW_DBGDUMP)					\
-			DBG_871X_LEVEL(_drv_always_, fmt, ##arg);	\
-		else							\
-			seq_printf(sel, fmt, ##arg);			\
-	} while (0)
-
 #endif /* defined(_dbgdump) */
 
 void sd_f0_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

