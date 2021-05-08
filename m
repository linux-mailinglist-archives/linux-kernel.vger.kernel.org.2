Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90523772DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEHQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEHQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 12:06:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46374C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 09:05:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a36so15387843ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gse-cs-msu-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7DhCvIteBF1AiZLgolJdfWDXx7RlxiueUEPWfMrlLO0=;
        b=qjXvg4TkfMJbXDBLbUb7ptQZpozeTcxE3jz3cMNqAl4XcCBz55Xj3dGyNClf2ND/49
         Si0ZiJBAYJNlaA/xBCLN0LwrQgnIzn/zr+vvIyUD7mFSnUQp4gsgWPofcecWxdZyErdR
         BRBaLk97hB4P3ZpTBRUwl9dhmIUnR4U7sHTIOaaNJ/pOUgd6RyrP+p9TAXmr2N7klB0G
         XvjQK+uTxwJeJze1rKpX2Ir7IqAcBJjHqsgS8xc3dzp8ikF0Pg4FlUkrqIOG/UEMaezy
         nFYcu3XgjTQ2SDO0twXPwbWCtj6FeUq6AtsbjG+4mtB8hVihBztSMOBYnHJnZPtbbxJK
         TANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7DhCvIteBF1AiZLgolJdfWDXx7RlxiueUEPWfMrlLO0=;
        b=jmf0SNySoi/KktgIV/inUeoqKYRo4Lc03FGpy0sIT0yxj194F85WwVmclHAXWqr+xA
         ZyCRea89+LYzkDF2FItgj/ErJ+tFeDt3ezRpUFpsbm7DEPwZxaQ1lvBp9ldreeS4TKrs
         7D3atyf2eqsikanrvXYQg02P1FFGzK1sI4TJwjNka3U6B0fNSzar6FWseSpbW88pYBnp
         sUrqgbzkowotYmeHbA4B1iMUfqAjfo0xwBzvqlzc/Cnta3PIZaY6aWVoHfnaghGdmQcm
         XAvU42QYaRx22SC42OBU+WyBHBzZaUN5nqZDyEUXonq1ARjahT5h9JkN2Mai+1jFser1
         Q9rQ==
X-Gm-Message-State: AOAM533xY0kpg3D+HVpvO4v+KrSvBnXrVlxWBqiEGpMuVso7yWFCVhvz
        MiMPziTSL2TRsTiItvjTlLc6lg==
X-Google-Smtp-Source: ABdhPJyV1vkEl+NROpF0QFiCOzWCNEOAGU8Jji8JGy3yPbWPrMuh6hvpp23ZjvrL3uMgSaiq2QoL8g==
X-Received: by 2002:a2e:b601:: with SMTP id r1mr12313125ljn.203.1620489899128;
        Sat, 08 May 2021 09:04:59 -0700 (PDT)
Received: from localhost.localdomain ([79.165.19.240])
        by smtp.gmail.com with ESMTPSA id o139sm1665325lfa.129.2021.05.08.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 09:04:58 -0700 (PDT)
From:   Yuri Savinykh <s02190703@gse.cs.msu.ru>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Yuri Savinykh <s02190703@gse.cs.msu.ru>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [bug report] media: allegro: possible NULL pointer dereference.
Date:   Sat,  8 May 2021 19:04:55 +0300
Message-Id: <20210508160455.86976-1-s02190703@gse.cs.msu.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

At the moment of enabling irq handling:

3166     ret = devm_request_threaded_irq(&pdev->dev, irq,
3167                     allegro_hardirq,
3168                     allegro_irq_thread,
3169                     IRQF_SHARED, dev_name(&pdev->dev), dev);

there is still uninitialized field mbox_status of struct allegro_dev *dev.
If an interrupt occurs in the interval between the installation of the
interrupt handler and the initialization of this field, NULL pointer
dereference happens.

This field is dereferenced in the handler function without any check:

1801 static irqreturn_t allegro_irq_thread(int irq, void *data)
1802 {
1803     struct allegro_dev *dev = data;
1804
1805     allegro_mbox_notify(dev->mbox_status);


and then:

752 static void allegro_mbox_notify(struct allegro_mbox *mbox)
753 {
754     struct allegro_dev *dev = mbox->dev;

The initialization of the mbox_status field happens asynchronously in
allegro_fw_callback() via allegro_mcu_hw_init(). 

Is it guaranteed that an interrupt does not occur in this interval?
If it is not, is it better to move interrupt handler installation
after initialization of this field has been completed?

Found by Linux Driver Verification project (linuxtesting.org).
