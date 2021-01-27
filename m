Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3073059B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhA0L3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhA0L0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:26:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE6C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 6so1516993wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiLqga9nREEazATvjCBJkNC1icYQezo71LhHKob0kLY=;
        b=kF56xyYCkfauVmaBxc5K+9sQQ37BpFYj5rD4ScA/OS+XT1j+vK2c/GYywpC+c/yii4
         Lki46pU8qF3H+VnsZq2aSJHgFr79DbT3Pgm0/aUY/AAiL0YXgp6oQq07NvxiAWvEgFYp
         agLNxejdtdzSoxzx4QaaNnfuChUDymwvvdwW2bAK2Ilrj0T08iAwu6rpV/mlkBkunDP6
         0/mEaxUcvRq4F3aqW3nY2V4D9pLNiS0NWBWNsgLrnJ8lhuv3YaxQ9tb3q1Frhf+t8gdU
         C/ivHO+6Wmp56PgFHpF/+i3SwAb2Qx9IORdvpss6VeryW9kMDL6U0bzC/Bktv+XJKUII
         3xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiLqga9nREEazATvjCBJkNC1icYQezo71LhHKob0kLY=;
        b=OgDpLzSHbz2DC94naSSy8csqN17NnS97Q51+dJpSPPKVI6pPFB41aTjgZxgwkLAeL8
         wIrFIJbBvsD73gbMOacmIdcqtiMQEon8DoVq8qCF8n2wLLPAl8F4b7GE9UPGojJ23LCq
         EdYumTFCOom+2vIToKYz5yU8oQ0+k1GyG1k2OBg08aSsJW24xyr7iDR7ItRbbyc/a4Bf
         eCgY2vQF2KhCpytTFQ1BdmWsGrr9g6SzeUQ81vKgKQPbwjbRsV8zUEh0RnsDnOOk+BJ9
         c8R7hJa9pIlp/d0j3G8v9dBNaNgV5lFCvl0Wq4NfKWLBGKQmUSz7IrSjV2SzfhwUdmC1
         +8sw==
X-Gm-Message-State: AOAM530/Zx80khCDUaxVYLEoT/RemTaIn/c4OM7rv7KEUXK3n7Mj8fhu
        DUCDP2nmJQ5pu445Wme0oNl3tQ==
X-Google-Smtp-Source: ABdhPJwDaSSir3UT2pEhwoTp65Dewf6mydRg2nuo1G79WCsLyrVFiMO30RfEnz3uG/TcyNexFx9tJQ==
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr10476451wrs.67.1611746759013;
        Wed, 27 Jan 2021 03:25:59 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:25:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH 00/12] Rid W=1 warnings from Thunderbolt
Date:   Wed, 27 Jan 2021 11:25:42 +0000
Message-Id: <20210127112554.3770172-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Only 1 small set required for Thunderbolt.  Pretty good!

Lee Jones (12):
  thunderbolt: dma_port: Remove unused variable 'ret'
  thunderbolt: cap: Fix kernel-doc formatting issue
  thunderbolt: ctl: Demote non-conformant kernel-doc headers
  thunderbolt: eeprom: Demote non-conformant kernel-doc headers to
    standard comment blocks
  thunderbolt: pa: Demote non-conformant kernel-doc headers
  thunderbolt: xdomain: Fix 'tb_unregister_service_driver()'s 'drv'
    param
  thunderbolt: nhi: Demote some non-conformant kernel-doc headers
  thunderbolt: tb: Kernel-doc function headers should document their
    parameters
  thunderbolt: swit: Demote a bunch of non-conformant kernel-doc headers
  thunderbolt: icm: Fix a couple of formatting issues
  thunderbolt: tunnel: Fix misspelling of 'receive_path'
  thunderbolt: swit: Fix function name in the header

 drivers/thunderbolt/cap.c      |  2 +-
 drivers/thunderbolt/ctl.c      | 22 +++++++++++-----------
 drivers/thunderbolt/dma_port.c |  5 ++---
 drivers/thunderbolt/eeprom.c   | 24 ++++++++++++------------
 drivers/thunderbolt/icm.c      |  4 ++--
 drivers/thunderbolt/nhi.c      | 14 +++++++-------
 drivers/thunderbolt/path.c     |  4 ++--
 drivers/thunderbolt/switch.c   | 14 +++++++-------
 drivers/thunderbolt/tb.c       | 12 ++++++------
 drivers/thunderbolt/tunnel.c   |  2 +-
 drivers/thunderbolt/xdomain.c  |  2 +-
 11 files changed, 52 insertions(+), 53 deletions(-)

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
-- 
2.25.1

