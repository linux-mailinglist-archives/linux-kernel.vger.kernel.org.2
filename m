Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF3327517
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 00:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhB1XIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 18:08:13 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35306 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhB1XIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 18:08:05 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 43A9D806B7;
        Mon,  1 Mar 2021 12:07:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1614553637;
        bh=j/4y79Sbn2mTxUOqHjk7rek/Rc6O8m6q4ne8OexoRHI=;
        h=From:To:Cc:Subject:Date;
        b=ZhC0tKdePGVFXUgTMgE+pqToPzeuSe+oAmnGXXCTtsutVkykj3HVNYlLB1iYPUYUy
         lWvVMslWgZwpp4ZtH0pZrzmYrVV9sA3QsqumEt36wVUP6lHNtUmJ4JsRCujXtQRUf4
         gZTQXjXUks8MPiVgwtx0FdZ4pMGrChfkzNVgeu8QIaBJyYrRg/TQeasnjXTO9CYA1X
         oVOAQTMMWIyi3ROkTcoiDE9GHph/Fv8yVtURRXpo5kPLjtOM7IT9pt+vDheWI6j8Ao
         k5T7jdusy1CAurKHPU8vUmeiZHFoZ006TO1ly4esvV3lRVeJMPLXSzQGlk37Dg3dm+
         oVx4AzkJW+q2g==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B603c22250000>; Mon, 01 Mar 2021 12:07:17 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 8281C13EF08;
        Mon,  1 Mar 2021 12:07:27 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1877C283985; Mon,  1 Mar 2021 12:07:17 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] hwmon: (pmbus): Infineon IR36021 driver
Date:   Mon,  1 Mar 2021 12:07:12 +1300
Message-Id: <20210228230714.26578-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7uXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=JyPFgGt3d6mCrvuXJWMA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a basic driver for the IR36021. This chip as both a PMBUS and I=
2C
interface that is available simultaenously. This driver is just the PMBUS
interface.

Chris Packham (2):
  dt-bindings: trivial-devices: Add infineon,ir36021
  hwmon: (pmbus): Add driver for Infineon IR36021

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 Documentation/hwmon/index.rst                 |  1 +
 Documentation/hwmon/ir36021.rst               | 62 ++++++++++++++
 drivers/hwmon/pmbus/Kconfig                   |  9 +++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/ir36021.c                 | 81 +++++++++++++++++++
 6 files changed, 156 insertions(+)
 create mode 100644 Documentation/hwmon/ir36021.rst
 create mode 100644 drivers/hwmon/pmbus/ir36021.c

--=20
2.30.0

