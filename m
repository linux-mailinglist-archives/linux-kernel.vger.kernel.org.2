Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9162F34E993
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhC3Ns5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhC3Ns0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E672C061574;
        Tue, 30 Mar 2021 06:48:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so24939748ejr.5;
        Tue, 30 Mar 2021 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHesdm8MfmQq/Mx8NCgtXN0WgABESjsUY5mxQL3k6c0=;
        b=HU+nGVhHLhCXmZLHy9oIKWEpLG2TT7397bG0JOVGqK++Lu3k5mhhHDMXAbhCdrPk4o
         NKp+l1J4f3QcUxOIfgD50GzqUtDg5l/lNIvrfRiPaPwad4JLOrT2D17wVDyK/Rxgc+oh
         1LDnNAUYkXr6x+HO8aWwWn6Bc1b78+qBaBWAlAHbmRyO9C5KE7DzKXpYAcZ6T19ceewp
         8nhL8D4jXyybEejBBS6y2CfseUAlgWtl6SJDz7cD77ZZ8Eye+EMnBGdYmIGjmxhkncYj
         +WGDYdMgCErgTSTUr0B16ngdNvAH8ZV8PpARH/iiQqYaNTnG2K5nkPv+FmxM3cSlz8iQ
         PcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHesdm8MfmQq/Mx8NCgtXN0WgABESjsUY5mxQL3k6c0=;
        b=ejNjUFjq+g8L3Je4PrC7NpprqZociZFOZeZLtaQZtV5LARqdg5otnI7GHGBErTvF4f
         4yf1NIYlC6kwxiIrrwi2LrRgvvXjlpv6kCGIdt0orYUGss2heh2coq2SCUTxMmVUpf3k
         h2cGhhRmo2w3Ry8VECwKNaBmovRC7tqFXL568+PaftIjBer25H7qNABMWq6yvDPZhp7k
         a30NUQ5ngJDELPGkPfhpfWpYWLqlgiE6u3t8XJDHMwZAAZOV/Fcjcd4Hip3KRvDfv5u2
         cHzan6sebu/UR0VMo62FuEWEC+bsqQnYnT6Tihc0AjwP2AXfNDhAQqS1+BwyhlwYqKLX
         dX4A==
X-Gm-Message-State: AOAM532dVDhAcQrI0Blx217aK5BKccrfL23sYCYpKO42vZ+WuiMFPGW7
        x1dmoQu/KCVXniDG0mbVORk=
X-Google-Smtp-Source: ABdhPJybuNlr/uWKtmzBSulIZS8xUoDGyJn5OtJZVqQ+xY3jp5m1fxhITb3prHky6PSlJwU9nUNSMw==
X-Received: by 2002:a17:907:2d9f:: with SMTP id gt31mr33128669ejc.233.1617112104324;
        Tue, 30 Mar 2021 06:48:24 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:23 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Date:   Tue, 30 Mar 2021 16:48:15 +0300
Message-Id: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a socinfo driver which provides information about
Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
serial_number.

Please note the serial number is currently available only for the S500
SoC variant.

This has been tested on the S500 SoC based RoseapplePi SBC.

Thanks,
Cristi

Changes in v2:
 - Exposed the memory range for reading the SoC serial number under
   /reserved-memory DT node, according to Rob's review; as a consequence
   added a new binding document (actions,owl-soc-serial.yaml) and updated
   owl-socinfo.yaml

 - Replaced the unportable usage of system_serial_{low,high} globals
   with a public API to provide external access to SoC serial number
   parts (e.g. Owl Ethernet MAC driver will use this to generate a
   stable MAC address)

 - Rebased patch series on v5.12-rc5

Cristian Ciocaltea (6):
  dt-bindings: reserved-memory: Add Owl SoC serial number binding
  dt-bindings: soc: actions: Add Actions Semi Owl socinfo binding
  soc: actions: Add Actions Semi Owl socinfo driver
  arm: dts: owl-s500: Add reserved-memory range for Owl SoC serial
    number
  arm: dts: owl-s500: Add socinfo support
  MAINTAINERS: Add entries for Owl reserved-memory and socinfo bindings

 .../actions,owl-soc-serial.yaml               |  53 ++++++
 .../bindings/soc/actions/owl-socinfo.yaml     |  57 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/owl-s500.dtsi               |  13 +-
 drivers/soc/actions/Kconfig                   |   8 +
 drivers/soc/actions/Makefile                  |   1 +
 drivers/soc/actions/owl-socinfo.c             | 152 ++++++++++++++++++
 include/linux/soc/actions/owl-serial-number.h |  20 +++
 8 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
 create mode 100644 drivers/soc/actions/owl-socinfo.c
 create mode 100644 include/linux/soc/actions/owl-serial-number.h

-- 
2.31.1

