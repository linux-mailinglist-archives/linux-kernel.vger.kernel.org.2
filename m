Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C78391847
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEZNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhEZNCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so457934wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXRlHuR8dYzOGyhflFNycbAwZlLKrSLWXp8cq2xYfO4=;
        b=kCHuvDlj3As+UwZJP6afIstbgMzi0xzIFtEepmnRJ+GGFfdbhkYac5rPNZdc220Gea
         yM3z0VYP6IHhIEahvl2JiUVykr9BMCEcBHG6T5jncC2XaYmNZDFfKNrPtlNiGgSZVPMP
         9AatYMDxfmQ3iYVq9lTpfhPvJ1wOEIOKpsU13BI97y+fDAJztS1dwyg3/k+TEbqtjlMd
         QPthKQ++QS2UiVkDXYdHL8mt7bSNaMnbyw/Om4f6yalsO1LCWpHREEqoyqqluKZdWNPM
         hea3XvfjU3UyWpnFbTwSUbkSMG3B8nVyOtr168DEiLGIB0qZBZy1Eeqajb4kyzg7VtMf
         ukNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXRlHuR8dYzOGyhflFNycbAwZlLKrSLWXp8cq2xYfO4=;
        b=oOoV6rQDyDcCyfrnZjLkLSxTMA4CpLgd3D8BiVwHv9a0JTi5AQSBpTYtAtSLDnCmSO
         /CLVOauHH8W55xRbTYjANWWvbH5JJft5/PheuDKf/kLELB3mkFoOcTEVCB/zSymP+qSu
         6xMrrBJfZX5r1rjshF88a5b+Y2YxL4M4lC2KViYT93DUd9840Uu2mG1nEVq8Wm8CHBjr
         bKdB74+jBV3JqJN2fSOT2JeQWSjt7RSuCeElnt0wYTCPTox1w6XqtgU0QJf0iCeIZ5P7
         sT1rqGoLE/Evnla/8hrcXGfTfNd3g6v/h3majGXIyjUxPUJ3nfYeARDEzcmLNb5PFRdu
         Dhsg==
X-Gm-Message-State: AOAM5321fhyBoEz028ZoI3V4KrwPdveqYBdn5Vnc8u7M7lwKM2spSeWI
        iXMl+TVy7ATZ0F8hllTGNGvbDQ==
X-Google-Smtp-Source: ABdhPJxOT1iBd8wDEPH/MKa6FH+mxFdaZgOpdrPl22LtW2DNWblWed9XP+ENfr6ZenEEiWw6sgwgzg==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr3143872wmg.17.1622034046102;
        Wed, 26 May 2021 06:00:46 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ben Dooks <ben@simtec.co.uk>, Daniel Mack <daniel@zonque.org>,
        David Lopo <dlopo@chipidea.mips.com>,
        Fabio Estevam <festevam@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthijs Kooijman <matthijs@stdin.nl>,
        Michal Simek <michal.simek@xilinx.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pawel Jez <pjez@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Roger Quadros <rogerq@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 00/24] Rid W=1 warnings from USB
Date:   Wed, 26 May 2021 14:00:13 +0100
Message-Id: <20210526130037.856068-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (24):
  usb: cdns3: core: Fix a couple of incorrectly documented function
    names
  usb: dwc2: platform: Provide function name for
    'dwc2_check_core_version()'
  usb: common: ulpi: Add leading underscores for function name
    '__ulpi_register_driver()'
  usb: cdns3: cdns3-plat: Fix incorrect naming of function
    'cdns3_plat_remove()'
  usb: dwc2: params: Fix naming of 'dwc2_get_hwparams()' in the docs
  usb: isp1760: isp1760-udc: Provide missing description for 'udc' param
  usb: cdns3: cdns3-gadget: Fix a bunch of kernel-doc related formatting
    issues
  usb: cdns3: cdns3-ti: File headers are not good candidates for
    kernel-doc
  usb: cdns3: cdns3-ep0: Fix a few kernel-doc formatting issues
  usb: cdns3: cdns3-imx: File headers are not good candidates for
    kernel-doc
  usb: dwc2: hcd_queue: Fix typeo in function name
    'dwc2_hs_pmap_unschedule()'
  usb: dwc2: pci: Fix possible copy/paste issue
  usb: chipidea: core: Fix incorrectly documented function
    'ci_usb_phy_exit()'
  usb: chipidea: otg: Fix formatting and missing documentation issues
  usb: dwc2: gadget: Repair 'dwc2_hsotg_core_init_disconnected()'s
    documentation
  usb: chipidea: udc: Fix incorrectly documented function
    'hw_port_is_high_speed()'
  usb: host: xhci: Remove unused variable 'len'
  usb: gadget: udc: pxa27x_udc: Fix documentation for
    'pxa27x_udc_start()'
  usb: gadget: udc: udc-xilinx: Place correct function names into the
    headers
  usb: cdns3: cdns3-gadget: Provide correct function naming for
    '__cdns3_gadget_ep_queue()'
  usb: host: xhci: Move array of structs from the stack onto the heap
  usb: host: xhci: Document xhci_get_endpoint_index()'s 'desc' param
  usb: cdns3: cdnsp-gadget: Provide function name for
    'cdnsp_find_next_ext_cap()'
  usb: typec: ucsi: Fix copy/paste issue for 'ucsi_set_drvdata()'

 drivers/usb/cdns3/cdns3-ep0.c       |  6 ++---
 drivers/usb/cdns3/cdns3-gadget.c    | 34 ++++++++++++++---------------
 drivers/usb/cdns3/cdns3-imx.c       |  2 +-
 drivers/usb/cdns3/cdns3-plat.c      |  2 +-
 drivers/usb/cdns3/cdns3-ti.c        |  2 +-
 drivers/usb/cdns3/cdnsp-gadget.c    |  3 ++-
 drivers/usb/cdns3/core.c            |  4 ++--
 drivers/usb/chipidea/core.c         |  2 +-
 drivers/usb/chipidea/otg.c          |  9 ++++----
 drivers/usb/chipidea/udc.c          |  2 +-
 drivers/usb/common/ulpi.c           |  2 +-
 drivers/usb/dwc2/gadget.c           |  2 +-
 drivers/usb/dwc2/hcd_queue.c        |  2 +-
 drivers/usb/dwc2/params.c           |  4 ++--
 drivers/usb/dwc2/pci.c              |  2 +-
 drivers/usb/dwc2/platform.c         |  2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c |  2 +-
 drivers/usb/gadget/udc/udc-xilinx.c |  4 ++--
 drivers/usb/host/xhci.c             | 19 +++++++++++-----
 drivers/usb/isp1760/isp1760-udc.c   |  1 +
 drivers/usb/typec/ucsi/ucsi.c       |  2 +-
 21 files changed, 59 insertions(+), 49 deletions(-)

Cc: Aswath Govindraju <a-govindraju@ti.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: Daniel Mack <daniel@zonque.org>
Cc: David Lopo <dlopo@chipidea.mips.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Matthijs Kooijman <matthijs@stdin.nl>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pawel Jez <pjez@cadence.com>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
-- 
2.31.1

