Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB82745F5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhKZU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhKZU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80318C061746;
        Fri, 26 Nov 2021 12:22:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7516090wme.4;
        Fri, 26 Nov 2021 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myHy6GLiOK3ibzQLkLpcI8h/6EY48s1TeorO1MCwIX4=;
        b=c4k3bRxnQpMARzx+IZLBccZsBgrqtmPRdRyKGaZen4az311dDPDxXzkto7esYUPQlM
         VgKP+nVfJpU9K+y+J7uMKpfzjSCMjJkoGnPX+F8gQ+iCTFbBt1GPoe22OyihK8JPssEi
         D/USbvUjFJEQNXHENhA8Q3pCViJcyPZ6bsDE+gN+p6TozhCvBCHJRweIFqDq1BP+jPp1
         jbp5gfLBzaUgrEAgjB6Nu/O/eBcI/s70HVjA3UwBFgG0+PISZZs/dhcCRIHjpY90VqGi
         Dqp12hYAbFt+DcbtTQk+t04DQdh60nTHPn6wtqBbYdgiEW9eHU3kOQRgARcZdSwtM0R8
         Uugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myHy6GLiOK3ibzQLkLpcI8h/6EY48s1TeorO1MCwIX4=;
        b=DUTBTjqlr+wigYfUqXrBpgCLFcLY/2GoSlcNdPzUl9MRhRHw4QeVPpreLgmHYhyhUe
         W1qdH0s3ScuB0mNyAKgtESw9YmdEKn+1nYbCgzYE4rbSq59SnnIE67edUJgA7I/talbw
         BgeuzEOt45I4ILK7nRcrUGCQwsAISnc+1ZzZ7Q7Vfib50c4h1Sm1iJdQ6b2QTh0s0Lvy
         PGK3uO8gJ9eQ9tD4yuh2MkAsTD4ITkjJa0jIl/BWpEYThKZqBxg9crNC4wzJGRKvLkvm
         H0kBOpf0LjxyDQQkwxExTp5qt+nSnLqyyGBcOWtvLr2Rhp3enJIY8SYdglKv0rHVReGq
         sgQw==
X-Gm-Message-State: AOAM532N39xNVk/zyjt5r1VLpVyp0J0rz54JWd3U/ejbeKVg1QmHlDw8
        M8BXB+I27+RCCaCr4Hg2mb/sZ81hRIc=
X-Google-Smtp-Source: ABdhPJxXtG16uT6Js4XqYueslPcGYisW3DO1kwAsafgLw0RUODk+SqvwbGEgJg0ikAe615oY7HT2Jg==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr18782406wmg.3.1637958120861;
        Fri, 26 Nov 2021 12:22:00 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l7sm8118383wry.86.2021.11.26.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:00 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add timers for Mstar SoCs
Date:   Fri, 26 Nov 2021 21:21:38 +0100
Message-Id: <20211126202144.72936-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series adds a new driver for the timers found in the Mstar
MSC313e SoCs and newer. It adds a basic clocksource driver, the
corresponding devicetree bindings and its documentation.

Romain Perier (5):
  clocksource: Add MStar MSC313e timer support
  clocksource: msc313e: Add support for ssd20xd-based platforms
  dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings
    documentation
  ARM: dts: mstar: Add timers device nodes
  ARM: dts: mstar: Switch to compatible "mstar,ssd20xd-timer" on ssd20xd

 .../bindings/timer/mstar,msc313e-timer.yaml   |  48 ++++
 MAINTAINERS                                   |   1 +
 .../boot/dts/mstar-infinity2m-ssd20xd.dtsi    |  18 ++
 arch/arm/boot/dts/mstar-v7.dtsi               |  20 ++
 drivers/clocksource/Kconfig                   |  10 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-msc313e.c           | 237 ++++++++++++++++++
 7 files changed, 335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
 create mode 100644 drivers/clocksource/timer-msc313e.c

-- 
2.33.0

