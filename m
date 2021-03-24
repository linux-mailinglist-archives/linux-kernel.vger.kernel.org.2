Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579C2347F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhCXRfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbhCXRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6371C0613E9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a7so34229672ejs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfriQXFxUvhVGCpwETjq8GWLI1DKoZwsNAe/TYwrv1c=;
        b=IuGQSm9ZOkoRlOIJfQSFYzPFECEl3x3bg7hp3Q5AREVd+EhDLiDTCzl2LNWOSMW30t
         gx1htkH4xis3A44H8pUUpnay3+rlpTBlKtCh3NE8lTwvZy7EuPtNttqsXCST9o0h9r+0
         5dC86DEnkcg1dIS8CHteR8/fT7nEKESUvlW439cTYEZ2I8GLcKsH3Mcm5k8OgKJhCYW6
         YKU/oAT7O44FCeD3Z/3QAkAMP0K7rxLecHNpg/nYyUulnOGCphHyJ4UOVCDzi1cKEp4W
         WTb5DoBfYnd6c7WDaOUJOUPZ7zNsfYOKZ5Fd5ytilNiEPZDC7tlVwXyIt4wbPMG14DIS
         GQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfriQXFxUvhVGCpwETjq8GWLI1DKoZwsNAe/TYwrv1c=;
        b=XjMsXTw03cxTBvGHBP0tuttvdPKj/wbc/MY8nz6KwM+ijlwChHTfVmEhtLKVG/8b8C
         /9oWe2w2R0l8JbrPJxwH1HbfM5RRtmTTUawD82H1BlYq5hIp1vFNW32+wKsR3v6OdtyA
         ffRWW6pkxNkJQ4cb0kfGiDmhEL/W0Ba0j5z04Z0buYQ0KgbG8yKhAWZhDvwfAwgFeflk
         F5bo+XjWhlAsFtCHcJHzSlC1TgtBRD+TAoQQDPAB7F/Z4uYLZK02FQfUGeZfc+2zYdlb
         jif29dbr4bnPCFb+/UR6Y+gRaZrG7yl/7jjhqxmT5Hun/rHbtlAbfq531e9mlC9RYois
         q37w==
X-Gm-Message-State: AOAM533wqUmAoX+xTHaZUJZZRFcIE3Gyu2rELIe3IF63qg3FD4Q/Uf2B
        vspuzBkrXn9VY2JadViGjPpYw2HcFQWCSQ==
X-Google-Smtp-Source: ABdhPJzFIus/MG+W6lLos8k0at8stD86NQsJlQa6l9bHKFEG9wvE4jSPSwAB86c7XlEyc1bfasMciA==
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr4966203ejg.330.1616607262431;
        Wed, 24 Mar 2021 10:34:22 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 14/25] HID: hid-kye: Fix incorrect function name for kye_tablet_enable()
Date:   Wed, 24 Mar 2021 17:33:53 +0000
Message-Id: <20210324173404.66340-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-kye.c:666: warning: expecting prototype for Enable fully(). Prototype was for kye_tablet_enable() instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-kye.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index c8b40c07eca69..f46616390a984 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -655,7 +655,7 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 /**
- * Enable fully-functional tablet mode by setting a special feature report.
+ * kye_tablet_enable() - Enable fully-functional tablet mode by setting a special feature report.
  *
  * @hdev:	HID device
  *
-- 
2.27.0

