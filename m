Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DEE34790B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhCXM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhCXM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:56:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A25C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z1so27546933edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9XD7LgutIthWxyh0z5JZ2FaeGZvIL8c4hnddAnFY7Q=;
        b=rHtXaN5hln2lNri4GKEYgFoML7CrNJGGG1rbRnRtjn6+dujoAalkv/r5bc4YpXj5Cl
         DgpHKHWpHsaj+oxL/GVFrHP6X6jHORAjYLcW8eWFiYdzNQ2OhDp+ZeVuw7cEXVHktoPh
         hEy1lqSNBb3W/gD7945+zLJ9s4dgRdDAI1sp2/SgiS2XWs9ZWd9xl7ki66IBex54VU1E
         pQJj939l1XAxfi/Osv89Di4fDbcPf4zde4l3IXwRPEym+O/Ax3peiaL4xCOubhomRWTq
         s4qK/dL8GotwGws6o5p8wdtGlKoGucYAh2WJZCxcpQrHGP/SxnfzOe9WmerXLNTzgeSa
         8U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9XD7LgutIthWxyh0z5JZ2FaeGZvIL8c4hnddAnFY7Q=;
        b=U1Bncc7LlZEqdXz7Tvc6j3iIFiKsmiRGW3PANf3m+/exQTb+bOyVOnA/Q3iCxX+P5r
         iXV2fRLSj1uwGa8MyCRY7x59jV7gYsu/CJEJ4j7Iew7YZOvX/LUJ9jjG4rHtvwb3TQna
         Bl2mQ2eG+XNk0CAAWcEMWsOEr+iG5SxCMWAA/0CBVcdvJgOUgFvcJz+EBqYinvy13Rkg
         syCKfFY/zqrh5+uTDWteMdy/fYS/fLKG4E/uk1rMhsLIQwepbWhcptNogNEQc/8epwAk
         hEBRghpnhco/Acuys2NX6I6yfuiKXiYJg7k8cjGmu09PAcLvDdVwUE/IIxvdN/Gy5Q55
         QLBA==
X-Gm-Message-State: AOAM532Czo0dllEHLCTIysx67WEhjtIWHif+pSs5RE+DVgt09mBh6pAp
        6+s7ELy5vtNag22kGrRhwGk+wg==
X-Google-Smtp-Source: ABdhPJzI/SdqyKZqfR2XhPBIU6Z8i4lnkS1sHkXwoXxmHwDZKeF6Bz5Qah6Es4+NCUjdk5vfhn9U5Q==
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr3211824edb.71.1616590560162;
        Wed, 24 Mar 2021 05:56:00 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:55:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 00/10] platform/x86: toshiba_acpi: move acpi add/remove to device-managed routines
Date:   Wed, 24 Mar 2021 14:55:38 +0200
Message-Id: <20210324125548.45983-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset tries to do a conversion of the toshiba_acpi driver to use
only device-managed routines. The driver registers as a singleton, so no
more than one device can be registered at a time.

My main intent here is to try to convert the iio_device_alloc() and
iio_device_register() to their devm_ variants.

Usually, when converting a registration call to device-managed variant, the
init order must be preserved. And the deregistration order must be a mirror
of the registration (in reverse order).

This change tries to do that, by using devm_ variants where available and
devm_add_action_or_reset() where this isn't possible.
Some deregistration ordering is changed, because it wasn't exactly
mirroring (in reverse) the init order.

For the IIO subsystem, the toshiba_acpi driver is the only user of
iio_device_alloc(). If this changeset is accepted (after discussion), I
will propose to remove the iio_device_alloc() function.

While I admit this may look like an overzealous effort to use devm_
everywhere (in IIO at least), for me it's a fun/interesting excercise.

Alexandru Ardelean (10):
  platform/x86: toshiba_acpi: bind life-time of toshiba_acpi_dev to
    parent
  platform/x86: toshiba_acpi: use devm_add_action_or_reset() for
    singleton clear
  platform/x86: toshiba_acpi: bind registration of miscdev object to
    parent
  platform/x86: toshiba_acpi: use device-managed functions for input
    device
  platform/x86: toshiba_acpi: register backlight with device-managed
    variant
  platform/x86: toshiba_acpi: use devm_led_classdev_register() for LEDs
  platform/x86: toshiba_acpi: use device-managed functions for
    accelerometer
  platform/x86: toshiba_acpi: use device-managed for wwan_rfkill
    management
  platform/x86: toshiba_acpi: use device-managed for sysfs removal
  platform/x86: toshiba_acpi: bind proc entries creation to parent

 drivers/platform/x86/toshiba_acpi.c | 249 +++++++++++++++++-----------
 1 file changed, 150 insertions(+), 99 deletions(-)

-- 
2.30.2

