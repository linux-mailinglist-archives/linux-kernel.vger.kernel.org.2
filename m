Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC62460A85
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 23:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbhK1WHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 17:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhK1WFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 17:05:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 14:02:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p8so17260640ljo.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+0z1JT9bKKctcsBbD+srLOTYQSXdtRRpNVoh1cwlsM=;
        b=NdIdxuvj0KpKsNTFvKDZndbsQkZ9gSmbJJap9cgvr+zd/AnKGdQj/iSLeLb+AJWAjn
         s6kIp2kitjpx9Zeeaohz3+PZOt2KLleQ0DutQRjkVnjw9UAYd0KGU+FA6s51fyH0USxV
         YtMslR6OpdxomoN7uQ5GMtxzwMx+CJpLtrPz2b3r7O6/gtJK6z0jQplqDWiZR8eWBd/+
         vJiUOS3yUTfC/UIqY8BU5yLUBxsKUon/GAcXwCQTqj9PQqvsmev9RDNan9la5UwZoqvc
         mnc4ksR+cA9OM9+8fNsI3RmrjkC5MMwKWzoOxckyYtEEG1h47tTLDpWDLns1QfFfiZNj
         QlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+0z1JT9bKKctcsBbD+srLOTYQSXdtRRpNVoh1cwlsM=;
        b=ltd8PfvHUtWTkQ3ch+hBleUB1SWT1NSXcF5ymvYyGz74tWuoPPHqSFZa05ebPm1BVB
         mhhIS9zFrW3k6Io1MvKh0h1/4bWWgUfn7lfI7Q80D9WPAek3RDRYESblIbeKuQpgAFKp
         z9HyfClmYQglGt746x7exevd23QO4wawvsJ/5NDPiNWGML8Bic3kflwle3RWwlUiOg8R
         7jdpdEwxKlFV6POZb/DH5BM5H68emlmvhbzbakZWi8LwKYSZcU4yR6dC5Ya1mGQmwSci
         p9HXy4qwOEw5qoo+TjVNPWViCjMRIpxPNVJUzxbTvl11MQSSg8Wf88oBOtGmh7vApIVe
         hYoA==
X-Gm-Message-State: AOAM532Uavjf+GlhJPNl96bov4//HrUsbn/aM1TOUlcRkXgxJcKTnWAZ
        SuICYBik/h1984RAe5ErJjI=
X-Google-Smtp-Source: ABdhPJy7K9xBRKsvusQ7WYLH310djPG2l2WFr9GIeEfRJAKkzNtjQjw6FL0mnie0K1E/8FWzH8A6hA==
X-Received: by 2002:a2e:740b:: with SMTP id p11mr46101046ljc.215.1638136920412;
        Sun, 28 Nov 2021 14:02:00 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id t8sm1114785lfk.159.2021.11.28.14.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 14:01:59 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ipmi/watchdog: Constify ident
Date:   Sun, 28 Nov 2021 23:01:54 +0100
Message-Id: <20211128220154.32927-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ident is not modified and can be made const to allow the compiler to put
it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 883b4a341012..0604abdd249a 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -668,7 +668,7 @@ static int ipmi_heartbeat(void)
 	return rv;
 }
 
-static struct watchdog_info ident = {
+static const struct watchdog_info ident = {
 	.options	= 0,	/* WDIOF_SETTIMEOUT, */
 	.firmware_version = 1,
 	.identity	= "IPMI"
-- 
2.34.1

