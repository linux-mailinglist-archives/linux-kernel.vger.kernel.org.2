Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83585354145
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhDEKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhDEKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71704C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:34 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o19so5232937qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BNJNsxcggvnnlUcExUgDHrQ6Gk5ZBZmiaHtJzUwTJo=;
        b=JMF/IVQuD15Y/ZzO1wl++S0SUxcbz84YpOkwqClD1wTA3uetz4zggosUy+WoOhrz9L
         b7jLAAhH5LWjVpClGvxQ0YHQS7oy7QP0E9XdS59qvzU0OHWv/71Z//lI4jADB+vwKY4B
         KjZwG3dWVOq/fkmDRL/rexwRBZ1zHCeiD9Eg7h0T9TjBX5UBCbbKtNzhHv29LGrLEEVz
         /NZhN8Zz3SaSB+9jjgv3KbxLacezfAoNI5zWzJ9EJmV7epK5bLSn6AKbwZ6T9V0YeQhO
         RCm9fCInJpsJEWW+FVpDtycThCh9g00Fm8NqzNFA0Dhqt5kghBmsjpZVehK57sr2mc5m
         JybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BNJNsxcggvnnlUcExUgDHrQ6Gk5ZBZmiaHtJzUwTJo=;
        b=NXXTIkbKMAbIkgNBttovzZ3adQaMGXiBCn/N5KUPdy+h91TQm39+4PG/zwePBio47y
         1qHb3Zj5urcYnJgzn1kVArwKOm6Y16iCH/CZ6xhoqx3RQJkR3fFXy8DYlwAxJ5ul0g4B
         uaSYCc6eB6oBX3Rbdvw47L2Qw+lY8ghA6RWcVEqe64JJnxL1VS3qaJKmXAffzNmguYJC
         fOn+CLh2taSTJkZKNtGfq28K7bAiFuVXJcFDuqQwYFSrE50WZCBsPgs0ItExsMUkR2on
         tARPEOa4u4KuK/C7DSrh5bfjf2pSEceGmSEXKdG4sNf+lyhipqS7i3lu1O57hJXc4hcL
         pvjg==
X-Gm-Message-State: AOAM5321ZMIHAKzu3tblEr6CR+j+FxTmU5kF3i5R92BUjuviAYRkSNjo
        27ZoMHg9QKdv+LnM72mCm9Q=
X-Google-Smtp-Source: ABdhPJzZtuiWU2tvD+DRXM1E9S1MhGMc0LcVIV9wWjx5kATxsTTyar9jgDyOG16p5UluQDqdzDQcBg==
X-Received: by 2002:a0c:ea8b:: with SMTP id d11mr3602398qvp.49.1617619773722;
        Mon, 05 Apr 2021 03:49:33 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:33 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 4/9] w1: ds2438: fixed a coding style issue in vad_read
Date:   Mon,  5 Apr 2021 07:50:04 -0300
Message-Id: <20210405105009.420924-5-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index eca50cec304f..eeb593294fbd 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -359,9 +359,9 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

