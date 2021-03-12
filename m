Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01CC338C30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhCLMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhCLMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:00:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A226C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o16so1627853wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctihznIBI6HYfRPQEJtJ2A5ihzsBfql6joqN4iVPcyc=;
        b=x3mD0xtGnMFOkAF25Ulh5v0L1V90mJLI9ed3zAM+VCt1lAi0MgnJ4P7H2JI8RrPEeu
         Z5PZQejpR5GtChXdWBfZ+bVqQzz5SDmejiDsEUOykdkt15U3XEzsGCkvwlVSFv+loDCw
         UQ7nC/MvgMtHp8u+2u1HM8jl2HbMGg6NH8kHCPcIDSTbJfozQ5LNeuXbW6KJubR2Yuug
         Ww45YA9QHTJdyge+9/r5xxwsrbCmYUoVCM5wGww/gNdkIk2KOrxlCb/11TdzyhACM5Kc
         pIoyyXCa/Fiwb7uCpyY9EIj50WSCdMxaSoAH75nUYwf6yhFP5MP7OprL5rugbTmrXRt1
         DAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctihznIBI6HYfRPQEJtJ2A5ihzsBfql6joqN4iVPcyc=;
        b=PO9O8QTmo+REcLJaEJZxglQPuk9YQ7t23jy7ODTv1/ef8jiJqqpCL9VIi0ib3YTqOB
         d5tkNptQzZT+tgI6HmxpFEMAJozisNO70XKPvS9AsKZftJ+Xip1lVI7p+lklPyS+OYD6
         HRbGekKke4IwNfS+DPiAqz4kVydHIEjKhF2keCHncvFnjRzNppZ1ikroqlWk8WSkZSbd
         tpvVtH8rexnkwloRh30zQ0b4MnJ+5EAVdEvUEvYsyowrT4sy79QRGTmxFH1j2XiHTigu
         NpH/N9wpY+HFatXSS+5EhXOzPikQ0CrdoVZTDfzdA/1ZlqA9v3MplGZTn2JSGtrrQrd0
         8Kag==
X-Gm-Message-State: AOAM532FKWkdSikBVXZb3TZdWd8F8/3paCk9otsgrXlEFbnvW6qll0er
        ZOE8qGy3dLsRvr9KqpBCJhSQVA==
X-Google-Smtp-Source: ABdhPJxyYk9ByGQyGPGOMzcFO7nnAiyV4NbYnLDByxC+Q47ow7ealzYGfhYUapAwr9K25/J3bJW+ww==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr13563213wrr.297.1615550423154;
        Fri, 12 Mar 2021 04:00:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:00:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/9] soundwire: qcom: various improvements
Date:   Fri, 12 Mar 2021 12:00:00 +0000
Message-Id: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v3 of this patchset!

During testing SoundWire controller on SM8250 MTP, we found
few issues like all the interrupts are not handled,
all transport parameters are not read from device tree.
Patch to add Auto Enumeration supported by the controller
is also part of this series.

Other major issue was register read/writes which was interrupt based
was an overhead and puts lot of limitation on context it can be used from.

With previous approach number of interrupts generated
after enumeration are around 130:
$ cat /proc/interrupts  | grep soundwire
21: 130 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
    
after this patch they are just 3 interrupts
$ cat /proc/interrupts  | grep soundwire
21: 3 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire

So this patchset add various improvements to the existing driver
to address above issues.

Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
Also tested on DragonBoard DB845c with 2xWSA881x speakers.

Changes since v3:
	- Fixed setting assigned bit during autoenumeration

Srinivas Kandagatla (9):
  dt-bindings: soundwire: qcom: clarify data port bus parameters
  soundwire: qcom: add support to missing transport params
  soundwire: qcom: set continue execution flag for ignored commands
  soundwire: qcom: start the clock during initialization
  soundwire: qcom: update register read/write routine
  soundwire: qcom: add support to new interrupts
  soundwire: export sdw_compare_devid() and sdw_extract_slave_id()
  soundwire: qcom: add auto enumeration support
  soundwire: qcom: wait for enumeration to be complete in probe

 .../bindings/soundwire/qcom,sdw.txt           |  20 +
 drivers/soundwire/bus.c                       |   4 +-
 drivers/soundwire/qcom.c                      | 529 ++++++++++++++----
 include/linux/soundwire/sdw.h                 |   2 +
 4 files changed, 442 insertions(+), 113 deletions(-)

-- 
2.21.0

