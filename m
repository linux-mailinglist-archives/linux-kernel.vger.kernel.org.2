Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120303A19E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhFIPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232474AbhFIPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623252939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VxgDk7cTkJTNNC5ZMrS1yGyqdCe9V2Gyf+MzVfrw8ec=;
        b=e7CgiIiIhjSq+vn+Qawe4fKFoJbm64cyLTEkgUlqRoRN7AGToM526z6yJ04nKb3YHNHk1U
        1qCF299Hg0+FjwRUhhQ+FU5/YpGm9HthlmbFANcJhTRlT1/PY3Un48T2PT2YpTEIatQuP2
        v43h8xJEWKmnhD8UYhuY1fEGF4Ig1rU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-3m8YyaTPOYGckGW2Px6hnQ-1; Wed, 09 Jun 2021 11:35:37 -0400
X-MC-Unique: 3m8YyaTPOYGckGW2Px6hnQ-1
Received: by mail-oi1-f197.google.com with SMTP id j20-20020aca17140000b02901f3ef48ce7dso4757082oii.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxgDk7cTkJTNNC5ZMrS1yGyqdCe9V2Gyf+MzVfrw8ec=;
        b=O0z9rIs11R20zwP9j00cOm84xHAOX1gmTOJjae6pgWKQT35WM3ZN+ishNZWwCkgF9v
         xmCi67xAjl6zxX0pKjVgqw0OyGGrtV5qDfGpdQJ7kITMKNm866JL5/VvCjqCMbkw8ira
         R1AuKa8RkQev5POc5oxDtbo8wqN84jy81G3KR2Vd4fItdja8gCY+BYLT4k9K//E6ouGk
         1Uup6HyjTtEWSuUGuT0s2nUnYCZr1uz8r8wupjZ+XZvzVIsbT/BX7/hXRT7vL3xDUPMm
         R/FY2mIaQ5uEWWBO1YqcsSorxWjCDE0h2CqrP1Qoy4hx2LnceEWzzpMg5MozO+PziXZI
         nH/Q==
X-Gm-Message-State: AOAM533AeDzaMMteG3A0CPy99T3PkWbCRRk/CXzWYdszzvjAU0wPS+Wf
        bjcrS+8OdKxIjR902y8Aa4Dh7ifZ4xvLSThNh35ACnlqI/ClxQR7FF/2cJ/Uu98c0Drs/QFpy1B
        8/9JX4PwX2TgVtHG3XQsU1o9X
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr10711otq.73.1623252936862;
        Wed, 09 Jun 2021 08:35:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7Daq8mDoBGGCaF1d0sj1xDGnnYrzi8QqE4yRaTjbZ2kHSKW8poNukRLJ4rCoORV1axGN9fw==
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr10682otq.73.1623252936325;
        Wed, 09 Jun 2021 08:35:36 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l28sm52583otd.66.2021.06.09.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:35:36 -0700 (PDT)
From:   trix@redhat.com
To:     markpearson@lenovo.com, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: thinkpad-lmi: set fw_attr_class storage-class to static
Date:   Wed,  9 Jun 2021 08:35:32 -0700
Message-Id: <20210609153532.3090201-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An allyesconfig has this linking error
drivers/platform/x86/think-lmi.o:
  multiple definition of `fw_attr_class'
drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:
  first defined here

fw_attr_class is only used locally, so change to static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/think-lmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 782d8e3fe7a1e..c6413b906e4a3 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -134,7 +134,7 @@ static const char * const encoding_options[] = {
 	[TLMI_ENCODING_SCANCODE] = "scancode",
 };
 static struct think_lmi tlmi_priv;
-struct class *fw_attr_class;
+static struct class *fw_attr_class;
 
 /* ------ Utility functions ------------*/
 /* Convert BIOS WMI error string to suitable error code */
-- 
2.26.3

