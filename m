Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A041FA0F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 08:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJBGX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 02:23:57 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47867 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232082AbhJBGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 02:23:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 76F163200974;
        Sat,  2 Oct 2021 02:22:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 02 Oct 2021 02:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cKmwPnxNcR2hQBOn+
        umhfyImSJ8x6Tid8jvRTvRXQck=; b=XzT0Lfgfbf4tpfEeg+Fhgz3L3qGX7yyX3
        rrGs1gpYGN1OlwjXp+VM81ylgkHaI+EgmY9pWL7qyUEaGxg6tANJDiW+h1X+bywx
        mVR99lcxs7hE1Am3VjiRSjnI0/vYjBY45IzonHsf2dSK4e8xpeXIA/Yq5f2NIlfZ
        sOH1AxzIRqE0RxbF3m7T8bvDGrXMLajLwvlWor8GgdApkzMu46K1pIVEmg8+K8FB
        k7DwiIvZrnVQl2cZd49dQ18vLLQTkUwgvS40WCg+K8UaXAipJbC81v7tBIQcbKAO
        iIP9WjRd6oziH1VAjAR8eJu3/uDVEZfIbOnIOAxrveIHh8qey1N1g==
X-ME-Sender: <xms:kfpXYVsfsuUxMInvQvEbkIKyibQ0hWBrMS3P0VlRU3chl1TiSflCDA>
    <xme:kfpXYec33e7WmiVTTKyBOXJiB_Xnf7cM9k9924CWXPhXyAgYM-x_7aWadV-3ZqXbg
    UBEJ-aEg22YJyIA6BM>
X-ME-Received: <xmr:kfpXYYyvvkZKaN1__2UQAwScMS2phvCpwCLUi72y-_Jb8wxPxw6eFn6OuZoP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeuke
    egteeigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:kfpXYcPy2_Jjr7ugJIKkNkUzALbURPDp8HY3f--8IwdH7O8S9Sjt8A>
    <xmx:kfpXYV9TySV5rJPdss-cijtcTto5CImdWHgglBanzWR7mswu7-UfgA>
    <xmx:kfpXYcV1GrbThzhGCy2px4lAMMCz4071dGwEtyNR9MU7UznlrCotBA>
    <xmx:kvpXYRbJw1c12PnMHszgY6S7G6F_W8_quY5xRMMzzSY_HAHDr1idwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Oct 2021 02:22:05 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, hadess@hadess.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v15 0/1] asus-wmi: Add support for custom fan curves
Date:   Sat,  2 Oct 2021 19:21:56 +1300
Message-Id: <20211002062157.33318-1-luke@ljones.dev>
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
- V15
  - Remove unused "default" fan curve store as these are read from the hardware
    when required
  - Use correct `to_sensor_dev_attr` for pwm<N>_enable instead of
    to_sensor_dev_attr_2
  - Don't call fan_curve_attr_2_select 3 times in fan_curve_show()
  - General code quality cleanup

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 614 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 608 insertions(+), 8 deletions(-)

-- 
2.32.0

