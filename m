Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185DF34AA02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCZOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCZOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E78EC0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k8so5882486wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfriQXFxUvhVGCpwETjq8GWLI1DKoZwsNAe/TYwrv1c=;
        b=ghIHk4GlZC5aYoLhvt/vuXGDzZlXns6m03U+T+WQOjnWn3ugz7Ej4YW3+deYR8DsMA
         n+YGcWCNvi43WQTC9g7YXw06COmnX7WyhwPzxBMmtrIO7D+Jy2ytxAE25eKBk46iealD
         c7e62MRFOGZDcedmuGN+fVd3P+li++rQWVKh0EPF/v6oSjAdj3dnmfPoQ5O1bKG2p+te
         pUdTld+oLQRnI+EHKdqncsJgVKrH3aPx+tIDTr/5EkDpAOjY44d1NBUMRclWSyEoGOuw
         fPR0Jjmj7uiVemy4FRowu4BS4JeBY7qmPLAPBOvV+6QaRGPE+GXuLTJt+Qiw2iU8Z/pl
         yPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfriQXFxUvhVGCpwETjq8GWLI1DKoZwsNAe/TYwrv1c=;
        b=STSyzgfgeBxiyPFrqVFTVr+QAz5AqHOIIgzMYYJ3nJwka6uJN+3dG5XRUSG/5Bpfen
         89c1OdjoJYs/kWpULgSS02knHY6L/U5blcjxXjLF7y8HV3oeexi7Enc8DVWKWIfdalLc
         XRzoeLzKcnnSsLgNrEjGVkZnPGC2Tvj5t9CdqXNjV32T+ymGxHSgQBexIh7/4J9oCPx6
         ixanR1LntRiLb+c2oF0fa8H23SGmujINGwEsjcRLt/Ce4jYArr34WD51sxCYyy2re6cW
         NM766On//LzdWTr2I8SvURKWGpfoWKAO9p/cbW5cScmtMTojaq2K6SKzRwsM/FeDCjVD
         xKLQ==
X-Gm-Message-State: AOAM532cxj/N8ZCLoUiSHdRoag18ysuPUAuo8A/1/N2psl6RwvPX0dw/
        nayKbugcH09eRu5AuwtYzRJw6w==
X-Google-Smtp-Source: ABdhPJxeseGkHowzWx525L+U0ZeaNPO56s/H9Fg/4iQEmMjylJLcsFebVgK/pjc7GkHSOBZmAo9uoA==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr14717926wrq.20.1616769316045;
        Fri, 26 Mar 2021 07:35:16 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 14/25] HID: hid-kye: Fix incorrect function name for kye_tablet_enable()
Date:   Fri, 26 Mar 2021 14:34:47 +0000
Message-Id: <20210326143458.508959-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
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

