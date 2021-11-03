Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB6443EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKCJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhKCJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D42C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 02:03:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r10so1438623ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJY8BVmSGkgTm20CsRqOlZqDh54ZnLLnIcGJozAZVtQ=;
        b=pbU1z0Vj5sHJUKmosC+O+X4SNnuCMgsM5oZhO7615jidEjVdb6lSRxFrXXLEdOY46l
         QWln5hwE96k7MpKskbrGrm5mZgqEhABOT9+KVXD8oXhz6z0opaQe58AgUEuIEOaQXF+4
         MYxSC6P99XZf0KAxhklD5JnrHdm63D77PYY6ivSpekrPqZXgTGgNbA0pTLsJNanngOWm
         39u4I3/DFjm6bVvpejl4RnLO+CNG18D2SuTgjp++8lTrO77zuYTaoUYD1oWBi6O/UTHd
         yVFytaN4bR734pwXvzCqbABNxVdvqpEtnSr/HLHnASvhxN/XjCQFvC8P1sL0XnvltfKN
         s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJY8BVmSGkgTm20CsRqOlZqDh54ZnLLnIcGJozAZVtQ=;
        b=LU+YcLFCYo0p4dSAnS7nziErj11A9grgOewS+NGFFmIpPa2J2GQufMxtM/IohzM3Ux
         1I+vvv11BQdk6IPpxZvukZFbXtDB2/ccbp8ZyAtabQiePS94yv09wTj3UEfY/NUlzIcV
         2tGaFmMoDxIlhn3OLKUt4FBOJ9XIlSAXiXrew2X+l78maAWOitHC6yu0QhLHmuQWadiU
         eUpXaYHhqkYeJCV6DlWAtantUztUG6mnZsxkJ6VeofJ5VdYbFV/OsA5ehfMWZPUfo5Kn
         DH1Ghh+fmbV8hm7q2y/fK6Ht9mnmvc7QtwX1ADmcbIcmJ2b9aqQDifay0Qw44MolxU/5
         32ag==
X-Gm-Message-State: AOAM532eA65WXdSlMomLPKPRC2uwo8JS9WHJJNadJ/4upiUh2Y3Mn+ie
        XZw7+hGVa2Gkhoh3xE7wKUr3655SsXyUJQTOR9I=
X-Google-Smtp-Source: ABdhPJwf6qkKTCAxHYBhHAVkgqQC5SAOerKxxzgblePi8wBo76Wk366WL9aI4kfaHjV/5FosvmDJgw==
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr19893084ljr.272.1635930182081;
        Wed, 03 Nov 2021 02:03:02 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id w16sm124373lfr.233.2021.11.03.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:03:01 -0700 (PDT)
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
        Marc Zyngier <maz@kernel.org>, jens.vankeirsbilck@kuleuven.be,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 1/6] docs: staging/tee.rst: add a section on OP-TEE notifications
Date:   Wed,  3 Nov 2021 10:02:50 +0100
Message-Id: <20211103090255.998070-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211103090255.998070-1-jens.wiklander@linaro.org>
References: <20211103090255.998070-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a section on notifications used by OP-TEE, synchronous and
asynchronous.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/staging/tee.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 4d4b5f889603..3c63d8dcd61e 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -184,6 +184,36 @@ order to support device enumeration. In other words, OP-TEE driver invokes this
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
+   edge-triggered interrupt and a fast call from the non-secure interrupt
+   handler.
+
+Synchronous notifications are limited by depending on RPC for delivery,
+this is only usable when secure world is entered with a yielding call via
+``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
+world interrupt handlers.
+
+An asynchronous notification is delivered via a non-secure edge-triggered
+interrupt to an interrupt handler registered in the OP-TEE driver. The
+actual notification value are retrieved with the fast call
+``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
+multiple notifications.
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

