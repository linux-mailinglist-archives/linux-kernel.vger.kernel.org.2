Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6978741EBC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353764AbhJAL1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353601AbhJAL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:27:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55345C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:25:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v25so4328687wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTtmLfOCpdg82rj8w493AIJsfz7Tq3NPSgiPIVGMf6E=;
        b=NCTTS38igTJB41//wXYbmIuXM+fveqgmEn8LmfvwamXlen7LVOZrQSVECdcO59BJ2t
         HOrX+LnojyL7b094Pw5K9+W1CU47y4e28ug3ROJOLXCsUxnrm+MypGsjS5G2nUt831p4
         QFESnkZFcZqKkCieAFaqwlm534QRFqWBJG1As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTtmLfOCpdg82rj8w493AIJsfz7Tq3NPSgiPIVGMf6E=;
        b=FxmF+PO2E30soOXUNxs4aapZTHecPK2/mrpqYj1CF84t4HMz4ySs0SdbhnqiBo+rRr
         lHULSzHf8mT3NVbMxGyQsGqqISG6zbenABMRzidcYDzO7zNGFLadpI+Ug2joRl8IhlPs
         wG24HvqPrODusN3FNXfwLpxH2VfUzQqg6mgr6qDmxVBjYhYI5ToxkGSyDue5x8Q/nL77
         LEb85Oo6HMIjb3NsCRbw3lKhc0Sc5I4RNJ/E9rfvIqrZYkMRFjpXWbWRtRO/7GaRP1tv
         z51CVXFEthR4ROZcWeZuwtOf0caJ/sqZJSSckGNSFOQhWWvtl+JZSPm2OEcMAcx3kmFW
         D2Mg==
X-Gm-Message-State: AOAM5315lzU4XN5RVH6VokTVtGd5cHYGCyJrdUuyq6jk6Z923dh+Nm0X
        vySZrg3RNjf/Dh80pDA3FwX05Q==
X-Google-Smtp-Source: ABdhPJyh2znq94x4U+ELpfWxo82SA4SOXRaXcXprbccbHxcYcek2ugFP7fZlSo+kebJUfWlhJYDFCQ==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr7356858wrc.402.1633087524945;
        Fri, 01 Oct 2021 04:25:24 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id x17sm5530958wrc.51.2021.10.01.04.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:25:24 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/8] media: ipu3 + i2c: Fix v4l2-compliance issues
Date:   Fri,  1 Oct 2021 11:25:14 +0000
Message-Id: <20211001112522.2839602-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some issues found with v4l2-compliance. Tested in Soraka which also
has some subdevices that had some issues with v4l2-compliance.

v1->v3: Changelog

- Rename cio2 to imgu
- Refactor bytesperline calculation

Ricardo Ribalda (8):
  media: ipu3-cio2 Check num_planes and sizes in queue_setup
  media: ipu3-imgu: Refactor bytesperpixel calculation
  media: ipu3-imgu: Set valid initial format
  media: ipu3-imgu: imgu_fmt: Handle properly try
  media: ipu3-imgu: VIDIOC_QUERYCAP: Fix bus_info
  media: dw9714: Add implementation for events
  media: ov13858: Add implementation for events
  media: ov5670: Add implementation for events

 drivers/media/i2c/dw9714.c                    | 14 ++++++++++++--
 drivers/media/i2c/ov13858.c                   | 11 ++++++++++-
 drivers/media/i2c/ov5670.c                    | 11 ++++++++++-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c |  8 ++++++--
 drivers/staging/media/ipu3/ipu3-css.c         | 19 +++----------------
 drivers/staging/media/ipu3/ipu3-css.h         |  1 -
 drivers/staging/media/ipu3/ipu3-v4l2.c        | 11 +++++++----
 drivers/staging/media/ipu3/ipu3.h             | 12 ++++++++++++
 8 files changed, 60 insertions(+), 27 deletions(-)

-- 
2.33.0.800.g4c38ced690-goog

