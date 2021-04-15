Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46636069A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhDOKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhDOKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:08:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c15so13773810wro.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggLldia6CekOvY/WIKEl4n4MVtuqBFto21z/p6tICc0=;
        b=Xy6W3Sc8SKGwsEPHocd8YFc66ryEpSeUQYGBv0gCYzk2Y1iuW2rDBZBVXObh5j/gWJ
         jcGEs+I08d/jxqFIcBd0pzjYwPtya83cuafr5jOLQddDPPk2cloiuW7jK8xo1bIds/aC
         s9c15+a8/RLwgYD+D3I9VQeYZCVlat94TtFnWEJdpwYJvk9BXEictvx1BmjT0qjwZJW/
         Y0Isau3VXG3ehvOmK6XKfYlB5FZ6RYW8f3B8DgFvmrMdnwByBZjdT8NDQhmw+C5sd6HE
         LXmFW8vzXQecaSp91Xrng9sZEcyQOiTPUq1bD1ySEzPu3zcvbcz01HQcHgduNOKm7Asy
         77fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggLldia6CekOvY/WIKEl4n4MVtuqBFto21z/p6tICc0=;
        b=Lo54bdOycDgkNbbfmfiD7zl0tSxR6ynXfooFGKFXl8FaPpgdsxO5OaIz6hk+ZlPCrG
         9MNXVIX76Se1g8c51rKKLDCvd+dqj3JxttGq/VEurzEKYKgE1q/tUgazUyW/iPkDDhFa
         +FB9xL55G6qCjqBvtMGdsUfIOMizfVomo9OwNPTEVtrtPPvE4wJwgHp19crEs6jkNBCm
         VNnEucPn7SQjiGSD15AZ+vtDnRIghiqIsruqnq4Wl58aZ41TnePlRyZm408pG3ichunK
         9D+gvsCXVuqQVSgP6YNw0AeCuWwF+cxITBw8RSiZQZVAM8ngnRQitUgkwa/F0OtJe3VE
         D/CQ==
X-Gm-Message-State: AOAM531ukCIiUM4nxN7qQGBZBYRw2ZtDWBThB0Yhks49/tlGPhlEEJFb
        eZGrvReN4lOmSsd71LKsfMcAQ01WU5Y=
X-Google-Smtp-Source: ABdhPJyniNcfSUS9tZjV3hpRH2Tnaw5KFZior4AifmoJmunogoiTE7Vjo+cpsZPGbMlOh6grLFNYWw==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr2495139wrm.427.1618481263456;
        Thu, 15 Apr 2021 03:07:43 -0700 (PDT)
Received: from agape ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id f6sm2151415wrt.19.2021.04.15.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:07:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8723bs: remove empty #ifdef block
Date:   Thu, 15 Apr 2021 12:07:24 +0200
Message-Id: <c2600c9a71d4e222963cbc600b2e703fe2b1289f.1618480688.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618480688.git.fabioaiuto83@gmail.com>
References: <cover.1618480688.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove #ifdef block left empty after DBG_871X_LEVEL
deletion.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index c767651e2134..d2bf444117b8 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -487,10 +487,6 @@ static int __init rtw_drv_entry(void)
 {
 	int ret;
 
-#ifdef BTCOEXVERSION
-#endif /*  BTCOEXVERSION */
-
-
 	ret = sdio_register_driver(&rtl8723bs_sdio_driver);
 	if (ret != 0)
 		rtw_ndev_notifier_unregister();
-- 
2.20.1

