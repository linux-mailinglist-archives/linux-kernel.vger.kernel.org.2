Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D44326518
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBZP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:59:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id w7so7806667wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLHTrfU3Zjihwx+6y3jZfrFCLGJ2eIivD/gyehbOpZA=;
        b=MHW2Pxfp0si6xuUqNuFIYgsocoIxmBuED6jXe9wqgnbCMS4vl6LPL444w4drS1y4b2
         IHfS4N3HT8EQepj+BpXwbYQ6O9a4TKWX81fK1eorQaDQlHwG5bAQYf3oRQphgWFeSFPv
         MNgvr5tZIFaZQ+oqaJTjEKPH1gQen1ma24KciGPel/TVYiUt2VklCYVxqlefJeQEt77a
         k45azYun1XN6UtBOSNUmaQn854vaBcVLelQ3XLCCg8BlRBPnqKYqc2OrU7ki4Pyi8307
         TlO1iA6sQXC/Dc6HvVOP/9Sg7IhCjksJ8yu6Lyi35hL5J2u1GbMazwyvYNQNFTZdQ7VY
         5A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLHTrfU3Zjihwx+6y3jZfrFCLGJ2eIivD/gyehbOpZA=;
        b=DhBj8UEytcISQzFWdrPFU/ENjoz/lTAEbBW8+rRuKeOTEmZlJ09u0x2MwRkKQwt8tI
         Al/g94nEQ68uuZEr/vlAlde1PA6hzhRoLQ+KWiva0q7ERjIlXkhDOyoDp5XCm2PmNE7E
         nIoXBq8tvVKhcoPgQEZf4ZTdoFRnvuqp6wFSr13TexKaAjwxnyxYY8pHQb4TwMLa8+QY
         JO9bBOd0r/l3ipSaMMm57kbSGMpuMeN6c4Alza9kGEZWons6mOcvgzve3P9ZXPs7kTXG
         sF8UxYB+zM9iC5uqUqhX0O97EhmiN0OdGP/8rGEuL5FhbE8eGKQ1gFM1YdHN8d2qMvsC
         pstQ==
X-Gm-Message-State: AOAM532W34KrvjBM0FntNr6DgfwFBxf1QZu0t/vMTz2xbxuhkQVqsYXO
        ekZOgTKsiMJ7UkkXa0/7/D3+Og==
X-Google-Smtp-Source: ABdhPJyIXlVF1XjGI6Rsho51LPb7veXYIn+o7cujO/Kp+tEpdXVoUByo3icsSsniwIsWRt2Ha4GEow==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr3538411wmf.165.1614355106619;
        Fri, 26 Feb 2021 07:58:26 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v6sm14398945wrx.32.2021.02.26.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:58:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] soundwire: qcom: various improvements
Date:   Fri, 26 Feb 2021 15:58:09 +0000
Message-Id: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing v1 of this patchset!

During testing SoundWire controller on SM8250 MTP, we found
few issues like all the interrupts are not handled,
all transport parameters are not read from device tree.

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
	- changed bgp_count to blk_group_count as suggested by Pierre
	- used version raw value as suggested by VKoul
	- updated read fifo logic and interrupt handling to do while()
	- renamed some of the variable to make reading easy!
	- removed patch that parses version

Srinivas Kandagatla (5):
  soundwire: qcom: add support to missing transport params
  soundwire: qcom: set continue execution flag for ignored commands
  soundwire: qcom: start the clock during initialization
  soundwire: qcom: update register read/write routine
  soundwire: qcom: add support to new interrupts

 drivers/soundwire/qcom.c | 438 ++++++++++++++++++++++++++++++---------
 1 file changed, 335 insertions(+), 103 deletions(-)

-- 
2.21.0

