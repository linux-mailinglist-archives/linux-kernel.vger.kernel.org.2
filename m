Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35EA3AF1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFURd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFURd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:33:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EDC061766
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r5so31542964lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj3vnqr9bU4v5JK2hmhbbYu29x7zXchPcIMa64GKEwA=;
        b=D9cJWnrXheK4OGnigfeIGBvVi303PUAb/1OB8+tIUd9Y9IkblBvYWwNW4Tvj6/rW8a
         msn2NA0jnbcGjbT5gURom8lx9YfpN1KFg9fXdhWGvt2OHMGpyo3KDIx7C7rVt0KMtmR+
         m3oNDW83Xe4f9Y7tEMipsRSXWOU53YchSOBg6wLx95LU472P0qh1FkqwBTy99hM1xjt6
         3AQb2nqDv4qYzzWeTgwKk1T4lpyibhWKmRGRKacV5duEmeG51IZw+RgujiNwIwKb8BH1
         hIJTdhmC5Hb2b1KqO+7HkzGYC5g/lZWYoL0DKRNs0SXlamQvqIoFKWDb7VsY4MfPv5vl
         RPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj3vnqr9bU4v5JK2hmhbbYu29x7zXchPcIMa64GKEwA=;
        b=GyTfW3eoMq2RV3h2HDY1Q0DOWP5iW6rIJRC4VnW79Gk6jVVElreLl7VxatyBR8yHBR
         ROUQdfIUby64DZXMDNEDnk/LiTsi06NaDUO5mRYfar+cxA+fpnvNx4N5SYN+iigyV0Tn
         Cn23gWXPS6Hy5N3EjsVd3S4zLXTbB0CO1eVcoReUSvm0tI87y55p1a/ZgfXEJJp31Q8I
         RPXa3U2MWB2ZiVPTFOHtVDUXJYqgajAJQQk1SPGr+K3rMOIBHIV/c7S+elgBEBKxzIqv
         Fs4sJGAj/ntecouPdFpFXOURLBoFVV1KLXjBojsAYrWiRtEADdo/80GtO6I6aF2YzQ7O
         dbbA==
X-Gm-Message-State: AOAM5307D0N08fz9L32j5i5nGqsppjk3YeYkxjzcPSyyhR/W3WJ8+HJX
        Sq7GXaBz5vLTTDiJw9wBE/IjAGkuzrAe6g==
X-Google-Smtp-Source: ABdhPJwxtsWwdPErFzAjuD+MmnYa/R6o/UjaJk2ScFQAPtJiENIo4chvrSFW0eFRJyU3VzmNwm/gHg==
X-Received: by 2002:ac2:4d8e:: with SMTP id g14mr14901363lfe.502.1624296670863;
        Mon, 21 Jun 2021 10:31:10 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id u11sm1926380lfs.257.2021.06.21.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:31:10 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v3 0/6] ACPI MDIO support for Marvell controllers
Date:   Mon, 21 Jun 2021 19:30:22 +0200
Message-Id: <20210621173028.3541424-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The third version of the patchset main change is
dropping a clock handling optimisation patch
for mvmdio driver. Other than that it sets
explicit dependency on FWNODE_MDIO for CONFIG_FSL_XGMAC_MDIO
and applies minor cosmetic improvements (please see the
'Changelog' below).

The firmware ACPI description is exposed in the public github branch:
https://github.com/semihalf-wojtas-marcin/edk2-platforms/commits/acpi-mdio-r20210613
There is also MacchiatoBin firmware binary available for testing:
https://drive.google.com/file/d/1eigP_aeM4wYQpEaLAlQzs3IN_w1-kQr0

I'm looking forward to the comments or remarks.

Best regards,
Marcin

Changelog:
v2->v3
* Rebase on top of net-next/master.
* Drop "net: mvmdio: simplify clock handling" patch.
* 1/6 - fix code block comments.
* 2/6 - unchanged
* 3/6 - add "depends on FWNODE_MDIO" for CONFIG_FSL_XGMAC_MDIO
* 4/6 - drop mention about the clocks from the commit message.
* 5/6 - unchanged
* 6/6 - add Andrew's RB.

v1->v2
* 1/7 - new patch
* 2/7 - new patch
* 3/7 - new patch
* 4/7 - new patch
* 5/7 - remove unnecessary `if (has_acpi_companion())` and rebase onto
        the new clock handling
* 6/7 - remove deprecated comment
* 7/7 - no changes

Marcin Wojtas (6):
  Documentation: ACPI: DSD: describe additional MAC configuration
  net: mdiobus: Introduce fwnode_mdbiobus_register()
  net/fsl: switch to fwnode_mdiobus_register
  net: mvmdio: add ACPI support
  net: mvpp2: enable using phylink with ACPI
  net: mvpp2: remove unused 'has_phy' field

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      |  3 -
 include/linux/fwnode_mdio.h                     | 12 ++++
 drivers/net/ethernet/freescale/xgmac_mdio.c     | 11 +---
 drivers/net/ethernet/marvell/mvmdio.c           | 14 ++++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 23 ++++++--
 drivers/net/mdio/fwnode_mdio.c                  | 22 ++++++++
 Documentation/firmware-guide/acpi/dsd/phy.rst   | 59 ++++++++++++++++++++
 drivers/net/ethernet/freescale/Kconfig          |  4 +-
 8 files changed, 125 insertions(+), 23 deletions(-)

-- 
2.29.0

