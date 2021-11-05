Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F344649F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhKEOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhKEOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD770C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 07:07:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w1so33763008edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=QCNq+zUbqjBlsPPN3RI213vrw2hNPJ7Au8oDGBx4F/U=;
        b=XZCntxTWh3ZP0eRrw82ahn9UVa+j/EgnV6UxdaWs+XSo7EvM9OKd3LOlnT/q+VEpLA
         WYzBIsNLfNDMlrG7DaQB/yzekMIH4RtYSX2FpwNhf8wVAuPkp2UPd5bUQI8n0q69JzWy
         YpadAL3qlN1xWMbJsyz14CP0j0AyHU32G2BcQbP1X5k72QY6LdM9iT80ROkkuYj7tr37
         HkoZ6M+JHVmESMFvv3Z+AYDj65T6YjWwQFOfhTL+29tb3mkIep7bPULa0gH7mDWmzAQn
         rbr5YyLp1ylGVe17S8O4IgnvIxYuHA7qqJYK+TtBNz11dEyCwhyoU7wy1fPQe7zGa+bc
         Vu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=QCNq+zUbqjBlsPPN3RI213vrw2hNPJ7Au8oDGBx4F/U=;
        b=y5bzc8gfAEHwCqAPKKUJpPVJ/qSmU459cEYyuzG798swgzT3bT1mbZWzO/6JwkBX5J
         1tDsfxWAOPpVQX37QSrb1X3U7bHd+omzQTgRvvnp0RYoGiqnrxEhLNmBHWWr6Q0kWprk
         7kYkysbe6HnFnu8J0u5g1mDaoc+6KyFhPGgrSONuiFSjZSLKs4H9+djpgThjuoIpfKIw
         vhZKRDE4jwZPxbIIdRGIKgKZIuXogihNFLenqCkto+y6hv/bt3HIHVo/nX18P2ZtLdos
         2orZ0MRvhnTm/fgciiJz6kEe+4sE6w33kq2XPi+9s7Pdqj1DyqXKRSrBXHcJqWlcPeM8
         sTYw==
X-Gm-Message-State: AOAM532N8/7yU/WIplFEnv/tasw1Z9AwaNqESI4kXMwAGVuiFsx3uYq/
        eQMao+KXKpx9ObzI2ljR74Y/YcM0z0NaWA==
X-Google-Smtp-Source: ABdhPJy4QHNJwR5b05DE3/0QSMCfKynDvtBd3fA0T2tLBdcvnEeYDbMbS+h9M8c3Zg7AZYBS+LC0gg==
X-Received: by 2002:a17:906:b854:: with SMTP id ga20mr19007888ejb.308.1636121258445;
        Fri, 05 Nov 2021 07:07:38 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id qf9sm4591442ejc.18.2021.11.05.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 07:07:37 -0700 (PDT)
Message-ID: <ad54816e-699a-cea5-5964-966fc290b797@monstr.eu>
Date:   Fri, 5 Nov 2021 15:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.16-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull this one small patch to your tree. Sean is pushing one pwm 
driver and these ancient properties are going against agreed DT binding.

Thanks,
Michal


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.16

for you to fetch changes up to 43bdcbd5004393faad06b65c1539d3c9b9d5f6b2:

   microblaze: timer: Remove unused properties (2021-10-26 07:37:18 +0200)

----------------------------------------------------------------
Microblaze patches for 5.16-rc1

- Remove unused properties

----------------------------------------------------------------
Sean Anderson (1):
       microblaze: timer: Remove unused properties

  arch/microblaze/boot/dts/system.dts | 5 -----
  1 file changed, 5 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

