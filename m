Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4899B33EBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhCQIoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:44:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B016C06174A;
        Wed, 17 Mar 2021 01:44:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g24so820816qts.6;
        Wed, 17 Mar 2021 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JbRF6Qj7q5szAzhJ2UjhaCTZjCpnjDyNBz/V7TfE2U=;
        b=B7g/y88mGemt0kYcZNjVh1HlC6paZPhdqQhgDGibz5h/ROpuHEJRU/N9ajzldfQ7kU
         rZTsmCJm5XRFATxRCWoS9QCj6Bfepgitl1M8WqWt6k/3xoe7lLqjYi/PY11VdRaxoqbD
         gLrgNZoZn5YFu2tljelBELpDppHiClnpQrG/ngbLVVBtsVpVliqGpaPuOWdg8lsSLdtr
         0tSZHJ1b0xG9yDRAQJGHdJv9tYAJvOvm77kAeB31p6bWuZlooX8b6bwT5k2zsZtA25IL
         4DUgbK73z2mWrvTvYRpYO++GIpc1nZrF3tZWgy6fp9SS7VlSkl6x/QPiapOYS/m9YW93
         iCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JbRF6Qj7q5szAzhJ2UjhaCTZjCpnjDyNBz/V7TfE2U=;
        b=LncfJp8Hk9jt5Cnlv53M4/lN5g+Ak3ma/OS2z0UaFwX1Gd9ERoQF5yFg05QBjATEUg
         wprFNw2Cq11miFmN5Ko9uacMCCBnIzvHT6ZIZOvimLlSGbae+i9aXfVR0vPkEzzvlKnO
         usVz4c5KGkM6e6iZbtHi1g8c37aWRnfa5jTTYozwK/3nCivxzhNXcRl5z60rWXeff1i0
         yEY9nZsLZVZ04juLxlK+rPbHJIGRtZ2cq8GgHJIIuoz3iuGsepeAiP7gjqGm+Dz5X2Qh
         tQBMe5y6XpypOvdtIZDu6QK3xMmIxoXDASsx7WRjCequKIGt/U3qrcdn8NqGIrNyWPUB
         f+oQ==
X-Gm-Message-State: AOAM530ITqVL2zq9PbgZVmD6UQEewKmK/GC8Ini8+qdm8EglFELhmlzC
        +A/0DHe0F7Ave8CinuE8AdA=
X-Google-Smtp-Source: ABdhPJyzKtnJNfcra4IXJO1T3jFNzLBNsbBL1LND1ngVH1KwZb7H4GmwhlvLXNvFkAwcVD2sc/h7lg==
X-Received: by 2002:ac8:4c87:: with SMTP id j7mr2954614qtv.338.1615970647462;
        Wed, 17 Mar 2021 01:44:07 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id p66sm17167880qkd.57.2021.03.17.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:44:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cascardo@holoscopio.com, don@syst.com.br, hdegoede@redhat.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] platform: x86: Typo fix in the file classmate-laptop.c
Date:   Wed, 17 Mar 2021 14:13:43 +0530
Message-Id: <20210317084343.3788084-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/derefence/dereference/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/platform/x86/classmate-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 3e03e8d3a07f..9309ab5792cb 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -956,7 +956,7 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 	/*
 	 * If RFKILL is disabled, rfkill_alloc will return ERR_PTR(-ENODEV).
 	 * This is OK, however, since all other uses of the device will not
-	 * derefence it.
+	 * dereference it.
 	 */
 	if (ipml->rf) {
 		retval = rfkill_register(ipml->rf);
--
2.30.2

