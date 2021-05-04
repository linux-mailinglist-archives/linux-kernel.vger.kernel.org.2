Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326A2372CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEDPE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhEDPE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:04:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E36C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 08:03:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i26so9050028oii.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TT0/iR1OPkegR+Vfhbk08FoUYubbeX4JiVGCSzah8XU=;
        b=n0PpoXLZGlyohVmymhVyjheE5yAwxUh7kFQkwhnChI6+BesTNJKBiBEUt4dEYRU6jx
         rE4CZnVNn//Bo7jVbdIFd7kx2rLXEG7ah4ArXwS6ePDub+tsIbOVoOowVrLBLO5oajai
         fAEUxhBY90gXBj55iNbnKfHl+dPC0RhO5ePYhtUZEfzu8QJXSwROhvl06XNZfYhN+0Vb
         R9AoZUBNfPwdBH9Ds0kYWIf4gyEt3y+aN+7dHzmkLBiEZ31RWimtulU8hjtlYMohVpHK
         aRMVcck7QQ/6aAq473/NFF9RNYKxV53N5X4wXYsACtkdiQB36AvI91LKMsPZPyCZAiVe
         GVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TT0/iR1OPkegR+Vfhbk08FoUYubbeX4JiVGCSzah8XU=;
        b=aIYVchJlFmUNrbgGMnm9VfyP1OZQP1Oa7JOaLq9EG08Fk8tG7zwlXptkU590zfTfE/
         KVJ1YRK3GGu/HdJhIUnrdyJJG9XEyNNMFvNniJTyDWYhF+B5Lln4FliO1TJEHpI0CWh6
         082GWbWv+90pYrgQ4PONsSmLO2vCqn224LNI7mAIQKYdRpETSLLVK1ISFBFhyNhY+W9G
         +Ri6aR6uNhhqqCon5rV9HC4tvKi+6r7jqxZXEeJAEG0PyTYdplr8UPnkaGVuYrOlGPc6
         yFHVJZtgouVk7BFFoGQFovvUcuMvB8ksnWzDkzXquHcT7BppJGnAguVxcupf/918RB3y
         wj1A==
X-Gm-Message-State: AOAM533YXc/VLFuUoriTrQ4SCTlZ/tt+aICW3FvbaOzLOM+LpTvqobri
        thNJ8sLyZ/ibrlxP/SVV9JOGWA==
X-Google-Smtp-Source: ABdhPJzBf250O96VMId5CAzo+BDxT7Q6vZSBZWxt29+B265VaJvOxNLcVMbvFLibLuY0dZNfqB8JTg==
X-Received: by 2002:aca:c413:: with SMTP id u19mr3382044oif.41.1620140603379;
        Tue, 04 May 2021 08:03:23 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c25sm847050otf.22.2021.05.04.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:03:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] hwspinlock udpates for v5.13
Date:   Tue,  4 May 2021 10:03:20 -0500
Message-Id: <20210504150320.1468505-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.13

for you to fetch changes up to 1cb8f3e2d8fe7533c26df9925a83bd3d185b312e:

  hwspinlock: remove sirf driver (2021-03-17 21:22:06 -0500)

----------------------------------------------------------------
hwspinlock udpates for v5.13

This removes the SIRF hardware spinlock driver, as the platform is being
removed.

----------------------------------------------------------------
Arnd Bergmann (1):
      hwspinlock: remove sirf driver

 .../devicetree/bindings/hwlock/sirf,hwspinlock.txt |  28 ------
 drivers/hwspinlock/Kconfig                         |  11 ---
 drivers/hwspinlock/Makefile                        |   1 -
 drivers/hwspinlock/sirf_hwspinlock.c               | 105 ---------------------
 4 files changed, 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt
 delete mode 100644 drivers/hwspinlock/sirf_hwspinlock.c
