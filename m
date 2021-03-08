Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F534330FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCHNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCHNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D18BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l11so8131292wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVXHwUF+4rYBeBM31g9Ze9WS5jjuoW2pQ3+wwBFnbQ8=;
        b=j1K3nNwa+4WIPoGWufWnEnRekEev6H7YsrlEreFNpjZ44W5vztutlseoj0Rh8qtwLx
         xXYpjiJ5pC+YbMJMGkdr+53Wt/tOmyGaPeTEdSTojCl2wY0zGZDKuJ0R63Q73ScwsJOX
         SWUjnGWtNJKsHdJiTz/KRllr2QOrIhf2peHpSuuk7qTH5fJHkPe+5xY/MOHkE8alpLip
         tMgdWJvRendDXSUPbkdIbynPCrBybWJ/Ogz6ZyMKjyMJN2XVWdcekP45QRq6z5muC8p6
         1vsaiNsntPkzLKPzorJJQtJKLDVhoQp/+1iuqpsxtsbvaaJVCn8mgg/0YgTthrWg5S/N
         zBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVXHwUF+4rYBeBM31g9Ze9WS5jjuoW2pQ3+wwBFnbQ8=;
        b=PbU6mveNrjIxM9qBl9zKkz/idCt85Bx5KAdE58d4VD8gkWwRJKT2GpygvPDVNCFsTp
         +/ewYFKLH80cLToJSc0SwdMjuUdUnVKOlPVIwg9ABbPp9R9QnfJX+K6cGomp+bhmCOMJ
         h+sHX87aXyJbHN74nKUwq+nuavuqiGQY5BDuZtwkcp5niaNWk4dovPCW7iHgP/rrEuwS
         1LuGO7m0ccaE/+ZL5CgLw8wQ1psUqVibV4WaojW2hvkbH/r87JzN/IkpUHQ7NQ8j6Hjd
         4d3X6HHJGmaSFAU6vm6md2oJnPlIwv469vWQ5jAnrpHU3VknVSCtylKYVdH+vqz7UVU0
         mT2Q==
X-Gm-Message-State: AOAM532NUWDX8Xk225X6dADOUovLgnbthDfUcyAOKeSMTjzTTh2mI95f
        iheTOHcNomrjgGxjcb8xjl2Vcg==
X-Google-Smtp-Source: ABdhPJzdSNArPf3ln4rbZc4YMouzE2dpM3VtjP/88PDzZ3b6z3kjkERby8dqVQUqfnWPkTRy9aYqxg==
X-Received: by 2002:a05:6000:1545:: with SMTP id 5mr23082513wry.90.1615211406168;
        Mon, 08 Mar 2021 05:50:06 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h22sm19490589wmb.36.2021.03.08.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/9] soundwire: qcom: various improvements
Date:   Mon,  8 Mar 2021 13:49:48 +0000
Message-Id: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v2 of this patchset!

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

Changes since v1:
	- added auto enumeration patches to this patchset
	- added comments to qcom bindings to clarify invalid values
	- cleanup trasport parameters to use internal port config

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
 4 files changed, 441 insertions(+), 114 deletions(-)

-- 
2.21.0

