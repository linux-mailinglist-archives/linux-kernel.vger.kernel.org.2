Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046903A97B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhFPKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhFPKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:39:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52702C0617AF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b37so3068268ljr.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPEFf1WmEOew3wXqjPL0D4ZH5STaPbCOCI4W4KStU94=;
        b=Wu0BlJMGLIrf/wOevRIS+XR+4dQDCMwD8EDfGBMUGP9eS4FoIpWnzRXM1+nWTx/PpE
         zToRutj8hVoI0s2/HTDsJbO4QPRiQw7Yorz6tX63dgDzXwiKiqqilSNNMbMbI3v7GIL+
         tdA2noUiH+fRxWUksAcFbOfRxQu+zO4B3uIfdND97u00fe4zT6R5E1c4iYEhrjRIZbP5
         Ou2w5IOhBBxFnuwUqANSnElUDnjy3dZkBJPQJ8qk32ysCSkFhOvYi3MnfhyNnyBXB3Kj
         lkYkpOfFxOyT+YgKH03rlUjQH5qZd4DNdQVdIeK5Kt64i6oq0XQKdxnyC9O1/vkH+JxH
         B3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPEFf1WmEOew3wXqjPL0D4ZH5STaPbCOCI4W4KStU94=;
        b=oOYx2ISkPGr2QJd2YaKdpiOKjNF+rGrab/aI31R6Fv0qv/3kkIUFxjUq59S5dhjwbM
         AsPC4VNkLALsfm3XFZcTS5ajg68bBLhKVbt0HvkGeiT+FXuPE4iOVjGJcm4oKcFbBHkv
         K2UaoBCmIiQ2Uq36gZ9FxVL4NR1yBW8QewU4HmfZ2jTQdLH8M6uyeyeJQb6QlihSutgt
         3fUErsN6qfIqUgFA2Swjl1Ht/aRUVsc+yW0rOnc9dKuDCigVOOgWRTc8zfQKg1xOec/c
         HaSLnnl84sRk0R7fQSnsUt6j2O/029fyhNsTEAZ5QepvVjMGwc4QbunJBdnUy9DSZcBQ
         eFTw==
X-Gm-Message-State: AOAM532is3LovQUKxYlRAUoSizGInMQBU1vrIZde8XxkDtCoO8p5c9dp
        4vC6SA6G6hKDrrKR2niNk0cZVVmCJoFd2A==
X-Google-Smtp-Source: ABdhPJxUQQnMedGG2WIOuUWHj2MtSIPkky3Mq4+PSdmzlf6IblLKi4pAsrlJngyW2WCidlJrTITXsA==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr3865559lje.361.1623839830434;
        Wed, 16 Jun 2021 03:37:10 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m17sm205621lfh.288.2021.06.16.03.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:37:10 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 1/7] docs: staging/tee.rst: add a section on OP-TEE notifications
Date:   Wed, 16 Jun 2021 12:36:43 +0200
Message-Id: <20210616103649.2662395-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a section on notifications used by OP-TEE, synchronous and
asynchronous.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/staging/tee.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 4d4b5f889603..37bdd097336f 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -184,6 +184,33 @@ order to support device enumeration. In other words, OP-TEE driver invokes this
 application to retrieve a list of Trusted Applications which can be registered
 as devices on the TEE bus.
 
+OP-TEE notifications
+--------------------
+
+There are two kinds of notifications that secure world can use to make
+normal world aware of some event.
+
+1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
+   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
+2. Asynchronous notifications delivered with a combination of a non-secure
+   interrupt and a fast call from the non-secure interrupt handler.
+
+Synchronous notifications are limited by depending on RPC for delivery,
+this is only usable when secure world is entered with a yielding call via
+``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
+world interrupt handlers.
+
+An asynchronous notification is delivered via a non-secure interrupt to an
+interrupt handler registered in the OP-TEE driver. The actual notification
+value are retrieved with the fast call ``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``.
+
+One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
+special meaning. When this value is received it means that normal world is
+supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
+call is done from the thread assisting the interrupt handler. This is a
+building block for OP-TEE OS in secure world to implement the top half and
+bottom half style of device drivers.
+
 AMD-TEE driver
 ==============
 
-- 
2.31.1

