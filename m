Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7339F327
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFHKHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230369AbhFHKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623146757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lmuQ7QEVYadIGf4KyYRGp1fW0heKfm9ulOpJ4lH1Hx8=;
        b=FpElR7PhqnRev3DYmn8dKQaG0oFmLn/+4DlKi77PvtYd63NuQ/RJzJjFn+OBHMh9VpsMLZ
        Szv7imTlV/+8wAPnELqEhN/gUqEJeQPuR6dNtBC55js6WSSduV4Lw74Z0gHT2u3dfGfX6x
        YF6YbYmE/b+OeKv14mSVPQQDSNyPKSU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-Cc8bIA2cNGKKO5UZXk8DUw-1; Tue, 08 Jun 2021 06:05:53 -0400
X-MC-Unique: Cc8bIA2cNGKKO5UZXk8DUw-1
Received: by mail-wr1-f72.google.com with SMTP id f22-20020a5d58f60000b029011634e39889so9192723wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmuQ7QEVYadIGf4KyYRGp1fW0heKfm9ulOpJ4lH1Hx8=;
        b=Pk4tslugs8do5nIIsxVJbKtzPflIJwblcma3uqBrK8mNnMJD66kTtLrgPNLPhR+U9t
         cqqyEldTdUqlXIDuKSA8IlLCvCfwhrImX4Cx71u9bqR9k8oRYYL3zZ5AjKqLU3uyjybN
         U6PLhAzYlLHxLoBdUZO15fyF9C+7cbI3lmG+gDoNaxc2rMfahnohO0zNtJTrxonVqjEI
         68/yRrmmoBlMMmbfWdYYwxvDtbubDLl3+vTaEXREizF4Pllg4n6FVpGBbENjKYgZqe1Y
         fUuW9UNA3S9G/OVYtVq54jiJryj5x5jLG9+SPm/ETUUpYViF7ZlL8s74EnKsQLYLIkkz
         XZtA==
X-Gm-Message-State: AOAM53292EsLr+3SbrFN8QJmZ8wNhYRt1Fi2dSxr1MQtnlwqYQo7oL1D
        omtFioS1sHLWo6M2jBK6BffixS8c8bRXrFV29xR5AsL+2BrKeFkN+wni02I73HjYnwNFKEFnZbT
        EDSZWkuUtjZQhFCv5JdqVWmkY
X-Received: by 2002:a05:6000:1049:: with SMTP id c9mr15474576wrx.416.1623146752591;
        Tue, 08 Jun 2021 03:05:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiMobTb7rBS4J8StzgZuCTXMJt+Yk8Wo4iX5earTWFn4rG+eWnBLqJqFtJ6vXexuacQcwBZg==
X-Received: by 2002:a05:6000:1049:: with SMTP id c9mr15474562wrx.416.1623146752410;
        Tue, 08 Jun 2021 03:05:52 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id w18sm18720697wrt.55.2021.06.08.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:05:52 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/1] bcm2835-dt-next-2021-06-08
Date:   Tue,  8 Jun 2021 12:05:43 +0200
Message-Id: <20210608100543.691185-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-06-08

for you to fetch changes up to ca5909b7fa6af9c7b9a215a8708926e44345a220:

  arm64: dts: broadcom: Add reference to RPi 400 (2021-06-08 10:44:36 +0200)

----------------------------------------------------------------

- Fixup MMC node names
- Fixup led node names
- Introduce new devicetree file for Raspberry Pi 400
- Fix issue with dwc2's FIFO's size
- Add VEC compatible for bcm2711

----------------------------------------------------------------
Mateusz Kwiatkowski (1):
      ARM: boot: dts: bcm2711: Add BCM2711 VEC compatible

Stefan Wahren (6):
      Revert "ARM: dts: bcm283x: increase dwc2's RX FIFO size"
      ARM: dts: bcm283x: Fix up MMC node names
      ARM: dts: Move BCM2711 RPi specific into separate dtsi
      ARM: dts: bcm283x: Fix up GPIO LED node names
      ARM: dts: Add Raspberry Pi 400 support
      arm64: dts: broadcom: Add reference to RPi 400

 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts             | 85 ++++-------------------
 arch/arm/boot/dts/bcm2711-rpi-400.dts             | 45 ++++++++++++
 arch/arm/boot/dts/bcm2711-rpi.dtsi                | 74 ++++++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi                    |  3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts          |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts               |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts          |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts          |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts               |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi            |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts          |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts            |  2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                |  2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts             |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts        |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts        |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts             |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi            |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi        |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi                    |  2 +-
 arch/arm64/boot/dts/broadcom/Makefile             |  3 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts  |  2 +
 24 files changed, 160 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-400.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts

