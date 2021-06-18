Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A383AD328
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhFRTxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhFRTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:53:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:51:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m21so18426709lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPNUC1INpkBGp7L0c6yR9HA1R8pzzjkYXv1R+/dnXdc=;
        b=JbpUejWIGvdWnGdaScvOssgSjlQOm6+oUTSDMXhPVQU17pxE44HrVju0YelRoaFNhI
         j63avYLtLaX7KWvuQNZZ40b4KqNxCl8kLOCGy5dnSL3ukn0FvO6D1xQYhDXtwS4x/Iyl
         uqeoUquKOq1oEsEBOVVL1/DMrMnrozFtlAZU9IsxEHSQycwtRdaYDaPwMjAiRnwwCrEj
         lLe6Xsf0uvNluuIP0veR3+Dka65ddrYNIFUAZ/qw5zyM5rc7MFQaB2UB0iyd6h/4eWI1
         Dyyn18WMyPfrSeHIMlhOzEnQrbbYog2eyq36FGpxY2cW1GRBbHSeUyNZP49WR3IT3W6q
         G+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPNUC1INpkBGp7L0c6yR9HA1R8pzzjkYXv1R+/dnXdc=;
        b=oVk5EuAzgCh89f6/+mCrbYRJWM0xjS1C96uDwWPyt9uZAeNUjqtkAwwoshBbUUzugd
         FOT04iaSo9A+3YY7alHW8OrlKd0glEESdZHb3Ax2u4j2pBjVkOrlHeMe9vuEvsEClIVt
         iJ2PE1SHsf54/MEIe2nyaKe2CvSIaO/IsoLgD4UsP0KYs6grnzA/y+S1kp+EkubsBdnG
         UaMJzZoDtUVkN1m9/82rd/ffvJqztm2+4lLtMaNfi6kcM9E9aczSyGDLvKa0c/bOUNtg
         44rL539XIw99QMFk4g7Pa+ZkOJKhUU5DVynz1ULJet+4rnq5dXHmtD7jytH6iydcun02
         URBA==
X-Gm-Message-State: AOAM532W6l34acnh6cwUWz+tFUrNcsxaIaK1joDBIKT5waeeWcplGSZt
        ra2gJVP2hz38J0lIBdZ+l9eL2g==
X-Google-Smtp-Source: ABdhPJwSCScqwnEQQilC7ZOKJUU/HzRiR2R7hdC02vTd9iU32d4X7neASyXaR24rQhCDirfjQi57qQ==
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr4585528lfv.181.1624045858969;
        Fri, 18 Jun 2021 12:50:58 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id o7sm993221lfu.215.2021.06.18.12.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:50:58 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        grzegorz.jaszczyk@linaro.org
Subject: [PATCH v2 0/2] introduce watchdog_dev_suspend/resume
Date:   Fri, 18 Jun 2021 21:50:31 +0200
Message-Id: <20210618195033.3209598-1-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following is a v2 version of the series [1] that fixes system hang which
occurs when the ping worker fires after wdog suspend and before wdog resume.
This happens because the ping worker can issue low-level ping while the wdog clk
was disabled by the suspend routine (accessing hw wdog registers while they are
not fed by the clk).

To overcome this issue two patches were introduced. Patch #1 introduces pm
notifier in the watchdog core which will call watchdog_dev_suspend/resume and
actually cancel ping worker during suspend and restore it back, if needed,
during resume.

Patch #2 introduces relevant changes to imx2_wdt driver and notifies wdog core
to stop ping worker on suspend.

[1] https://lkml.org/lkml/2021/6/15/542

Best regards,
Grzegorz

Grzegorz Jaszczyk (2):
  watchdog: introduce watchdog_dev_suspend/resume
  watchdog: imx2_wdg: notify wdog core to stop ping worker on suspend

 drivers/watchdog/imx2_wdt.c      |  1 +
 drivers/watchdog/watchdog_core.c | 37 +++++++++++++++++++++++++
 drivers/watchdog/watchdog_dev.c  | 47 ++++++++++++++++++++++++++++++++
 include/linux/watchdog.h         | 10 +++++++
 4 files changed, 95 insertions(+)

-- 
2.29.0

