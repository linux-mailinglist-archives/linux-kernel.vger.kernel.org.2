Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E201F460695
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbhK1N7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbhK1N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:57:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E52C061759
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so14704363wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UrcIjjq19+8x+tKdvPz3//oFylEYXfeLOia6PAhgG84=;
        b=Sy8+MnlQ+25SMuIu0N+NgpipUOZcsBukBwyRyI2MHCq8tz2rwvtZVRX+cOfEqUjWI7
         Qm+OxXcwGlDyfAtT0JyB6twkw/WwCaX6rBTv0A/3OAe3KJuOyp0EzIIt16aa+6oW8Ghz
         szOxu0X3NzadPS9NZ7OtqxZVjMxEEpZm3nbszaiBjyxwH6EtWUPNsD35ZhtEycCMfU4t
         oGJimkqu9h7JCxIQcBgggKfwKS6YnyLDVSKldelN2EzeS1bChe6126ul013Tc7QlNmTI
         U45gAEftWxiOyDz5Nz4dW8GGmjj0xhKd3e5TpgLI8JJGvcs55uMemJKKJro3R6zE0yT1
         pUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UrcIjjq19+8x+tKdvPz3//oFylEYXfeLOia6PAhgG84=;
        b=nr7QSuhfLsoKNT9NdDZIBFWUoDlWGEql4xeUyjw/MkA40ILZaY3mhcFfrTsT8XmjPC
         FEQ0ZAqDVwFWO3eUTeUC6duehs2TS3aEMBFqVoDRJIxaafFWo8GPIoC000CGtI7wEdOj
         OyZZ7vVck0oD/YjYLTkCR+OyWXttQVDDR5w2rEXBXHneJY2asPRKyYR6UBbyM20IMWQp
         Z9MrfSwLbRue1CG3O4EegwmqP9U0nzrirPqvauAb3Ky3kR72pPHFHqAertM8KWpd+4fF
         n5zJtrgbuuGEjcYquBj1O32jbCupzC8la2YirAhrgtf6v32QWQlvh7TmC2K1xYjXuBDP
         dDoA==
X-Gm-Message-State: AOAM533O4R7tbZojOnvciQwLg05nk378FpbVLy9dJAuf67WNbfFndW9T
        bel1XPa2EP9TMELtAd6vhYY=
X-Google-Smtp-Source: ABdhPJzmSE9FJESXNt5pVdJT4gR5HGp8c9JvwxnSAj0ZecIcZ9m5lJadTnpEwsn7rzTzs8Fw9j7zNw==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr29455080wmi.2.1638107616379;
        Sun, 28 Nov 2021 05:53:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id l26sm13598510wms.15.2021.11.28.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:53:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove rf_type and rtw_rf_config
Date:   Sun, 28 Nov 2021 14:53:21 +0100
Message-Id: <20211128135326.9838-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes rf_type from struct hal_data_8188e and the
module paramater rtw_rc_config.

Tested on x86_64 with InterTech DMG-02.

Please apply this series on top of the series
"staging: r8188eu: remove more usages of rf_type".

Michael Straube (5):
  staging: r8188eu: remove rf_type from writeOFDMPowerReg88E()
  staging: r8188eu: remove rf_type from bb_reg_dump()
  staging: r8188eu: remove unused HW_VAR_RF_TYPE
  staging: r8188eu: remove rf_type from struct hal_data_8188e
  staging: r8188eu: remove module parameter rtw_rf_config

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  4 ---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  6 +----
 drivers/staging/r8188eu/hal/usb_halinit.c     |  3 ---
 drivers/staging/r8188eu/include/drv_types.h   |  1 -
 drivers/staging/r8188eu/include/hal_intf.h    |  1 -
 .../staging/r8188eu/include/rtl8188e_hal.h    |  3 ---
 drivers/staging/r8188eu/include/rtw_rf.h      | 10 -------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 27 +++++++------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 ---
 9 files changed, 10 insertions(+), 48 deletions(-)

-- 
2.34.0

