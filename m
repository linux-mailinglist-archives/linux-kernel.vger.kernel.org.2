Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906543531E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhDCBYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhDCBYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:16 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B18C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y12so4753686qtx.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BNJNsxcggvnnlUcExUgDHrQ6Gk5ZBZmiaHtJzUwTJo=;
        b=THbes+nw2CCQbHZqVJ813qTOmG717AlieMkD546e1SJy2c5m09JyIwk98R/f2ImRbl
         nw8FItwuQyjmTAX3PHGMSJwhvhjsgYORPgNgN7afsPHiZVid2j/ugR7CB8SzDll1+H3G
         lTHxIakEVlZvhWg9gT4j2VFlPeIUSrJxR60jl75FXAEjRSBBNxAJDGu4kjyBIobzn0/+
         RgGSGKBE6TZnldxGk5nasa3eTQAyTQzp/kdr4GH81r0gwl2GIIS34bg5l2GKLsCZLGue
         EF6DcnIW+14PDzrgImweZQE137k9CB8AH3w77BBdXZmchyKqkX7kxXfiBmQBU/kfkyJJ
         mttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BNJNsxcggvnnlUcExUgDHrQ6Gk5ZBZmiaHtJzUwTJo=;
        b=f1pTEob00ul9D+O6qJopGgOIcZCGVmKMqX/dYr9vOodmaz79Wsb1uTA+7UTRnssu7o
         mClrg3hrcFn8bK6MtYuq3kJW8tNaoS5ruLGQWCKS4LNHk0lQCMgmei7TV9lp4xGujklj
         9UvAQmAW046InZAi42ePHpV4IWs4/CKAc/b4rdVDKAbNqP+5NyRtYJT6gXUEadDXuWmg
         ofNWMw2TC+JTufNM7z8BddhRlbFh2TS8H2F8DMh0rDusFJYNdbD7iLXHzAiOinGWCPxU
         7nm+U4nYcx8muuskPT6PJhepy4gouV7fy0TMKkrUGxgZxdGQ1A2fUDe/jp3VWcatFxrh
         8BXg==
X-Gm-Message-State: AOAM530yyPOT6+P56nK9iUvdzjJfov3C2ZC9SpNxRg4yRJ7toqEPdZcH
        bf1I0R3IvlUD6I+ClNEOMf2urbMwwvjqLLXV
X-Google-Smtp-Source: ABdhPJy78sIogS7ujW+Dac8aYqb5us5aHQ3lSh+I7OzVkmZt1XuGDCaX7VpTmeT9Z6L2DplHIppCNA==
X-Received: by 2002:ac8:4903:: with SMTP id e3mr13607225qtq.16.1617413052366;
        Fri, 02 Apr 2021 18:24:12 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:12 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 4/9] w1: ds2438: fixed a coding style issue
Date:   Fri,  2 Apr 2021 22:24:41 -0300
Message-Id: <20210403012446.381516-5-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
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

