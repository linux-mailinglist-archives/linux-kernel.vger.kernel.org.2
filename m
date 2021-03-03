Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC432C0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836090AbhCCSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbhCCRoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:44:23 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA55C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:43:15 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h4so29609227ljl.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+dhB3YrJVlTSxFCA6Z/e42UCJspJWfH2abZXmJ1XC4M=;
        b=i7iOOBQrYR1nHjFHl9efeWLvpEwwqWdbDME3Hb1qx60ZFDs24dYf79cH5Dh7sQgXx3
         i2djTXa+lgkuwyUjYXCCfpehzZO5T5Hsc6n42jFgT2iZwXDO5DUaxBuE3LerIEPGnUIN
         rprCzy8t4HugYBS5SeJoK4TuGQS7mcciQh3spAy0rAv/rGOiQylsDqM0xhgT7iX4ScyN
         hbbFtDROXGZC9mLCWtPfEUEh/srEC+WnKIxms9E+udmlNtcl9uwdQENHAOYNogEpfZVu
         G9mgyRF1tn0XH1GG64WSYaZJz0woNEhbBmVokhLvmP8rJlUg69N3BTfthYXW97klvqub
         GBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+dhB3YrJVlTSxFCA6Z/e42UCJspJWfH2abZXmJ1XC4M=;
        b=irIBvJvFKCTQhTysgPH3haK8oMDC1U2whX2IwEOxBfb+4auv2/B2wpwykIcqkyIOkH
         J6kEe+AgLujpyat5Pj0rscred7pUA3hKsG7ECgxBZDKgd69ObesFm7YjSMNGOO/U0xCb
         k7o1iTEtaS7lMLndaeC0OKKeYpmoLGfBIcB8Wd2F4FheYi75eFh1w0/WGCevwhXSsuRY
         OciWbUX6dGurt3mfhp0OvHwyMYn9xnRtD6cOvK4ykrvpYJlZD+M5ldLXxQssEpY+b35i
         eiqoqK0DclFr30zFNOHd4Kma2A3oqHBX31e7Jpi012VTUqyQ6269S3rUMWOom4O6kfdb
         mGzA==
X-Gm-Message-State: AOAM531IINSqPMzu8xbBB+APkXW8d6lgXz5X40E5QfYjLyHODo+RMp5p
        tzbqk/V7aZsxYRtpG5R3d8jB0ibNqYPpBQ==
X-Google-Smtp-Source: ABdhPJzuDUOJRhDvWgdy8lAlBYZ0zeNkinZA/knIsk7X9BzWhHaJ1dZ8YYTA5DmS6Eg7a4h8cRYlcQ==
X-Received: by 2002:a2e:9047:: with SMTP id n7mr15373ljg.291.1614793393677;
        Wed, 03 Mar 2021 09:43:13 -0800 (PST)
Received: from localhost.localdomain ([85.249.43.69])
        by smtp.googlemail.com with ESMTPSA id s7sm2101441lfi.140.2021.03.03.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:43:12 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     junak.pub@gmail.com, robert.foss@linaro.org,
        sakari.ailus@linux.intel.com
Cc:     todor.too@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] media: qcom: camss: V4L2_CID_PIXEL_RATE/LINK_FREQ fixes
Date:   Wed,  3 Mar 2021 20:42:47 +0300
Message-Id: <20210303174250.11405-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds printing a warning in v4l2_get_link_freq() if
V4L2_CID_LINK_FREQ isn't implemented (this is a mandatory control for
CSI-2 transmitter drivers [1], but many sensor drivers don't have it
currently).

The second patch is the start of the work discussed in the "[RFC] Repurpose
V4L2_CID_PIXEL_RATE for the sampling rate in the pixel array" thread [2].
I'll send the similar patches for the rest of CSI receiver drivers which
use V4L2_CID_PIXEL_RATE to calculate the link frequency as a separate
patchset following this one: I don't have the hardware to test the changes
to these drivers, so the second patchset will be build tested only.

The third patch in this series is the patch by Vladimir Lypak [3] rebased
onto the changes done by the second patch. By replacing getting the pixel
clock with v4l2_get_link_freq() the second patch also fixes the integer
overflow which Vladimir's patch addresses. So the third patch only needs
to fix drivers/media/platform/qcom/camss/camss-vfe.c which the second patch
doesn't touch.

The resulting patchset is free from the "undefined reference to `__udivdi3'"
issue [4] as the u64 value is only divided by a power of 2, which doesn't
need do_div().

This patchset has been tested on db410c board with imx219 and ov5647
sensors (RPi camera modules v2 and v1) attached to AISTARVISION MIPI
Adapter V2.0.

[1] https://linuxtv.org/downloads/v4l-dvb-apis-new/driver-api/csi2.html
[2] https://www.spinics.net/lists/linux-media/msg183183.html
[3] https://www.spinics.net/lists/linux-media/msg186875.html
[4] https://www.spinics.net/lists/linux-media/msg186918.html

Changes in v2:

* Added [PATCH 1/3] v4l: common: v4l2_get_link_freq: add printing a warning

* camss_get_link_freq() changed to take the actual number of lanes as the
  third arg vs the number of lanes multiplied by 2 in the first version

* Fixed checkpatch warnings and bad indentation

Changes in v3:

* The warning message in v4l2_get_link_freq() improved as suggested by
  Jacopo Mondi


