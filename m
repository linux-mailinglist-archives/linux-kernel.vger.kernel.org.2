Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5DA3F6C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhHXXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhHXXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:07:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FBEC061757;
        Tue, 24 Aug 2021 16:06:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i6so9812486wrv.2;
        Tue, 24 Aug 2021 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvNMT9LUR7zPj7A3O6BncGYRhFBAKuZVpmxoLPeyKbg=;
        b=XZPGd+c31s0bzs3c2EUg7FvhA3/bt9LmRnbAVEfCTzqVaW33wSVshWkVLx8V8Riqo6
         zSziH/6pokLnAkhuf1d7gQt4q+DInY+6F6NgjzCw9xp1Ed9rafAylGa3AIXpx6KThOBg
         a2lIDKPnqxdcHe+wZuI8KeI3KswWJxs7Ppwp1BQbs0hrsGSPnDwWvjeNX1hZmGkxWc+W
         +YLXTJirtlygLiJLZmViAp+yz2M5MsataN8m9XQ8FL8Zjd7kLTk+0n6Nk8q5X0NewWLm
         +qpcL1SdZuZU1ssWTsI45rwEW8ZModaqwqvX+FEhW+R9c7OQn3vM2p5XNqvPIi3yYKRx
         SpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvNMT9LUR7zPj7A3O6BncGYRhFBAKuZVpmxoLPeyKbg=;
        b=sH4fL42W1JaMwKfT49G/lxWP8OI4ZSwWat1gGCoDEm8Clc6ADjrAYeiC/rtV3zSIQk
         rCZoKes9VboNlIyRKhHrquOWRR96Nmap8Ba/28HoW+AUnTzkpPBnwDJDg4YB/O47Pg+C
         GXZz9RLlm8JW8jL6Qla0rlMsZP7HT5PgjjE9kUkxKX35zWarFqkSLUd3l+OdKmh9PG+s
         u76JL2/ktk1KkPVURP0dHWo32Unr/eIS6YxaIy1y63tmf5QniO218+lVa4cOPrKZeqq8
         vLwsaSStqpyeNmwq+M6BiCfe/lJnXt+UfBazifsBDVWRDgRbh6yqG6k00HP0RZG2cf4M
         UffA==
X-Gm-Message-State: AOAM532SSgjg4kJRH04hRx6TdRKzNFKwgQuDlX2cEIzSk8Ln3bGQ2p/C
        ZpwQ8B0sqBiVU6iYKHdW2kL3RnRsckw=
X-Google-Smtp-Source: ABdhPJwKee4COZshLLoOplw/BoVDGp3KsbfNJkSFEehomBeXlXYl0EeMuQ/gXuO5+s9bHnsZppgmsg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr21500416wrs.256.1629846400288;
        Tue, 24 Aug 2021 16:06:40 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q10sm3477868wmq.12.2021.08.24.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 16:06:39 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC PATCH v2 0/3] Add regulator_lookup_list and API
Date:   Wed, 25 Aug 2021 00:06:17 +0100
Message-Id: <20210824230620.1003828-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

This series adds a new list to the regulator core; regulator_lookup_list.
The intended purpose of this is to allow board files to pass instances of
struct regulator_init_data to regulators that are being registered by
_other_ pieces of code.

The problem this is intended to solve is where ACPI enumerates i2c devices
that provide one or more regulators, but which do not have any power
control methods defined in ACPI. This leaves the consumers of those
regulators unable to use them. With this series, the regulator drivers for
those i2c devices can bind and register regulators which will pick up the
init data as though it were parsed from devicetree. The new API emulates
gpiod_add_lookup_table() to allow early-running code to fill in that
init_data so that it's available by the time the i2c driver probes and
registers the regulators.

This is marked v2, because an earlier series [1] had the same aims albeit
using a totally different methodology. There's little commonality between
them, but I include the reference for context.

Thanks
Dan

[1] https://lore.kernel.org/platform-driver-x86/20210708224226.457224-1-djrscally@gmail.com/

Daniel Scally (3):
  regulator: core: Add regulator_lookup_list
  Documentation: power: Document regulator_lookup_list
  platform/surface: Add Surface Go 2 board file

 Documentation/power/regulator/machine.rst |  31 ++++++
 MAINTAINERS                               |   6 ++
 drivers/platform/surface/Kconfig          |  10 ++
 drivers/platform/surface/Makefile         |   1 +
 drivers/platform/surface/surface_go_2.c   |  97 ++++++++++++++++++
 drivers/regulator/core.c                  | 119 +++++++++++++++++++++-
 include/linux/regulator/machine.h         |  23 +++++
 7 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/surface/surface_go_2.c

-- 
2.25.1

