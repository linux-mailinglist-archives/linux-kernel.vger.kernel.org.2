Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41A74546BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhKQNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhKQNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:00:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB61C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:57:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bi37so8040342lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qZPa2mY28LffgzuxXGxY7bPALs0+EXJe+qkR4+Voe48=;
        b=Tg1ld3eB8x+kUnRoDQRjd5qR8rlRksu+KI9DjISMo9Z7rlYRGXkR9OEK7BTPHkw/T2
         ryHERoy4SzdFke9+rYxUKd4ESr1X2z922WpPou8zCIY431YvSOISZ6OJk7EbtUlIti6x
         VX63mpgfqgxt8gmFTv9OkCKC5Ka8hpQI7jRzs0Y5Y0Apci3HQZ4ZhRw61sfrAfzv8+eY
         aTH6DLIK7kq09kHOcKTJ1sAi5gOw3NLwXsiuNxBMvsNTiHB4BFVlke2ZP8Td94c8uRlP
         XZd5CMQ/3Iaux0VNL4MM7JMrPxtHUKTglx+H3CuHvhm4qtLfWBBv7/M1gcM7ptBmCI7k
         NOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qZPa2mY28LffgzuxXGxY7bPALs0+EXJe+qkR4+Voe48=;
        b=qAenSLsbt8kcy5vxingAk5nd/7qT9rQmU8B8tge3Yfa1RXLxJux5TUYB/ub9Jkc8+j
         MBZfO0mqsW5OJQaERoZsaz5mQ/yFjEYC0XNn4RViZKKs6o+UZwleehM7b+aKmIMqW61o
         FtP5PpjIu+52jbRgJ5kHWbRiqwUOJcBupk+AmkyiQv3wiX3rNoK45GlsguDFJCnsBZQ8
         c/8TLarLKJM1OKZqipnwmnXQ+BFJJ9fR0koY0SAVyS1RQmGyHWL+yJHPPqYA9pPZ1m5o
         FvJ8Dsd9atCWQaNXmKrkymKXN3ot4I95L3G+3K4Jj+Eh0wQkimQlIak1qo5KFQgtcklX
         Vk4A==
X-Gm-Message-State: AOAM533aj1Jlt9/qv9yiNI5EQBypZM3X+nbaFhGzns5s0cAU1L2Z3hEZ
        xZ0NJWT+WsWRJ7By8+u3BZbL4g==
X-Google-Smtp-Source: ABdhPJyXDli2e3Wq9QBa6FI5+bRrg23v2EjYnJyqYR1ymOsyIaXeq8nY55BRKP8dU3mbdH1dnMH9lQ==
X-Received: by 2002:a19:7404:: with SMTP id v4mr14701257lfe.76.1637153869439;
        Wed, 17 Nov 2021 04:57:49 -0800 (PST)
Received: from jade ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u16sm1070197lfk.178.2021.11.17.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:57:49 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:57:47 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OP-TEE fix for v5.16
Message-ID: <20211117125747.GA2896197@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix to avoid a possible NULL pointer
dereference in the error handling path of a probe function.

Thanks,
Jens

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-v5.16

for you to fetch changes up to c23ca66a4dadb6f050dc57358bc8d57a747c35bf:

  optee: fix kfree NULL pointer (2021-11-16 14:41:23 +0100)

----------------------------------------------------------------
Fix possible NULL pointer dereference in OP-TEE driver

----------------------------------------------------------------
Lv Ruyi (1):
      optee: fix kfree NULL pointer

 drivers/tee/optee/ffa_abi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
