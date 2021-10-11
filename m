Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21224286FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJKGsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhJKGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:48:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B33C061570;
        Sun, 10 Oct 2021 23:46:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e3so19019475wrc.11;
        Sun, 10 Oct 2021 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/1OxJ8JM2QUHn4Oc3wpiHkW/oQLE60mEH63KUNuQH0=;
        b=mZ0BgGAsXahKMOL1Yb0NVOGkIoHGnBtcN5TRN3txu45qiUP5g3sp4JCjbInv0Mk2mE
         P+34hJHss/ssiuAZzS524kK7NhjYP5d2EpLSFdSj1SMdF65BBLVmuuRuhuueZoinE4o0
         QrExMkH7A5YEGGQRyho6a6tVuVDNqPaEZoYZYwLGC1TXEuuh92rWyjuz7DgOEI7h+eCp
         dpX32vn4xh4r/SOZNNdqXF2KCYxbf4/ZQW02aswxrthEsNjhHDKjGcgeyG9XUpcsprQp
         B30xqIV79J/AbTlxEaKg0v3yLBP7SJpL5v/KbeyiRq2r2XJXz3GKA6WsdCIAto9/VOzH
         h4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/1OxJ8JM2QUHn4Oc3wpiHkW/oQLE60mEH63KUNuQH0=;
        b=OGbZRPLI8dURmO5QKx70oy15OcqRClDh3Vp3mtAHK9MwSede1BrbNSB2C1FX1i3XpP
         S3WLuvl7K/qQdJ4fV0gGtMitjNI+kQSbrUd6kuX5BK+Q18lME+dvsROhnJC2edqt7oNh
         QEtdCq0oWOoCVkys+U7nA/aPa797P2yyDeM9WzODeqGMQLd5xq8ShOrfbE+pNbOwCwMZ
         14ItVyhgoEm6B9NnFIqxbkmZ1PceaWFBisTjFYijL6Vqd2rXeLIdzq2lh23T2qH2nNi9
         jVoG2ZY8LTF7w2Lxed4sVuBWgzvlgJyc/sn35MeERn+9wVsqaPZrDuetEpiDHJvhKjvz
         nuoA==
X-Gm-Message-State: AOAM532rRXc5K5LzoWqe953QEstvEVMPsSe5DCnjoPepVItj1QE4r+MJ
        fG913C42mqNJY3sUmvbHUcQ=
X-Google-Smtp-Source: ABdhPJxu5D3VwMyGvCs4ynOf30vPCWewa1A1sYe67thP7UZGLI9KeF6M+vPS7ee9Dkg1vTpy983mIw==
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr22798327wry.87.1633934773355;
        Sun, 10 Oct 2021 23:46:13 -0700 (PDT)
Received: from localhost.localdomain (i577BCB28.versanet.de. [87.123.203.40])
        by smtp.gmail.com with ESMTPSA id o23sm6915843wms.18.2021.10.10.23.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 23:46:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND 0/1] Kconfig clean-up after IDE removal
Date:   Mon, 11 Oct 2021 08:36:23 +0200
Message-Id: <20211011063624.12269-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sekhar, dear Russell,

here is some cleanup to the issue of Kconfig references to obsolete IDE configs.

Following checkkconfigsymbols.py indications, this patch series cleans up all
references to removed IDE Kconfig symbol throughout the current kernel tree.

This is a resend of the patch that was not yet picked up from the patch series
https://lore.kernel.org/all/20210804123426.16947-1-lukas.bulwahn@gmail.com/

Pavel Machek already picked the patch "leds: trigger: remove reference to
obsolete CONFIG_IDE_GD_ATA".


Best regards,

Lukas

Lukas Bulwahn (1):
  arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710

 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.26.2

