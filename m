Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B403F3B0479
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhFVMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhFVMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A579C061283
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e22so19887459wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNOemOTras9F985BUt7jkfUSz/FQKfSLHckmy+4u2+Q=;
        b=md9URWQfYhzAQTs7BYUAnfuxfNGRiN53UUQ/YA2W9aitulTBiv8NN4mQlQhd5At3rs
         oaHzBlzJp4INtOR4hSDVNS73nct0M0bYd6+HwQPoL1FVEfm93HgIsgjqmc8evn2X5XOH
         HFzYg+dGt6K9YReAe43WstwlsWvN0TBbRJmy10m5jbPPpT2jmLHekhgBCu50mMYLloVK
         X6MSQcKqxTR4pTI5AAUfRCAsu9WGYmI2jGoq8CyRr/E6WfGPgSdSbZWR+ujLV/CKKOwY
         volAOKsjEYI717R6K3Ch7M798cdE2NgsEyP/5UXVb+wG9OQwlIG8ujf/vsxBN+08PnDK
         UhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNOemOTras9F985BUt7jkfUSz/FQKfSLHckmy+4u2+Q=;
        b=REYOINfvYxMilI0jwyxkvvIAPQP/+JVJy7XxBroQ/mU5kUvNtwj8sdWAsSiPN4a9G3
         AUAgiC4gdFLCdoS/SzYfLhEenhAnPvXgWERn+kVbX+FzLntJtxlj8Lree2TEQLsEfOou
         tJdEiHNyYnw4y+91ocbSDRA0dtcnNMMGAXQWB/kRyQa89xM4SNRljloPT1IrYHULGF5O
         8IDtK7pyUBO4Sq3bhlkno//Q6sWzys6YoHSs8xmKzQR4P1JFlX1jazGbg+dF3dIIz1Mq
         uK5dmLUEahyeXIPSmmd2xaJXKu+t85gpWE0d2MLUUNVndS2SD8SmxnO4CxceaQDuSpkd
         ZaJw==
X-Gm-Message-State: AOAM530WPTqawTwEORVFJIF8uOQflQ2alkO4jk02YMyMrI6ekGy3KfZz
        PM+seCgdW5FC0nfpchUS9tNXoBSLZ2oZlQ==
X-Google-Smtp-Source: ABdhPJzNQ4Gl5Z3wur+aWLx0vtZrsxh8ujxdDjR8m61DMLQ43MHn20VbthpJGAwyMO6FxsWj4GKpQg==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr4401630wru.88.1624365007782;
        Tue, 22 Jun 2021 05:30:07 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id e12sm20920883wrw.34.2021.06.22.05.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:30:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/17] staging: rtl8723bs: fix check allowing 5Ghz settings
Date:   Tue, 22 Jun 2021 14:29:41 +0200
Message-Id: <f18b7f00357b4919cdc8183be18427632c16ce77.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix check allowing 5Ghz settings, only disabled and
2.4Ghz enabled states are allowed. Fix comment
accordingly.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index afefc2c8a2ac..e73fb13f8968 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2572,10 +2572,9 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x12: /* set rx_stbc */
 				{
 					struct registry_priv *pregpriv = &padapter->registrypriv;
-					/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
-					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-					if (extra_arg == 0 || extra_arg == 1 ||
-					    extra_arg == 2 || extra_arg == 3)
+					/*  0: disable, bit(0):enable 2.4g */
+					/* default is set to enable 2.4GHZ */
+					if (extra_arg == 0 || extra_arg == 1)
 						pregpriv->rx_stbc = extra_arg;
 				}
 				break;
-- 
2.20.1

