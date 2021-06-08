Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951273A0590
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhFHVM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhFHVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623186630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SuVjuJH4w3Ocpr5QTaJlwbpKa0fizHs5LZcw2pr44OU=;
        b=L9kSZGgA9s+hYkU1mjN3MSNycfhd4AQmO9HnWdF9QAkk8u+iHMhb+VdtXQb8Hkhy1xZcWV
        3Zae6/cuQvDD4LJ18UDwx+nGyRBw3wUGb7XQ9xzkLmUkZxfoULg52VwKGS/Gab+PtzSPAG
        VRWsY1auq/ex9CdUiRA1Iqm8nnjHDek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-sT7pNk8PN9Ofe0vh_JPFAA-1; Tue, 08 Jun 2021 17:10:17 -0400
X-MC-Unique: sT7pNk8PN9Ofe0vh_JPFAA-1
Received: by mail-wm1-f70.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so1696081wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SuVjuJH4w3Ocpr5QTaJlwbpKa0fizHs5LZcw2pr44OU=;
        b=TOXszz82jvHCQyVOOLGTAjIl+iyeHV+zcJxXzvx0a5sDukxDKcqCa/Ntcj8KxcVtAI
         LZ1Z5NleOtYe0pEliYvdlmx+j8ua2MnZJ74mrdOGjiw68fM78mPpc74ef5+YoluJ87rv
         otWRM4gN6N/GkUOHv0a04hOzPiEd6uTfdlwF0b9NlXomgd+fl0mknhkG4lEPxnKnZYbv
         k6aiD1T6xZsj2tJ42dZ+h8J96Do88cyF11rCxbj2HtE+Ock4gfGomJ8JoAyY6SQxhTw2
         zmCpysRG4Vi71pZuYrp66GuwCtPZ3i0KEgc69/TvABAvMGIp9N/C+7BLS3K6hV76S4yo
         4j8Q==
X-Gm-Message-State: AOAM533gFO2B99fAa83dOGMIC/7XDicG+CdBe/Q7wap/mKoSjpCh8EpG
        CCwUuPTcLo+Ezpuw0rlNCyvSUJ2vfBy8gCbM7sDQqb/mt4By7NGGc+qjaY8+qRB0pxfVzzvXwaO
        mnj9rQJep4yXFSYAjRd3lRLjS
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr6344473wmf.23.1623186616305;
        Tue, 08 Jun 2021 14:10:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz80lNVY7J+IPUX6ULyDpvCZvlvbZuEtXCKPNer3Sg7W5fZYJ0WIBl8vXH2Hk/muL6QE/lAyw==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr6344457wmf.23.1623186616113;
        Tue, 08 Jun 2021 14:10:16 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id l31sm7524836wms.31.2021.06.08.14.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:10:15 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL v2 1/1] bcm2835-dt-next-2021-06-08-v2
Date:   Tue,  8 Jun 2021 23:10:12 +0200
Message-Id: <20210608211012.1386151-1-nsaenzju@redhat.com>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-06-08-v2

for you to fetch changes up to 21c6bf8304f0141af6460cfe404dbbdeb96bdd62:

  arm64: dts: broadcom: Add reference to RPi 400 (2021-06-08 23:06:34 +0200)

----------------------------------------------------------------

- Fixup MMC node names
- Fixup led node names
- Introduce new devicetree file for Raspberry Pi 400
- Introduce devicetree bindings for Raspberry Pi 400
- Fix issue with dwc2's FIFO's size
- Add VEC compatible for bcm2711

----------------------------------------------------------------
Mateusz Kwiatkowski (1):
      ARM: boot: dts: bcm2711: Add BCM2711 VEC compatible

Stefan Wahren (7):
      Revert "ARM: dts: bcm283x: increase dwc2's RX FIFO size"
      ARM: dts: bcm283x: Fix up MMC node names
      ARM: dts: Move BCM2711 RPi specific into separate dtsi
      dt-bindings: arm: bcm2835: Add Raspberry Pi 400 to DT schema
      ARM: dts: bcm283x: Fix up GPIO LED node names
      ARM: dts: Add Raspberry Pi 400 support
      arm64: dts: broadcom: Add reference to RPi 400

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |  1 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              | 85 +++-------------------
 arch/arm/boot/dts/bcm2711-rpi-400.dts              | 45 ++++++++++++
 arch/arm/boot/dts/bcm2711-rpi.dtsi                 | 74 +++++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi                     |  3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi             |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi         |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi  |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |  2 +-
 arch/arm64/boot/dts/broadcom/Makefile              |  3 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts   |  2 +
 25 files changed, 161 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-400.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts

