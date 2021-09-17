Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27F94100A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbhIQVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhIQVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:20:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514FDC061574;
        Fri, 17 Sep 2021 14:18:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq5so38371725lfb.9;
        Fri, 17 Sep 2021 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7x9Mf1nsbfFuOkzeXvxz9R901v90JLdCe3TVldsY/hU=;
        b=c3evz0QwYHVDcVxisfXFAvO8RICUiC4PjjasrtiFxEpkQQ6gon1LyEYq0ZWOk/7jXV
         5idg0CFf3f0KNNWAZfRinqAjXTSDrP4sgDgB7G1gurcEGiPaf0UdrdoKdfSvUSJ4Pdkp
         pLzxoZujRGcMhA3EW8kQPzN8qrms1pniCzmW7Qph2WfezGNJvhbu2HiZdcrwnXZYgtaE
         A4xkPBwtGh40CsoePMKIKleMANE65d2FcjvTv7XfovjwAze1LLv/lvxMIfXLGMZkyyVH
         hzGnZHx3elG66MMrGfpxc/GdkJCGXc+jy5EjBwEuMp+VJG5abGJC4bxeALlNosyMebZY
         RB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7x9Mf1nsbfFuOkzeXvxz9R901v90JLdCe3TVldsY/hU=;
        b=56sj8VmuPYjfvP/KCsoYNbd//phf6AhMAv9FPg1yTxX1BIcSB9piHoPkoEmtSB5prS
         dxV5Qgs/Joz+hJzULaynE9/F+7c0jDQDBMWvVZKaoBR3TG0kUGf7xP6mR1c1NfpWN4Uk
         SYMQ5TYDr6bR6g1Z8MPqoPx2SJb0e90Vyd2ZmhOIm1sCqQZPDhnGGkNP6ySxXLW4fokb
         dnfftWomhs3QYcIC9nCWkjJRv6OCeXi8cNshHH3eAYSdzqChKTKOEAN0QP+Hhd2y+1AK
         WYFaZQWSzdft9oHjszU0mTtuMUG5UEMkzer1MgNfEWQMUhgL7qVBiysfmPbqq0C4aVPj
         ru2Q==
X-Gm-Message-State: AOAM5301eMAYqCwQi4M6uU+3eACESzIGCB4Gr0f5A4Q1MqVKkglLC56/
        OPxNrV9zFloD08/7bBoNByE=
X-Google-Smtp-Source: ABdhPJw2z7ZatxQWJDsgwRqmquTnN5fBRanLsAp1Ydi6yR8s1qtLGAuP16zuHwQNLYxtSVG1lfs0VQ==
X-Received: by 2002:a2e:141d:: with SMTP id u29mr4991753ljd.49.1631913527539;
        Fri, 17 Sep 2021 14:18:47 -0700 (PDT)
Received: from localhost.localdomain (95-42-179-94.pool.ukrtel.net. [94.179.42.95])
        by smtp.gmail.com with ESMTPSA id h17sm196037lfg.258.2021.09.17.14.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:18:20 -0700 (PDT)
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
Subject: [PATCH v8 0/3] hwmon: Support access to the NCT677x via Asus WMI.
Date:   Sat, 18 Sep 2021 00:18:07 +0300
Message-Id: <20210917211811.39271-1-pauk.denis@gmail.com>
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

@Guenter Roeck, I have renamed asuswmi_evaluate_method() to 
nct6775_asuswmi_evaluate_method(). Also i have checked why results of 
WMI calls are ignored. In most of case initial caller also ignored resuls 
of the write operation, so i have added logic for stop futher operation 
after the error and write to logs errors if any in call. 
I have marked that first two patches are reviewed by you.

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
Changes in v8:
  - Rename asuswmi_evaluate_method() to nct6775_asuswmi_evaluate_method().
  - Add out error message if WMI method is failed.
  - Stop futher read/write if first operation is failed.

Changes in v7:
  - Remove unrequred & 0xff with i8 variables.
  - Make ASUSWMI_UNSUPPORTED_METHOD as default value for WMI responce,
    before run wmi_evaluate_method().
  - Rename ASUSWMI_MGMT2_GUID to ASUSWMI_MONITORING_GUID.
  - Replace checks of 'err != -EINVAL' with 'err >= 0' for match_string result.
  
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

Denis Pauk (3):
  hwmon: (nct6775) Use superio_*() function pointers in sio_data.
  hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
  hwmon: (nct6775) Support access via Asus WMI

 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/nct6775.c | 722 ++++++++++++++++++++++++++--------------
 2 files changed, 480 insertions(+), 243 deletions(-)

-- 
2.33.0

