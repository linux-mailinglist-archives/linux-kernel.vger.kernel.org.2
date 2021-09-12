Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47304081CB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhILV1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 17:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhILV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 17:26:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17013C061574;
        Sun, 12 Sep 2021 14:25:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h17so1130163edj.6;
        Sun, 12 Sep 2021 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2s4KXPxoDKA8MRQgt+J9btH4rwobhqMFscNpoWY7/go=;
        b=Ch3/SAbEYz0AGK9khFaYWEJtgJpwvfbbYlxWrhl3xkuP6PGJ7qNuT7Ae+IcSSCdcsd
         9Qgdjv7DyQahX3It0RxmGGXhe04jCK4YfGenosfLHkXYTY/kSRKaE5FDGXyjO6gV4Vzc
         d2cGNpzpEY7YBD2y/kJ+kph1SRmyDCIBFFijcp3gdbqOgRDJBEK4VtdgpCE9WSyt6oPC
         +9HZhktzoS4Mr70nmKWLvxuXGawtHXmHuqZP1iKRvO/C2t2uqVvAcY+bVx4t6EMXoKKX
         ZTn/Bnl2y5XQLGjU6dc8FEw/Pt69v6JAWtr0d4Xcm2wkCA6K8UfQF6nxi1zPM0mXH4ll
         M6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2s4KXPxoDKA8MRQgt+J9btH4rwobhqMFscNpoWY7/go=;
        b=T6UNLLFLXPluEvEShI6NAw68h5mbcKbBAmh7Qy8am5N7zioPEPmRNc9qeSUdJuck89
         6W/DNCU7q3QSsPeW49Cw1McnIJSGI4W3pFUtWC4HzHUIzQYnEQgmX1NmzNZE5CnHf2ro
         ClYgh+7ZRrwKy2wQcQKXrbZo5jUDPyOGMZbik0OsLa0T/DheV/mVSh20yY5Ymvhb5ZN0
         oIcFf9voH16yE0Il7fT8eI39SnLJ6UCudSOMiNAM3jS5NWhaiggMDoHoMPKh+9AV7oiY
         i/DBjtPISw0qX26eHy/tlx/0m0xtfE5yL8iX2JLoc/TCbWNhq6NAcqIkr/rGrzJH2MEN
         5APA==
X-Gm-Message-State: AOAM530AITJEDqLb/m32tWIYNSxls+zR95J9xJuWC4PJLLYt44PHXmKC
        siTAeC018NmQk1ztJQ1ZmSM=
X-Google-Smtp-Source: ABdhPJzOqeva/GnTUk67NtyqCHeuAYwbDpf3jI+R4/Fz4fJal6hSRtDzbpif6tcDDf6QuvykA9BSEQ==
X-Received: by 2002:aa7:cd13:: with SMTP id b19mr9832889edw.210.1631481943641;
        Sun, 12 Sep 2021 14:25:43 -0700 (PDT)
Received: from localhost.localdomain (146-25-94-178.pool.ukrtel.net. [178.94.25.146])
        by smtp.gmail.com with ESMTPSA id hz15sm2506677ejc.119.2021.09.12.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 14:25:43 -0700 (PDT)
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
Subject: [PATCH v5 0/2] hwmon: Support access to the NCT677x via Asus WMI
Date:   Mon, 13 Sep 2021 00:25:35 +0300
Message-Id: <20210912212538.246215-1-pauk.denis@gmail.com>
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

 drivers/hwmon/nct6775.c | 701 ++++++++++++++++++++++++++--------------
 1 file changed, 464 insertions(+), 237 deletions(-)

-- 
2.33.0

