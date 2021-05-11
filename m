Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE89379ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhEKE4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhEKE4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:56:31 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:55:16 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u16so17944341oiu.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RLdz6u4UkE2ox0kCKMtaXA0BkTZvZTJUFZWTFaO/60=;
        b=HFSTpV6uYJJcwU0bp/9dIyyynt36KXx1pZXUYOzN5F2N1IJdlG9Tkjle3fwrcJzaQt
         6SELkeiBIjG1VEQiEoWx03flCwpkLFl6XYa+kB9cr3RmylrL7I+raaAvUacS/Ya58dCK
         FqhrJvQ69ukLfYTIKWstAolzphllzhGYOs5z4Jni/i1zRsrQsE2YLqTLtIU+Jy7y+OpF
         byQRaaCxJk0P7rb3DDE/9AyH8IoKHnVWpVpkMKcEwvWWeola56OWBLvDNXWUAQN8CgC0
         geROxrhu7FLtrzfAd7OivDwikQKG3E2QSUrqDObGQcfFim5b9NxQF0sbPeQAj6i7vkRp
         YUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7RLdz6u4UkE2ox0kCKMtaXA0BkTZvZTJUFZWTFaO/60=;
        b=fAA1Ttcl9VF4fRIfg5E5oYp7AsY+lgUcsQfWyLU//SsZpDuwKnwuCDxiBrsGrJu7TX
         A5Jp2wTq/IZanLebsLe9Kpfib9GuDhkjRTFYq0rnJlpH3XwQ/GKvMbM9/mqUI8cE7V7d
         IctiMlBucipMUlKOhXqwVv9U2Czammnw7VFkKpfVsl9BVPGdrgpTYKABJqthDnVnGkmK
         i+W+9zBVKqfZ477E2JbZR7rfbTxORzp3qkYOFRXquTncXiEBUBp+Mb740hBGlloEyxCL
         I/qMq1iThYhlznBr3t4y7gjfJjX9zLvzhYpkMPgo1YkvDstW6NMisfBS/FV7dfWK0l+2
         BsLA==
X-Gm-Message-State: AOAM530vkWVGkPHmrsKuXRMrT9TqYJz2zbxDo+6MdYPMWtZNmDwtU2X/
        TLdKrltSVnCmRF8Pk8iCk8woToo1oug=
X-Google-Smtp-Source: ABdhPJx6ykgRM73heEg0WUBQEqE9QD+RXnS/Pc8TwcptyGmb/+wRuSPnjh9leYQoKot4vHSN2JXgpw==
X-Received: by 2002:aca:bac5:: with SMTP id k188mr2124485oif.99.1620708916399;
        Mon, 10 May 2021 21:55:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a23sm3648194otf.47.2021.05.10.21.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:55:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mei: Drop unnecessary NULL check after container_of
Date:   Mon, 10 May 2021 21:55:12 -0700
Message-Id: <20210511045512.2376580-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of container_of() operations is never NULL unless the embedded
element is the first element of the data structure, which is not the case
here. The NULL check is therefore unnecessary and misleading. Remove it.

This change was made automatically with the following Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/misc/mei/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 28937b6e7e0c..9001c45f6fc4 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -50,8 +50,6 @@ static int mei_open(struct inode *inode, struct file *file)
 	int err;
 
 	dev = container_of(inode->i_cdev, struct mei_device, cdev);
-	if (!dev)
-		return -ENODEV;
 
 	mutex_lock(&dev->device_lock);
 
-- 
2.25.1

