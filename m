Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B123E86BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhHJXve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhHJXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6182C06179B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso3130554wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vH97/uCd+lf2pt7Za/zqAhi1/nCsR1Usl1LMbLR/fU=;
        b=C/9R/2Zqdotfvk8edzl9VTuojRPObLLxvQs+pWnpFbL8zb5hOgDBgg4bLxAOsMY9Qk
         LBv5axnGw/RSLAtzO3MVjF5LT+Tw6cwvqrut3wANNWtU0dvbyjcp8MHiNmxist8a7Va7
         LiyTVYu/hmMh9moyJNPzpuXRB7/titM1GfkXFByV8dMqMBhO0nxvOLbzJGBJpFVER7R2
         hkpTOU0r6xEk3EzdsRzBEJ8GFUfkR5HVfqDE5wK/YUQhGbyyOSRlkfzxhWPuOI7qQbW3
         d7+9G2IbvFOawl5RGB7wwGiVtL+Xoma07RrzJu4YCHxten9oSfx2ZkFT737pAISd2X7K
         spTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vH97/uCd+lf2pt7Za/zqAhi1/nCsR1Usl1LMbLR/fU=;
        b=DXa9urTtXS+ZyT/BSKMH8BpsndMZOgO0Aqy7/gf7sQKjQyMLJV+agvgi08JqkM2/g3
         30miA+Km+6s4k+kUzb0m5Dyp2Jz7fELnP0KVGRZWAvfM6i892SrxcoNiRg9PM4QOEWNV
         W1GLvqzv1Bww4WsnHlGq4w4aDD4JJ59fEy6zQiqm10RYZWZosofwkPdqSSLfhZIKu9jL
         o35ZLygMk6vfqsFr6hYcFP/LC3T9QzSPDkIw0XRFvOqWmuyBbL02R+/7Dq56PqRZTYT8
         BglpooCrwaZoXADTfndRbA0P1bV2L7nnKdo7X+bHThErE3m5t9AGEXo4GBVqlLqkgjLa
         2Nkw==
X-Gm-Message-State: AOAM530PyMeuLIcpRF3O2yT40+jSxtZp/nEWRBmXn+fTVMLpXLCT9CHJ
        WIyph3IC1mT8ys9YfFKrud/33A==
X-Google-Smtp-Source: ABdhPJxnzVytmkauOXAhM+QlQVMFffIABzlzCVUSxpZSyTtKRQ7R7+x+pUA33PgF1QizONYAbOkByQ==
X-Received: by 2002:a1c:8093:: with SMTP id b141mr19189469wmd.177.1628639454510;
        Tue, 10 Aug 2021 16:50:54 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:53 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: r8188eu: remove unused variable from rtw_init_recv_timer
Date:   Wed, 11 Aug 2021 00:50:46 +0100
Message-Id: <20210810235047.177883-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable from rtw_init_recv_timer function in
os_dep/recv_linux.c

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/recv_linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index e0fbc5751391..74d76b2baebb 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -211,7 +211,5 @@ static void _rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
 
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
 {
-	struct adapter *padapter = preorder_ctrl->padapter;
-
 	timer_setup(&preorder_ctrl->reordering_ctrl_timer, _rtw_reordering_ctrl_timeout_handler, 0);
 }
-- 
2.31.1

