Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43944438671
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 05:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJXDjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 23:39:45 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36977 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229794AbhJXDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 23:39:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4E12732009E5;
        Sat, 23 Oct 2021 23:37:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 23 Oct 2021 23:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UpZ6hFmf2yp0T+a37
        6qj6iS3wIRm4Sq94hQJk/2ew1g=; b=kWkV12gk/3SVigzk7APYjhJlrnbbRqBRm
        ocw9LFuhFS3RQ2hvrpRf56dhHZ5tyMOjncJ3f0q14fvg8WiAa2iN1rTJuVrAPY96
        LTsxuDME5mvoM0m0VDhniw2DWlXdBHudvh4ibcK97tXggQgjslyWazuzCnUCiTee
        SwxAZFhgjg0Udlb8bsmn4jyZEY+JH8VNtESM5r0KOU5V+t2mKTkm49cwogvbdnQX
        UFQuSrG0PrW7K+XMG8vUVfo6t3wuqyayb51zRbu5JefZgFT+PDb/8HPl9bS8SHvb
        axtH6DOZCXovMLRBCobcdctN00AcsihmsKXOxkostek9ulVSCNgVg==
X-ME-Sender: <xms:79R0Yascge93xEzZ4UvZJt-InORM64rPHmIHgk9IYoP2Rsf1JxgDrw>
    <xme:79R0YffyVPmUy0aasZd0Nay8uE0_xzjS5EABYevc-kQehrXPjqFPlcTAtIuhBqpWx
    XC62KucsLGdxRHwMWM>
X-ME-Received: <xmr:79R0YVy1iaBTTmhmmJov-d9mMQoHiU7ik5svfQ5fiBCeuXoL7qULs97HqJzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:79R0YVNMRlHRKcslCkwDalytiB1UAxqd4jhaH12QS1G16-G-Id1MvA>
    <xmx:79R0Ya_VSFaX3UNFcWOCKULqv7fVSUEu8T0gSdauxel8l-yTebASlA>
    <xmx:79R0YdXROG3FwqU88dpErOXCM_UVZgP3_qyKNjWhc9QYlaH7-QuhjQ>
    <xmx:8tR0Yebl2EFdDsHfB33bk1QkAug_Ng22xsxWquBUPXMDwKRZloZ8kA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Oct 2021 23:37:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        hadess@hadess.net, pobrn@protonmail.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v15 0/1] asus-wmi: Add support for custom fan curves
Date:   Sun, 24 Oct 2021 16:37:04 +1300
Message-Id: <20211024033705.5595-1-luke@ljones.dev>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for custom fan curves found on some ASUS ROG laptops.

This has been fairly widely tested by the asus-rog community now and
should be in a good state for merging now.

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
- V9
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
- V11
  - Remove fan_curve_verify() as this prevented easily adjusting a fan curve
    and there is no good way to give user feedback on fan-curve validity
    unless checked in userspace
- V12
  - Remove unused old_value as caught by CI
    + Reported-by: kernel test robot <lkp@intel.com>
  - Rebase on upstream master 78e709522d2c012cb0daad2e668506637bffb7c2
- V13
  - Fix the errors related to old_value where I didn't remove the old code
    + Reported-by: kernel test robot <lkp@intel.com>
- V14
  - Fix incorrect logic in fan_curve_get_factory_default()
  - Ensure fan_curve_enable_show() displays correct status for state
- V15
  - Remove unused "default" fan curve store as these are read from the hardware
    when required
  - Use correct `to_sensor_dev_attr` for pwm<N>_enable instead of
    to_sensor_dev_attr_2
  - Don't call fan_curve_attr_2_select 3 times in fan_curve_show()
  - General code quality cleanup
- V16
  - Remove two unrelated changes
  - Refactor the fan_curve_enable_store block
  - Perform match on attribute for fan curves in asus_fan_curve_is_visible
  - Return 0 in asus_wmi_custom_fan_curve_init if no fan curves supported
  - Store fan device ID in fan curve struct, enabling fan_curve_write_data() and
    fan_curve_set_default() to be removed
  - The above fixes an issue where fan curves (user and defaults) were being
    written to each fan when only one was enabled

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 600 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 597 insertions(+), 5 deletions(-)

-- 
2.33.0

