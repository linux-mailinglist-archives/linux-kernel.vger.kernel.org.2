Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4055A3DF834
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhHCXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhHCXFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3515C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so349012wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCO0LwScrHHjGKpotTmWANPpGoELMy6/oBIbIpif3kc=;
        b=BltfUQ8uH1+zMi9e7ao1SXmhNWFI6lTUjxo7bK1Q8thLw73wc5dzgPupf0BmHJVulo
         uUxcqfl0Jc3rJ3lqQIKokHxed2+DCHYqpFet7XxclEfWPws+ywiTPiB8AB3LioJue1xk
         L9dYtjsaPQXTQ3LfKy0yrNPfEovnmPX3sxGE3zfgwhH4/7NC+LHX4JbUWvLXOkCAeGAn
         9q+VErnnYrOoPwmFBJzgzdfAfJ+jAeJ8SgHt0kMgjHj0i/1N3SlyzsxM9m1y0W66RRcY
         Gq/RShr0FJ1QxbyUa1JsLY2JuaWc0oy9u+8jxo9H5lEEjCNUiGRsCeE+iotbBMYRCNey
         zWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCO0LwScrHHjGKpotTmWANPpGoELMy6/oBIbIpif3kc=;
        b=aEwekD4fPLNfGRl/VR3Su56h0LE7PqkDtJBt3t6ifmeDV2xHzCHY6p278NuMqcYDIy
         h7bK/wtHoCVklGpsvkzQvlqOxJNXP2DmsEVBFCZB649JByZS1s2t2xMNeKbKrO+PDs6X
         oRjgsaBJtKut2wpFC4gz/fxJNky1NTMiIXShnPnZU5u5vUGTYiN5QKOgD1XTMahbkfg7
         IrlVZbqiMg5lUczfnFQnP2u6B16rNaioJ7A2hEI4QgJfJulEbfshFP5ZMC5CA700FomR
         B8caRyvBD6AoKnpnbp3e99yqAVJvSJGXQIKazY3TCBdV/AXDC8Y8glXiHsFKJ8qW3a4p
         mRMA==
X-Gm-Message-State: AOAM531zqinpUu/v8ycwsOsfADmlxodDE/Aef3FaJ0aPkx+/7U+gC11T
        NF2VXZyWkIQumhn+AdyKlswSOQ==
X-Google-Smtp-Source: ABdhPJwsCSA/Bg15S8TCOpLuAvSjxZYis9z8vRyH+N5P0fUjHTyvOhBCstHCdPp/ujj26c4bJBhx/w==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr6524118wmc.102.1628031940583;
        Tue, 03 Aug 2021 16:05:40 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:40 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: r8188eu: remove RT_TRACE calls from hal/hal_intf.c
Date:   Wed,  4 Aug 2021 00:05:31 +0100
Message-Id: <20210803230535.74254-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/hal_intf.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/hal_intf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 1d813b6c3678..57819705da76 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -88,9 +88,6 @@ uint	 rtw_hal_init(struct adapter *adapt)
 		DBG_88E("rtw_hal_init: hal__init fail\n");
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_err_,
-		 ("-rtl871x_hal_init:status=0x%x\n", status));
-
 	return status;
 }
 
-- 
2.31.1

