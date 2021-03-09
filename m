Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422703331DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhCIXNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCIXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:13:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CB0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:13:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o9so18919939yba.18
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CQRMAIOvqBs8kZZqo+ZLWXcUVnOj5R3ECqdWM5F4gPE=;
        b=UYNyZvVncul7Pst5XhlG8JZRtQZq7IMynBgZ+sQoPXaZmfjWQMLRwKLmDaeCYZFaoT
         QkzRGaBVXGCoW4vl8vdDADcS+LbZjxg6ANCU0g/REbx2s5NFQg/ZocI886W3ojQXjl/9
         6fzla7DZuo9OaetwEGm/lxQ/RjrOnAx+9NcLFORHzy+rR616uUk4Gu0HYNswZjx6SOqg
         TnNK6tfeg19t9QgKaIqLA7l0mGjdxCyfAovzUlsjJAhfpT+xQ8cc9i+0UqsDd8vQuMZE
         6HRxeTOROeqz3BEnEahU5/hJxbZ5S5OFJBwoleCw0qY1t4TxFWGQdWnlhw9eoMvKpbRW
         EveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CQRMAIOvqBs8kZZqo+ZLWXcUVnOj5R3ECqdWM5F4gPE=;
        b=AFYpG7MJO49Am4ANMZ9xUYiVFqH7hjJ6dAprkfYUyMmUzPqy16aMzmW6EIx7BXxiJI
         Wgxz2ZejnREftZuKhnp4M4WO+/GeDavYHfOcmG+Okf7ZJJuMYHkpvAsqBhnnS3fJynlS
         Kr+cLbwImYi41N8ZSLFadEbclEFudkt45/Ds1+UXrsybUJcEBpxAAF8Acq7esafXc1n9
         tep3F6cHDBFBAkdS7tMojrcfC3Tg+vDRAKBNWujOYtz8GvIu4Qrjod0FAaJl1P46/a2g
         ugrDgLl2Lfc2qgdoCk4BJxClsic2T61HcTEYlE6ilJ+XaskgwTkyLkwzuf4hkW9ygnTp
         PEPA==
X-Gm-Message-State: AOAM53107qJZZMOhS6iToMssskYs58Mudchh7/Ml9XXZeTcVvMDUIpSZ
        DB89KfDCimst9mvsPPyzl556edcOZ916RQ==
X-Google-Smtp-Source: ABdhPJyom18/0zK9WNwCYjHt1hZhXoYjht7+1+zYLO36Lcf+Pp+g0TDWQB6G7imCWLO1HjcUlqIyldrEDNyepg==
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a25:ace7:: with SMTP id
 x39mr271843ybd.400.1615331583814; Tue, 09 Mar 2021 15:13:03 -0800 (PST)
Date:   Tue,  9 Mar 2021 23:12:58 +0000
Message-Id: <20210309231259.78050-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v7 0/1] Adding support for IIO SCMI based sensors
From:   Jyoti Bhayana <jbhayana@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com, gurunagarajan@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for ARM SCMI Protocol based IIO Device.

This driver provides support for Accelerometer and Gyroscope sensor using
SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification,
which is available at 

https://developer.arm.com/documentation/den0056/c/

This version of the patch series has been tested using 
version 5.4.21 branch of Android common kernel.

Any feedback welcome,

Thanks,

Jyoti Bhayana

v6 --> v7
- Fixed the error reported by kernel test robot

v5 --> v6
- Fixed the warning by kernel test robot
- Incorporated the feedback comments from v5
- Fixed the bug found in scmi_iio_set_odr_val
  for calculating the multiplier

v4 --> v5
- Dropped the RFC tag
- Added channel ext_info for raw_available
- Incorporated the feedback comments from v4 review of the patch

v3 --> v4
- Incorporated the feedback comments from v3 review of the patch

v2 --> v3
- Incorporated the feedback comments from v2 review of the patch

v1 --> v2
- Incorporated the feedback comments from v1 review of the patch
- Regarding the new ABI for sensor_power,sensor_max_range,
and sensor_resolution, these are some of the sensor attributes
which Android passes to the apps. If there is any other way of getting
those values, please let us know


Jyoti Bhayana (1):
  iio/scmi: Adding support for IIO SCMI Based Sensors

 MAINTAINERS                                |   6 +
 drivers/firmware/arm_scmi/driver.c         |   2 +-
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 683 +++++++++++++++++++++
 7 files changed, 715 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.30.1.766.gb4fecdf3b7-goog

