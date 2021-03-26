Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE734A1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCZGl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhCZGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B394C0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u5so6766934ejn.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=601vu5quzaQf6DnHp3OpM53cCBOhcUim1UL6VJ/oy0U=;
        b=cT5DeJ+blY6t22wiG1Y2kVtLodJ9uXZElUCLgfFosUxxWW1blbg42q55+V/XI+9iDG
         eSjqS+5sb2CyQx6VMpvU6ZtubD4icr2xzo2Aqbice9XnxxFxHRsdqpbvB/7joKFXdOFn
         GbISma2EmFJF4V20w36YmFsDCll424vNjNBfZCAj7RGubZT9H4sAMFwX9zfqgy/A5FkT
         ibbtew5DF8dfc/XLm1zcnSvCFYq/3ashV/B69dCdO8gHJHw6SKFu1c49I/K7Et8gJmwZ
         HXklQvv8NvPIttHmY4AnRvnzGY9BKRoFg1/VRmGJYXjUSHuuVQnsm+QFspVXU/wOHzBL
         NjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=601vu5quzaQf6DnHp3OpM53cCBOhcUim1UL6VJ/oy0U=;
        b=skicksYr6TpYa4G1h63kRljHTaF4EVshHUvDWgOqz8K94bIs3nPeixw0iPJP1eLSMN
         rgb1zqVmloSZz6AWr3JmgcKvHdDaBolganxXAxwoUtaqkeHqRx5TRNfFuTYPw9Mdp1/Z
         KbdUhuqHoGi/SNb8xLiPzi6r4/EYRD18y0baUWVRqaWFh8jSw4EqNPsCaLwyRkgCsCF4
         tmQWNqfKEe9V4MulHutvTeI3+lPtUpM/y8EKwt07UyanESKRgcXgEokC7ZR5h9zda389
         JI3Z6mwwr7alow/A+wU7k5Ov8Q18vISgn2w7BMOMiMlNnDsJ/+aa56VR66W5mjLDjsRy
         tZvQ==
X-Gm-Message-State: AOAM530CnDuyrMEaPyTP4hz2Dez2OheL5+AJ8wP7hAFAiMEh1QM+o7fE
        nL9IL3i3tNGg8ESS9Ra2q9FWLA==
X-Google-Smtp-Source: ABdhPJw1JGdbPPuEEkOWdp72gOM1ahgIOoxvaklK9HwXG7IGdQ60CqpEKz5TGF11UDeZxqwBrNvBhg==
X-Received: by 2002:a17:906:3f88:: with SMTP id b8mr13913431ejj.36.1616740876082;
        Thu, 25 Mar 2021 23:41:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:41:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/9] soundwire: qcom: various improvements
Date:   Fri, 26 Mar 2021 06:39:35 +0000
Message-Id: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v4 of this patchset!

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

Changes since v4:
	- exported sdw_slave_add as kernel test robot reported error

Srinivas Kandagatla (9):
  dt-bindings: soundwire: qcom: clarify data port bus parameters
  soundwire: qcom: add support to missing transport params
  soundwire: qcom: set continue execution flag for ignored commands
  soundwire: qcom: start the clock during initialization
  soundwire: qcom: update register read/write routine
  soundwire: qcom: add support to new interrupts
  soundwire: export sdw_compare_devid, sdw_extract_slave_id and
    sdw_slave_add
  soundwire: qcom: add auto enumeration support
  soundwire: qcom: wait for enumeration to be complete in probe

 .../bindings/soundwire/qcom,sdw.txt           |  20 +
 drivers/soundwire/bus.c                       |   4 +-
 drivers/soundwire/qcom.c                      | 529 ++++++++++++++----
 drivers/soundwire/slave.c                     |   1 +
 include/linux/soundwire/sdw.h                 |   2 +
 5 files changed, 443 insertions(+), 113 deletions(-)

-- 
2.21.0

