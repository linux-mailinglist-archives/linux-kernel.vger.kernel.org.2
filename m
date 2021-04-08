Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD9E358AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhDHRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhDHRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:09:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F5C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:09:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z16so1863118pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKP5uzY1vUJqutzVdh8HfO5V6lcloeop8soak6Xb7Ms=;
        b=QBLbMFXhmM8mm2tuvskbVwyq01GaENaNKLjh8CAQ/tSEkvQAouisttLj/lijX7mi4l
         flTgtPcdr/bj+cBZvSZkp5TW50zDvhtWz3rS1P5i/x+tALV+Lwqyr/yytRHA+7TDy0LQ
         JqkrrP+n58z4VioGtjU+T0sDCXqiiIBOLrzdnGiZfhkGNkJ0CMsl8JgCfdca4cdrNb2g
         QmZRBvTvj8gCSpQVgcHZdwPTsjhzb4hzlxQ0JSukbcw10rabHOTVPKAZdPygyuRsMTLA
         brDXMmEzNvUVNBaJIcPlZOWVWoCJjrsnnNubCeHG/h8dYEywtCj+Xm35iIukla3Qx7nD
         Vo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKP5uzY1vUJqutzVdh8HfO5V6lcloeop8soak6Xb7Ms=;
        b=r3DKsWuBWSmsHoTW8h6VuSp4A8HZfZU8HRfdghhJTu+QzSIhcYjKzJ6+WRB+1Dtm3v
         91b64x+/QVdlFATbnWLX/wfFx9xG1u3xdIFGqVG/qGLvsf4SD9d+5R07VQzlLixIINgr
         wOhXFFU/RefyONH1u+v1bi1w9/hnGKYHsAiiYFypSuQOxifDiFdj18DbHjvEa5TKcBkX
         ZI6IxrOaPKVR2gXNQTGrfxHFOBZ+gxYJLQ9OYNtnuA160a2JD0FAQnCzwLhf5dCSerih
         cFNZYoMrJMwSIvKw5btcLOamdylwiV87vow2By3PGCy3Fjv4IjgpDBfjK3pA1DNV8Epx
         VTeA==
X-Gm-Message-State: AOAM533SJkzVDjkYgCXGG6/m1JzLOZrBIZcYOB5FTySQvAiyxe+rZ8v7
        GC3WmoSfiIKm7SAOiau/KOI1
X-Google-Smtp-Source: ABdhPJyErrR5yuOzP5kpGYcwbqynHPO1ZHIWJc5W/k6EQCFviH0+gc+FFM+BIEHpL6NwuR0yH0s95g==
X-Received: by 2002:a62:52d7:0:b029:224:6be5:ab22 with SMTP id g206-20020a6252d70000b02902246be5ab22mr8604010pfb.63.1617901784151;
        Thu, 08 Apr 2021 10:09:44 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id a191sm57921pfa.115.2021.04.08.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:09:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/7] SDX55 defconfig updates for v5.13
Date:   Thu,  8 Apr 2021 22:39:23 +0530
Message-Id: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This series updates the qcom_defconfig by enabling the drivers required
for the SDX55 platform.

Please consider merging!

Thanks,
Mani

Manivannan Sadhasivam (7):
  ARM: configs: qcom_defconfig: Enable APCS IPC mailbox driver
  ARM: configs: qcom_defconfig: Enable SDX55 A7 PLL and APCS clock
    driver
  ARM: configs: qcom_defconfig: Enable CPUFreq support
  ARM: configs: qcom_defconfig: Enable Q6V5_PAS remoteproc driver
  ARM: configs: qcom_defconfig: Enable SDX55 interconnect driver
  ARM: configs: qcom_defconfig: Enable GLINK SMEM driver
  ARM: configs: qcom_defconfig: Reduce CMA size to 64MB

 arch/arm/configs/qcom_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1

