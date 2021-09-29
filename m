Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D294641CE20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbhI2V3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346983AbhI2V3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:29:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5DC061770
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:27:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l84-20020a252557000000b005b6f0d0b2a3so2012644ybl.21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aSPV27tjY7pw3PilwZezZx2K/hJgwuA/3Sl9DWnicys=;
        b=fPAfs9F2RGWNVGNpY1vbd3tw35Qe9d9ADKWh9fz38g1iKJ0vWO4Me6axzgomQy+J0E
         7UCuKx3WlPViBCXN4P8hSuxuqAE+EaJ5yP/qs4l/ZcFqqshOaGaK/QLfd8YQPe61LyRL
         j2hKXNU0v0RAvhMTHJxrKE9f8Ymgyg3jZPF76LQ7QG4Qo4ZQ/NtZUHPuZvVm5WIsatyB
         NAslu9lhgdS8z/aXqcvQwMBDyKYVYq2jVJr0/tYtDFWPKpOdm5WN70ofY0479ZAMnmwD
         CMEnGkCVo9IxoRc86KDoqub07ixobnK8MqzFrUW126fKl3cG9U3sqet6+ky1xOHz98xW
         6o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aSPV27tjY7pw3PilwZezZx2K/hJgwuA/3Sl9DWnicys=;
        b=H18bIHDGrWqUPuRCgvbZyCYGPoqEiy6u8MBCevgIA4nmzPsT34ejecq4uC6VDaqlU9
         dvdhLbZLb/u3Rhlwuz4AM36wt8uFF6DPoBlNSoifzuE1bafVdifP7uxwm6ijOIXpCT10
         bU12lSeXn3IGERUQKwvxS8Ii3mM1vExmrWecHYBbK0BPLW4tprthgMNy9QLTZT0FtlkM
         vJ/pKz29yIpWEzt/hrxddRh42sBczysTJf2BkvYB5l5vrC/9movxE3YS2evDU/28wrYO
         bxknCcYysKhwdMh+Nbxu4YeMEMLfO/NMN7Zdm/pYlxA5EsiVa5f+BvW06TWhSiF8j2zi
         j87A==
X-Gm-Message-State: AOAM531sqg1juMuDnKNFefGee/gHXXYsEe263xk/FR4nR0FpVENjbVO+
        Wvjor+LaN/9gAd4SYVugDEmBX+mNR1YJzL6bZ1Khhg==
X-Google-Smtp-Source: ABdhPJyErlGQvS1CYKbsC/V+OsCpTku3TIuMCkUAL4Jzl/iLJIZy1pCIolM/CMAW6C7Qj4FovUZKq9AhydHyU4IWOMESYQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6610:: with SMTP id
 a16mr2493812ybc.193.1632950847837; Wed, 29 Sep 2021 14:27:27 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:12 -0700
In-Reply-To: <20210929212713.1213476-1-brendanhiggins@google.com>
Message-Id: <20210929212713.1213476-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210929212713.1213476-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 4/5] thunderbolt: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit:

drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Linus already split up tests in this file, so this change *should* be
redundant now.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changes since last revision:
 - None
---
 drivers/thunderbolt/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index da19d7987d005..78fd365893c13 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -7,6 +7,7 @@ thunderbolt-objs += usb4_port.o nvm.o retimer.o quirks.o
 thunderbolt-${CONFIG_ACPI} += acpi.o
 thunderbolt-$(CONFIG_DEBUG_FS) += debugfs.o
 thunderbolt-${CONFIG_USB4_KUNIT_TEST} += test.o
+CFLAGS_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 
 thunderbolt_dma_test-${CONFIG_USB4_DMA_TEST} += dma_test.o
 obj-$(CONFIG_USB4_DMA_TEST) += thunderbolt_dma_test.o
-- 
2.33.0.685.g46640cef36-goog

