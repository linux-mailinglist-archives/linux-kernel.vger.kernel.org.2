Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946A332BEA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574363AbhCCRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbhCCN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:56:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27BC061797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:55:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l12so23776988wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YOg5zpUZn68sgiB7/CmxizbcXg6Inaa7h+fkuHr+NU=;
        b=Q++B4VWZxWtKiqGZOTBh7Q0d/9A0phGVBtZ6Tcdb4OivrfT3V4n0KsvoOItbwPg22B
         eZTQxcobUCkgxxpQhiOnUPwwsQn5nBwRoE+k3WqfxZVKFY9QUzku8hGKZrGRskpwzURk
         E5Ounzx8YiqKubHadqCT9jr9p3ukzspXgv7PzPpS4UDG8X4gIV+KbXQ9KHcg9IXAJw63
         UCL5onsn8O1KAKUci0VzlWmxEzyBpCh0XxHnmS8yB8ldQUD1vrBPT733kTGT2Lhnk9Rg
         /IJLSGZaMvFGuHZpxikQ11dPtZqZQ2/uP5/kW5517eYdIOTW/PX+bPcsXFZvVm7dQK3p
         9//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YOg5zpUZn68sgiB7/CmxizbcXg6Inaa7h+fkuHr+NU=;
        b=g4H2emMoy8FfWtHk+LE5xkEp0fK77FRS61msHs3S9fNezKmBSQDVKDQz5WEQXlrB4d
         mGUZ6jWKo2mXzW/kWnapnRhiWAblwSRQScdX74pVQ6E9qSP5nujc1fwrNMqrYwYosUmR
         2XyzEI/FW3qSNhbYq5p65kkeUhX4X8ib3POWAuQmjSRF6prw1tXO/biCdfq41TdzpGv7
         SEKN1Iuwt590iMo1PbRBxLe0P8PasL+EC7oequ0TXeylG1HLolyPDR6DqDhVgyj21Bbq
         +dOCvyUcZbfRNDizG03+389ZrFciRrbB6QHbuWuldiGEJPoOofZK4oVsEjCBe+9Gq4Wg
         z1mg==
X-Gm-Message-State: AOAM531Q6UqCzkadQE/JgD5hS1abcOz6VuWgYVcIgB/b30CyuCG/TSs5
        I9kPcBtO6SBNCiIRFY3669nWPQ==
X-Google-Smtp-Source: ABdhPJx91tE7QNaiOg4lhJlGoG68rNj5C29IKjGEmIu6HFCWZYgTHkJqWzctCL1kV5mftTGxfwRG5A==
X-Received: by 2002:adf:c752:: with SMTP id b18mr4774484wrh.233.1614779702514;
        Wed, 03 Mar 2021 05:55:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id p10sm18581441wrw.33.2021.03.03.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:55:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 901401FF7E;
        Wed,  3 Mar 2021 13:55:00 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH  0/5] RPMB internal and user-space API + WIP virtio-rpmb frontend
Date:   Wed,  3 Mar 2021 13:54:55 +0000
Message-Id: <20210303135500.24673-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a follow-up to the email I sent last month:

  Subject: RPMB user space ABI
  Date: Thu, 11 Feb 2021 14:07:00 +0000
  Message-ID: <87mtwashi4.fsf@linaro.org>

which attempts to put some concrete flesh on the bones of the proposal
for a new internal kernel API for dealing with RPMB partitions and the
resultant exposed user-space character device API.

It became apparent while implementing a virtio-rpmb backend that the
initial proposed API didn't sit well with a device like virtio-rpmb
which isn't part of a greater device (like eMMC or UFS). It also
exposed the gritty details of the frame format to userspace leaving it
to deal with the complications of creating JDEC frames and calculating
MACs.

The series is based on Thomas' last posting with a bunch of
functionality dropped:

  - no FS/RPMB integration
  - dropped the simulator
  - dropped the sysfs patches

There is a start of a WIP virtio-rpmb front-end however as the initial
discussion should be focused on the proposed APIs I thought it would
be worth posting as an RFC before getting too deep into the weeds of
implementation. The principle changes to the original proposal:

  - frame construction left to device driver

  The differences between UFS/JEDEC/VirtioRPMB are left for the driver
  itself to deal with. This means things like MAC calculation and
  validation also remain the preserve of the low level implementation
  details. This doesn't mean there can't be shared code where
  implementation details are common across several device types.

  - key management uses keyctl()

  This means in theory userspace could interact with the RPMB device
  without having to manage the key itself. This also means you don't
  need to pass as much data about as the kernel internals can just use
  the keyring id with the API to fetch the key when required.

  - user-space interface split across several ioctls

  Now we no longer have multiple command frames going back and forth
  we can have a single structure per ioctl which just contains what is
  needed for the operation in question.

So what do people think? Is it worth pursuing this approach?

I'm certainly intended to complete the virtio-rpmb driver and test it
with my QEMU based vhost-user backend. However I've no direct interest
in implementing the interfaces to real hardware. I leave that to
people who have access to such things and are willing to take up the
maintainer burden if this is merged.


Alex Bennée (5):
  rpmb: add Replay Protected Memory Block (RPMB) subsystem
  char: rpmb: provide a user space interface
  tools rpmb: add RPBM access tool
  rpmb: create virtio rpmb frontend driver [WIP]
  tools/rpmb: simple test sequence

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   9 +
 drivers/char/Kconfig                          |   2 +
 drivers/char/Makefile                         |   1 +
 drivers/char/rpmb/Kconfig                     |  28 +
 drivers/char/rpmb/Makefile                    |   9 +
 drivers/char/rpmb/cdev.c                      | 246 +++++++
 drivers/char/rpmb/core.c                      | 431 ++++++++++++
 drivers/char/rpmb/rpmb-cdev.h                 |  17 +
 drivers/char/rpmb/virtio_rpmb.c               | 366 ++++++++++
 include/linux/rpmb.h                          | 173 +++++
 include/uapi/linux/rpmb.h                     |  68 ++
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_rpmb.h              |  54 ++
 tools/Makefile                                |  14 +-
 tools/rpmb/.gitignore                         |   2 +
 tools/rpmb/Makefile                           |  41 ++
 tools/rpmb/key                                |   1 +
 tools/rpmb/rpmb.c                             | 649 ++++++++++++++++++
 tools/rpmb/test.sh                            |  13 +
 20 files changed, 2121 insertions(+), 5 deletions(-)
 create mode 100644 drivers/char/rpmb/Kconfig
 create mode 100644 drivers/char/rpmb/Makefile
 create mode 100644 drivers/char/rpmb/cdev.c
 create mode 100644 drivers/char/rpmb/core.c
 create mode 100644 drivers/char/rpmb/rpmb-cdev.h
 create mode 100644 drivers/char/rpmb/virtio_rpmb.c
 create mode 100644 include/linux/rpmb.h
 create mode 100644 include/uapi/linux/rpmb.h
 create mode 100644 include/uapi/linux/virtio_rpmb.h
 create mode 100644 tools/rpmb/.gitignore
 create mode 100644 tools/rpmb/Makefile
 create mode 100644 tools/rpmb/key
 create mode 100644 tools/rpmb/rpmb.c
 create mode 100755 tools/rpmb/test.sh

-- 
2.20.1

