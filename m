Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4915A3EDDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhHPTYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231191AbhHPTYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629141811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tWj4QoGgsZXwBjPcpg0s+AqXSiipgAeGsG36glfrsNA=;
        b=N3BiG631OtQqn6ToBC8RF/TRSvuWf6wzzqUUFIFXZTAAx27oJiGwJRti6gDNi1lJuNyOJJ
        7mo3DD8YkCOTlQgbv5O58RNdawvZIJ85LZfEaj7Yx2YtiO9dmaEPJHAh9gEuLUZ4z5Lesz
        bUgAkIVfTiXzeYFAA6d+kAGHaLnAUfU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-ukB6Da1nOFiuvPD1HSTV5Q-1; Mon, 16 Aug 2021 15:23:30 -0400
X-MC-Unique: ukB6Da1nOFiuvPD1HSTV5Q-1
Received: by mail-qk1-f199.google.com with SMTP id s206-20020a3745d70000b02903b9207abc7bso13883320qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWj4QoGgsZXwBjPcpg0s+AqXSiipgAeGsG36glfrsNA=;
        b=cgRKhCzuKs07xT+GJ0znjtajJF99eTbWdCqFvbsgKepQwJQwbNcsc7LiemWNN7qoy0
         cf/KHhCtIIgHm36eOHbsdCciCx2OYAroAgo5u0H8fkbkeO92mrClT6PJdG3gf8jl3H+L
         MV+wvq3INGtEMHWPQqIXm3//O4ef5gQLBEoftxSdPv1vDo7t9DkDsYMSJsRXiW7Yclgs
         +oIsl0HP9X2JIME4L/kwMSA3XaR13OQHDS5ecYuSkJWzHNqLq6kDd3xyJ6Qoh7uKQHPp
         i6Mvu4V4Fi22vmHhh7Y/rMaH1P397yM8uOifveLtlvuIndLLUjVq+uBDEzs67ozMr2yK
         Xxlw==
X-Gm-Message-State: AOAM530fMt7mRTpJMkFK4288TLm60TnoreStWeBfkK7QvgTvuuRaI2dK
        2YlCnlxiYPrpPTFIqO1bq9rMcodIq3HUtAqXnjANDrJqDiTeMF0XSIv7VlryD5unQjBNa63LVdZ
        v8klwVaMVmxK4LxM/qj9aA8If
X-Received: by 2002:a05:6214:aa8:: with SMTP id ew8mr312661qvb.43.1629141810009;
        Mon, 16 Aug 2021 12:23:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEa+K77EwKUJ0Um/4h+WQIF7my+th7mGi8g1MwVio9mvnR546sa0MV+RmKb42YeLka1sw4lg==
X-Received: by 2002:a05:6214:aa8:: with SMTP id ew8mr312643qvb.43.1629141809795;
        Mon, 16 Aug 2021 12:23:29 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y124sm55002qke.70.2021.08.16.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:23:29 -0700 (PDT)
From:   trix@redhat.com
To:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        ashish.kalra@amd.com, rientjes@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: initialize error variable
Date:   Mon, 16 Aug 2021 12:23:12 -0700
Message-Id: <20210816192312.1291783-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
sev-dev.c:1094:19: warning: The left operand of '==' is a garbage value
        if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
                   ~~~~~ ^

The error variable may not be set by the call to
sev_platform_init().  So initialize error to SEV_RET_SUCCESS.

Fixes: 1d55fdc85799 ("crypto: ccp - Retry SEV INIT command in case of integrity check failure.")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2ecb0e1f65d8d..b2b9f0f4daf2d 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1065,7 +1065,7 @@ void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct page *tmr_page;
-	int error, rc;
+	int error = SEV_RET_SUCCESS, rc;
 
 	if (!sev)
 		return;
-- 
2.26.3

