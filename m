Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410343DF1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhHCPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbhHCPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:55:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58FC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:54:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h14so25817437wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Cd0emsP5LReJzMwICeULSHMVP3hj4iso/RTi0nAK+4=;
        b=E5Eu1MzM4Xz1dW5QuiMiiUfn4ah/4qw5yuowxGXr+k44EppUBzVIPhiQvGPuPxll+s
         XNdv7PT/F/LPtAEtFWtQv8L4CMFXRRcs+U6S2zuV/3prCbStOENzKak3MXaXN9tDYdip
         RqJ/hYcHnRP1oNpN5vY/deR8yBiavpRiwNDp1q4eqsrl4ZCU1FGqumYYkNbn8Qfjc8mA
         k3nITc84huKUC7V7vNeEqYxYIsWMorfCKVmEri93lN+zfZVxbIopfQAbRh8tEc4VGSW/
         s1tHGlTLh1EaOR527C4v9QUu3E4PZDRyO3UYIs5+xcvtTpa3/RnyJgOOP5VQBDrs2Ek7
         nEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Cd0emsP5LReJzMwICeULSHMVP3hj4iso/RTi0nAK+4=;
        b=rQj5CpFuznWAFl06KwM5Hyiq6pi3cDKKsZg5iMirnRgITk5dZH6Ct2h8UGyo7tCLq8
         M8aXQdt/YlwF/msr9Q6nkzAkx/LUTWeHzqUTsFosTHQZpOfCVjNzDkYCmDypX6OKfBQR
         U9NxQQo6ZGagPED12/uyT6OIkzv4ChHLay6HHCYwkg5KKEb+dcKdOql+n4SKRxI2ddWw
         sfJ3KS7adcE93JHclU450h1cnIzd7/HL8xUUbnnXzrPFn8cVDkSmfnHOeHtLmQbJ9WEW
         6STsCNdINoeA65HfNxijOF20yxHjz17d+c7A6QnrKcdDZaCvXKLmmVNf3MebxTTcabyx
         vvwA==
X-Gm-Message-State: AOAM533TvizVh0BiOHlTl0mARmm42UNumZibRpEa7NIQlWt2uJlG2amz
        s9+J1XVKd+YABFTi5j792ME4bA==
X-Google-Smtp-Source: ABdhPJzvzzsZgFfQYNaIUtQDSwTWfGoPz6k1WFgry1Ej0utOLPYpGM8HdOIA/lS9Mul2oSUAkPTjYQ==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr23650987wrx.277.1628006096035;
        Tue, 03 Aug 2021 08:54:56 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c10sm14058863wmb.40.2021.08.03.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:54:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] power: reset: Convert Power-Off driver to tristate
Date:   Tue,  3 Aug 2021 16:54:49 +0100
Message-Id: <20210803155452.435812-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide support to compile the Power-Off driver as a module.

Elliot Berman (2):
  reboot: Export reboot_mode
  power: reset: Enable tristate on restart power-off driver

Lee Jones (1):
  arch: Export machine_restart() instances so they can be called from
    modules

 arch/arc/kernel/reset.c            | 1 +
 arch/arm/kernel/reboot.c           | 1 +
 arch/arm64/kernel/process.c        | 1 +
 arch/csky/kernel/power.c           | 1 +
 arch/h8300/kernel/process.c        | 1 +
 arch/hexagon/kernel/reset.c        | 1 +
 arch/m68k/kernel/process.c         | 1 +
 arch/microblaze/kernel/reset.c     | 1 +
 arch/mips/kernel/reset.c           | 1 +
 arch/mips/lantiq/falcon/reset.c    | 1 +
 arch/mips/sgi-ip27/ip27-reset.c    | 1 +
 arch/nios2/kernel/process.c        | 1 +
 arch/openrisc/kernel/process.c     | 1 +
 arch/parisc/kernel/process.c       | 1 +
 arch/powerpc/kernel/setup-common.c | 1 +
 arch/riscv/kernel/reset.c          | 1 +
 arch/s390/kernel/setup.c           | 1 +
 arch/sh/kernel/reboot.c            | 1 +
 arch/sparc/kernel/process_32.c     | 1 +
 arch/sparc/kernel/reboot.c         | 1 +
 arch/um/kernel/reboot.c            | 1 +
 arch/x86/kernel/reboot.c           | 1 +
 arch/xtensa/kernel/setup.c         | 1 +
 drivers/power/reset/Kconfig        | 2 +-
 kernel/reboot.c                    | 2 ++
 25 files changed, 26 insertions(+), 1 deletion(-)


-- 
2.32.0.554.ge1b32706d8-goog

