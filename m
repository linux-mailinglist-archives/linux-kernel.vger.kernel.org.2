Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFDF36FD15
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhD3O7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhD3O6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48313C061342
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so105669974ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMN4zuhUHvB3cXnh9Uh5ILIZdfR0r9cSa/aL/onWxjs=;
        b=M4so35V9e6pXbfA5i2+DQ4FzZ0sd0sCQtzTPA1x2FL94sf8Y16CTjHMBzIZsyEYPyr
         hiiq8+4ncAD/bN2OVT6mqmvchJumirbal5ANDQktGkchNDKo9qOZfWbSs6eK6X2BvyXu
         2f6hdjN2oZgf7mlBvH33veMWHvDNfWfesgl3i2gi9fceO5kKLYmx4KqKNYQoVricglmF
         Ek9hc6bTCzKjeZJ+9An7lik10uGlZKurLZxKb0QVTnpRIZ5KWmYVmDDKvQHYSDqAkgAx
         Ad15WfQpOdJViYgNyNUNSd7h6Zd1GeVY/5lr7ta1Gk/leLLXz0dzEGpsxJMymVjUbb80
         CrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMN4zuhUHvB3cXnh9Uh5ILIZdfR0r9cSa/aL/onWxjs=;
        b=XVjmpSvzl0y7WFwkNxO2tZMCLuLghe77OljbTbmLWKmu+gaE+wZlmCnlsqMyjiVhIB
         18xu8/N1B2oC0CVwEL283J10AtS7ZsJfNieCSrmtvK17wjD4mx9Xm7IL+rfbcIIG5SFK
         zo/VsGg7b80GCiUruoOssSpt8Xoc06HQduyXzzJ/f5YkPuH9ZSFoy8/u0MkORu9ncKEM
         6ZitXCpkYfNLhBtHMRXjNw0QvkXsc9sZLf3DABNcWEc6E7jPEbh5ABLDyluKcxMrDiOg
         EwokYrIkeer96rJ1K0ufjxt963eLv9lKyqjiReTci0GRs4rkTigt8ZOTYzGD9+rr66/v
         fbmQ==
X-Gm-Message-State: AOAM531HQHaUIP1qGC4nlrn6wBrVFJkxtEMvm4R6Xx+Yl+9J36nSxJGB
        6FzjUFIiTB6V93cgCTsOSh+1CAPjBPw=
X-Google-Smtp-Source: ABdhPJyCgdf1UNKS1T/v6bMP5wgdU1JKS/rGDVNAWPz6bCLMdDLtnxLqq+WqF1nh9W9j2KMOhYBpvg==
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr4729992ejc.2.1619794671844;
        Fri, 30 Apr 2021 07:57:51 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id e5sm2155884ejq.85.2021.04.30.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 27/43] staging: rtl8723bs: remove BTC_PRINT_F macro definition
Date:   Fri, 30 Apr 2021 16:56:49 +0200
Message-Id: <503423caee1cc2b7a8fe321e0efb546556f2887f.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT_F macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 36636ad62aac..9c9ad29870e2 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -115,7 +115,6 @@ extern u32 		GLBtcDbgType[];
 /*  The following is for dbgview print */
 #if DBG
 #else
-#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
 #endif
 
 struct btc_board_info {
-- 
2.20.1

