Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237583A0C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhFIGLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhFIGLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:11:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD58C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 23:09:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r16so8754ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpRw0xQJ4DmRjPc3XZOXCq8Yj+A2BA3B/GaickI4wN8=;
        b=xVAfZE0A8Unf98HcFCXuX4RZeOIC8Q5dOG09zV2gGNevdLM0zMJq3dLuzH57zS8DoX
         3g7to94dmRnjqwU072m/snpS5qSZ1uK+THO+4bYMUC4R6ZtG97z1753bAaxxLfTfnw5p
         PsiE24KVo9JW2MWWQYmZloqVI3ItixT13V8B6o5VkETPAqsLnmdoGWthypSGqK8JsT9L
         vaTWLj1shu0bx6Zb+qwzXryK8c1HAF7qFV+S60IM2Bs0+8k24SIRw6ZCJSQLUuCGrx3x
         ektFdVrwjG+rdnfGMO3iRTeXqg/sKwwvfkoTQnmnYcLHfxYvbd269M2vh+Tgn3g1eUvy
         T9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpRw0xQJ4DmRjPc3XZOXCq8Yj+A2BA3B/GaickI4wN8=;
        b=CxsndGLk8TK8T1FHm4Qu3JRsGnSiN4UL44v3vnJHz1xesx1pGPjqHB6ha12SWblmmN
         CXziDMktalWdr4wTqAZ5b/KW89l6gasY0ZIC9vlgOTiHMCPulCCvmFnwNjs8aRjkd9jF
         i9/9WxPS3J1lDmA6yXqFXOb9Fk/bW29r07RfPAfJpWSkxrSy2GOw1D0CcawR59v0kV//
         mzvPYOf6rtjsznQE3g1SYNe+irrLZ8AUE+xrhXfz520IK+Nbfy/CCzXqXcVi8q4orTnI
         lCBdHGtwTnglUH6TUT55/rNU21k8fAACVqDkZEB8BGSD7fCQ69KscamIsCodJJxtmgEV
         jp/A==
X-Gm-Message-State: AOAM533q20SL3xvM28j7d5QIfUj3B3PpHeYIr3rzV4K42vz2zFceUyRR
        3/xJBSwHwn2UifIcKWabMv9fxHSA4F3OQw==
X-Google-Smtp-Source: ABdhPJyzlIexmGtILhLW7B9H59a3K8PmSTy1VOX2F2Hp6cFGPRPg1J0rmm+bT9kFOnkasmm0JfiFEg==
X-Received: by 2002:a2e:9f47:: with SMTP id v7mr21932830ljk.333.1623218958271;
        Tue, 08 Jun 2021 23:09:18 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id l26sm213735ljg.87.2021.06.08.23.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 23:09:18 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/4] Asynchronous notifications from secure world
Date:   Wed,  9 Jun 2021 08:09:06 +0200
Message-Id: <20210609060910.1500481-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This adds support for asynchronous notifications from OP-TEE in secure
world to the OP-TEE driver. This allows a design with a top half and bottom
half type of driver where the top half runs in secure interrupt context and
a notifications tells normal world to schedule a yielding call to do the
bottom half processing.

An SPI interrupt is used to notify the driver that there are asynchronous
notifications pending.

Thanks,
Jens

Jens Wiklander (4):
  tee: fix put order in teedev_close_context()
  tee: add tee_dev_open_helper() primitive
  optee: separate notification functions
  optee: add asynchronous notifications

 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/call.c          |  27 ++++
 drivers/tee/optee/core.c          | 104 ++++++++++----
 drivers/tee/optee/notif.c         | 226 ++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_msg.h     |   9 ++
 drivers/tee/optee/optee_private.h |  23 +--
 drivers/tee/optee/optee_rpc_cmd.h |  31 ++--
 drivers/tee/optee/optee_smc.h     |  79 ++++++++++-
 drivers/tee/optee/rpc.c           |  73 ++--------
 drivers/tee/tee_core.c            |  37 +++--
 include/linux/tee_drv.h           |  27 ++++
 11 files changed, 512 insertions(+), 125 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1

