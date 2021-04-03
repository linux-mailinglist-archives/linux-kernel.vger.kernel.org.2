Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1429535329B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhDCErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhDCErr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D6C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f12so4960854qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BNJNsxcggvnnlUcExUgDHrQ6Gk5ZBZmiaHtJzUwTJo=;
        b=F18b/MBEfZR8g2KcwKCMoZfnb3HDl9wwUwSSmyItMtfkMrxTwO598vPseMtEMrI2Ue
         eHtZRCy+77QHDrJj4of9JO96GoFcfj7W2HKgjTghDiAj65BD5bgUfzhGpYyr5lYHc2lj
         Qh7XUcvU9rLZnY2kQdCuEOjoOPUjko9LgZ4nVKwWJxpQBOsOpFfp+PEf/O3ZSrJMQd9q
         jWTuC2AAHqrvaXxjj7oTTXyPSq1kFQZaxVVsy/M6sRxjmd7mymVsHyUs3t7582BNWT+f
         zmrS9jpPk7GjjBZkqNbmEBHG8/4CefFgfySomSyZaYpij3lAHxbo2SoQhBlLb2FJGJ9q
         vR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BNJNsxcggvnnlUcExUgDHrQ6Gk5ZBZmiaHtJzUwTJo=;
        b=jOIB/UU6eN3V/lPgLI5tudR+YVweRJeT6MBnP031Ene9sRBL5XbvuwUVt5b56TRCaP
         VO5HNpIK7WIWIscrkPEEF++7AWuykoeuiW6sOvVlvHeUO6nczA14365T+nDSkgEQKbot
         FeeUqORg3ZBN6i/gC1vUREX5+Fs8SnuDLUg2O8e2QmbXxYB7w+nho+7FZ7XXPDb1D5q7
         XvJy9AnHjdeAvfodmEQCSpj/X37l6sfSkxsr0cB8eLLsaq4RCnSJt2aH8GSQPM0oW6Ad
         Khy7ju2xDUEIDxRBq90w1D4cwwxs0hNBLk16bvGmQJGjqXk4GZGiFIwTmNIBMzuxfCOT
         kkAw==
X-Gm-Message-State: AOAM532kLD6ivFl7SqlduRyDnYnlL1fFcypVPdelx/y68oFbpbbh3noH
        GLpoxWIlkC8jJ70orjxBbog=
X-Google-Smtp-Source: ABdhPJw1gMz6R6IhLp//txeL9wtV1xDQ2YQPGKKZbpZU5UgTAHuwGHaBPAHb+nbUCXiW4QfMVXZLtA==
X-Received: by 2002:ac8:744e:: with SMTP id h14mr14199069qtr.383.1617425264315;
        Fri, 02 Apr 2021 21:47:44 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:44 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 4/9] w1: ds2438: fixed a coding style issue
Date:   Sat,  3 Apr 2021 01:48:16 -0300
Message-Id: <20210403044821.390485-4-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
 <20210403044821.390485-1-sampaio.ime@gmail.com>
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

