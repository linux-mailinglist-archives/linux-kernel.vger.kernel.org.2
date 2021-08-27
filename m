Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B213F9E39
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhH0Rqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhH0Rql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:46:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB41C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:45:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso9366852pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=0WKKYjvy1TgBuyRVyCby36vMfEwiFoM9lW+Cn+bAZYk=;
        b=P1jpkTPIwm0g455oQ17Wg9OyulzuKKRqHezM24WtFrqoP3YZvPX7++97c+d3WibR43
         5fIM0M0s6my48zFK8bkZvqkDa3MbFil0S1mglvJK9Hvm1rfcCzodrJTv4g6lBzzHOyap
         C2VV8IiD5uEDA4txqR/BlvyOfCZMDL118mJbEz/5ZK9u4Q8YW4r6Q9RRb035k+lyq374
         1z14rWSljKX2XBwywH6bgP+gYmEOE+3wSdCi94l/yNqkyXzaB0xwW3kjDti3AgR1R1gW
         e+SvcdXF3A5DAKdscdwcRbtv209Rnq548LnaeAFK6UwA8xCU/1FLlbnLEL3QAdnzZ44X
         FfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=0WKKYjvy1TgBuyRVyCby36vMfEwiFoM9lW+Cn+bAZYk=;
        b=ucx5vMpn2iNPA5qso/We1hZkBEEswUCo+0bBXkCi8SAoT4j848vdl7BrzN35XZHqx0
         e/PkD297kGu59nMzxmP+b95Rrdgs2ZAnXuNydkzZfb/y+moshm5PcVqi+AGGqyOFUBxN
         l/UNq24PmlCszGrB6WYHTq86Zn8cg90qjHK+9Zrth+egkloFInGww++J5BW9/fTRVtx6
         m9nMWEa9ubBJb71ck+/4XKTeV9mth2YJ//L37CXvoRkNI7jW6yUWfcD2XKnHGqY0J83F
         kLNitvMHhv0bH6qzgQSxpo/CdK/RWPZrFdYjgeY1hCOLtWJ5G3arYEhCqtjgazlMQcHo
         lFJw==
X-Gm-Message-State: AOAM533frcTm/OktEHHeSTFD+lvuW2lbErkjrQ/cXnFpq0NDdykcJksf
        QtS0anBRGQqBkbhZ3SEMTO8x8g==
X-Google-Smtp-Source: ABdhPJxVQjdKqS3vmruotXg3ZfPgtLskUbrPmpDCVWc6LiJn6CWPZ7Gqp5pi21hbbEv1Hp9pxYsTBA==
X-Received: by 2002:a17:902:7484:b0:135:8c25:d33a with SMTP id h4-20020a170902748400b001358c25d33amr9836241pll.83.1630086351869;
        Fri, 27 Aug 2021 10:45:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s29sm7751274pgl.38.2021.08.27.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:45:51 -0700 (PDT)
Date:   Fri, 27 Aug 2021 10:45:51 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Aug 2021 10:45:47 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.14-rc8 (or 5.14)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f06b0a4c-f321-4c14-9378-da36fbf6212f@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit aa3e1ba32e553e611a58145c2eb349802feaa6eb:

  riscv: Fix a number of free'd resources in init_resources() (2021-08-20 10:15:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc8

for you to fetch changes up to 417166ddec020c4e969aea064e23822591ad54df:

  riscv: dts: microchip: Add ethernet0 to the aliases node (2021-08-24 20:57:32 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.14-rc8 (or 5.14)

* A pair of device tree updates for the Microsemi Polarfire development
  kit that fix some mismatches between the u-boot and Linux enternet
  entries.
* A fix to ensure that the F register state is correctly reflected in
  core dumps.

----------------------------------------------------------------
Bin Meng (2):
      riscv: dts: microchip: Use 'local-mac-address' for emac1
      riscv: dts: microchip: Add ethernet0 to the aliases node

Vincent Chen (1):
      riscv: Ensure the value of FP registers in the core dump file is up to date

 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 4 ++++
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi           | 2 +-
 arch/riscv/kernel/ptrace.c                                  | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)
