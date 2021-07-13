Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FE3C69EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhGMFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhGMFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:55:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F7C0613DD;
        Mon, 12 Jul 2021 22:52:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1403955pjo.3;
        Mon, 12 Jul 2021 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJ30J7VKV1daCsRGNwfmp9q3CDthhlGNXCEPTO+nQbA=;
        b=htUuNLDOvPkDtNegm9OUrCWSSFPhs8tq7gE2EF+9UoGqv90rCH4TJyfXIyy431CtdJ
         raYhB76APe8UykZsX9ug5EKSjLNCEe3MR+2Tffb27xmq5b9Uq6/TgdsEpzgMHmaeTdEd
         P8X/d5GYvnzM1Q6MjbEllBvTi0kRk2oNRerLHlstVh25KXSV5zzxTODQJDbqxHbxjJ8O
         8OWyX6ki0gKMz1aYWsBBT0MUDXbJpbE1Jk9wzdsTUu4G+pyjDgrQR5RejGd7XqD8nDfT
         1UsLTRzRIq2w1irdGqSQ0GjMX3uR3vQQ94QgZL86L6kNoDtpFgbot8vdtEl8mba7iiVC
         c+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJ30J7VKV1daCsRGNwfmp9q3CDthhlGNXCEPTO+nQbA=;
        b=aCJDLHE/UDBQFlBQF4k+j258/VYKKpX04Xcizw2k2VG8AURW9rTvMA3cSFGWdIgvrR
         3FOld6S5cofRYT2JYWJKzxPMzBq1VJSvF0g2QWYK+SygASKbsgpWQq8XnvM8/Gjr10QO
         9nx7MSv0NPZZhLUxrEsp4v1Z8oFr/f2DWzX8HNopDT0sry2PGKYRqNsrVTAp8ni39yNC
         2B0i4YAqXcJP+aeRbUth2KAIewXlmzS7hjBwE7IfUoAsvjaEsNCtzVxLcGVGXUnw/mSk
         D9scD7wnBh+BqZ7BpNyGRgBqVUwrMrrHCtz1aqJmgaybgomnEm8N2E1o3Xuru8nrcNyn
         PtGg==
X-Gm-Message-State: AOAM533wWe6v3tiUxYDEv2wS/QL/49UwsXRLonK0JgMaUMYdeOQkpMMM
        1kDgCutrt/04juRmU7qlbdM=
X-Google-Smtp-Source: ABdhPJwBqGvbczjI7jyE+C1BkSY0LCJl39s636/wlyXTLR4kc/X91Rbc2m/axi7Bh7Ve+9wwieJ2cA==
X-Received: by 2002:a17:902:d293:b029:12b:1912:2540 with SMTP id t19-20020a170902d293b029012b19122540mr2172256plc.76.1626155566777;
        Mon, 12 Jul 2021 22:52:46 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id x19sm17755198pfa.104.2021.07.12.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 22:52:46 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv1 0/3] Meson-8b and Meson-gxbb Fix some missing code
Date:   Tue, 13 Jul 2021 05:52:12 +0000
Message-Id: <20210713055227.1142-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid C1+ and Odroid C2 USB feature is broken

It's being observed the after initiation of USB phy
the USB port goes in to suspend state, If we pass usbcore.autosuspend=-1
via command line USB hot plug seen to be working.

Another issue I observed is increase of USB interrupts event
even if there is not much activity on USB ports.

$ cat /proc/interrupts | grep usb
 35:   26462800          0          0          0     GIC-0  63 Level     c90c0000.usb, dwc2_hsotg:usb1

Changes added power node to usb phy and small code cleanup
in usb phy.

Previous version RFC.
[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20210617194154.2397-1-linux.amoon@gmail.com/
Dopped the reoder of code changes as of now.

Thanks
-Anand

Anand Moon (3):
  ARM: dts: meson8b: odroidc1: Add usb phy power node
  phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset
    mode
  phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER

 arch/arm/boot/dts/meson8b-odroidc1.dts | 20 ++++++++++++++++++++
 drivers/phy/amlogic/phy-meson8b-usb2.c |  8 ++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.32.0

