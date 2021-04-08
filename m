Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DB3587E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhDHPK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhDHPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:10:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87AC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 08:10:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso1438799wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bJO3m9kpFM7FzruFJ4qQ0cN3krVAmVb4P9PPJOl2Fyc=;
        b=oI5ASPtwtc6yZAQX4+FRjEYgySPWc9H+xcfFFIG+kp6YE0eDHNGnqX3l+BxlHHE3tL
         QicTstREGHPzmgX047l8rctMIN8ZYYTs1/D9yHBqCk+dIzDY9TcN8ckkadaclQPNslH0
         5+ucPAcTueRguY2IfOEn+XlxYWQPsT03O4650mSjEf6pkjMenxk7NrV4SLiRyvBO1T9R
         OW92ZclZaz9eS6F9oIv1p970ljI3mei4RJiA5Zk2cudcsjvOzeTTpp+pPPrtcEO6g+5p
         ilfF8HUO6Ku0ANak5rHUHd/ovCSXj5zGDUMrZ4Qj/Xn4KTDsQ8ywNVkIi0EE+PlHaO8L
         5r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bJO3m9kpFM7FzruFJ4qQ0cN3krVAmVb4P9PPJOl2Fyc=;
        b=Q0/or52AJyc3opNUHOL0hVjzvq5Bq6nTiJeXihbt/WDScwTGD8qzvKV1X43ZAO8kcK
         GuEZd9EmIyY/p1A+aFLrn9O91cCTJPyaAg2qST/bMsLw8VEQY/6F7slF9adVxtz0NY1E
         y7a9GV6g3fmfMHpi3Q+0NaNPgMg7ZKSvpvt3jkPo5WvRHqiXhfjW05fw21M6mp/onYe+
         Jg93qIepfsx28CWqEBL4JHyjJHldGIheCxmBa8IqsaTxOyzYHWp6tp32vWJzXVrkeA8m
         Y1stLxkeNE8Fn3S0YL+yNb43Y05OQsclhIzPB83XL+YKsWZ+Pr6CDVW3Onmk7iRO56j7
         0IFA==
X-Gm-Message-State: AOAM532V90s0nXrDqj9hFn2t8j2XdsUlIaYuXuvBLdSIDIC0GmXnVq/7
        rCBUTJ50+0RWjduYS7jOSiYDZg==
X-Google-Smtp-Source: ABdhPJw05yk6Np0QciLv6Xuo6fNciMVJVijaQUICwN3sn6qXk5IAofBNlFDW3jtU8gHjlmNU95KiSg==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr8820195wmq.25.1617894613180;
        Thu, 08 Apr 2021 08:10:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9407:6619:589b:441e? ([2a01:e34:ed2f:f020:9407:6619:589b:441e])
        by smtp.googlemail.com with ESMTPSA id l13sm6211336wmj.3.2021.04.08.08.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:10:12 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, He Ying <heying24@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle for v5.13-rc1
Message-ID: <03743d3c-a3bf-066f-614c-1a49f566fdb2@linaro.org>
Date:   Thu, 8 Apr 2021 17:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

please consider pulling the following change for cpuidle on ARM for
v5.13-rc1

Thanks

  -- Daniel


The following changes since commit dde8740bd9b505c58ec8b2277d5d55c6951b7e42:

  Merge branch 'acpi-processor-fixes' into linux-next (2021-04-07
19:02:56 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux tags/cpuidle-v5.13-rc1

for you to fetch changes up to 0beffa4e524f3989ac31fe8563348d45a87f7314:

  cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration (2021-04-08 16:49:19
+0200)

----------------------------------------------------------------
- Fix the C7 state on the tegra114 by setting the L2-no-flush flag
  unconditionally (Dmitry Osipenko)

- Remove the do_idle firmware call as it is not supported by the ATF
  on tegra SoC (Dmitry Osipenko)

- Add a missing dependency on CONFIG_MMU to prevent linkage error (He
  Ying)

----------------------------------------------------------------
Dmitry Osipenko (2):
      cpuidle: tegra: Fix C7 idling state on Tegra114
      cpuidle: tegra: Remove do_idle firmware call

He Ying (1):
      cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration

 drivers/cpuidle/Kconfig.arm     |  2 +-
 drivers/cpuidle/cpuidle-tegra.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 16 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
