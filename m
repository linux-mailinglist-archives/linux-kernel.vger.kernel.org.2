Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C693FB49C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhH3Lcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:32:41 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39001 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236397AbhH3Lck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:32:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id C8D33320098B;
        Mon, 30 Aug 2021 07:31:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Aug 2021 07:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2Oc99NwV8VMrqVgnk
        G+pJCy6NiK7a8xRqXuPfgym40I=; b=Gb8OwSYTLMPIG2lpkixYiYtgukDhCzCog
        iWKT/8Jj+FAiArGp9poC2OXOBHRwqju0xCeoGQowjC64LfZpyAeoeIj2L+XaOL04
        +hf8wTuULMG73kbPIkaOV7+hzlmhiCeX0C0auz7a6YRMGBv+fTPUOXba71eMxaHo
        WPvT6LViapnxBfUWYPVfRsxpT45bE6b2QKKj0iA2RkHI6USgyc7LfiK8ZNeymSG6
        RM5B63F86RX2OTqwy/LlVM8/8W/UAYJDiU9Qnt59INMyrJb7tOos7y5SLSSNzT7R
        GXCrCUNS8kpM8+T8oglxRFm72Z4hBDiKwb3kgZyQc+crnUz362KJw==
X-ME-Sender: <xms:ocEsYZ3XFEAB9Ymy83wTm6mwPOXoMoI4uphppfNq4Kvznm6qhTjdgA>
    <xme:ocEsYQH4SDX8EyId-Ho31UNMf29OuoauvDsKEeTHyS58bVtrzQ7drwFb1nFitVQVo
    mOiym0YcVU5-qYQ3P4>
X-ME-Received: <xmr:ocEsYZ7WLrW3DR7xp-hZIzsj1yxJpT-PnwmcjCHS0ijxJ7wNhsVr7Oj4xNFv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ocEsYW3BTlwUdMMtmaDohpuICcllBDxZiC2JzM0SBQ4ur-hHFa-Ggw>
    <xmx:ocEsYcENECITjUKpML02XVBVRTFHIdyr9WImrhH0SV8NvGKAxQ-O6g>
    <xmx:ocEsYX_dA3reAAFl5ujYW6bhQbQmSDfioqsTafImC_gDmCgd_UgmhA>
    <xmx:osEsYQDUFOs1EV8xh5XdoYJLxskDK_n5AKZ_yzcbW4r1PQA1z_PIGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Aug 2021 07:31:43 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v7 0/1] asus-wmi: Add support for custom fan curves
Date:   Mon, 30 Aug 2021 23:31:36 +1200
Message-Id: <20210830113137.1338683-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for custom fan curves found on some ASUS ROG laptops.

- V1
  + Initial patch work
- V2
  + Don't fail and remove wmi driver if error from
    asus_wmi_evaluate_method_buf() if error is -ENODEV
- V3
  + Store the "default" fan curves
  + Call throttle_thermal_policy_write() if a curve is erased to ensure
    that the factory default for a profile is applied again
- V4
  + Do not apply default curves by default. Testers have found that the
    default curves don't quite match actual no-curve behaviours
  + Add method to enable/disable curves for each profile
- V5
  + Remove an unrequired function left over from previous iterations
  + Ensure default curves are applied if user writes " " to a curve path
  + Rename "active_fan_curve_profiles" to "enabled_fan_curve_profiles" to
    better reflect the behavious of this setting
  + Move throttle_thermal_policy_write_*pu_curves() and rename to
    fan_curve_*pu_write()
  + Merge fan_curve_check_valid() and fan_curve_write()
  + Remove some leftover debug statements
- V6
  + Refactor data structs to store  array or u8 instead of strings.
    This affects the entire patch except the enabled_fan_curves block
  + Use sysfs_match_string in enabled_fan_curve block
  + Add some extra comments to describe things
  + Allow some variation in how fan curve input can be formatted
  + Use SENSOR_DEVICE_ATTR_2_RW() to reduce the amount of lines per
    fan+profile combo drastically
- V7
  + Further refactor to use pwm1_auto_point1_temp + pwm1_auto_point1_pwm
    format, creating two blocks of attributes for CPU and GPU fans
  + Remove storing of defualt curves and method to reset them. The
    factory defaults are still populated in to structs on module load
    so users have a starting point

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 602 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 600 insertions(+), 4 deletions(-)

-- 
2.31.1

