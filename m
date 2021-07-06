Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1163C3BC6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhGFGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGFGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:42:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE519C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:40:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i13so11428373plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RnfC90qmrJRM/A3hqOe/93Ug+s8qei2DZtNwiknaExQ=;
        b=rfDHuSYDvco53PrlcQNTQIw/rO1D+x/M6kaA1somiOMKXkWvB/Q7EwEyjLCFBWa8tW
         n0YBhjyg8v42iLVSS60G/6V5ESwnL3geAdaz97hXM8ODbU+w+0ZsRQj0rtr+Q0i/AS8x
         aairMi8rBOcZKZRG6bnSBj4m7IJoOpKflp2PUSzDnxb23QcfUXRge5bNVgU6tr5up4Dv
         bYGzZOdcskDE+v8KjSnS+JRv6ByFpDaqTcyQXIl4Z5ygCex04/juUp4xJUwTmnwLw6u9
         8/BXHb+cNmBQfsYPeyEbFu1p7/CZloQYs9AseWp1xQgyiHawdkbVz8AgwbsydDpB6PQQ
         BjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RnfC90qmrJRM/A3hqOe/93Ug+s8qei2DZtNwiknaExQ=;
        b=je1bTEqK3VLuis0kXr3jpUf/Yv2NW2X+ds1k1cZs8AmU/iv0UdPDRRiyq1MTs9nSR7
         5tCDpG/WaQHBw3g6sPX9k1W1l5oZ1kDH5Magr5VkQMqgXXdyblBDDN6BUmz/CgNN1UU1
         uoikg7kNRCUe0gw13YhJvwla8SyJfDUePcjF2EtApGpVBEj2q4uYLs2qT3i8fAXClIqw
         CUpwbsDXaVAXT4WXM7eeuQuT1LXW9ectbFX0YGx+/yPfAU1O7eGmrHMnm2G4HwQzlTRg
         UjDuC8W+M7IZgdMERbf9nOW40N/820DyWORAH5DY9meKqieSDgnB+Zlf4OSiGXkI/YBa
         Yn+Q==
X-Gm-Message-State: AOAM530QCpwcVt39oy7vL6ZuE1zlIHqabWWX4mhbc+jsV3T4r1IC/LBm
        6150QRUAVBc/jGlYc8TmCKI=
X-Google-Smtp-Source: ABdhPJwS/TL6GSdJ9UJz79AMLTNaG3F0oGhQYz0lOsx6ZNd8CZPH04S2lKOnnCe5a4cVP8dWIFMWkA==
X-Received: by 2002:a17:90a:df10:: with SMTP id gp16mr2922095pjb.164.1625553610207;
        Mon, 05 Jul 2021 23:40:10 -0700 (PDT)
Received: from localhost (g164.115-65-218.ppp.wakwak.ne.jp. [115.65.218.164])
        by smtp.gmail.com with ESMTPSA id m7sm7357158pjf.8.2021.07.05.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 23:40:09 -0700 (PDT)
Date:   Tue, 6 Jul 2021 15:40:07 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: [GIT PULL] OpenRISC updates for 5.14
Message-ID: <YOP6x0Mz8aBv9x18@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to ad4e600cbf897f47525b342cd4b02e88ed300a83:

  drivers/soc/litex: remove 8-bit subregister option (2021-06-11 04:35:40 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.14

One change to simplify Litex CSR (MMIO register) access by limiting them
to 32-bit offsets.  Now this is agreed among Litex hardware and kernel
developers it will allow us to start upstreaming other Litex peripheral
drivers.

----------------------------------------------------------------
Gabriel Somlo (1):
      drivers/soc/litex: remove 8-bit subregister option

 drivers/soc/litex/Kconfig          |  12 -----
 drivers/soc/litex/litex_soc_ctrl.c |   3 +-
 include/linux/litex.h              | 103 ++++++-------------------------------
 3 files changed, 16 insertions(+), 102 deletions(-)
