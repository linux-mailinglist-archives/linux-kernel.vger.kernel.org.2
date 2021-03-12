Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD15D3388F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhCLJsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhCLJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:47:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51912C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v4so1396239wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrQ+7ZH8hdEcqjDJ1NufGAV5+lAKZ7pUReLcSfydwew=;
        b=mMwokNhJjxNU809LhihTYAds9RepOe5eVxyE8Z+0Ds2XHVQtNvJADEYpqs7Ff8fhgQ
         6eEjbED6trnXLdfLDqGKqbkUXgajYwKVPGO0NfNxqZth8ytHV7tC8470j2KCMrHn3npG
         Hn8MLrujWL0yUpgrMJFSJwkDEsnIwAVR/LG5bANdWP3ITy5lKRUGHUpTbfpKRbn9nSCn
         zsw3GeDVaW/be8dLiUCMiXgYy/EUPsvd9w5GAoNgC/j8E5nZ2UelIXAzJrVryBrbW4/2
         5NZDiDCXKp6/GydfiZhdn0vWnSKFTXdll6z0ODb6WFhlxw2ekYmiQCiCYViDGVa0/x39
         7Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrQ+7ZH8hdEcqjDJ1NufGAV5+lAKZ7pUReLcSfydwew=;
        b=RGuGOMO6RJyUU35Ze0jWjM53KxDQZ3AxIYhZVe9Hc4iwc7BYcFtD1dzvTJvNhfQO58
         4LNEAUvdZXHn0VbaI25gjEKh9+U/p0hmm5HwmS3j1BLTXsLhBZNV7n/EJNdTaQ0alNG9
         ugKyeonHYmajxJNh9BZlVcbf4ox8W3mYbTim8ynB4S6kEC4xLEP66rNpR2mkvkxIjFsc
         QO2sGWrUeuAJhR9Va8d58LFbb9fA/tkrASWLxO0wTY1pnyRX77WrfTXC5BhTq5few+Ks
         L6xD/74aBQbt67Kak2RY3WufBUW56A0F/GrelQ3fNF/iKSyTHKp0B7hPdxKtZ8ifVI13
         Imbg==
X-Gm-Message-State: AOAM5312Vb0L/Q2yf319tUgALKv77FZDEYTsqKGvrBvFQ3Dopp9f/LqG
        cVJasMORWpAGdMcxA8GLQkgdvg==
X-Google-Smtp-Source: ABdhPJwJxrqDbaV2u+c1ECEngaI6sJkBMUGycupvuKzIBQ3A/3nJ1G9UCu2s9XtmyFZmpwfnEA8eCw==
X-Received: by 2002:a05:6000:245:: with SMTP id m5mr13371283wrz.284.1615542474086;
        Fri, 12 Mar 2021 01:47:54 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:47:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 05/30] scsi: libfc: fc_rport: Fix incorrect naming of fc_rport_adisc_resp()
Date:   Fri, 12 Mar 2021 09:47:13 +0000
Message-Id: <20210312094738.2207817-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/libfc/fc_rport.c:1500: warning: expecting prototype for fc_rport_els_adisc_resp(). Prototype was for fc_rport_adisc_resp() instead

Cc: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_rport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 56003208d2e7c..cd0fb8ca2425d 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1486,7 +1486,7 @@ static void fc_rport_enter_logo(struct fc_rport_priv *rdata)
 }
 
 /**
- * fc_rport_els_adisc_resp() - Handler for Address Discovery (ADISC) responses
+ * fc_rport_adisc_resp() - Handler for Address Discovery (ADISC) responses
  * @sp:	       The sequence the ADISC response was on
  * @fp:	       The ADISC response frame
  * @rdata_arg: The remote port that sent the ADISC response
-- 
2.27.0

