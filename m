Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA03F0176
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhHRKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHRKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:19:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:19:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y7so4181219ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3e91kQfirH6a922fd9k6DmPw5po4wAqiN1XqXe8pum4=;
        b=Q8jjU+n7MIxJBH7wrWILgYWYOOJrsba3lzg9ln09V3DshmPDoPwzTVnksd12xNrA9g
         ZRZ5NkmfwWJpFgdN37WlkhmIsKAcMPfgWNUx0Urb6hL9DMBiK0TFfvowwKxbklKoc9M2
         KlypTgmPDzfA5i72/QYV0jpIhhXskpBFP/muUoLCS9SUu9gaXHyTXWuK8JTbPv96GRg1
         rJyxsnLCpb0S1+50091V1Kc5VrJOj6yqmgNJOTAT0oIlQCorj1MHPn/I90fTnzfQ0RMG
         1Ej6QsPKge03MgT1HtU5OOaDuQCjZjxfmyjANldUQH/RqsUota3x8pLCkgVScyUiQXdo
         uOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3e91kQfirH6a922fd9k6DmPw5po4wAqiN1XqXe8pum4=;
        b=LrY8V38T1ZnLt4N7Ib/jFt0SyXts8Ds9mI6gBjcEk3EXnyBDIYnQQCTiS+FNhQGPGE
         dC8qYBHgyNvJkck/1OgVA2u1uxVZpaRtfUYbACkKHaELGenaFPZ0pelHMaNeRkoR42RU
         dLLZQl8v9gruiiQ+m1h01ixTd4KRD28l40iRN/7jhWZLBctu5n/oP/T6aZ7hw5/rdOz/
         VnWv+DkLqd4zZU99EfviSdH779m9ENnuys6KrfRiMMqgNwR0bMgVgyeEfmSyHlEMnPJU
         7waSb4gH5eEmnp3uK6P0MBncqqV7+35K9MnafzHHBGvoofLy+ANkqfkRuHVkAD0sYzip
         M6Nw==
X-Gm-Message-State: AOAM533AiEQFzWXUq3N3RdbSKs2MPRsYuNTRNW+wuT4I/Mnjgx2xUn6h
        eVG5G4XGr2WduvpWbcCpfZyOZ/D/Wvm6IjiV
X-Google-Smtp-Source: ABdhPJxKlRCwnxfG5a1PM1Jrxd62jjhZ8/Bvf9gyq+mVIpPUefjihry3BTpVGdJK8Fe4SaWiaRJDFA==
X-Received: by 2002:a2e:a370:: with SMTP id i16mr7355475ljn.444.1629281946193;
        Wed, 18 Aug 2021 03:19:06 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id l27sm451160lfp.245.2021.08.18.03.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 03:19:05 -0700 (PDT)
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
Subject: [PATCH v4 1/6] docs: staging/tee.rst: add a section on OP-TEE notifications
Date:   Wed, 18 Aug 2021 12:18:44 +0200
Message-Id: <20210818101849.602257-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818101849.602257-1-jens.wiklander@linaro.org>
References: <20210818101849.602257-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a section on notifications used by OP-TEE, synchronous and
asynchronous.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/staging/tee.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 4d4b5f889603..951f07dd026b 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -184,6 +184,35 @@ order to support device enumeration. In other words, OP-TEE driver invokes this
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
+``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``.
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

