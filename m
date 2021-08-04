Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315513E0A06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhHDVcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhHDVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:31:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61507C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:31:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u16so4553583ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pvwg0n6zrVFRteh7pLiTbDONpJZxU30uK8EC69rMJMQ=;
        b=nN3nDX6hkgfV+TIHqhzqghwJxobDCOTpZ2e9aPjEtRv4ULsnC6kv9n0RGHeNf193+9
         uVv4aVac5BedXbdiheAFOXuDt9bza2t/K5GJIy1+aCUGLVknwADV+vsZaPpRRAjm8URK
         e0rPE+NeSKNzuktQlTJ+kRehxtGTnDMx4uhTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pvwg0n6zrVFRteh7pLiTbDONpJZxU30uK8EC69rMJMQ=;
        b=bMTd07aMUtywF/zo4Po6Q1eDPaJaklPdCynf61+axkaPl/P7HwwcicPadzInNzjkD2
         iPX6mZoazEB5bHfXWitl7p2kiuak+MG5Wx1wzEZCVh7+LMqOOlbeyjp3wEIH/ey4tGLG
         HMVVmQ+5fdto88MYfEs8IJvwbVYspdetw4XWWdDkQlkpUDEsY58dqdqcT9vks+2pcRRy
         JPxJI9EDrQdkK7TiEGt+awIqUL7Y/aLV/M/37UE6xeKe1JZ0X/toTyvGviMgeBohgpFL
         PpG+TZzBgh2uJ06RxsygNE/DdwOJb/qycF5ov96eIyTGw+OzDq4dICwqk2KydkCi9BPz
         /BDA==
X-Gm-Message-State: AOAM532ywPZ5oJ4FFd2DuoTACIxkFbmIzgIiEUzTFxPZrWOk7S1DBSx8
        IGfcIDXGheeUFXtBZbIBD+43hw==
X-Google-Smtp-Source: ABdhPJwfVXRUcgEfmAqIVz84pHgULxreY3OLXA3rNsM1VAhDdJZpVLwT//2JO/J2YVkx8vSNoolM7g==
X-Received: by 2002:a17:902:dac1:b029:12c:61a8:1f4a with SMTP id q1-20020a170902dac1b029012c61a81f4amr1297118plx.37.1628112704856;
        Wed, 04 Aug 2021 14:31:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1bbb:ae51:b1f4:49bc])
        by smtp.gmail.com with UTF8SMTPSA id a11sm4804548pgj.75.2021.08.04.14.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 14:31:44 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dtor@chromium.org, jwerner@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/1] platform/chrome: Update cros_ec sysfs attribute after sensors are found
Date:   Wed,  4 Aug 2021 14:31:38 -0700
Message-Id: <20210804213139.4139492-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attribute "kb_wake_angle" in /sys/<cros_ec hw path>/chromeos/cros_ec,
used to set at which angle the embedded controller must wake up the
host, is only set when there is at least 2 accelerometers in the
chromebook.

The detection of these sensors is done in cros_ec_sensorhub, driver that
can be probed after the cros_ec_sysfs driver that sets the attribute on
behalf of the chromeos EC class driver.
Therefore, we need to upgrade the sysfs group in the sensorhub probe
routine.

Gwendal Grignou (1):
  platform/chrome: Poke kb_wake_angle attribute visibility when needed

 drivers/platform/chrome/cros_ec_sensorhub.c | 6 +++++-
 drivers/platform/chrome/cros_ec_sysfs.c     | 5 +++--
 include/linux/platform_data/cros_ec_proto.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

