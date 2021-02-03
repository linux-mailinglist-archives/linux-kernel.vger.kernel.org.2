Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E646B30D98D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhBCMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbhBCMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:10:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:09:57 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a12so32988945lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pv1qciXbuEXdJ686V9ClECcdM/TT1AFBeAb3316YkDo=;
        b=be9HmGyubkh2mJwqE28CDJr937G7MiPdy0oXglGV6mdW5A71v9Nz8VwFUVXPx9VSjk
         4VTkRA3KgdvxNDCJlEZs12xcsk1f9KEkP20PUSbNnr7Zn76cXRGjF9mrgILapZzvd/n3
         rt1wzOkL8JAsWBAaARiQBWfpCSrG8/AvmcTV027IrwRd9s62EJ4SatogWi/oOXg71bx0
         XEfAAZJe+xHak4SXETmwmyX5WfRfnMss9IB7glmH1+B3B8QZzj0IqgtfL7ZE6ToRmEmu
         Bubwm/KNhEoKLreZFn0XjL1zYX2JYr7nUF8Dv00ILjn5Jwwreu3pW5CA+kAhlPOVHI7i
         ax6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pv1qciXbuEXdJ686V9ClECcdM/TT1AFBeAb3316YkDo=;
        b=rUw4XcQTAcpNKyMg5ZeEkuKhEWTIaLLLkA9TJy/9VJnmr/zm31icN29W4AVtiEc1KF
         tD/xtVVmrH4y4F5vhYyEFmqoqmwVMCCS+HHZl3mR2OqeouCpTpTk1A1yvXqYoaxgiHvd
         7PmNJ3FFJ+rNam0352LTBuqlwPhhGGCJkOvuPMPvR+fRLbaMO5NpvCJCYHPRVFHMKWjk
         x2UO3MUy1a8hKtAaKX0GLXgDYDQD3/Wul//W3KdeXx73vRyEgmbCJviUockwhaDqGkXp
         huFE4HAf3QLopG6MouFVaMTJxRvvPZWh2yGjqZSzwz66t4z87s1ggWzdVyKT03+bYeif
         Pcdw==
X-Gm-Message-State: AOAM5314UTXlcefjbD8lyyoDXGFRVHy43pFkYf4o9csbwyzpCGeE5MjH
        yacHbVviC2hFZPHxYaoUqJqgKQ==
X-Google-Smtp-Source: ABdhPJybRZzGpTiMX5nvQjiDuUczL+iSxnRQlwBPmLzDZwU7MLBda/LI3lJUp+t2+7nGnEPsRgJ/3Q==
X-Received: by 2002:a05:6512:2004:: with SMTP id a4mr1590639lfb.212.1612354196266;
        Wed, 03 Feb 2021 04:09:56 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id j8sm224571lfm.79.2021.02.03.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:09:55 -0800 (PST)
Date:   Wed, 3 Feb 2021 13:09:53 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OP-TEE fix for v5.12
Message-ID: <20210203120953.GB3624453@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small fix removing an unnecessary call to need_resched()
before cond_resched() while the OP-TEE driver is handing a RPC.

Thanks,
Jens

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-fix-cond-resched-call-for-v5.12

for you to fetch changes up to 958567600517fd15b7f35ca1a8be0104f0eb0686:

  tee: optee: remove need_resched() before cond_resched() (2021-02-03 08:11:11 +0100)

----------------------------------------------------------------
Remove unnecessary need_resched() before cond_resched()

----------------------------------------------------------------
Jens Wiklander (1):
      tee: optee: remove need_resched() before cond_resched()

Rouven Czerwinski (1):
      tee: optee: replace might_sleep with cond_resched

 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
