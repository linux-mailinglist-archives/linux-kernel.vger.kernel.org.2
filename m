Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8A362AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhDPWRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbhDPWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:17:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F466C061574;
        Fri, 16 Apr 2021 15:16:48 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c6so21944169qtc.1;
        Fri, 16 Apr 2021 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGnFBaq7FMOAuLMEwvb3+Wu8srJOg+PUStsw9VmMLAs=;
        b=qfd6rGar5bZAaj/OmxXjZbJJs5th0dw207o/4IY3p9kOnz1P1idV/6DSWWK9gQBHr0
         sYTTu/fU54PbBp5zSM/+4sW/2dv9yv5/uLy7uucjTb4ODRPWzQZQoMAAd/RPeE1wfHNZ
         ckruZApnxXTWl5qgSUj1r99BRo5JxtJvkEraye3mZzV7Kfrti1cVHPUtH9wqZBR9ZA6x
         PMCgE8sQm0gqaeW37KlsrxokguHp0Z1ZUDp23v50ZisXJK5NETYx7n3DIzQ0OxXOOZxN
         S+D3VNVUmph3NMq+6+HfkoahL4DgyDbghuE+n8qSmB9hwgCUPWx+Rbhgw5s374BzPVq5
         fX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGnFBaq7FMOAuLMEwvb3+Wu8srJOg+PUStsw9VmMLAs=;
        b=QiZ2q2wxkHUv35RRSQ7MJfR547jHYr0hQP8UXAoVw6/KNMUztqm1SV0jxEXh7YR9wx
         CS4A+lmd2bgnN1lubYAYHZn9qx0ma4LE8/YPLggMxk6VHwIZyjp2U3/sn2/MDW1n2WHZ
         Vk1xXvHIUaaQ9sXT0xP8REdC7599KdNKA7hudhI+op4S+TEy36AXK/RcD5fo+oqofBVW
         cNMtK8FIgG6ClQoSYTz3Sc/oO6hrOQSi2XPgbXpe93RMebCSXnSAkR6gb1NahH9Qci9d
         Nzjpqfw9aln9aiqqK41mOnRmtRwuV/oIo6uHpV23TRBJ4aarjstDS8U6QQbMlwalZt9t
         nU0g==
X-Gm-Message-State: AOAM532LMGXkXlbBioZJwZnydefhrWjCKl0ARpBN/P1UAeAjUiCPGA8a
        ExtemxeRGv/Na7gf9Ub6Ptc=
X-Google-Smtp-Source: ABdhPJxEUcVeW5+r9PBDIUPyr+x86GQrVIkEu/nvycuXkxDAvwCzez3bizZIej7lqoE+++NsdCG/9g==
X-Received: by 2002:ac8:4b54:: with SMTP id e20mr1227637qts.371.1618611407620;
        Fri, 16 Apr 2021 15:16:47 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id y6sm5131166qkd.106.2021.04.16.15.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:16:47 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v7 0/6] w1: ds2438: adding support for calibration of current measurements
Date:   Fri, 16 Apr 2021 19:17:33 -0300
Message-Id: <20210416221739.501090-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches aim to make a user able to calibrate the current
measurement of the DS2438. This chip uses a offset register in page1, which
is added to the current register to give the user the current measurement.
If this value is wrong, the user will get an offset current value, even if
the current is zero, for instance. This patch gives support for reading the
page1 registers (including the offset register) and for writing to the
offset register. The DS2438 datasheet shows a calibration routine, and with
this patch, the user can do this quickly by writing the correct value to
the offset register. This patch was tested on real hardware using a power
supply and an electronic load.
Please help to review this series of patches.

Best regards!
Sampaio
---
Changes in v7:
- Build test again

Changes in v6:
- Actually changing from BIN_ATTR to BIN_ATTR_RW

---
Changes in v5:
- Merged all brackets coding style issue in one patch
- Changing from BIN_ATTR to BIN_ATTR_RW in w1_ds2438.c
- Wrapping email lines
- Addind Documentation/ABI/

Changes in v4:
- Fixing different patches with identical subject lines as requested

Changes in v3:
- I accidentally added a wrong line that would not compile. I'm sorry. Fixed it.

Changes in v2:
- Using git send-email to send the patches
- Adding documentation as requested
- Separating the coding style changes in different patches as requested

Luiz Sampaio (6):
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed if brackets coding style issue
  w1: ds2438: changed sysfs macro for rw file
  w1: ds2438: fixing bug that would always get page0
  w1: ds2438: adding support for reading page1
  w1: ds2438: support for writing to offset register

 .../ABI/stable/sysfs-driver-w1_ds2438         |  13 ++
 Documentation/w1/slaves/w1_ds2438.rst         |  19 ++-
 drivers/w1/slaves/w1_ds2438.c                 | 122 +++++++++++++++---
 3 files changed, 137 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-w1_ds2438

-- 
2.30.1

