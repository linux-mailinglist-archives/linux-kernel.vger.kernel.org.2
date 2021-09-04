Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CBE400B5D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhIDMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhIDMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9207FC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so2566931wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zHqal9h+jJaWhEw2JxpQmHT6gLaSxp8mSOl4ryaFk8Q=;
        b=aG09Kp5NHfT7KEQ/z0kGfitBZtEJsE0cqGFHd6ZD8Qgz6mfLpYtcN9R+EwDtDhFvpj
         S+7KXw/5CEpaJreH2mZ+oiyRpH/7nmucn3mAH7JIAdV/ijzQQf5tij7McPDFJmRItjYe
         U6+kS4dehIOOTM9TW5wvEKzxe4+lp0cwAu4c0R0Ne0laLM2uH9pLfUsXe0E0/0U7Q/xz
         9yNfXDNuMoV07yAiDpP1DMSch7qZn4I9tt1QSVAH07USUt/6OxkJ6CmqQUXeNlWM/CSD
         Ok7TcBNwLaYr4O9BZtWv2kjcW1wrkfisDLKhU/CLBOMQeV7uN2hDvY8xALmE9JhrudeG
         l+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zHqal9h+jJaWhEw2JxpQmHT6gLaSxp8mSOl4ryaFk8Q=;
        b=uIfaFX8pOavqeu0n0LKWA4KaxOd5wErrUiYqzhi8dudWmj2v95h60EF8tJrnq3Zn7X
         yperN27XYzDLn4d47YE2xYVJ3MQ9hYa4fWYNPVK27iXmTUYYH+vKohlmffZ3Vd4NycR2
         RJqEcIgQh1gL4FN15lWv6WIAims7gYyt63Pg+AaD0EpxMNVaIUqDWCtuAbuftiBCQvDb
         AUNTMcF2WjvTOTRgl7uhz6pq299JKnUSTDpFGoJutN6eAFnMMQEktRx45qeEGYrJB2aJ
         cb6njdAsNrnodGObr2uwuwH+b8uOPXDd7UeH0wQZ0zeBJQpll/Q/xLEUv6Tp7KL5Nb4/
         seyQ==
X-Gm-Message-State: AOAM532qQRSexGn3GldEa+7PKa/26XST9EVMXFGA/JJQDj0otr02Dk8o
        8giabw2c3BAyNxdRfNwV4Cms2zEPRTr84g==
X-Google-Smtp-Source: ABdhPJwpDMT6IL1yyHoo1bn+PHEbWjtBPV2IHcM4UR4SYn2av03cjtZx4UDc2nKDITCaPlz/IiN0XQ==
X-Received: by 2002:adf:c452:: with SMTP id a18mr3828338wrg.225.1630759251222;
        Sat, 04 Sep 2021 05:40:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: remove some functions from hal_ops
Date:   Sat,  4 Sep 2021 14:40:27 +0200
Message-Id: <20210904124033.14244-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting rid of the hal layer is on the todo list. This series
removes some functions from hal_ops and make the driver call the
pointed functions directly.

Tested with Inter-Tech DMG-02.

Michael Straube (6):
  staging: r8188eu: remove intf_chip_configure from hal_ops
  staging: r8188eu: remove read_adapter_info from hal_ops
  staging: r8188eu: remove read_chip_version from hal_ops
  staging: r8188eu: remove wrapper around ReadChipVersion8188E()
  staging: r8188eu: remove GetHalODMVarHandler from hal_ops
  staging: r8188eu: remove init_default_value from hal_ops

 drivers/staging/r8188eu/hal/hal_intf.c        | 33 -------------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 16 +--------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 10 ++----
 drivers/staging/r8188eu/include/hal_intf.h    | 22 +++----------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 ++
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 +--
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  7 ++--
 7 files changed, 16 insertions(+), 78 deletions(-)

-- 
2.33.0

