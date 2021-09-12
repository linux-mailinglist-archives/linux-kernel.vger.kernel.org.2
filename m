Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE24081BC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 23:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhILVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhILVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 17:04:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF9C061574;
        Sun, 12 Sep 2021 14:02:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c22so9798422edn.12;
        Sun, 12 Sep 2021 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUjkt5tqxJNwJpj1rH5M8VTbLi4zFaSrxlPVzEoZ9iQ=;
        b=IroTDtlg/R8fwCDZ9Y39i3Xm20k/XhtmkKrZkzuLJqMo23zWePF6gDGoNV0UHchD/h
         iM0JPHCzyhMPWnsI5rHzW4CpesX0svbkL/PLpU04IrzGUT5cZVbq/OoJuon/zTiU940d
         sDLc/QveRCL1ChqbNXSUqEkTcT/rYZC+4+hIDRnoc87+SQfmJECFaN8Nhtkf/iA3THqQ
         +NV++vqeA/hih0s3BYaD2w9/fRldXLq1zXIOkwTy1ISxTLnuXAx97G+HHdbOXKnUT3lF
         S3QltItUMREJafG9ymr5Y0Phkqy2Q6mZ4+GqTecUhfKi8U3ZkAnVEYT9hijewVBDpN6r
         AP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUjkt5tqxJNwJpj1rH5M8VTbLi4zFaSrxlPVzEoZ9iQ=;
        b=tbvY8brLCtBKz/qgo8gfN4YWGnJZARwQ+H8X55LUusIerFRwHKGdxLpYuvJxDxUP7y
         ZBSqb2uB5lFCuqfjWQl60chwtp3usOMxZSkXYf+lIqoZPNfvtX1CNZm8nGG0Yvj2xzNG
         Qm8BV3de4Z/jkx5qOZQMqMV66xMKHC+JwrpMW2Jp2+vVu1ZTVXOWXC9KO2LymtrjCZhg
         rvfXZWO4d+o0Oy6t0psWAjDpUGtejULBMmHE7QdEgE1kOwgqh+e3Sl4lrIkfrCzCsxuj
         UmnmogRfJGSzXkQTZiCQvnaxPbIM6fY4q1XK4B9aBYXyYCa3AtYDne2xB5g84Nevcci/
         t1aA==
X-Gm-Message-State: AOAM533UAa2gIgjUWkaWa3WF1chAyHdExiFrygDPS49iMQgChPsB0kqI
        sTiXPgI9yeFZlOxcStMtgv8=
X-Google-Smtp-Source: ABdhPJxVARRCBe4mlbGw/hbIOW1bu8ui0r3otvsqZCimM8WOoIoJf90vTbkhOw+MJXjpKIY/UOL1IQ==
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr9817558eda.205.1631480574702;
        Sun, 12 Sep 2021 14:02:54 -0700 (PDT)
Received: from localhost.localdomain (146-25-94-178.pool.ukrtel.net. [178.94.25.146])
        by smtp.gmail.com with ESMTPSA id z97sm2821140ede.72.2021.09.12.14.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 14:02:54 -0700 (PDT)
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
Subject: [PATCH v4 0/2] hwmon: (nct6775) Support access via Asus WMI
Date:   Mon, 13 Sep 2021 00:02:41 +0300
Message-Id: <20210912210244.184521-1-pauk.denis@gmail.com>
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

@Andy Shevchenko, I have added check for ACPI WMI config enabled 
for prevent issues with non x86 platforms.

@Guenter Roeck, I have left nct6775_*_set_back() call without
changes as its always called from platform specific callbacks.

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

 drivers/hwmon/nct6775.c | 701 ++++++++++++++++++++++++++--------------
 1 file changed, 464 insertions(+), 237 deletions(-)

-- 
2.33.0

