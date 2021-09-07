Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE740317C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbhIGXXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:23:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37215 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234094AbhIGXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:23:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B197D5C0161;
        Tue,  7 Sep 2021 19:22:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 Sep 2021 19:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XmGpVA9LgnfvWASko
        9M2evuQcRTH4dUVsKXYvTaXXpA=; b=EJGd3VkbpVsnArhKrOhAAjSfJbFsppVZq
        ZOKotmGLiwf1yIgEyWFpWXkSeOspj+b+2TDxNw2uCe+LzRpS6OGg/uG6NFFQTyla
        ndIbwhqyw/jc0oB/U8+nuIQhGUz/ndFyYmQtwk8ykpi19j0l4W5hniL8Cc1SHJ2E
        +j25xsja6SGbZjvjmym/bsn8ODCL8xcCfx8QRne6J3gj7pbhnAWXCHQ9nrQnCMTc
        AnHYE070eJYpZWdFm1j6zH8Mjjngxeg+yik5qtHtJ3BiM9BYmBcZd4vW0cdhLd0A
        mWQi34ve/GmZ2J8MXYJSLHmpW8ZR+d1eZ912vR8xRUq88atbxdbFw==
X-ME-Sender: <xms:Q_Q3Yc92yQFhBIEjifzv_fbpxuCiFPfh3YmblKiCmTqHjb6ds9qmIw>
    <xme:Q_Q3YUusTxREh3YgFgJk1F-GV3lrUzxH6t6fKSk4fopv9O6j65jhf5d8T0GKenLTU
    h2wlgDHMTGV1YiBf-0>
X-ME-Received: <xmr:Q_Q3YSAWPBG26gAjVMdE8HadSuoWTmzWjacyOuhHxvpW-i4mfigi6iEsvXmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Q_Q3YceX2bxNWiZjIMK-dEpIj20LbroJ8CenOyvV4LM3l2aE2bh3rw>
    <xmx:Q_Q3YRMuuqCrMq9h4XFXHAO0rtwR6ynO1Z70zuZrLDOlpgZLs5MdZg>
    <xmx:Q_Q3YWlMFSmkk5k-nulcf90zAtAxnazfTYuViMYrjNS54TWYRaiI2A>
    <xmx:RPQ3YWqrfM0mxaCrAuxWZ1fYkxELP4Y7caWAZp9pkp-XP6Tr9jbpZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 19:22:39 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, hadess@hadess.net,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v11 0/1] asus-wmi: Add support for custom fan curves
Date:   Wed,  8 Sep 2021 11:22:31 +1200
Message-Id: <20210907232232.5205-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current version is v11, this is to be considered the final patch *unless*
there is something horribly wrong. The patch has been quite heavily
tested now and all the edge-cases found (with the resources available).

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
  + Ensure the same for pwm1_enable_store()
- V10
  - Better handling of conditions in asus_wmi_evaluate_method_buf()
  - Correct a mistaken conversion to percentage for temperature
  - Remove unused function
  - Formating corrections
  - Update or remove various comments
  - Update commit message to better reflect purpose of patch
-V11
  - Remove fan_curve_verify() as this prevented easily adjusting a fan curve
    and there is no good way to give user feedback on fan-curve validity
    unless checked in userspace

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 650 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 644 insertions(+), 8 deletions(-)

--
2.31.1

