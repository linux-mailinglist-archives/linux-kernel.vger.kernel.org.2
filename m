Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3683B1A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFWMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:48:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03507C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:45:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a2so1685685pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6XzMiumB4ycSFXZaaWbXgxSbMB9qisO++ZHH1gQyycU=;
        b=Jz6P4EU9EXNmpLjKYwCZp9M2cd+kZ72FWsG1SwC5ormTx4R3EYJVD9L6rfjDOrlTH7
         4XKjCObQUEpmP6HigR6L61a72M+i28bHpuVm85mRBQ/sYetlCXmjX+kEZk+Nvj2DHLJv
         Du4JvqTe+w9LUlnTtzIUcBYpFEBiVHg5iT1B8PMrDBDGAvny7+dnGz5U5LLHFFWbPI+a
         8/7RbzVFxFLENUZmzYBvhUiDSuQjOS1Bl1MWiU7jFDu6oxB2x+5bcrtvjWqT2Y+ANkTN
         vl9S5ZFAOd4rjOcvfR8LThbWmLCur6me4BD16O8B9nJ4dTrAWFK67RmKKA10/Xk7wSVs
         XT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6XzMiumB4ycSFXZaaWbXgxSbMB9qisO++ZHH1gQyycU=;
        b=DKNZcxaYb9EcGRviwGCS8SNvjuRq0lgf05aBmPIXt6S0tFqjceq5b1xf4PsK0lUh25
         APlVCjFdqnja3Q+WUHNuxQgM4gsHSTVG8FcI7jv6OybFbHryvHDPItugLJyqS5qyle8Q
         xihS7mV5t2sfkHnnhjV6tT+P0pMj2M5+Yne3FKeFayUGx035ThCiDk0CHa2TXYfgILCW
         s1vy+caFigPG3TNdfxYnG5bGj+VVYWEqP6FYbh2e9Zrvc52uwgQE5qy6SydwBWdI9jFz
         51506ltMk0j13epe9JFEV6BC6APybxxi1rOsqfsTmd+Lfo1cvwPW9/frb/TcG9GFYD2N
         noLw==
X-Gm-Message-State: AOAM531/P1DXjE8t8qDU0rKSCoLGDPL+9igeTq5uo4rxMvKem46XwVwZ
        O94nYQu5mEAg9QFS+kF1ZnQwcDgJ/7b+bW8Y
X-Google-Smtp-Source: ABdhPJzIJqgPpZPk64KsRvH0sKjyRMzsLaT0sQhf1I1v7XTqCKQ3/5sslagC9RJi5Iu+e/HEVhgbew==
X-Received: by 2002:a63:e309:: with SMTP id f9mr3719049pgh.443.1624452357089;
        Wed, 23 Jun 2021 05:45:57 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id j19sm22777753pgm.44.2021.06.23.05.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:45:56 -0700 (PDT)
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [RFC PATCH 0/1] Adding jh7100 SoC to defconfig
Message-ID: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
Date:   Wed, 23 Jun 2021 21:45:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Would like to have comments for adding jh7100 SoC to defconfig.

To make the upstream friendly, try to add as minimum as possible in
arch/riscv/configs/defconfig required for beaglev-beta against the
upstream defconfig. I might have added too much configs.

Then the distro vendors could use:
make defconfig beablev-fedora.config
or
make defconfig beablev-debian.config

while distro vendors keeping beablev-fedora.config and
beablev-debian.config in their own repositories to make one binary kernel
which boots for all riscv boards.

Probably, it is not good practice to add a different defconfig file under
arch/riscv/configs/ when each new riscv board comes out.

Akira Tsukamoto (1):
  config: Enable jh7100 SoC

 arch/riscv/configs/defconfig | 105 +++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

-- 
2.17.1

