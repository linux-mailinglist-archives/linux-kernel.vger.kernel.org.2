Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4B379B90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhEKAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhEKAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:31:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937AFC061574;
        Mon, 10 May 2021 17:30:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t11so25977290lfl.11;
        Mon, 10 May 2021 17:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaKpOVYs51TkiQrnYxtfnQwNocRssc+UCyct27FeBk0=;
        b=sLityj1pAMNBz1mkMvhO8HZMwCcW8/XzOyLOeOQijN5D22no704dCMDvGZOCTvcREH
         jTF6Al0D37T+t050t6lN29IkE00KhJwlR/C9oDE7IQZEA3WO09AFghWfToM4wN56Fvdf
         Z/124aBGsofxCWT25jwUYuT3k9b5AtoP0hHSL1tzGpfbSeEIOS6r8Ce66pyB8AmZGrCt
         6h7ccoLQMrKVWxrFlAKb3z1fyxg9hwBHQ90jponHYGPxXLuiCzzTw/mzCB60sjlaMDTC
         T+VXGcHocIwa7ThGCoSkD0NmDqDkS1B9nBxSfWz4hYU4P7z4LxCKPodv8wSHfju/j8Fw
         bdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaKpOVYs51TkiQrnYxtfnQwNocRssc+UCyct27FeBk0=;
        b=M3MnvcPY+zWvfeLLK1h7UrtkBMq84ZkwWJ4Ql8ahUNkS0rnW5aj5uUnxrXC8xs/+Ii
         0JYsiqYHFzFa5Q3D2QXYG5364Fkc/AiH8q9CGV1SQcLn7+ApjEkhdABSif5A2oc1MmL4
         Uf5IkZbcE4q3RZEiT5qJIn+SdjHYy77JLxm/3j7lMMZVjssWW1qfsXL6Qp008woHV+AI
         WvZs0op9ozFIxYIG839O0dKvoQf2QI/YqPtzT8QayCMlNqp97Bp/EYHW/RZ0wwJU42Vs
         CHdJoOZy8l+JkXOoNpA056Ta6U0E+KEVyDyyV9StcDrpGA7B04lIUGl28lx6IRDfuosk
         ay3A==
X-Gm-Message-State: AOAM531JvklP+10gC6tlswVXDI5IeqQE+LSXJnomxi2MBp5qZa1grEbk
        BiX/a3IxvSGycYP0S3qpW58=
X-Google-Smtp-Source: ABdhPJyX3/DbnNaFezK5bh0ZTSRWncJd9VxxAaC29kb7R9SQ9T+YyxM91625TDatGXa09hJ4ODhfCQ==
X-Received: by 2002:ac2:484a:: with SMTP id 10mr18603917lfy.392.1620693015186;
        Mon, 10 May 2021 17:30:15 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id x62sm2418025lff.295.2021.05.10.17.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:30:14 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Increase timeout for HC halt
Date:   Tue, 11 May 2021 02:29:33 +0200
Message-Id: <20210511002933.1612871-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices (specifically the SC8180x based Surface Pro X with
QCOM04A6) HC halt / xhci_halt() times out during boot. Manually binding
the xhci-hcd driver at some point later does not exhibit this behavior.
To work around this, double XHCI_MAX_HALT_USEC, which also resolves this
issue.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/usb/host/xhci-ext-caps.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index fa59b242cd51..fb591e41cd50 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -7,8 +7,8 @@
  * Author: Sarah Sharp
  * Some code borrowed from the Linux EHCI driver.
  */
-/* Up to 16 ms to halt an HC */
-#define XHCI_MAX_HALT_USEC	(16*1000)
+/* Up to 32 ms to halt an HC */
+#define XHCI_MAX_HALT_USEC	(32 * 1000)
 /* HC not running - set to 1 when run/stop bit is cleared. */
 #define XHCI_STS_HALT		(1<<0)
 
-- 
2.31.1

