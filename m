Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A94009C4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 06:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhIDEeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 00:34:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44505 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhIDEeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 00:34:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A15025C012A;
        Sat,  4 Sep 2021 00:33:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 04 Sep 2021 00:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9iAbThow1Wwu2D1Ny
        fnXM3mTHai62Au0exxAVgOwOz4=; b=j+0KAzO2z88O6MkJdom724C/wIjm/zrSA
        dmUp3sWmFEVFHrk7+C4VughixRhdXyHa8oltnFoKGMBJga5OAH2QJ1xhJJ5aBaRb
        6DZzI/TUizufa2Jan+Qitod2uIlKS7e5PsZXSieVFCbzPlqTEKd1cHSrhCpBgEoo
        cX4saqAXolEJiccG2zhiFzAFZq4u4mTwSxMhHp+6W2hcXPINAcOwVPD51PU6BQsw
        +jG1a8+yKKWvHKKNWy7h3tkOgRtnlEaneetlks/g/kyweYHk4Ij+KuIQde49/yxC
        2V34HyuHmvPLTojRsNXp6LogAoWkbosLLPxboM8k83s0NsksgH25w==
X-ME-Sender: <xms:APcyYTUbXBvykpPMV7B-mTCgc2XLbpl2HZ7PGtS1jAgnsY3rjTKvMA>
    <xme:APcyYblPe7nOrdOFXvfM_p_GJO9XDqtbJ-a4UHSrYwVl0EcIHWEs0NMBmtzqRnxLS
    DtPe8b0XdAH5CI_WyQ>
X-ME-Received: <xmr:APcyYfZ_DafMqFXxNUG_SXlV_ZBWS1JBuYTyVKiomM3i8WxRYhMMK0T8FAF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvkedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:APcyYeXrYdEI8sKsA4QQjQB_bYIm9rVpXeaHV-sRkrTaguvtN_Xstg>
    <xmx:APcyYdnyAGphEo3ldArWXw8wxMBN4A-L5ewDkPYz3Cdz1BvxnrZYnw>
    <xmx:APcyYbf4iIua_L32EUtOillYsX6FYT52HiCYJ6a8G3XGjucKR_pkOw>
    <xmx:APcyYWDNX5dBZysC0gDnlIb-LgvZGbDPbA82wiV2fbIvzlqeRUnAlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Sep 2021 00:33:00 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, hadess@hadess.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v9 0/1] asus-wmi: Add support for custom fan curves
Date:   Sat,  4 Sep 2021 16:32:49 +1200
Message-Id: <20210904043250.134260-1-luke@ljones.dev>
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
- V8
  + Make asus_wmi_evaluate_method_buf() safe
  + Take in to account machines that do not have throttle_thermal_policy
    but do have a single custom fan curve. These machines can't use a 
    throttle_thermal mode change to reset the fans to factory default if
    fan curve is disabled so we need to write their stored default back.
    In some cases this is also needed due to mistakes in ASUS ACPI tables.
  + Formatting tidy and dev_err() use
  + Extra comments to make certain things (such as above) more clear
  + Give generated hwmon a more descriptive `name asus_custom_fan_curve`
-V9
  + Cleanup and remove per-profile setting
  + Call `asus_fan_set_auto()` if method supported to ensure fan state is
    reset on these models
  + Add extra case (3) to related `pwm<N>_enable`s for fan curves to reset
    the used curve to factory default
  + Related to the above is that if throttle_thermal_policy is supported
    then the fetched factory default curve is correct for the current
    throttle_thermal_policy_mode
  + Ensure that if throttle_thermal_policy_mode is changed then fan_curve
    is set to disabled.
  + Ensure the same for pwm1_enable_store() and 

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 618 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 616 insertions(+), 4 deletions(-)

-- 
2.31.1

