Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBCE3426BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSUWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSUWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:22:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D737C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:22:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 61so10322230wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXySPiFeBqFNXOlBA8Hlxv7UAlSpBEE41vijCE3djrc=;
        b=vSv6oPxmtEU9z27sFTxMUsx3Z+3ox6KRRCkclzbqS2s/HHe4v3Xe6kho9eJx7zSVA4
         7oOxtrNuvFjdYuRCS3H7wBSBgh7/fhQJsHK9p7ba/1VInwBA72Ml2ZRt/kniLI8jR2Pa
         rMB3H4/vxHt3HIWxQudgHZN0qG4CwEwcmR/l2le6Ze9yCsbDs7gbI+g9yGUBR3+Bsoka
         2dvku831OhbcCSvQ4pfx4QXD5XQTy5UbZ3mDQI2zmNQ4Q1ngWx8Em6R02c1fpPKf+KIf
         KlAHX6A+MMgMevjHQcZeubY6I19x3MSCHMtct/mjXBsLgxn5rFz7trJZbq9iT2nFMUUa
         F+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXySPiFeBqFNXOlBA8Hlxv7UAlSpBEE41vijCE3djrc=;
        b=DgkqHEegtlv7TVaUcRtVznAEHTAQrshBWbTI5rTsltByJ25G34QC5qHloJN5I5Hnsv
         aGOBhSmdh7qfeGK3CO5+IS9CA4Ietdl8qkMrnld7ST1avJp2PIgt3Sb9kaN+Yct5DRlC
         BGxXasMbtHP1IyoExnNRZrv8qk3BGh24fOAgJJG4D9OjiwWho72VPGBhyHRVug/im+mf
         3H2xQVrewVXlZicXBkteLMsPse76tv/K1vRMnfPW+3/ZibYate0fweh+Ol9TQs/oW5A8
         P0r39A9iO2l7ihoQ+aZQFd6W7xKZhnQAU+OaIAMdINqWrqctg6i6U9BgjowNJx+m0Ra9
         lNAg==
X-Gm-Message-State: AOAM530r0GGCb+FfhVIAaznY47sau6MYRK49izTHOwGZVVr4XnCQFBb9
        tlI0DToAxYkyYBK/ZFB/Mv/1fQ==
X-Google-Smtp-Source: ABdhPJzGION6z8rZr2vfIt19sANVKEW0E7BDXy1V7/Eydzx0QdLTqnardKLbFa4fucQPbJTAXBfCEQ==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr6615711wrt.28.1616185347689;
        Fri, 19 Mar 2021 13:22:27 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-149-6.w2-15.abo.wanadoo.fr. [2.15.231.6])
        by smtp.gmail.com with ESMTPSA id p17sm7225865wmq.47.2021.03.19.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:22:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.12-rc4
Date:   Fri, 19 Mar 2021 21:22:26 +0100
Message-Id: <20210319202226.24590-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following two fixes for the GPIO subsystem. Both address issues
in the core GPIO code.

Best Regards,
Bartosz Golaszewski

The following changes since commit b41ba2ec54a70908067034f139aa23d0dd2985ce:

  gpiolib: Read "gpio-line-names" from a firmware node (2021-03-08 11:59:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.12-rc4

for you to fetch changes up to 6cb59afe9e5b45a035bd6b97da6593743feefc72:

  gpiolib: Assign fwnode to parent's if no primary one provided (2021-03-16 10:18:08 +0100)

----------------------------------------------------------------
gpio fixes for v5.12-rc4

- fix the return value in error path in gpiolib_dev_init()
- fix the "gpio-line-names" property handling correctly this time

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: Assign fwnode to parent's if no primary one provided

Wei Yongjun (1):
      gpiolib: Fix error return code in gpiolib_dev_init()

 drivers/gpio/gpiolib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
