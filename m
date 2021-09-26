Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA39418A63
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhIZR7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhIZR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 13:59:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DAC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 10:57:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r23so19699361wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iBY804phrZguMBrW+AtI34S4xk8baTszOfWKGmoDKLQ=;
        b=pBnfAlQ2CZIfD8ubwcN381NEh1dBbSQs32Xnyg5NkKGV3L+qg1qvmqkFSHE75IsrBW
         kSAb78TnTaHITpIIuC/6Nq2ygeZLDr2RCep76haNyZKz1/KmDqkDHoWylNZ6Wh7WkGcJ
         boOaBJF0p73BjpcduMXhDGDxtWx4uEDN0R3hi3vsyp0oQ2ibIaTXI+UCDoBtA1FMSEtE
         gkyzBg3EjcnUSBbOtpwAV6n+GpOObpzz/jwZgvNX7u37CfwKyp7Ab3Q+LdQ7nqVSkCMd
         09COLPEJIKBbFyWBvjbtodbgtzbKJIIV25SGHI6F+6BhrV3vj+S3Kll6O6mroi6OqYLe
         yFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iBY804phrZguMBrW+AtI34S4xk8baTszOfWKGmoDKLQ=;
        b=XPWJxdJgDp85lwKhudNLvmaOL1RR+4vCyRtwlNhFltU1ZsizMD5bIuR1R+weRENhJA
         hW/ImQ2g71YxaXoArqylQ7nbuuqSpryV1YxcV4cS4Yx0uYsGVSMY3VSK5o827gp6iUVz
         IigkA7AD8K7XuKpXzZ2ZoNuypFKonbG5qk/41vkh243PjDkpflFvYGiCZl0m5aoOcwFT
         njxkxNhledHcwA4zOxsOnL8VKb+dk595JwKXhPC71DbiSb4MchDkF/ZUFkZkf+rTS3bw
         ondTqg3fu/2TqOyWMzITV6Mvl+oz+PqXWtrD97EH+KimsytsenK5plnZXtbvqM9Jm/Vx
         vvFQ==
X-Gm-Message-State: AOAM533myBOMCc+sySFMuXOV001OHOkdibbaESsfm2F2fEv+xvTjNPsd
        x5P/kLFuIytbsr6P6nxpgm++ickkLCYmFw==
X-Google-Smtp-Source: ABdhPJyxW2u5jGF2mMA8R1UimD/q9n67CFCef6uE3BCnu/PZyjKKw3kP2ICsjtKee6WauRtEQNDKkQ==
X-Received: by 2002:a5d:464c:: with SMTP id j12mr2241491wrs.261.1632679043351;
        Sun, 26 Sep 2021 10:57:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b8ba:f606:a9ed:a3b? ([2a01:e34:ed2f:f020:b8ba:f606:a9ed:a3b])
        by smtp.googlemail.com with ESMTPSA id 8sm7263293wmj.18.2021.09.26.10.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 10:57:22 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.15-rc3
Message-ID: <15f013d8-d746-6034-bbe7-dc86cd8fbdf1@linaro.org>
Date:   Sun, 26 Sep 2021 19:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.15-rc3

for you to fetch changes up to cf96921876dcee4d6ac07b9de470368a075ba9ad:

  thermal/drivers/tsens: Fix wrong check for tzd in irq handlers
(2021-09-21 15:17:11 +0200)

----------------------------------------------------------------
- Fix thermal shutdown after a suspend/resume due to a wrong TCC value
  restored on Intel platform (Antoine Tenart)

- Fix potential buffer overflow when building the list of
  policies. The buffer size is not updated after writing to it (Dan
  Carpenter)

- Fix wrong check against IS_ERR instead of NULL (Ansuel Smith)

----------------------------------------------------------------
Ansuel Smith (1):
      thermal/drivers/tsens: Fix wrong check for tzd in irq handlers

Antoine Tenart (1):
      thermal/drivers/int340x: Do not set a wrong tcc offset on resume

Dan Carpenter (1):
      thermal/core: Potential buffer overflow in
thermal_build_list_of_policies()

 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 5 +++--
 drivers/thermal/qcom/tsens.c                                     | 4 ++--
 drivers/thermal/thermal_core.c                                   | 7
+++----
 3 files changed, 8 insertions(+), 8 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
