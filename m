Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D533EC21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhCQJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCQJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:02:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A3AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:02:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4971135wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ApKtBPoSIWQUrCpVqiKRCFyvDrL2J8ftPogTa611uXo=;
        b=Pofurp6lLuNNVnbzZViJEc4FphgHvqaEx+4UUzNw9uzdRPg4FL79SjMJDjlhNXhtNF
         MZeWgvBeeSfIU7CEQqBfacL+MldhAZoA1uObz4sIoOHVEp8q0/TeuqLhZAqp3H+JL76Q
         uYFUr7N5UMQC0sSopMaAT5IUD7Tojz6eR+duvDcFLUX2C+ozPmBiiNAW82mn1KQR1/gP
         rulgwUfXpM4BIVafGDAMbqNFSs95abHf4eBa85Nhx1KdioBuP3IC+Vmy6zSw9zOTOv+V
         kwIroFvMRdKbvskJhDsHKUzXVrxvKbhKKqoGKQ3gTrCBP228p/bAmVC39vF4lfthHVVz
         7iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ApKtBPoSIWQUrCpVqiKRCFyvDrL2J8ftPogTa611uXo=;
        b=cmacVSaR+h6tSNb8LDcO31LPWxnghX1P0p0LW1hjcYql47mFw0uVe/ZCMHRKu1TyJ/
         W6OGMVIYvYWWWb4n8urOl0+D5bGcQZVch1d2K1t8ZkCte6dZXgqpQZyDqTorJfj0yBgP
         Sv5S8HHW91Vf23V02vw445S0ZvunITi/Zfq+QgH68JgLghv3eUcr9lOQa0xYVJ2c2h/B
         xODjrHOc8XxABR8DSvYyd6aULtP1bFkQ7w2JeJnJ3pk8gELB2tDIX0l3JfQSKKV+A5Ty
         qN9vUEX7rTf58B2pQBUnetRPuC7Z36ITAt8iMwP4+TLQzVXBLGTiDvKAw5c1jEGf8KSN
         NOsA==
X-Gm-Message-State: AOAM531RTG/+uzBURA5SqN++sDKweLksFZtQT5jMGJaiQlQlnIIo5j/p
        EUivQxypolBuyJ5CpfoohBNc9g==
X-Google-Smtp-Source: ABdhPJztarvfabT2tgmwWehxbS8/7jiw8NqwxYGzn/kk4ZlADIA4gwU2EPIGOp2vpsgDeYHqlzOegQ==
X-Received: by 2002:a05:600c:4146:: with SMTP id h6mr2733051wmm.32.1615971772433;
        Wed, 17 Mar 2021 02:02:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4? ([2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4])
        by smtp.googlemail.com with ESMTPSA id u2sm2317811wmm.5.2021.03.17.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:02:52 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.12
Message-ID: <64ffeeef-45de-6e0d-0ce9-767024d8dd22@linaro.org>
Date:   Wed, 17 Mar 2021 10:02:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

please consider pulling this single fix for the thermal framework.

Thanks

  -- Daniel


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.12-rc4

for you to fetch changes up to 2046a24ae121cd107929655a6aaf3b8c5beea01f:

  thermal/core: Add NULL pointer check before using cooling device stats
(2021-03-17 09:55:58 +0100)

----------------------------------------------------------------
- Fix NULL pointer access when the cooling device transition stats
  table failed to allocate due to a big number of states (Manaf
  Meethalavalappu Pallikunhi).

----------------------------------------------------------------
Manaf Meethalavalappu Pallikunhi (1):
      thermal/core: Add NULL pointer check before using cooling device stats

 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
