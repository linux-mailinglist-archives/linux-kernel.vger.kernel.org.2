Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC940CE56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhIOUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhIOUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:44:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F85C061574;
        Wed, 15 Sep 2021 13:43:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w29so5870470wra.8;
        Wed, 15 Sep 2021 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYMNpJU+PHQutIetAOxFlUiodfYqlgLAPcoIEHh5XL8=;
        b=SR8V+TK+1fv69LCRUWqZTHK44FxsPdbHaKL8DINoLCXvi4n0v/JPemCSrqBYJKcJ5A
         EkK7jA3tFG7A1fxJf4tzY9qUuY6D9wksftK7nGp8cfQmyB8t8w0VF0rfqIQFXIAA+Jor
         W+wsSqwEb5jCAcZLyZ2uPmqrOqRpqLW08ejpmaFRAW8xsiI0IFiD0zCIfhNDfBG2FDc5
         CSFJDhJbM4qURlzugI3C85NZ89ICLhXzG7ktysZM9vJWggSuUWfvqJH+KmypiVOv/zNG
         drbQTefmOC9kj+XGE3prQtGAgKTap7VUUq4w4yZZRgF8fd7KLIM7gpyVP2zYKYYPs3yJ
         soOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYMNpJU+PHQutIetAOxFlUiodfYqlgLAPcoIEHh5XL8=;
        b=pUFxwauPetVwJQYIvzTtHvW7RnCfmnT56hLLO6G73pox1GNiXYkuZNB/bMF3naTrox
         1FJMf0WjMf7Rzh1LwuoCF41UpPNzdNPrCTFrl13fAD1zbSLgI0pOmU/IDi8+gs4P6apq
         T4PUTJ35OFmRPyB42nnQjrDJsgkUDLtQ0kVeC+MTp69520WkYch8ToFLPGOL5UNJb73w
         bvbng4T9kaymKjbCIs1H0pNj/zY0jRfXNtIuJhAXNaUsRbRq93o/G8cJMOgzhUIyy16c
         yRncyV88D9k42ngs0sIEzNej8/qF/IT2flPLpSUaLCOJkKWB073Nu9aRhsr8l9KEU0FB
         QPWg==
X-Gm-Message-State: AOAM531jq2vQum+x7zewaq7NCbysKczHXNroYhRO26Z4RBZUx4jILf7g
        0AwQu460MjRr6fd8NFV+S2KzbO8IyveqOQ==
X-Google-Smtp-Source: ABdhPJz4CJYPktW7wZLvcNwwT0PNuCKttacyiUENCai9DUD7m81e1G8J+4l3xDeuQHT4XZ7vmiX4+Q==
X-Received: by 2002:adf:e546:: with SMTP id z6mr2151212wrm.346.1631738583745;
        Wed, 15 Sep 2021 13:43:03 -0700 (PDT)
Received: from localhost.localdomain (15-40-179-94.pool.ukrtel.net. [94.179.40.15])
        by smtp.gmail.com with ESMTPSA id j4sm1080509wrt.67.2021.09.15.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:43:03 -0700 (PDT)
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
Date:   Wed, 15 Sep 2021 23:42:48 +0300
Message-Id: <20210915204251.26081-1-pauk.denis@gmail.com>
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

