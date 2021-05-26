Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08888391453
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhEZKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhEZKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:05:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F621C061574;
        Wed, 26 May 2021 03:04:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z12so1548582ejw.0;
        Wed, 26 May 2021 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sWYmaexz2luPiKMpfqCnX/580CB+tPzQNwZHR9+Ogyo=;
        b=PdbB8DY4k/TIB0lwvZoPwsZXAbtN4XwPmx/v+USX1E4Py+DgVAoRf3xcaHcCSHhMau
         gVSPGH6YtDAq1LT0ABO6dQJs2thvCFX6x7Xm9+Zkf/K++a+F1x/Gw7Y1l2wZUbTthyxK
         lD1sHhE34BOG0246w/blcwwyxIZozag17Zv4GLDcErrVvegYhMyOzeUILIdcrMq3QCGk
         qg1GEwqfxwoo2gmQlZZ028J6+/mNLlW4deEZJlAJPBaWuKAdCZL1yAVSId2w0Ksjv8/i
         mOreASb17a9p/61MTP0NnrIiZR4BPIxnXagYSYMIsSn3/SCwBt06W31evnrfbDh8OeUK
         6+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sWYmaexz2luPiKMpfqCnX/580CB+tPzQNwZHR9+Ogyo=;
        b=FaAUVT94YM9gyIJl8BRCxpt8MRKsEdKFT3anGE2h/Ok9Zm09pmuEs49/qVT+TdwaTk
         nBaI/1wZTKdCH7yOkhmSGt7RTr4Fq+defXiRjLR5oHyT0+Mydb6V2AJ5vpR/EqqdH5Lu
         WkL49NgPp4LokxCfqv4AtAd4Tt+9BFODdnx5JuMh9yAY7WWaFwH0YG3Jz2Ou29wE051v
         Q9hrajADnSe7ZHQDXKSRc3Y0UDsSiq1EqQfG6HnWtsveF/okb2DaRMYsxQIR+pjA5REy
         UCuFuFSJuVmZS+TWiuhpSdAOwQnW4keW6kyQrVlqq9L4C+wxJos8YrjGnAxMtpKP/lr2
         2zBQ==
X-Gm-Message-State: AOAM533g/u8m6sAhGraiMQPkWkw3Kcc+B39zIq7hhTrsgl/iHYYfJMJc
        hODmkO9aucFpshAawCD+CRg=
X-Google-Smtp-Source: ABdhPJxLi+0tXUMC7tUvF08xl7sU5rZjegiy72puaZhglc4nYXlKG0C85+WdkIGxq8dkBNx7sHn36g==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr32950705eja.275.1622023448116;
        Wed, 26 May 2021 03:04:08 -0700 (PDT)
Received: from ruhe.localdomain (89-139-227-208.bb.netvision.net.il. [89.139.227.208])
        by smtp.gmail.com with ESMTPSA id x9sm10611599eje.64.2021.05.26.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:04:07 -0700 (PDT)
From:   eli.billauer@gmail.com
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH v5 0/2] Submission of XillyUSB driver
Date:   Wed, 26 May 2021 13:03:09 +0300
Message-Id: <20210526100311.56327-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Billauer <eli.billauer@gmail.com>

This is a resubmission of the XillyUSB driver, which is the USB
variant of the existing Xillybus driver.

Because these driver share some API related functions, this submission
consists of two patches:

(1) A patch moving away Xillybus' class related functions to a
    separate module file.
(2) A patch adding the new XillyUSB driver, based upon this new
    separate module.

Thanks,
   Eli

Eli Billauer (2):
  char: xillybus: Move class-related functions to new xillybus_class.c
  char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)

 drivers/char/xillybus/Kconfig          |   22 +-
 drivers/char/xillybus/Makefile         |    2 +
 drivers/char/xillybus/xillybus.h       |   10 +-
 drivers/char/xillybus/xillybus_class.c |  263 +++
 drivers/char/xillybus/xillybus_class.h |   30 +
 drivers/char/xillybus/xillybus_core.c  |  181 +-
 drivers/char/xillybus/xillyusb.c       | 2260 ++++++++++++++++++++++++
 7 files changed, 2599 insertions(+), 169 deletions(-)
 create mode 100644 drivers/char/xillybus/xillybus_class.c
 create mode 100644 drivers/char/xillybus/xillybus_class.h
 create mode 100644 drivers/char/xillybus/xillyusb.c

-- 
2.17.1

