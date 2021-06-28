Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1C3B6B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhF1Xjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhF1XjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:39:04 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79738C061767
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:36:33 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso5207503ood.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=+H55P0ypSdIaQcdDFx4sbQNPtQN77yyUkvRBo423tNY=;
        b=FLyzzZmpszg1zHHEUiACeaYpQdeBPA61HCJxhFW68E37Mzq5wX771/o2Ndy25g6aaV
         O7iDlJSKoMxruI3ZdlTbUz6vgLN0JJhCQ7RgTEawJCYcsWOMDXiXr7klV3ME/6phRArM
         mLH3CYyrpPeno8jI4vrUjx150OIVWx7QomVpQZQC4dUsWy2pVX1A0KtyEs2qh2V58i2u
         +//QWY0m/GvdcPUh3yM6cAIElL9Y16hCWap/Ysmw/3v1I0nLxUbTBuXoZlfyw6uU0AMA
         4hDgTTKXM8+N/6Znl8yZIK1ufhX4JDS2v2np4d47chV4KAt8ufSOf/sIR34jf2hV+gMu
         NC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=+H55P0ypSdIaQcdDFx4sbQNPtQN77yyUkvRBo423tNY=;
        b=E+cpkyT12Tw4n5olIl/e+6N2jLEA1q0zT6pkPNklIz+c40TyJQu80PMNe/sbAYE6XP
         WbKauvIk1rUgoxtL0Z35EHUWjMe1lxWyWiybnWy8llgr7HQXsaw0+s1nFG6e2WEhQscj
         qzT9EpLWQR99i/fdS6MYpD2EIhFR6Vsue8gMI9wzadsIBYun0SkIXMIxoEmRyyN5Gk9Y
         6vDb3rxIALKxGAbzBtBCQFdqNftUxasU+ixdU5xpHBOWn+SbJV2xA4KGiWmo29MefetS
         u5F51X6e+fqVaWM3hmEtQZeASaP8zVrAUzHgCNPACUEKpHyN1tl/PrYtbi1OxHhmRSZp
         KVNQ==
X-Gm-Message-State: AOAM530JI5/IeBOEwMXNl7JtH8s1jr0gAKfxXIOa1sk44VkFvsPfOF+e
        G6FoPLKCupsVKgx/4WNGyA==
X-Google-Smtp-Source: ABdhPJyZ+oIeGRbGqpS0i3Grns1E55zv/R3ld8o1gspUfrWzfWHVkZdE7u17QYy+zCn6FX4JSaukEQ==
X-Received: by 2002:a4a:b815:: with SMTP id g21mr1534098oop.70.1624923392762;
        Mon, 28 Jun 2021 16:36:32 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o17sm1203907oie.56.2021.06.28.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 16:36:31 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:bdb9:8367:8bd5:6021])
        by serve.minyard.net (Postfix) with ESMTPSA id E3C1018022E;
        Mon, 28 Jun 2021 23:36:30 +0000 (UTC)
Date:   Mon, 28 Jun 2021 18:36:29 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.14
Message-ID: <20210628233629.GP2921206@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d72cd4ad4174cfd2257c426ad51e4f53bcfde9c9:

  Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2021-04-28 17:22:10 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.14-1

for you to fetch changes up to 5b32dd281ee0a269f39ecf6b48f0cd3f37264842:

  ipmi: kcs_bmc_aspeed: Fix less than zero comparison of a unsigned int (2021-06-21 19:50:36 -0500)

----------------------------------------------------------------
Pull for IPMI driver for 4.14

Mostly a restructure of the kcs_bmc driver to make it easier to
use with different types of devices, and just to clean things up and
improve things.

Also some bug fixes for the kcs_bmc driver.

One fix to the IPMI watchdog to stop the timer when the action is none.
Not a big deal, but it's the right thing to do.

----------------------------------------------------------------
Andrew Jeffery (16):
      ipmi: kcs_bmc_aspeed: Use of match data to extract KCS properties
      ipmi: kcs_bmc: Make status update atomic
      ipmi: kcs_bmc: Rename {read,write}_{status,data}() functions
      ipmi: kcs_bmc: Split out kcs_bmc_cdev_ipmi
      ipmi: kcs_bmc: Turn the driver data-structures inside-out
      ipmi: kcs_bmc: Split headers into device and client
      ipmi: kcs_bmc: Strip private client data from struct kcs_bmc
      ipmi: kcs_bmc: Decouple the IPMI chardev from the core
      ipmi: kcs_bmc: Allow clients to control KCS IRQ state
      ipmi: kcs_bmc: Enable IBF on open
      ipmi: kcs_bmc: Add serio adaptor
      dt-bindings: ipmi: Convert ASPEED KCS binding to schema
      dt-bindings: ipmi: Add optional SerIRQ property to ASPEED KCS devices
      ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration
      ipmi: kcs_bmc_aspeed: Fix IBFIE typo from datasheet
      ipmi: kcs_bmc_aspeed: Optionally apply status address

Colin Ian King (1):
      ipmi: kcs_bmc_aspeed: Fix less than zero comparison of a unsigned int

Petr Pavlu (1):
      ipmi/watchdog: Stop watchdog timer when the current action is 'none'

 .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml      | 106 ++++
 .../devicetree/bindings/ipmi/aspeed-kcs-bmc.txt    |  33 --
 drivers/char/ipmi/Kconfig                          |  27 +
 drivers/char/ipmi/Makefile                         |   2 +
 drivers/char/ipmi/ipmi_watchdog.c                  |  22 +-
 drivers/char/ipmi/kcs_bmc.c                        | 505 ++++------------
 drivers/char/ipmi/kcs_bmc.h                        |  92 +--
 drivers/char/ipmi/kcs_bmc_aspeed.c                 | 633 +++++++++++++++------
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c              | 568 ++++++++++++++++++
 drivers/char/ipmi/kcs_bmc_client.h                 |  45 ++
 drivers/char/ipmi/kcs_bmc_device.h                 |  22 +
 drivers/char/ipmi/kcs_bmc_npcm7xx.c                |  92 ++-
 drivers/char/ipmi/kcs_bmc_serio.c                  | 157 +++++
 13 files changed, 1598 insertions(+), 706 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
 create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
 create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
 create mode 100644 drivers/char/ipmi/kcs_bmc_device.h
 create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c

