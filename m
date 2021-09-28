Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FE41ACD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhI1KVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbhI1KVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:21:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE48C061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:20:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so1690544pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmpamNJBA5dOWdIg24EJhG8H+7qVWbY6nrdilMuP4vE=;
        b=FgOY5NE890RTLd50NfOYwWZhwfo+MoDF4jb9FEBGo6kqtGS6NJQg4HDp0u6C0R+EOf
         eMBAvVa/2T5FN+1HN/XsMPwbk74LEXuNYrv1js0ue5VhUui2dps0Vz1eeeIoKo6VBKDS
         6tmYTv8vukO/YGLtSVmw3MhWlj8P2UN2Hjcqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmpamNJBA5dOWdIg24EJhG8H+7qVWbY6nrdilMuP4vE=;
        b=BJbL4l+OGixPqYZw8Zxz3baL+NrndPYclJUKWmns/jLRz8fF9UmHNAS6zVYFVThDYg
         2eB3PmWNHb3eCg7ZIPMSBrL/lZU7tY1aEl6jZIisHoHgNBh8md71tDLshkRNEwYjsRYn
         xlM4gx8alXWmw5rG3ob+DIZv7ZCsGW5forrHUB2G04pGiiPBmTHayPVxj4MRRRobzrYh
         mNam6VlhZs9ZyDn+AykjWtt7Pig+g/IWhwJDazsV6KM13QkqkENiN8kHVZPKOhYnxg10
         Q+tXR5IVQmoZMYwvPSi6yxGnRZuaV8Z8DtO/t/IYGmXrzwZaD/VmX5e094wU1hj20wDU
         J+9w==
X-Gm-Message-State: AOAM530zynYt60Tb9Gmuuzsn8bjenKf8Crw/pgMUlf8J81sBtgwWfDPn
        QcNrnF+a5eJ8OvWamG6fwcbHO6pRpxsvCg==
X-Google-Smtp-Source: ABdhPJzstPV0i4GKAgvwZAO278LokHrGLfmYcQHIV0XcgBsVfqz6p7THyo44TNbWRU5OIILoeklGIg==
X-Received: by 2002:a17:90a:6605:: with SMTP id l5mr3572334pjj.174.1632824412132;
        Tue, 28 Sep 2021 03:20:12 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:f6d8:1ad1:cc75:70fb])
        by smtp.gmail.com with ESMTPSA id z9sm19734576pfr.124.2021.09.28.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:20:11 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 2/3] platform/x86: intel_scu_ipc: Increase virtual timeout to 10s
Date:   Tue, 28 Sep 2021 03:19:32 -0700
Message-Id: <20210928101932.2543937-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928101932.2543937-1-pmalani@chromium.org>
References: <20210928101932.2543937-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a7d53dbbc70a ("platform/x86: intel_scu_ipc: Increase virtual
timeout from 3 to 5 seconds") states that the recommended timeout range
is 5-10 seconds. Adjust the timeout value to the higher of those i.e 10
seconds, to account for situations where the 5 seconds is insufficient
for disconnect command success.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index cfb249da2a7b..d71a1dce781c 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -75,7 +75,7 @@ struct intel_scu_ipc_dev {
 #define IPC_READ_BUFFER		0x90
 
 /* Timeout in jiffies */
-#define IPC_TIMEOUT		(5 * HZ)
+#define IPC_TIMEOUT		(10 * HZ)
 
 static struct intel_scu_ipc_dev *ipcdev; /* Only one for now */
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
-- 
2.33.0.685.g46640cef36-goog

