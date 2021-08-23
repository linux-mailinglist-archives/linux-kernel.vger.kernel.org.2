Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CD3F4A40
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhHWMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhHWMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g138so10361447wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ie2LUKLvJAhCwfhxzRAdWNjRl3Humfcq+0FcV7sa3Y=;
        b=WzySwQycekqnCDlzSJwb1TqW7FIpgS3zAdjfyy9l/2QS36+VTiKFmSS9WLLDXl1+Qt
         0alreyYG8aa5bMLogGQXqJFl76+C44B54fr7a9JR8e1MV7YfUG+s9NgOzRJZwT9W/yOu
         FFx/vzCu9YF/5XPKhRhuMJazJdFA1xiqhDBZk7JIKhy8r6ErP/LYTANI0gjURwFZ6VDr
         Ec0aQgY3bgHB5yWjGLK5Jlh8HyygnST9Hg+DdaQ7G2O4bcjXMcnWAfjAfevxr2sJG5+h
         ArgbGJgPM9PypBk6ImpJicRmsh+awk0HH4LhqFpWjmOAe4GRDCN9swkkgnTLxZOR9uVj
         SWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ie2LUKLvJAhCwfhxzRAdWNjRl3Humfcq+0FcV7sa3Y=;
        b=skReHjO1WuIr65SOm0N1DfiaQPmPLehmTmD2ZJUJnV3I9i3ykUDf96TzOnw5HUWilY
         dppRS6WeA1ZLXaqKzZmljnGcz7X9Xf7tbCACYimvX0NsODdnm3KBvHzURHEAFF+8aYuC
         10tY9h2E1lAxIsHeiusXv0OhjVKsDShjNEtDIUuRvoX499ICiIYH6SsXNEfo9quDQLM7
         8cW9Z7fwwsScSTk0nD9IoFv1k/Pr6YfUJLZmDMP2EjO0ysBIQRGo0nQMztqwQHpViTVU
         hEnKSCmAlzKPr+qT1aMn+F1CmlV9JzD6roovwLrLM43gLK3QofiIP7dRp21CMexVkTW/
         3Efg==
X-Gm-Message-State: AOAM532lMY6zpmggSB+41uVLg2I1efZJ897Vaau3kBHM28eoGn+A9/u3
        ehkKPUfGjMydfmDovyUEgB4=
X-Google-Smtp-Source: ABdhPJyEf5urADYIU7VVIagTAr4fmlOdU1Jn2KdrvJvRPwx4PziGYIdDNhLJu6ArYKW/RGOw1t/idw==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr15791563wmc.75.1629720150218;
        Mon, 23 Aug 2021 05:02:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: r8188eu: use is_multicast_ether_addr in os_dep/recv_linux.c
Date:   Mon, 23 Aug 2021 14:01:06 +0200
Message-Id: <20210823120106.9633-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823120106.9633-1-straube.linux@gmail.com>
References: <20210823120106.9633-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom macro IS_MCAST, the
buffer is properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/recv_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index b4c5333bfff0..dd3113b6d4f3 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -132,7 +132,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 		struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-		int bmcast = IS_MCAST(pattrib->dst);
+		bool bmcast = is_multicast_ether_addr(pattrib->dst);
 
 		if (memcmp(pattrib->dst, myid(&padapter->eeprompriv),
 				 ETH_ALEN)) {
-- 
2.32.0

