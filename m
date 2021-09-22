Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D656A415452
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhIVX7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:59:17 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36883 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230412AbhIVX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:59:16 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 8C8403201D03;
        Wed, 22 Sep 2021 19:57:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Sep 2021 19:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0UXP2XdhUtEGTT7ey
        4x9ig+OphRDducXHmpZVLIm6EE=; b=vJLrwQD0nSyJJhwN80TpcB+Lx10aP4Tcq
        Nv9ZIn+21qCfiWzLKPYRk1AtewBdBnr3nDN9T8bAiNNU4F3kojApCPlLL8lDnc0a
        fs6fL6gWxmocaSJn7PIUlCYOiV1PQHzaKSf0vIHD88v34sFjYA/cGjkoA5nobGgB
        RlQyJkc0/8vArgHRj00/Q8EizM2nSOPHNhI4bg9h3zcvJnEaGDeLMxC/3rTgruJQ
        5eWn7wxmuG0bbGiniGwCR3K1MbPua2RKK1OwqbSzRqyUrAKF1Br8Futa0uRKbpnJ
        ch6b5TNcHpz8xKVd43YY+KpvIKMQYCPCfc9YSBoeEo1uQ/64K6F8A==
X-ME-Sender: <xms:9cJLYXTSg5mxH_6Srin9JFoQ6NdUJq2ZNsWl91ze24kjjscDyvb3UA>
    <xme:9cJLYYzvGq-VQzCUqIA2mjOq2RTmhwpqGMnbanVAqXRf-nvWdtZm6qR_MTFfYNll4
    C9OU25vH98aBAzCi9c>
X-ME-Received: <xmr:9cJLYc0eIPb6HF8K7lKB5uM51Q9gNxU8mD0dYHbqio-cQNzSyD9G2Qx2kELU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeikedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:9cJLYXC3OBcl-Jy8EcKNxnw9gO2i22i-0DFAcrGb58O5vYRB4Tm65A>
    <xmx:9cJLYQh_eE88pGkex-Qrqm0djfxWo6l2S8uJR1Se-jw8gqdrqncSAg>
    <xmx:9cJLYbritaRZLUfYXPha1hEIBnwbrynQlggL7HPqnKgG_GtjDPw1Ig>
    <xmx:9sJLYZslzmO-SFGNtHRrbBKoPrPRvASK_PNSwCL8VUQCnUZIlTDY_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Sep 2021 19:57:39 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v14 0/1] asus-wmi: Add support for custom fan curves
Date:   Thu, 23 Sep 2021 11:57:33 +1200
Message-Id: <20210922235734.3518541-1-luke@ljones.dev>
X-Mailer: git-send-email 2.32.0
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

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 611 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 605 insertions(+), 8 deletions(-)

-- 
2.32.0

