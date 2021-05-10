Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16DD378E38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhEJNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351116AbhEJNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:02:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4569C06134D
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:55:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n84so9161147wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLAkJk2XYN3zpNZJSBihL1QIdDzW0qzyrz5YHmbRkas=;
        b=IyhxI8zBkWsO3F1VgIXC301oSbWCidyan9jWmrAHh5gVQ9JuDRRMiYpGXUsgI1DYqk
         C7JG9Lpc9uf9SZN5f+nHNumtkQ343zpgRt3k3fsJ7Hii+D9m/0JOYsJQRNXr+Cf/qU33
         XLKoOgjwaxmybPsAaXk+GU70hCGQWRC29+XDNRnVMnHxL1EzLNL7kJrHAV7jPQlUUPhr
         qpyVSgia22Z4keGQ06wpvMmDLbBgE/LZEe48FyrvT+KaNKJX0FkeJpmuRg0PUZtHSIgP
         lCnUqI7TNjGLTTYKp18jU5Z6U8vbPBQVK6RdiFjOClyTK6jgY5xphSfzJn7kDpWDZm5G
         m80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLAkJk2XYN3zpNZJSBihL1QIdDzW0qzyrz5YHmbRkas=;
        b=JSp9L8buKSx/0ylunKWoVVHOwUR7kxzgt5uuPA+sPIGBQaUHZyMKY6VgI3JnfhJyqZ
         UTyITPCr0s/0OvlETD1/wOgQ9gb/AugG8C+xQnirLJ60jqc59HhOQPS+Nf+VBzVTlqGh
         DS9p2Rm548zBhvI62afr/mwzKoxGvZ+/tijYYIs67NHdK143gZQyn9wvCKFaTC9E6HaR
         NTlhzSA/fmG3l7SkvaepNG8nJM1CYjPVfvGUIzIJApln6YAhXJtT4fTNTPKVrmqS8z6f
         YjDfOYR7BHqGyjIdm05RvFc1mlaQGR49xIhi2TJpHbdHCH7BK4Q6DbFrqK6NM6D/X7wH
         te4g==
X-Gm-Message-State: AOAM531fcuglAnV3DXYPX3oHoReOx4n+ZXgx82zCjuyz7iElrovE/mDc
        1OQWK78g4x+wZgv/BB2tpEwJoQ==
X-Google-Smtp-Source: ABdhPJyZZuBSFJRPGg1reGsrnx5QvrgC1PJt4m9buGdkVfyVVKlcuOiawyOCrVJJyY+pRrWLsMVxFQ==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr25571375wmc.112.1620651349267;
        Mon, 10 May 2021 05:55:49 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:48 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 00/11] ad_sigma_delta: convert all drivers to device-managed
Date:   Mon, 10 May 2021 15:55:12 +0300
Message-Id: <20210510125523.1271237-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, for lack of a better title that's what this series does.
It merges Jonathan's patches from:
  * https://lore.kernel.org/linux-iio/20210508182319.488551-1-jic23@kernel.org/
    Patch 3/3 was a polished a bit with my comments from that review and also
    to use the devm_ad_sd_setup_buffer_and_trigger() function.
  * https://lore.kernel.org/linux-iio/20210509114118.660422-1-jic23@kernel.org/
    Added only to base the conversion to devm_

The AD Sigma Delta family of ADC drivers share a lot of the logic in the
ad_sigma_delta lib-driver.

This set introduces a devm_ad_sd_setup_buffer_and_trigger() call, which
aims to replace the 'ad_sd_{setup,cleanup}_buffer_and_trigger()' pair.

This helps with converting the AD7780, AD7791, AD7793 and AD7192
drivers use be fully converted to device-managed functions.

Alexandru Ardelean (7):
  iio: adc: ad_sigma_delta: introduct
    devm_ad_sd_setup_buffer_and_trigger()
  iio: adc: ad7793: convert to device-managed functions
  iio: adc: ad7791: convert to device-managed functions
  iio: adc: ad7780: convert to device-managed functions
  iio: adc: ad7192: use devm_clk_get_optional() for mclk
  iio: adc: ad7192: convert to device-managed functions
  iio: adc: ad_sigma_delta: remove
    ad_sd_{setup,cleanup}_buffer_and_trigger()

Jonathan Cameron (4):
  iio: adc: ad7192: Avoid disabling a clock that was never enabled.
  iio: adc: ad7124: Fix missbalanced regulator enable / disable on
    error.
  iio: adc: ad7124: Fix potential overflow due to non sequential channel
    numbers
  iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
    remove()

 drivers/iio/adc/ad7124.c               | 84 ++++++++++--------------
 drivers/iio/adc/ad7192.c               | 90 +++++++++++---------------
 drivers/iio/adc/ad7780.c               | 38 +++--------
 drivers/iio/adc/ad7791.c               | 44 ++++---------
 drivers/iio/adc/ad7793.c               | 53 +++++----------
 drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++---------------
 include/linux/iio/adc/ad_sigma_delta.h |  4 +-
 7 files changed, 141 insertions(+), 254 deletions(-)

-- 
2.31.1

