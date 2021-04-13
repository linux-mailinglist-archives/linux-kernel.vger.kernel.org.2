Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3E35E8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346938AbhDMV7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:59:02 -0400
Received: from foss.arm.com ([217.140.110.172]:47136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhDMV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:59:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F339311B3;
        Tue, 13 Apr 2021 14:58:39 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD85C3F694;
        Tue, 13 Apr 2021 14:58:39 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-usb@vger.kernel.org
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/1] dwc2: Enable USB when booted in ACPI mode
Date:   Tue, 13 Apr 2021 16:58:33 -0500
Message-Id: <20210413215834.3126447-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 has a designware USB controller that is commonly used
on the CM4 and RPi400. There is a desire to use thes machines with
a standard UEFI+ACPI stack as is being done with the normal RPi4.

This patch enables this by adding ACPI module boilerplate to the
existing dwc2 controller.

It should also be noted, that there is an ACPI table update
in the firmware which marks the ACPI _DMA() entries as
ResourceProducers. That change is required for this to work with
the 1G DMA translation present on the platform.

Changes:

  v2->v3: Add this cover letter to describe the patch changes
  
  v1->v2: Fix the kernel_ulong_t/set_parms() function typecasting
          warning by explicitly doing the type cast.

Jeremy Linton (1):
  usb: dwc2: Enable RPi in ACPI mode

 drivers/usb/dwc2/core.h     |  2 ++
 drivers/usb/dwc2/params.c   | 18 +++++++++++++++++-
 drivers/usb/dwc2/platform.c |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.29.2

