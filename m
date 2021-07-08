Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6B3C1B91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGHWpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 18:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhGHWpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 18:45:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D38C061760;
        Thu,  8 Jul 2021 15:42:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so7836179wmq.5;
        Thu, 08 Jul 2021 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x621fK8buUAY43nsSreHPxG4n57Hwycv+IeTs0hwv44=;
        b=kacOgh+tpoNLdrl/WLS2B/svr+FPlBFONhfiNK38T2Ozs0tZHAH79mF0XlI4oICMRD
         LwCFiz8iCzpC5H9ijG4Bq5hhBaeuCMwIBDrLMsqvYTZWEFLNputHGP3FEc+KWgQkc66U
         5OpXPZxmj+RTAtImF3Ma3Om6gI0LrfTBpKon7GnsxCw70VvsmYyJc8KTb/OxoA8zvDQJ
         uCW07YbSvYglI/Rj3eqSrd0xn7ZScyxA7qWQoJdkJUQKNL3fmFImfkC9iKv04WZDCW8A
         sXzRo38zJvDMp2mwviojNR6sNf9NyKMammilyCFxnqVWWQz5YyTSotBFh6kLT6yMVZCC
         4/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x621fK8buUAY43nsSreHPxG4n57Hwycv+IeTs0hwv44=;
        b=DU2h6OGIhzwofahVNo3+QDBEMCLcma/JNJL8OTlysXWmVQr5OOsW8Gt4W7tRDvDYBh
         S+nFtjVddgTBlZ46737HrmiSBuhgat81aJBWgZxVPxIDrPSkP1lGtPmGegUgagkNTXje
         OJULU0s6Ihrix0K/sM8Z0IR/4rdKSPQhaI2iIpbZJtx7v2kyEjJ1VmvO9yZ1rGycrzqm
         0dqThR+2O/+P7BRbZjg0X565xp3KXb7qDRH3h3W1d9J38d/Nabgr0fdEgxdOtoJ9ZuAU
         VmT0CtjhjgPEz4vWiPc08C2Giv0kOziLXLbIjY1bxvqOaxX5UW3LymZ/flhDEWXOLabg
         32jg==
X-Gm-Message-State: AOAM531r16TY+LiUVi4tamEuBrv78bkJd+QUUNPk0Md6Uu9ZUgb+vhlT
        f6Hnam+0jaTZMdrUSiHFBwTdsi+YxNk=
X-Google-Smtp-Source: ABdhPJyscBYDf8HkS1yoc4z3nE1AKSrRaUThPbLRD0IqAKmnJwRLf8/K8213zb9xsYF5pGkwbyZotQ==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr12955472wmf.10.1625784154691;
        Thu, 08 Jul 2021 15:42:34 -0700 (PDT)
Received: from valhalla.home ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id l4sm3080655wme.26.2021.07.08.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 15:42:34 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: [RFC PATCH 0/2] Add software node support to regulator framework
Date:   Thu,  8 Jul 2021 23:42:24 +0100
Message-Id: <20210708224226.457224-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

See previous series for some background context [1]

Some x86 laptops with ACPI tables designed for Windows have a TPS68470
PMIC providing regulators and clocks to camera modules. The DSDT tables for
those cameras lack any power control methods, declaring only a
dependency on the ACPI device representing the TPS68470. This leaves the
regulator framework with no means of determining appropriate voltages for the
regulators provided by the PMIC, or of determining which regulators relate to
which of the sensor's requested supplies. 

This series is a prototype of an emulation of the device tree regulator
initialisation and lookup functions, using software nodes. Software nodes
relating to each regulator are registered as children of the TPS68470's ACPI
firmware node. Those regulators have properties describing their constraints
(for example "regulator-min-microvolt"). Similarly, software nodes are
registered and assigned as secondary to the Camera's firmware node - these
software nodes have reference properties named after the supply in the same
way as device tree's phandles, for example "avdd-supply", and linking to the
software node assigned to the appropriate regulator. We can then use those
constraints to specify the appropriate voltages and the references to allow the
camera drivers to look up the correct regulator device. 

Although not included in this series, I would plan to use a similar method for
linking the clocks provided by the TPS68470 to the sensor so that it can be
discovered too.

I'm posting this to see if people agree it's a good approach for tackling the 
problem; I may be overthinking this and there's a much easier way that I should
be looking at instead. It will have knock-ons in the cio2-bridge code [2], as
that is adding software nodes to the same sensors to connect them to the media
graph. Similarly, is the board file an acceptable solution, or should we just
define the configuration for these devices (there's three orf our laptop models
in scope) in int3472-tps68470 instead?

Thanks
Dan

[1] https://lore.kernel.org/lkml/20210603224007.120560-1-djrscally@gmail.com/
[2] https://elixir.bootlin.com/linux/latest/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L166


Daniel Scally (2):
  regulator: Add support for software node connections
  platform/surface: Add Surface Go 2 board file

 MAINTAINERS                                |   6 +
 drivers/platform/surface/Kconfig           |  10 ++
 drivers/platform/surface/Makefile          |   1 +
 drivers/platform/surface/surface_go_2.c    | 135 +++++++++++++++++++++
 drivers/regulator/Kconfig                  |   6 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/core.c                   |  23 ++++
 drivers/regulator/swnode_regulator.c       | 111 +++++++++++++++++
 include/linux/regulator/swnode_regulator.h |  33 +++++
 9 files changed, 326 insertions(+)
 create mode 100644 drivers/platform/surface/surface_go_2.c
 create mode 100644 drivers/regulator/swnode_regulator.c
 create mode 100644 include/linux/regulator/swnode_regulator.h

-- 
2.25.1

