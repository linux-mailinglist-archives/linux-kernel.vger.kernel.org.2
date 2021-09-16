Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34D40EBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhIPUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbhIPUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:24:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31121C061574;
        Thu, 16 Sep 2021 13:22:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n10so20722510eda.10;
        Thu, 16 Sep 2021 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBBPqG1hLKmKqZNNQxg2oOYMeN47sNRYlIYZJu3MY7U=;
        b=g39u8hgN4J0kJQfjL8z0G0cQhTFKShUNtCFVzmjl7Qrw0/65vBgL1How9azXcnwf/W
         Z0msPuvFuFyKKXwThEAVx0qnDM8B3NzKVRUPtpDlyXmHCyNPtVF28mpgyRFxX/HHYs3f
         AJzJq5dBjFIE5SR1/mKCvFSVo7hC4fgTqjK+60qkHnyUfNQmjDCny4Pkj3Zx2G4K8kBI
         Zj/mDFY/E2fWeYJNtElguKnmGRELYuIlneq8Liq9fGObHurEb9LOOROjeNC4Yz6F8DSI
         QVb7HhZ6gE58PhOeI3uvdEyCrjK16MTQUJNjoqw+AW3yFRsUTAnkNDoQ9hoGoxttWe+N
         0Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBBPqG1hLKmKqZNNQxg2oOYMeN47sNRYlIYZJu3MY7U=;
        b=1X/sV9HWN654LFCBtkMqwdUIneGGZKrdTbHAbox69H5oFHKFNaUGyugDzi8HycH5CZ
         K35vZ2hO2NROlNFnO6ndDddwQkyH+8zXWzyINsLEYQHm8Dl5DfvpyTxXGGMk7Rfpy48P
         969ULADgsI2PopjG0m3cxvPfeKouEZOQr2Rp6wSooRappWxv5vgpkMrtzpNMNtD1Zswj
         VxuuosAQQFZp7f+oAL8S+DY8AU4m5W+wBTbmh+Iq2ir0p1AY1mzCqBH+qu/mSflVs7n7
         3G/kfY+1X9pO24plHChga7E6LtLZEb0ciNOXEgVNmKcNAdQv4e5jTfRqUpsx3BOljLud
         7HWg==
X-Gm-Message-State: AOAM530tOmUGIOv4eWlCK9TGoShJnv/6JmifFWbl1Y1QO9aB7J8n6SsU
        3HmHEQ4F4GylIFWpdVgKnaI=
X-Google-Smtp-Source: ABdhPJzJIRjzN+Y/46fHIMLXapMfyLDFcitq88n9u2txcCM86Mky5T2BzY0PZhv3KCdSmYQc0/n59g==
X-Received: by 2002:a17:907:33ce:: with SMTP id zk14mr8356492ejb.84.1631823762643;
        Thu, 16 Sep 2021 13:22:42 -0700 (PDT)
Received: from localhost.localdomain (32-46-179-94.pool.ukrtel.net. [94.179.46.32])
        by smtp.gmail.com with ESMTPSA id d16sm1501661ejk.39.2021.09.16.13.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:42 -0700 (PDT)
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
Subject: [PATCH v7 0/3] hwmon: Support access to the NCT677x via Asus WMI.
Date:   Thu, 16 Sep 2021 23:22:30 +0300
Message-Id: <20210916202233.40334-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916202233.40334-1-pauk.denis@gmail.com>
References: <20210916202233.40334-1-pauk.denis@gmail.com>
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

@Andy Shevchenko: I have removed (tmp & 0xff) for i8 variable and changed 
'err != -EINVAL' to 'err >= 0'. Also I have changed default value of 
parameter for wmi_evaluate_method() and replaced ASUSWMI_MGMT2_GUID
to  ASUSWMI_MONITORING_GUID that looks more user friendly name as for me.

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

Denis Pauk (2):
  hwmon: (nct6775) Use sio_data in superio_*().
  hwmon: (nct6775) Support access via Asus WMI

Denis Pauk (3):
  hwmon: (nct6775) Use superio_*() function pointers in sio_data.
  hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
  hwmon: (nct6775) Support access via Asus WMI

Denis Pauk (3):
  hwmon: (nct6775) Use superio_*() function pointers in sio_data.
  hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
  hwmon: (nct6775) Support access via Asus WMI

 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/nct6775.c | 696 ++++++++++++++++++++++++++--------------
 2 files changed, 454 insertions(+), 243 deletions(-)

-- 
2.33.0

