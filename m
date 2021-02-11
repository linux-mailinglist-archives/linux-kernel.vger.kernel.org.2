Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B06319328
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBKTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:33:12 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A01C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:32:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id j12so4309380pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHG55bobZvUkJrIVKEFe5OS7Zmw/0/Q73OMR8fPHjoo=;
        b=bZqAgMtkJcqTDxpPaQyQrgxoNw6KaB5AA7+y2TO2tDXW8HP8btnSqrI8NGTaNynudx
         /foDkhJJqw3verKGvpdhSeMK0DCECV8Q8/gRg2Gkeife19zdTtw0eRuJqzgXYpOoBti5
         ZG3b23818AAVz2bqLLWNi4PXAtzYWdXFi2JXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHG55bobZvUkJrIVKEFe5OS7Zmw/0/Q73OMR8fPHjoo=;
        b=Ncpwgqpe9DZoW8wo9o8mDt9/89YoHvZjmqJx26qAVaMNEZsLkcJ6jxODLKSlqqYvTq
         1yTxVfbyIOCWO96Ay3v6itW+1VMvP3Z6wMHSdBAdXXZLEGw0SYhxFu+5wB46iGEuhKQx
         HJW27lC/HK+dKiwFh7wqw1QlBP699WSSz0MVxmsyYJPMOrYR9tZcSlY6mPH70rXNLZ2y
         j2aJMkEAF2LYW2xdwoRJVVAcKFazUYosu1NLkspgym5vPKJhSyXuQxzNZ9axD/fNFsK9
         RTYlcI0hN+zuNa1CkWPSqipx8ykdNnF7bypkvp900/iAEstZHcNWdTjDTzPlcR2iRJ4k
         DL3A==
X-Gm-Message-State: AOAM532KBj/m7nlRFUUNqfncN9P+IQBQZjZz4ASgVhMbk/cO1aHGMDss
        tLLamtenk2Vk1G6MTwgo+0KZKGXQVmQW6A==
X-Google-Smtp-Source: ABdhPJyKGbHO2GsS6XKrVxfPT7hS9jNKog3TVa4CFjN5koRCBhIL8rzy5JsAo+LkAmeK1cJLV6SlZQ==
X-Received: by 2002:a62:1788:0:b029:1cd:367d:2bec with SMTP id 130-20020a6217880000b02901cd367d2becmr9396625pfx.38.1613071951133;
        Thu, 11 Feb 2021 11:32:31 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:f98b:dce0:afc3:118c])
        by smtp.gmail.com with ESMTPSA id f3sm6816556pgh.75.2021.02.11.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:32:30 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Flush pending work
Date:   Thu, 11 Feb 2021 11:32:21 -0800
Message-Id: <20210211193221.610867-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PD notifier event arrives, a new work event won't be enqueued if
the current one hasn't completed. This could lead to dropped events.

So, flush any pending work before scheduling the new instance.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index db83c03ae5cd..2fac95e7a455 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1031,6 +1031,7 @@ static int cros_ec_typec_event(struct notifier_block *nb,
 {
 	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
 
+	flush_work(&typec->port_work);
 	schedule_work(&typec->port_work);
 
 	return NOTIFY_OK;
-- 
2.30.0.478.g8a0d178c01-goog

