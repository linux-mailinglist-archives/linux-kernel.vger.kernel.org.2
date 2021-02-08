Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324503132DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhBHM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhBHM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:59:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:58:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v5so19864920lft.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7e+2QeCZIF/RTfB76G03UV8gWuzCrr+kzUqC9Ip4Txc=;
        b=gzReHfoXRHqz/CxDxuG2pYbOxlcR4jVk00/Q4Zw0I6cpUCcnsdpwpdwOaFQQFWdfPu
         kn9HKZSWPPplowkmKTU3UD7RlQvbJcBete9noP9lTRoqJLJob5bfSSN1T5XSjD2c2L7y
         91WwEZyiXakAaS5CRwxzgnnCt3ir1R/p9GXjwn+U3wuneaN7UXtpkDWQruWn18fFxum0
         bhkplDDgMQOQ6o1XCpsoMYjRcOfxu1Lz2D48WT+q3FxcGqiH0/ToHWlljZj3hwNEBar2
         REr+wIWEnQTOS/klOAQGiBiQY160FCndNk0bQNTxioG+FudkESeuROt+ylsTRGrZ1TSH
         d2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7e+2QeCZIF/RTfB76G03UV8gWuzCrr+kzUqC9Ip4Txc=;
        b=oZFZZGGcZOJoo1umIRB0UW3WH7K8oR6VYw1HwwJdtkIVMmFrkiMcfI9rY87WbDXQO9
         rR0cBrHaC//VzVeX9x5EH8xGjXUf2qJ152y9nBZRodS6eTFQX7y/yGzDscRaPl1k832s
         npJLG9UKRmGasV6SOHjgO2TuS5zHivpMtR/cHUkYkhY0KCVPIzukdKjKwPyjGcVf4g7G
         WMh/xpDbepZX7ArrvgFTa8fTtmw+Vrs3juHRslIKiZCt/yg+iJAFzFAuA8uSbV/qTqBd
         5Ti6hwBMUUcyMGhm/6rWYdyDRqRgF6bcReeg1nedRquDBbNKXF7Kec3dKzh811uDWPdC
         SlRg==
X-Gm-Message-State: AOAM530gL0J4o5d0GCumJYHqOg6kkl9kr682vbJt4EOhEGQPoyZn429Q
        1Un5jQFP/RSdUefp/02oCtEO1g==
X-Google-Smtp-Source: ABdhPJwOZcoerPukFtmudmtjfPealVwCV3D/Czvysyzfg3fSeG7P0Go6A2Y9RIw7BD/9tR/W34X/XQ==
X-Received: by 2002:a19:6b1a:: with SMTP id d26mr1424486lfa.162.1612789135353;
        Mon, 08 Feb 2021 04:58:55 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id a7sm2087969lfb.308.2021.02.08.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 04:58:54 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:58:53 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OP-TEE I2C simplification for v5.12
Message-ID: <20210208125853.GA288348@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this fix eliminating a stack frame size warning and also
simplifying I2C access in the OP-TEE driver.

Thanks,
Jens


The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-simplify-i2c-access_for-v5.12

for you to fetch changes up to 67bc809752796acb2641ca343cad5b45eef31d7c:

  optee: simplify i2c access (2021-02-08 13:42:31 +0100)

----------------------------------------------------------------
Simplify i2c acess in OP-TEE driver

----------------------------------------------------------------
Arnd Bergmann (1):
      optee: simplify i2c access

 drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)
