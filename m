Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C034A24B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCZHCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCZHCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:02:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7CCC0613AA;
        Fri, 26 Mar 2021 00:02:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x126so4218227pfc.13;
        Fri, 26 Mar 2021 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fYmuhM1IRdVizXhzKiPSv+Ub0QxzG3Tko+5Eq9MvW/Y=;
        b=heyhvJU3/gnGrud3yBbvIMaXolUTjLPjrYkFKp6B+qMUBMZTyxLexr3TIysq05T7qY
         z2T9axaa32d04Osw8uFzvGzDUonOoqJ/bR4bav7eZkvokFQkf2tLBat8/6lI1HJOMVxe
         PZoCfl0RboIDWZunfsbHt/9J12HKfjdo8V6xBagYemS32K1S//zKRB/K6J41+DwGXOUq
         s77rumz5RicGCo9nqaW+WK5lnTsDJ5FIQtPXxyyl9m5VcWRdIArfJhTn7kjtkjpXTScQ
         IzUrsv/4AnLYvD/1zvEGmhBd0e/lqhm9SJIq0SoGQudeGNHemfPS77Smni59pQ6VTWzl
         rSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fYmuhM1IRdVizXhzKiPSv+Ub0QxzG3Tko+5Eq9MvW/Y=;
        b=Im0MAzfaExNvsEcYbvUG5ALvE0Ly5WAvIyjzd0+Ch7xMtWKTKWzEIONJNRbYKqQsX/
         rlJSjnFFR2WcZhx5lsFVN+ByZLtOHmfiFWmEOWX/r26/JDNkxnDkUTJd/5kDIp6L2WaE
         GFRKelGMCnBIRiv9E1CbbYmTzarVCEH9gkjrHeVcumca1iuAnwRMXxUI+RgVjmBJgYaG
         PND/7/VhKKtIpu2Yx8vdTXcaIHrHfiaJzl3KklZFeF9+zO0R22kh80IpKIK3du7d2mhA
         i+bpOdAw2cR6XXIhAbS2TCuNaNcxri8thcynfN8YO5emLnNmbtRSw47034JRoXe33GjV
         5VUg==
X-Gm-Message-State: AOAM533L85MbB+6UZwD5KJX+t6sHfeAP6mPbu3k9DyO7yzVRytzqECAZ
        HWOedW4122sdz8i9vSSLZd0=
X-Google-Smtp-Source: ABdhPJyn9RFt10iRoIkTqW8m0bKtd4afC3cJ85B/IDkwTe37xBUR7RWH1VR4Hm3SQMbY8NcPWjBVjw==
X-Received: by 2002:a63:545e:: with SMTP id e30mr11128704pgm.13.1616742144402;
        Fri, 26 Mar 2021 00:02:24 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id y193sm8105133pfc.72.2021.03.26.00.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 00:02:23 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tao Ren <taoren@fb.com>
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] usb: gadget: aspeed: set port_dev dma mask
Date:   Fri, 26 Mar 2021 00:02:14 -0700
Message-Id: <20210326070214.6719-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set aspeed-usb vhub port_dev's dma mask to pass the dma_mask test in
"dma_map_page_attrs" function, and the dma_mask test was added in
'commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer
dereference")'.

Below is the backtrace without the patch:
[<80106550>] show_stack+0x20/0x24
[<80106868>] dump_stack+0x28/0x30
[<80823540>] __warn+0xfc/0x110
[<8011ac30>] warn_slowpath_fmt+0xb0/0xc0
[<8011ad44>] dma_map_page_attrs+0x24c/0x314
[<8016a27c>] usb_gadget_map_request_by_dev+0x100/0x1e4
[<805cedd8>] usb_gadget_map_request+0x1c/0x20
[<805cefbc>] ast_vhub_epn_queue+0xa0/0x1d8
[<7f02f710>] usb_ep_queue+0x48/0xc4
[<805cd3e8>] ecm_do_notify+0xf8/0x248
[<7f145920>] ecm_set_alt+0xc8/0x1d0
[<7f145c34>] composite_setup+0x680/0x1d30
[<7f00deb8>] ast_vhub_ep0_handle_setup+0xa4/0x1bc
[<7f02ee94>] ast_vhub_dev_irq+0x58/0x84
[<7f0309e0>] ast_vhub_irq+0xb0/0x1c8
[<7f02e118>] __handle_irq_event_percpu+0x50/0x19c
[<8015e5bc>] handle_irq_event_percpu+0x38/0x8c
[<8015e758>] handle_irq_event+0x38/0x4c

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d268306a7bfe..9eb3904a6ff9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -569,6 +569,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	device_initialize(d->port_dev);
 	d->port_dev->release = ast_vhub_dev_release;
 	d->port_dev->parent = parent;
+	d->port_dev->dma_mask = parent->dma_mask;
 	dev_set_name(d->port_dev, "%s:p%d", dev_name(parent), idx + 1);
 	rc = device_add(d->port_dev);
 	if (rc)
-- 
2.17.1

