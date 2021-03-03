Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0A32BDFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbhCCQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhCCMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:21:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01AC06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:20:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v9so18969476lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hA5MnWnH4b98jsrotQXDzoePbCFhv2AxGnot/fu2+EE=;
        b=DLlkMoi1+ZjRGJoWSN/yLilCPcqaxU21fi+/pyC8IcGigkQFRPgOgHmHopwpRolB5G
         ZnwXsVCsy4abkc8JEg+jOJXY7OBy2qaBFAwa8xRYIvW+3rBK7Qi7Kfh9M+h8B/WgiIlv
         76wOYf9NAOJAKSP1DmE1nxWL6FgT4dvwTRTK8/KHLEMZAGmnbBxYKmbO4WTX5xLL/lVk
         MOclwmp8259qTHietYbJ/oBgvdgJ7oFtdPmJ3Zq4BiUozx/Dnm1TwSFk4hSYuOUfgT0S
         Cwmj4CbfeBGzgqGa6boik1fbhY9WB6GZTXaQl4EyYoyzmowj1mYXbY1jIPOohoPeVlGL
         iF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hA5MnWnH4b98jsrotQXDzoePbCFhv2AxGnot/fu2+EE=;
        b=oJoC6qDCl34jF6eylMIw6Gvhyl1lmY9MVXyUtGmxwxXrBfGvi19D9QssMG2t1g+cQs
         ON5m46lF72NSl0KZ8jvpN8/59vvoc8gKowXYOGTNO6+9dkwN3obqQb9nupSqNpS5refR
         eq14d/Qcjf53jY5gr+j9RyzehDKnG5j6+Wd8mY31hW5R1tfoJkL5OJSNuOZyWy6AaIZL
         TbkvRLYGQb+Cx7mjlGY5+XBKs4+FnQl5En9hYJezbyMANmnnZN4gujAcIzTob/YE2QAn
         f7ctEDzyMJOJ8sy0oOSI3QAK+Tb6o+OV8Jh5Vk0tMtH3iZgf5M/RCkKbwrGLpEUweOCk
         Eijg==
X-Gm-Message-State: AOAM533CH10uYx+7rmb0hfaUk/HT65Rk0DreEpV0zRLnqhc17qZ4RJ0O
        2og4OmcDsex2oerUMCWz/evAww==
X-Google-Smtp-Source: ABdhPJyC8DmkA2DFtAwigbc46smsN7jy7jbnqc1TpM0VC+8BqYa6SmI9pmBOUwovZMnl9Zlt5Tc4pQ==
X-Received: by 2002:ac2:5149:: with SMTP id q9mr13810577lfd.619.1614774052598;
        Wed, 03 Mar 2021 04:20:52 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id d3sm811519lfq.249.2021.03.03.04.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:20:51 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: block: Cleanup mmc_blk_probe() path
Date:   Wed,  3 Mar 2021 13:20:46 +0100
Message-Id: <20210303122049.151986-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on fixing KASAN splats for the mmc block device driver, I stumbled
over a couple of annoying things in the mmc_blk_probe() path. This series takes
care of them.

Ulf Hansson (3):
  mmc: block: Drop use of unlikely() in mmc_blk_probe()
  mmc: block: Simplify logging during probe about added partitions
  mmc: block: Fix error path in mmc_blk_probe()

 drivers/mmc/core/block.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

-- 
2.25.1

