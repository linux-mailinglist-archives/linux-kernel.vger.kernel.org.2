Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8596401258
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhIFBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbhIFBCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95019C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so3659061wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k3O94BU/B6lxKQsYIiBmKyOBWMRvKAUVPDndT06yD0=;
        b=NFnoNcak6BMgalls+FznBghdZhdZRZUsLTI9Rs9bNnKBvLbSqeICYFoaRKcebnEl6f
         BvxmlyloXcghqprmfvxfBbdIDfnA/cvyotlPyzRiDAZEjQo5Mtzy0tOLOCIaJ3JZCO6j
         9N4b8hNM6s2JZOeOJ0NUnsoss9P/uWuuHwZVw/zL1OSDmzb/Vg0KMkIm7p09zl6W6e+m
         srAEYoBl4AbYeM+OQeoSiowQftm2AhBbtr6MYXbzkrEk8+Lt0pBcUk5+vGkPRCypHwxW
         gUS7SZQr/5NGR4KU2veky+ZD+t0sRnjXcOqBreIx9QCRLrgtoH1F7JLHhxvUvpLFN/TM
         SMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k3O94BU/B6lxKQsYIiBmKyOBWMRvKAUVPDndT06yD0=;
        b=I9Kn7+o9p9z8V3Nbc/Cxbikms7g8iKSzxf51KHV+GRqtYGoXLlb/Po2XfaXqhEPQdy
         jwcgycJYD4td/ei7fqugpJ76BQMTz/pkdlxFMN2cgV77zdlHweJ3xX21Jaw4n78o0b7A
         L/+MUe8Uv/F/Z7LqV4ChoBx/LbpDzdA/P/WQWeyzddOAbLXRHHH+Q8DqtumBoYEfwoRF
         ngW3eCWsvRaRVH/abkoxN1Z66mZn/RyclOaBi0aRv7L7EtVRts1uEMEfV0LA+qWIE7iS
         azyaPasfWQkgtCbVPkcmNKCYCmhjaFYroz2UiVPnCcsM5s76i+GL81QRsCawpmAZamXU
         WsXw==
X-Gm-Message-State: AOAM532bSR4ORAb3Og7IqDRKWpGx6uG231padubN7p6SGvTkeDdWaBsk
        dW38PmZgiwonUrLaCb9vTRAzobANXbwaRw==
X-Google-Smtp-Source: ABdhPJzXfs62SXQ0/tygdLtk+R/Vy0uF+6ITClv+0JG1uh9x7XEbWWB2eK1/tXQWatGWrOzr5Wybgw==
X-Received: by 2002:a05:600c:3588:: with SMTP id p8mr8878608wmq.0.1630890080194;
        Sun, 05 Sep 2021 18:01:20 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:19 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 14/14] staging: r8188eu: remove c2h_id_filter_ccx from struct hal_ops
Date:   Mon,  6 Sep 2021 02:01:06 +0100
Message-Id: <20210906010106.898-15-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove c2h_id_filter_ccx function pointer from struct hal_ops, as it
is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 6deecbbc284d..efc2d9955efb 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -242,7 +242,6 @@ struct hal_ops {
 				  u32 bndy_cnt);
 
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
-	c2h_id_filter c2h_id_filter_ccx;
 };
 
 #define RF_CHANGE_BY_INIT	0
-- 
2.31.1

