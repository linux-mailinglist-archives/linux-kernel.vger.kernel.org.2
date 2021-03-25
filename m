Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E434883F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 06:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYFL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 01:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYFLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:11:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE048C06174A;
        Wed, 24 Mar 2021 22:11:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q26so665040qkm.6;
        Wed, 24 Mar 2021 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGf+dE7GQDA/q97rbo/pU30+TTPhkjhLne7muyW7Be4=;
        b=kCaMYagqmf6cvSo7H9RVTi2CIPRgYneyJfFyVXUfYFY9kGHMhC4GDIcuzDIjG2I5CT
         shOIoRPhPggUBohwEdtZRKmiKPp1aI5Dqe8CgllmjHd4qSKpCSLLWdgireBTvPqFPuKP
         R28hcKO+SYZx+9HPNoW1Bge7bV2wYIHmMfdFbn+pntTZE1zH8j9MAv8+08hRz0iRojLR
         /7ylFajEOsWgUBWjoKGcDaROr7TgjAZn2AU/mJRB6FBQ7GRp5otXheVySnm0zmLojdjv
         SX5mA+LVWf94JEAwTVa9j/N8WtRNimfugtdT4+vhGlpj3WP7EaE2yPql15tJLquPgnNz
         PYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGf+dE7GQDA/q97rbo/pU30+TTPhkjhLne7muyW7Be4=;
        b=LGsmmbZMQS82P0odAq0hxSrc2xsSyBMzH40H1nPO8qLxHJ6DRLBKYmLRf7ct19Qqme
         Uy0DJPPdifZImyfWBbwq4tdnTNWp/BwlTdwbOi/xwvhI6o4Dtzl/ejPLLJjCmusYvDCj
         vVFxubsmkybR5QolqvRyzDHHvZZNaA/P3HW+hsU34EOboWeeiLATBaPR1NcNEJpflYb3
         Jaa7deQiYm+su1FyRZGGtGTH18wCm2nHFv3omTwzrqDN5Bi2mTbhaD3i8mIBZ4Cb3xDr
         t+qxcxQicXN5U/Ybfb/x2zmXs5Wc8VAhfD2ONaLZui3NxGb4O1uDeOByDjVO3RWss/3W
         znZA==
X-Gm-Message-State: AOAM533+ZrnkoWsqZh8IdEVbALHNhM+SXx6oqmBfuIOR8SssWLknxIwQ
        gc9vgcSd6uCUbQyaTgic8snmFvA7qdlRgMPJ
X-Google-Smtp-Source: ABdhPJyLl9mA+WPApFiVI/wV81903QfIR1lqJgahu50ViLn48/toUxzc3uMjlfNnQrgySWeSmjNtnQ==
X-Received: by 2002:a37:9fd2:: with SMTP id i201mr6227260qke.435.1616649069097;
        Wed, 24 Mar 2021 22:11:09 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.176])
        by smtp.gmail.com with ESMTPSA id s13sm3433913qkg.17.2021.03.24.22.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 22:11:08 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, linux@roeck-us.net, abhilash.k.v@intel.com,
        mrana@codeaurora.org, lee.jones@linaro.org, bberg@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] usb: typec: Fix a typo
Date:   Thu, 25 Mar 2021 10:40:23 +0530
Message-Id: <20210325051023.27914-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/Acknowlege/Acknowledge/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 244270755ae6..282c3c825c13 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -63,7 +63,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	u16 error;
 	int ret;

-	/* Acknowlege the command that failed */
+	/* Acknowledge the command that failed */
 	ret = ucsi_acknowledge_command(ucsi);
 	if (ret)
 		return ret;
--
2.30.1

