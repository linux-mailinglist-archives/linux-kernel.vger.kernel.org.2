Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9B35FA86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbhDNSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352182AbhDNSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30555C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id x12so12034699ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyv+iRJLEcjbZd/LhEPn8OpiX7PAY3puKqYKPby0/Lk=;
        b=bzPA/e5rxcRDwYB4W/RKUS7MdXft/jZBjQHvDR4BNbzy2iIfbD4C++piw+mlIe4vCZ
         2Xi434xHZRLkWYl2lTtcA6zRdWHTa6y48dCBmapVWZeC74b9BJR9ixLW2sqI3Pi12IBE
         CVYxRIvN5s4KxplTxNMCG+ajW9+h6wRpDvTKnrZsw5/78mJ4FWmmrMuYrGFV7Giuk+SG
         HbE4y0cA9qoPRB10UP/b4FzikEEHIVRzSkJyPIix4/ZJKeErxLAXYkr4WX4nDa+MPNxA
         y5PQKFBar4Zrfq1aqPm2fquDF2fX+qPZhf1llbXGiNvvKc+apRvVEGEHNNR+xcBp1jyM
         rWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyv+iRJLEcjbZd/LhEPn8OpiX7PAY3puKqYKPby0/Lk=;
        b=ZHnzA6d+OAHDQjKSYspIzSwtknR207x7bJ+/36nOrYKWCyJ4RR2RLCCAMvvFYWtIgW
         sEwzfeDApQvKYjYP7hngWgy/vniPVtkwjUa69tvrnotwape5F28NkSKHD7fBwFmEede+
         kzS3gudlakZqPwPSMb6u4DuYrGiVO1t2SygF9l+fnGUAkmvBBDzp/MmMyxqnbXFgbw+2
         gYAny8GC9ZtfHPAs7Jucoy6FShByCdQAEyv65dkIv1T//IikrMiKYrGdQJr0bdF8wfyl
         a6QyyQQmYw+05wZzdU03nnaUtBS/ks8UZs/wGIKLE02g66Gl0D1bLkjLQgPAKHxd9UUc
         5AsA==
X-Gm-Message-State: AOAM531I2nJu7K8xs1oYdRoZ8np4ulUubX5BgyYdMrOuMMUSUO4gC1m4
        env7v7GC5NB0tmcPQZSVePkwfg==
X-Google-Smtp-Source: ABdhPJzWU45QwP6Lt+RjOuvBVG+9W1IN10pzBUcN2fub7X8rSe7o0vKyauEjD+VDKsua3PTkjKwBgg==
X-Received: by 2002:a17:906:d555:: with SMTP id cr21mr189857ejc.66.1618423921972;
        Wed, 14 Apr 2021 11:12:01 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        linux-staging@lists.linux.dev
Subject: [PATCH 26/57] staging: most: net: Fix some kernel-doc formatting issues
Date:   Wed, 14 Apr 2021 19:10:58 +0100
Message-Id: <20210414181129.1628598-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/most/net/net.c:548: warning: Function parameter or member 'iface' not described in 'on_netinfo'
 drivers/staging/most/net/net.c:548: warning: Function parameter or member 'link_stat' not described in 'on_netinfo'
 drivers/staging/most/net/net.c:548: warning: Function parameter or member 'mac_addr' not described in 'on_netinfo'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/most/net/net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index f125bb6da406f..a5fd14246046e 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -539,9 +539,9 @@ static void __exit most_net_exit(void)
 
 /**
  * on_netinfo - callback for HDM to be informed about HW's MAC
- * @param iface - most interface instance
- * @param link_stat - link status
- * @param mac_addr - MAC address
+ * @iface: most interface instance
+ * @link_stat: link status
+ * @mac_addr: MAC address
  */
 static void on_netinfo(struct most_interface *iface,
 		       unsigned char link_stat, unsigned char *mac_addr)
-- 
2.27.0

