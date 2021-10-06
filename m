Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58629423999
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhJFIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237769AbhJFIU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633508346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20/XyHEawBf2rjIblWfL0e2c0GES71I16mTyA5ptBcY=;
        b=GKxbbGUL1CI/N3X84voEiGBQDxmret9diUJcg5L0Ypu6QTW0Rvj/dMEXhCtBuFlkMm9X7v
        vZL/9zE+XroUvAx4rYbk6vRyqUmnTDNgwtNwUg6P45QiT/tKXOPbfa1tsolvR/1h1ngTi7
        cCIVb1jS23xyR0WYb08QtCNI3OoK0vU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-_rEWBq3fOMCJlFsZd06arg-1; Wed, 06 Oct 2021 04:19:05 -0400
X-MC-Unique: _rEWBq3fOMCJlFsZd06arg-1
Received: by mail-wr1-f70.google.com with SMTP id o2-20020a5d4a82000000b00160c6b7622aso1280141wrq.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20/XyHEawBf2rjIblWfL0e2c0GES71I16mTyA5ptBcY=;
        b=XaMRspvGGaoYBzOkSzNDr5nK0wXk+T9+AeBhETgjzU0aIs14bc/Sf56ZtN1PwC59qD
         zon2RSMkN4lYOBzyvp9s0JMuyqVEB4AlwTw0voPNffH4/dJIg91Bw2MVmZUdCitrUspx
         8f2y8eooBNdMHdhz3Y8ZkR8fob0BosCMyZcqgIZHuI5bZnqYU25rBS7h8YzDUMPfnL0R
         s1qjRKvsQ+og5+OBkCfzzqcjZJGRxBOSY5Q7zQvU+dnMWWdmpylAkyGmtiF/aWhpbeh7
         PJ4uLEr0irctSe8eYbl/gP2XFKedaV2RoQL8/aAF+f6O991BLoFfGFx9DHU2LviVJMc+
         cRMA==
X-Gm-Message-State: AOAM5305fIPvo7GKsKolt9qREdaYav9oJqchkpRwkAfnVTsIpEJOW7yD
        9JteGIrBGC/HQhpYm0g8RJoQZrK9grzZAjVXSvicNA/L3KMljAKfqw2bkCne2oFTTwmUJcx7iem
        Vz0x/VopdumzpuEM7MEuWk7Qe
X-Received: by 2002:a05:600c:3b87:: with SMTP id n7mr8414223wms.93.1633508343888;
        Wed, 06 Oct 2021 01:19:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIawR4WUKpJOV7gnUEFSD8rvTMnU1dTx2SDKXmKB/lAhh9f9mq4stS0Ksi/kgoYEw4Rv3UkA==
X-Received: by 2002:a05:600c:3b87:: with SMTP id n7mr8414212wms.93.1633508343688;
        Wed, 06 Oct 2021 01:19:03 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id y23sm4686717wmi.16.2021.10.06.01.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:19:03 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/2] bcm2835-dt-fixes-2021-10-06
Date:   Wed,  6 Oct 2021 10:18:49 +0200
Message-Id: <20211006081849.1434867-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006081849.1434867-1-nsaenzju@redhat.com>
References: <20211006081849.1434867-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-fixes-2021-10-06

for you to fetch changes up to 75fcbda959b059d47c38c43f19658527eff4a470:

  ARM: dts: bcm2711-rpi-4-b: Fix usb's unit address (2021-10-06 09:50:37 +0200)

----------------------------------------------------------------
A series of devicetree fixes for the Raspberry Pi 4:

- Fix VEC reg address
- Fix MDIO address/size cells
- Fix regulator states
- Fix PCIe address formatting

----------------------------------------------------------------
Mateusz Kwiatkowski (1):
      ARM: dts: bcm283x: Fix VEC address for BCM2711

Nicolas Saenz Julienne (2):
      ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address formatting
      ARM: dts: bcm2711-rpi-4-b: Fix usb's unit address

Stefan Wahren (2):
      ARM: dts: bcm2711: fix MDIO #address- and #size-cells
      ARM: dts: bcm2711-rpi-4-b: fix sd_io_1v8_reg regulator states

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 ++++++-----
 arch/arm/boot/dts/bcm2711.dtsi        | 12 ++++++++++--
 arch/arm/boot/dts/bcm2835-common.dtsi |  8 ++++++++
 arch/arm/boot/dts/bcm283x.dtsi        |  8 --------
 4 files changed, 24 insertions(+), 15 deletions(-)

