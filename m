Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0EC322FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhBWRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhBWRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:45:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEDDC061574;
        Tue, 23 Feb 2021 09:44:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so23467264wrz.0;
        Tue, 23 Feb 2021 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xePih+lj3aAhAkKt7KsLGqHiApDG139qal6vPJJIaeo=;
        b=Pe18qgDHUD2UoFJX9nNaVqX5yD5DWnha3vqLxSJJcgvQIOi1fsxJVEBmzw9DgH6mG6
         UNj2c72fSe84Ubfcp/dIhzwi4Us07Dv+HcPTN12uWk/dlMBaJ9u1F9srXwB3A4Xa2Vmz
         gKhebDMcCxIWhjd7eu6Flep6gIJcWUBE3I0gEBvuzybCRwLMPZYAWiHHsRgfrT+0fFpX
         o1rfjzyoYZiIQl+cBWiyVJedtjNRneRAwbiX7olAFbJeObnlE7NAbIKkSFiSUDJojS9R
         R2/BQqF79Dw0ZVx+S6mrrELA7DFq9rFeq225K0b2AZo0QUrR/IAYp6hPSQ4DpditV0mk
         rV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xePih+lj3aAhAkKt7KsLGqHiApDG139qal6vPJJIaeo=;
        b=l1X8XDQw5ZVcTxDa//SBQBpjiCPpDBBT6WlMHVKla8Xrhdn6U5H1GN6gPaXaJfRxtM
         5KEYooYNGx9279AupJtZU0sw5kwpw5SI2mLGqdPMWHkkFr8rS4rK0OJ7pp4ZQ0AwP7pR
         E6MIS5e5ztTAW+jTQ2xIZZRQRtUmLpklFV1iRky/UJ9CFZ1k91Q3x7oywg2kdJO8ZSOk
         cgqqNZwSpI1OMena1z9HnrpfvZQ3Lm4YbSz2MbokkwyWtTCjfP1r7RoOH+UVNAfiDWgM
         I2zB/s4V+pmZ+1rpW2uVpCxD9qEyNzS06VMww5zLi5b8Ir7cSm7Jl0mmH5B+Ayg/o0Ub
         LBOg==
X-Gm-Message-State: AOAM533AE5IiLABsemBoySRA7N/ymTyCVtzkIkEA7WD49139ygH2uCWj
        1aWDUhIwSDaLXH8ZTI4sIRQ=
X-Google-Smtp-Source: ABdhPJwn3hIJdJrMXlzLkgSRgFjj5dwMAsVwRnbMvl5ACPmuA8efv7I/TpRBNDZoRChI4aMciXNxUw==
X-Received: by 2002:a05:6000:107:: with SMTP id o7mr27272371wrx.87.1614102298359;
        Tue, 23 Feb 2021 09:44:58 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u7sm32408428wrt.67.2021.02.23.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:44:57 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 0/3] usb: host: ehci-platform: add spurious-oc support
Date:   Tue, 23 Feb 2021 18:44:52 +0100
Message-Id: <20210223174455.1378-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223155005.21712-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over-current reporting isn't supported on some platforms such as bcm63xx.
These devices will incorrectly report over-current if this flag isn't properly
activated.

v3: add missing patch from Florian Fainelli.
v2: change flag name and improve documentation as suggested by Alan Stern.

Florian Fainelli (1):
  usb: ehci: add spurious flag to disable overcurrent checking

Álvaro Fernández Rojas (2):
  dt-bindings: usb: generic-ehci: document spurious-oc flag
  usb: host: ehci-platform: add spurious_oc DT support

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 6 ++++++
 drivers/usb/host/ehci-hcd.c                             | 2 +-
 drivers/usb/host/ehci-hub.c                             | 4 ++--
 drivers/usb/host/ehci-platform.c                        | 5 +++++
 drivers/usb/host/ehci.h                                 | 1 +
 include/linux/usb/ehci_pdriver.h                        | 1 +
 6 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.20.1

