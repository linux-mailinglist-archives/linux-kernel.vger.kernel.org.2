Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F88402A41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhIGNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhIGNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:55:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E85C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 06:54:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i3so6912810wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=7hpkjbgaQVZzEPZcbH8qOgH0WbER07wryFsX/6Acg0E=;
        b=qeO8T3rQhtcnJGMsGMT51ExH9fK54vgQsOcBqsjsaK4t7L1SVVh9oeWSAENB6JYpT+
         USOtYcwfxelhh5yZNuWvBkelP2ihXbADzMXLWYp+lomDvCkLPepF3mSynPabuRnaTaPq
         SAsm77YO8HFJmtEx+r7YA/GFsW2OWfTUwR4NKLIUK/kwg2RVVaedQBeGZE1BqOhrg6Vx
         NI+btaTPeBrtMRb855daYb1xi4psHe2WksRXSDusbCIdq3D2mWqai4elcJg552BWRrxK
         BpD4TeiarZGEoIKiNMNaYdYTOr3nc1ktcwKum8HcKQNiuEZPDuRDWha7ziIG+VYSmcYI
         JtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=7hpkjbgaQVZzEPZcbH8qOgH0WbER07wryFsX/6Acg0E=;
        b=OqK72X4JzfHl8UvWWNsN05eMBBXlPVRmE/Qy4sgnIBaEowD1Wsok+3t8aTmEG4zVD+
         xSfxGKKQOcAJmXI+z74ghdUmXbYpWxjGBIBMhudYqLWiXpQEip5uX0vAXbKGZePgI40y
         RnPWB0WNvsKeFqQnNV8PMtYcjMIDT7moa7JcsaqYjoqKWJMSc4rDmusrliiYhmu051j/
         LiFU7YClrO30o14pnJgtITiLniCKEKeceLCaozKAtf3zXUaSlevmUgseJ3PYhN69xXry
         B/y4aAmXWUIRB0E4vg8JPn14l8X/2R2s4Zel/tf8jF8ps91mQ/fdHjeedOtNPU9Py8KX
         YqmQ==
X-Gm-Message-State: AOAM530XObVm0/4UOkefGYW85r/W7daI/LPm+205IDoNNi6+qRHgmMV9
        6EapfSj2DytrC1U79Y1DjR1TGJhVED8rSg==
X-Google-Smtp-Source: ABdhPJw9sx8riXQNqBQDdwdAPygBTOxll7ciHfGWan7OxXiImp83Io0PIyI4yVua2c7Ygo/IB3d/ag==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr4086561wmi.152.1631022887940;
        Tue, 07 Sep 2021 06:54:47 -0700 (PDT)
Received: from google.com ([31.124.24.230])
        by smtp.gmail.com with ESMTPSA id n1sm10741281wrp.49.2021.09.07.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:54:47 -0700 (PDT)
Date:   Tue, 7 Sep 2021 14:54:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.15
Message-ID: <YTdvJZ/oLpSKs4mn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.15

for you to fetch changes up to 79fad92f2e596f5a8dd085788a24f540263ef887:

  backlight: pwm_bl: Improve bootloader/kernel device handover (2021-08-19 10:59:03 +0100)

----------------------------------------------------------------
 - Fix-ups
   - Improve bootloader/kernel device handover

 - Bug Fixes
   - Stabilise backlight

----------------------------------------------------------------
Daniel Thompson (1):
      backlight: pwm_bl: Improve bootloader/kernel device handover

Linus Walleij (1):
      backlight: ktd253: Stabilize backlight

 drivers/video/backlight/ktd253-backlight.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 drivers/video/backlight/pwm_bl.c           | 54 ++++++++++++++++++++++++++++--------------------------
 2 files changed, 83 insertions(+), 46 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
