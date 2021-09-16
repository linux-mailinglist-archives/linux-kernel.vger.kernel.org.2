Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06440EB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbhIPUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbhIPUYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:24:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32302C061764;
        Thu, 16 Sep 2021 13:22:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c21so21138337edj.0;
        Thu, 16 Sep 2021 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYMNpJU+PHQutIetAOxFlUiodfYqlgLAPcoIEHh5XL8=;
        b=CgMjSEXa72OYUo7RRUW/klkLivwuogAvVtyysU8jFIzYPlgH9MIJ/LqND9m4XC6aVK
         prGuoL/Qdnv+B27h708EtGBpha63N6KAxHfyIBrQ7Ta1dwdEnQjUnvS/koMUBhe5uPal
         3yGwbDWyh+ZMZ30wwb4KQBCUkTTcFXXVTDqscQj2tzVD1WR0Gap69a+v4wmjfMRqSfn9
         /Ufi8hpTRSKhqUOAt57mMvq66Q0mUB0aXgBGrLxSWwW2gBU0mkJRfcw6QKh9G39k+62Z
         xnj9r0WdQwU1fJmhnwaOb67a4Ab37DB8bDmgAtcCn90xCwz38f2XhAxiNAg4tHpg0wmA
         USlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYMNpJU+PHQutIetAOxFlUiodfYqlgLAPcoIEHh5XL8=;
        b=xh+SYWxMYU7BXXVQxv1NXRPdaOqX/bDZ/CfItdk/r+kmiAwCXZKJ09So0z1SleD9Av
         fdYPjZetA+pKbLCVMWTIwg9JHOcpZBZr26SjKwNcSzzAH+vADxgTxgfVieCazpZ7DE2o
         vWXo05aOfPJKSWRyKg6gkgnM0QNf0B/Qa6HtX2EPCu6sjuBN9lOwlRZ5PXSuWZogqwkm
         U8gxiynmA1Q3c/ParjTpB2IFdRqCMFaogZ9Xz4l/peMO72d7GYEPhBRh8wEIVQdBRy6q
         dmmnSrvfG7POgiD4GXsa8vYGgLN2mH+iKFUV8c1rvbv9wFOw12AX7FbMwYI9re45VJH8
         g2vA==
X-Gm-Message-State: AOAM532E36LaUQzED4OJ+mRoIy7OYc+XqUmQr6chv1KbFU4iCRyI6v+0
        KcCy8k5eIyQ2ffqU+/31dNc=
X-Google-Smtp-Source: ABdhPJylZ/nOv+KcOJTYxkfwcu7N/A5p+4+Eij1QgYB/qgZNXiQWbYN4wvwQ8wZk6CG3DkYH+Nosxg==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr8331030eds.166.1631823760607;
        Thu, 16 Sep 2021 13:22:40 -0700 (PDT)
Received: from localhost.localdomain (32-46-179-94.pool.ukrtel.net. [94.179.46.32])
        by smtp.gmail.com with ESMTPSA id d16sm1501661ejk.39.2021.09.16.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:40 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?P=C3=A4r=20Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] hwmon: Support access to the NCT677x via Asus WMI.
Date:   Thu, 16 Sep 2021 23:22:29 +0300
Message-Id: <20210916202233.40334-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support accessing the NCT677x via Asus WMI functions.

On mainboards that support this way of accessing the chip,
the driver will usually not work without this option since
in these mainboards, ACPI will mark the I/O port as used.

Could you please review?

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Tested-by: Pär Ekholm <pehlm@pekholm.org>
Tested-by: <to.eivind@gmail.com>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>

---
Changes in v6:
 - Add dependency "ACPI_WMI || ACPI_WMI=n" to Kconfig, 
 - Minimize size of code under IS_ENABLED(CONFIG_ACPI_WMI),
 - Remove not requred check of platform_get_resource result,
 - Split function pointers patch to two separate patches,
 - Add more board ROG CROSSHAIR * names from bugzilla.
 
Changes in v5:
  - Use IS_ENABLED(CONFIG_ACPI_WMI) instead defined(CONFIG_ACPI_WMI)

Changes in v4:
  - Fix naming conflict with inb, outb by add sio prefix to callbacks in
    nct6775_sio_data.
  - Fix build without ACPI WMI.    
    
Changes in v3:
  - Remove unrequired type conversions.
  - Make function declarations one line.
  - Use nct6775 function pointers in struct nct6775_data instead direct calls.

Changes in v2:
  - Split changes to separate patches.
  - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
  - Rearrange code for directly use struct nct6775_sio_data in superio_*()
    functions.

Denis Pauk (2):
  hwmon: (nct6775) Use sio_data in superio_*().
  hwmon: (nct6775) Support access via Asus WMI

Denis Pauk (3):
  hwmon: (nct6775) Use superio_*() function pointers in sio_data.
  hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
  hwmon: (nct6775) Support access via Asus WMI

 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/nct6775.c | 698 ++++++++++++++++++++++++++--------------
 2 files changed, 456 insertions(+), 243 deletions(-)

-- 
2.33.0

