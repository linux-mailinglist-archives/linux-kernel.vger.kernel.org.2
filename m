Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD44308BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhA2RjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhA2Rdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF953C061788
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id s24so7453478wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aez8PVObRInISJ18DKfgcQIQqvuy67+Y7a5HFxY8OU8=;
        b=q31UQwg+6sm7u+A6JNafUr/fYxe0Gf76aDsTPUG312pq+ILyrsJ+6A1dmC8ce4giMo
         Va5+A5WUZEA4AR1hRSGUkngBHBFzs+e4GkCi0VJKzSXKf7eK/ZT6kcS3AxrbsUY+DYcZ
         WI2hJ3WV6FZ8iHk2jCgEoK1Z4o8b2w7gUcbAMTM9udjcsEi4WEueNEmfgwMHmqhkO0bn
         XzaLnqfPKQtN5ED9PUAfFkPZIn1URMjNPn3iBuOW2YvmMnfrfnWWzwGgeskjItfgSguD
         Sf0Ylue9pfE3sCBqlH6qtj0qybVg8X/cp66iFSuoIcAGEcARWLgrC8+Rl9wN1EvNg9RC
         WrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aez8PVObRInISJ18DKfgcQIQqvuy67+Y7a5HFxY8OU8=;
        b=q0axUTivVbVrtj04V2Zn0jjixDNnSdryGjGukEDoCIOUYN7Kgyn5Chu8H4hweq+BRc
         gz2122bHpPWiJqLyZfcEnQvdsN6cmA3P/hSqFmf7CIlZsqYvueV42VcTKaRR+PFxMfuE
         5CaduP0hBt2J+sgOA7Lfcaxh2+/+dRYe4YoKs2GQeRdg+cvXaaWaUZ/ar4lMLOFjwhIb
         IqbLKMCIEeOjyIHwvbUOudMkdNtZcj/SW36s5CYxQHHFbG13rH6BoZ2gNN83ykJ85PVQ
         dbbH//N9HMu2z8Fbjtesi+KWo/mJSbMKZexsdGymiJ7H6qv4e9gbDUANRT55MP8KkpN7
         8kKQ==
X-Gm-Message-State: AOAM532TdYsojaJIjrxYMfLcceZLzUceWq6nrS1Ot4tGC9jAr3bqKcZ+
        75b8k9WZ2C1ztepkrGNBpstBGA==
X-Google-Smtp-Source: ABdhPJwvt027/229+3L3Oa99agF/XUe7Ir5dIww1gH0PGuykMQJVIuF4H4uqchf2EyNEh76OgYUC/g==
X-Received: by 2002:a1c:5456:: with SMTP id p22mr4835322wmi.81.1611941573612;
        Fri, 29 Jan 2021 09:32:53 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:32:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] soundwire: qcom: various improvements
Date:   Fri, 29 Jan 2021 17:32:42 +0000
Message-Id: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing SoundWire controller on SM8250 MTP, we found
few issues like all the interrupts are not handled,
all transport parameters are not read from device tree.

Other major issue was register read/writes which was interrupt based
was an overhead and puts lot of limitation on context it can be used from.

So this patchset add various improvements to the existing driver
to address above issues.

Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
Also tested on DragonBoard DB845c with 2xWSA881x speakers.

Srinivas Kandagatla (6):
  soundwire: qcom: add support to missing transport params
  soundwire: qcom: extract version field
  soundwire: qcom: set continue execution flag for ignored commands
  soundwire: qcom: start the clock during initialization
  soundwire: qcom: update register read/write routine
  soundwire: qcom: add support to new interrupts

 drivers/soundwire/qcom.c | 471 ++++++++++++++++++++++++++++++---------
 1 file changed, 366 insertions(+), 105 deletions(-)

-- 
2.21.0

