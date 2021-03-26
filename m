Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5234A121
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCZFqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCZFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:45:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB6C0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:45:47 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q3so4171466qkq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H0nKKN94g3rEpQ8UJAWbnPHo1zuRCqzXoAQHyyq3QlQ=;
        b=cEWJ/SIeapNso5pKH9Q2aYpL12RrP9MrsKFp3ziuSgwdwmwOp72ediBpmsbw09n/Ii
         X+0HWsztbEC3fNldp8zJrpSO8Fs7NvIaB0Qk/3l7zwZuMVlcAeKJ4c0K1ztcRM0zRdm4
         j4DTBTUHUqmqkzqP3lMGCN6+JfjEY/pMZR4WWG+u17t33ciz+A+doDxnv2l7CrSffKY8
         JQ1DmNFvALbaQju5wjcuzWXTnkg7vwVrjoVRCjch/tc91yMiT9zrfWITuqwgUgo560vu
         LtlM/XBcmrNfF+Xyx8x5ea6r3jqVdnPMpu9L/iHoTg66MjMhVTdCgMMRGbHQ0BK+BSM/
         WYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=H0nKKN94g3rEpQ8UJAWbnPHo1zuRCqzXoAQHyyq3QlQ=;
        b=gEE2cj22NJyPR8ui9prnYiiWD88yHAsg3rnLdT+cZwsA9P2JcCjCK+1qtjvGH0LiVE
         s5rTzxpHr4dgkyHUVf/zanHRCEVkHdNe7Srobh9c07OqCofskhKZgOSMQ9pbxYh1t2yO
         L0+B9H9IAj6k2dGKgAmN04p8lGGfyZmq4Evb0RF03+m8B8SaAqO+E56VgJW6mq5yoqQe
         KllSN9LrxbU0QkaH4GG+eaw0SLwA2by6N/9pYSUONmvqmCOmcim/PD9JBid8SGWQ54w1
         86Eigflij2GzsU2ayF2XEq8nQ9s091praqoTuW2/jHaRIHPW8EdCzkhR34GhY9Pv7WTX
         ylqg==
X-Gm-Message-State: AOAM533iDeb+6Fg5bsTvIAQfMDpPzR6wzhdFiKi13HG4yIZnIhTMLF9a
        aZCEWAwC+niNwvxLge4k6HA=
X-Google-Smtp-Source: ABdhPJzfl7bYQlAzbCwNGaX9TnzFrX7G4r4KcPhWEUX2BBmWcK0DckBJWZGV5TUfnpRz4TfIyB2hCg==
X-Received: by 2002:a37:78b:: with SMTP id 133mr11452198qkh.109.1616737546500;
        Thu, 25 Mar 2021 22:45:46 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id d23sm5827566qka.125.2021.03.25.22.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:45:46 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] drivers: staging: netlogic: fix unmet dependency for PHYLIB
Date:   Fri, 26 Mar 2021 01:45:33 -0400
Message-Id: <20210326054533.48751-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NETLOGIC_XLR_NET is enabled, and NETDEVICES is
disabled, Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for PHYLIB
  Depends on [n]: NETDEVICES [=n]
  Selected by [y]:
  - NETLOGIC_XLR_NET [=y] && STAGING [=y] && CPU_XLR [=y]

This is because NETLOGIC_XLR_NET selects PHYLIB
without selecting or depending on NETDEVICES,
despite PHYLIB depending on NETDEVICES.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/staging/netlogic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
index b2a4d4586697..e1712606ee3c 100644
--- a/drivers/staging/netlogic/Kconfig
+++ b/drivers/staging/netlogic/Kconfig
@@ -2,6 +2,7 @@
 config NETLOGIC_XLR_NET
 	tristate "Netlogic XLR/XLS network device"
 	depends on CPU_XLR
+	depends on NETDEVICES
 	select PHYLIB
 	help
 	This driver support Netlogic XLR/XLS on chip gigabit
-- 
2.25.1

