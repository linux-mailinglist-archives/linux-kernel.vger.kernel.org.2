Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDB41010D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbhIQWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbhIQWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:04:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47728C061574;
        Fri, 17 Sep 2021 15:02:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so36317405lfu.2;
        Fri, 17 Sep 2021 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qu9Wn2OHc/O8Y4RhFTYDG+zso2AKiwODJeSW25BVQwM=;
        b=FsWSwQ+uYSFEGz7c0lSthO+m3b8/rZbrWH8C6DnrcRATk3D2s6MjX3z3Rrp/uaDjKY
         78O/esY6C/lx/HDSZ5PZqa0iWhljhOU4TwsY6qs2jClNJgo361CiiB3Ckb86Bn/SMXfb
         guoGbKVnW20acCUtGS/SgfahFbW4XzhE+WWgu9H0TB5XMtZ4YahLD6Bc6NVlNvgsGy9t
         pHfI98+dO7TnlucPKm3i7MKoWZ0uVOHz2jf/nWhqPLmgX0RzXFx2+eVF0AkDj1+yAEJj
         RS43biH3zPZnqf+L39TLKUITHRUIQOCHJJCJvX3bdMl+x+JMyHmrTq3dIxK1Bv9jZKLs
         5bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qu9Wn2OHc/O8Y4RhFTYDG+zso2AKiwODJeSW25BVQwM=;
        b=zgOVQAllb88jLzKEQcMY78HwzUoR9kLzbSau1rklU+E/yk6eVZM4xwz60+fjKHVd0f
         CnYgFuTJvfT5fEzYW/bnLjFwe1kFYJ2g++aYydZitLsLv6JT02y05Y8VoT0aNPO73bQy
         dH06Yz3RDRjzdxwRot+Ww2y2f0ZfXovHdU+srK4wdgs4TfXzd8FkKz1BumklXOv1m7lW
         zuf3gO+ndIxT2mwFME6Agiz56rH/eYndcMMIHUxwEbc+1y4ZPDubtrGojiZ5kUojALAO
         gQnz9SWWN59OTQ520O6U+IFFRcjCh8wCmTJEJi1U1lMfaXAKVEa5moEsr7MvFiaYgNkn
         64Wg==
X-Gm-Message-State: AOAM5326i54CPS+8iar2JrwgPQxHMRItWuu0YCsagI6FYfzGpcV5Rh0U
        oFOyM9cK7YjwdS6rHwRkscY=
X-Google-Smtp-Source: ABdhPJyAMMLp0fu+ljsbIBQaQTYLaaosFRCLVu5qOL6nQC1EUtExgrkwRl5wqOWR5vft3LSx4nqzmA==
X-Received: by 2002:a05:6512:118c:: with SMTP id g12mr9616650lfr.143.1631916175631;
        Fri, 17 Sep 2021 15:02:55 -0700 (PDT)
Received: from localhost.localdomain (95-42-179-94.pool.ukrtel.net. [94.179.42.95])
        by smtp.gmail.com with ESMTPSA id i20sm789529lja.36.2021.09.17.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:02:55 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/3] hwmon: Support access to the NCT677x via Asus WMI.
Date:   Sat, 18 Sep 2021 01:02:37 +0300
Message-Id: <20210917220240.56553-1-pauk.denis@gmail.com>
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

@Guenter Roeck, I have removed unrequired error messages.

---
Changes in v9:
   - Remove unrequired error messages on WMI call failure.
   
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

---
Denis Pauk (3):
  hwmon: (nct6775) Use superio_*() function pointers in sio_data.
  hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
  hwmon: (nct6775) Support access via Asus WMI

 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/nct6775.c | 706 ++++++++++++++++++++++++++--------------
 2 files changed, 464 insertions(+), 243 deletions(-)

-- 
2.33.0

