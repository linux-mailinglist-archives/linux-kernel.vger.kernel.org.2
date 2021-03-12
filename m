Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75F33932B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhCLQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhCLQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:24:56 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:55 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y13so2215867pfr.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLPYqdvg9MFVJ4vgEAAqaEwpKmLxtxoj80nZ7ASbFTw=;
        b=gGBk5i2sXg8XfPoDZIGwKeoBZ3o+Q2za8Akb+lk6i8b0iin+UFMLlkD86TAEbW0h50
         2pHwcpvBWGcACPe2uapXqofrp9XZpB/dU8I/WuqJRgo6eYFOobgJ2a0bY3m3FAbamCNr
         eJmEg5cAlZO1k52FhpswI+Nm9v13XUJhTWPcW4HTr+/V/G7IcK7KLY01rSHGrJEeVqIT
         eLmlozDgdi36Ema2omChbE9LcgPpxi/8om4ytlsKXRxaxMHJhEkha2/CHv96Tx/GgU7a
         PM6fAvU2Chub8oQDDV23TXxTiJyv9WzyBlZrUiXAhMW/o7TTW3mjVK2x13MlBeikTtzo
         Wgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLPYqdvg9MFVJ4vgEAAqaEwpKmLxtxoj80nZ7ASbFTw=;
        b=ODNJtZ7dSbRqjy65Q5MKvd/GJnwn7U0c4EuG6cTJ6ld9sElkocS8JKDesFp8xJjAKt
         KP7euFf7TasBF7olsWl9uqTccdyNO5X6GjYKnGGliApQ3S+b/Nsf7Ae4DouPKIEu/FAj
         RJ1XrDxjG224C6H3wae8qvbIyCoV2Sl2+HZ+kekN0lBLIGkkE6jy7+a49cvf1/MMF3wx
         2H4yVwDBafolrqkIfOODjt0Lx6xGr+YLOf/o9u5mL9vvhJ0t+I1zAxp177RFaBpxOnEQ
         yWVvRSgIoGXblY7mC6xWh/SF4I26DZXmI2roJxQgbGpiZthPmxQiHW3asQFshlyu+qHN
         g86Q==
X-Gm-Message-State: AOAM531eRvFK+wM/OXLW2kAi93sbGTkyq/eqJOqJ+yEuBHBintveQg6n
        70McpNS6/QCGkCIQizw4RJ63zg==
X-Google-Smtp-Source: ABdhPJwSpltrCO0OnpdZMIJb8pP+93hJhPCIK5TilQeex21X3PF2rwNf/G+LSkE/z7+rsuAaQIu6yQ==
X-Received: by 2002:a65:5a0a:: with SMTP id y10mr12576669pgs.285.1615566295421;
        Fri, 12 Mar 2021 08:24:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:24:55 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 00/17] remoteproc: Add support for detaching a remote processor
Date:   Fri, 12 Mar 2021 09:24:36 -0700
Message-Id: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set provides support for the remoteproc core to release resources
associated with a remote processor without having to switch it off. That
way a platform driver can be removed or the application processor power
cycled while the remote processor is still operating.

This revision fixes a couple of minor problems with patch 11 and 12 as
pointed out by Arnaud and the kernel test robot (detailed in the change
log for each patch).  Other patches have not changed.

Applies cleanly on rproc-next and v5.12-rc2.

Thanks,
Mathieu 

Arnaud POULIQUEN (1):
  remoteproc: stm32: Move memory parsing to rproc_ops

Mathieu Poirier (16):
  remoteproc: Remove useless check in rproc_del()
  remoteproc: Rename function rproc_actuate()
  remoteproc: Add new RPROC_ATTACHED state
  remoteproc: Properly represent the attached state
  remoteproc: Add new get_loaded_rsc_table() to rproc_ops
  remoteproc: stm32: Move resource table setup to rproc_ops
  remoteproc: Add new detach() remoteproc operation
  remoteproc: Introduce function __rproc_detach()
  remoteproc: Introduce function rproc_detach()
  remoteproc: Properly deal with the resource table when detaching
  remoteproc: Properly deal with the resource table when stopping
  remoteproc: Properly deal with a kernel panic when attached
  remoteproc: Properly deal with a start request when attached
  remoteproc: Properly deal with a stop request when attached
  remoteproc: Properly deal with a detach request when attached
  remoteproc: Refactor function rproc_cdev_release()

 drivers/remoteproc/remoteproc_cdev.c     |  21 +-
 drivers/remoteproc/remoteproc_core.c     | 302 ++++++++++++++++++++---
 drivers/remoteproc/remoteproc_internal.h |  10 +
 drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
 drivers/remoteproc/stm32_rproc.c         | 168 ++++++-------
 include/linux/remoteproc.h               |  21 +-
 6 files changed, 401 insertions(+), 138 deletions(-)

-- 
2.25.1

