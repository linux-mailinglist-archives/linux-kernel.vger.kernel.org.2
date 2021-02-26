Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09A1326609
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBZRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:04:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E83CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:04:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k66so8431237wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRZDtCEEl5QmOqRGg5rQkT6Rg7IhztzVKYboB6BmINE=;
        b=VpXjEBe+fdimsjtrUM0doB6FVRuUq/Q6gobJOuBjGIyg+Kn8c+vAsaVPwa4lJ/n7Gb
         WUEgMvi43OuXQ3xvZlBLxaKTEl39rkRLdC9UYqHuT2rJXZUIota8LUQG/Gw27Wbz9GCU
         A6QcKShuQZUoRTC4BOBhqr3mf51P91KXjKWpG9S7XfJUYQzLBBGqI+hBm68DGI5azX6p
         ElCj9d8+L7ONsM9E351yhwiBLxV2odKIikY7KH7INotYDGjO3KpXCTvzBzdY7MCfK82w
         KPCMYjtA8ZBVjVuCGpiNdU+LKvxZTTAoTQPamGFiwSk/6gcWcCGCjf3q8XUfvRJacXwq
         fUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRZDtCEEl5QmOqRGg5rQkT6Rg7IhztzVKYboB6BmINE=;
        b=qwuDmcIn5wilyXGks1nL1Df28Gn2f2GhMPBdO85FYhVaJhPSRDuFsUPddZPpxfjavK
         AzxmqmDikS6HSlT/zrqpNKom+a/3xKlOfkjuiH1ID6ChOiVK/21OiZf/GJU+/dxxzyoB
         4u3QvtmkLhxoWpPG/Ml44qD48069kjVKBASCiVzQ9ZWdwcsNDOp39QRG4vdr+nC5o5Ty
         1aG4i8o/Lj38rci1i3aJcvikOZv2eK4zmFMwLaMh94E989eRFpLNOphg3xGjsMIObC7h
         TQotTojhCMO/e50ACBLvzLR/ocCvlo6VpYglIGCHcAzqGyFatcYvdc0f7iFrr7+V+UXn
         pR8w==
X-Gm-Message-State: AOAM533ISwNj+lwFW5GC4aYlGglv9GhBudrQEmCaq/imxQnJt7neMVS2
        oGu2BOzJq3PsBkDmx1MuVUtV+g==
X-Google-Smtp-Source: ABdhPJwf+JAykD/Kci0p96UuSQmVwaV173yV3TX4IWs/BM/sf1T4n3mVbjAjb6wiNrPAjx5wcYF/vA==
X-Received: by 2002:a7b:c18b:: with SMTP id y11mr3771975wmi.132.1614359048281;
        Fri, 26 Feb 2021 09:04:08 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w13sm15962972wre.2.2021.02.26.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:04:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] soundwire: qcom: add Clock Stop and Auto Enumeration support
Date:   Fri, 26 Feb 2021 17:02:47 +0000
Message-Id: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Soundwire controller have IP built-in feature to enumerate
SoundWire slave devices aka Auto Enumeration.
This patchset adds support to this feature along with Clock stop
feature using runtime PM.

Tested it on DB845c, RB5 and SM8250-MTP.

thanks,
srini

Srinivas Kandagatla (3):
  soundwire: export sdw_compare_devid() and sdw_extract_slave_id()
  soundwire: qcom: add auto enumeration support
  soundwire: qcom: add clock stop via runtime pm support

 drivers/soundwire/bus.c       |   4 +-
 drivers/soundwire/qcom.c      | 187 +++++++++++++++++++++++++++++++---
 include/linux/soundwire/sdw.h |   2 +
 3 files changed, 179 insertions(+), 14 deletions(-)

-- 
2.21.0

