Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D9407C0D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 08:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhILGh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 02:37:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59105 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhILGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 02:37:26 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 81A425C00AE;
        Sun, 12 Sep 2021 02:36:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Sep 2021 02:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=982ctXFMXGuLURP0R
        WgapXMEE+XhhiYvUuhQCPiWQ74=; b=pR/4/h1yukAx1buTX1XwtFVmpho3ayaPM
        XxzvIXyieTYDe5QsTN1HfYMPV4l1RtEkbLH3CjGprY/qXI8urJhQkh1A2hzvk394
        vLDgEWOQxhm0sdlVxJCMVcotnEU/JMIl26elBtOtCG7hb12KHikk+CaJBnZEpaBD
        89wYvIpc7R4HuLWiy95lU1GIuAFpEhNuqXEeI6joB9Vf3ViZYGa1Z39eCoz6AhuT
        ZceY5RTN9ggeoboEznnS3oRPPjTlpUNT8sLNhBSKcBXq+fG47zDZNWJvcKD383fR
        Qs2CVIQOQhx4Z1DIFU3+H3nUAej7/kn1ng7cWah2Vg4wbxu4BX3bg==
X-ME-Sender: <xms:2589Ydh26G9DNhYdNMTUmzv7FPkE2lAjpn5h-NV4n7ued9QFE2l-5w>
    <xme:2589YSDG1qdstk7FvMYdXKbrKSpMyX1lE3wJN2YTf9hq8ad2nIjO9qWiTIyNVtgMT
    7DbU8kf9eBDm2dDs1c>
X-ME-Received: <xmr:2589YdFzU8l9T3TL_o2dOIwyoxWK0LVX_rsrhrpbkhL106nfh9WkcRWa5AgZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeggedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeuke
    egteeigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:3J89YSSCJfor0bmbsesD1mov7cHkPWMplcsyQOEA4MhCWVffUOfrRw>
    <xmx:3J89YayFWKINPrU7J_ll9yRxqLZy9hucesOKMLIFX6Dw8LjA7Tv4mw>
    <xmx:3J89YY4OQIt3VSGcQlnv_GpvHH_9sTxhcox3kKpmFfJpvPqzgoAV6g>
    <xmx:3J89Ye93eu6krBdJeTYGO1Ni_hmL6nOuIGmH1eSCIvRmK8-g65LSHg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Sep 2021 02:36:08 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v13 0/1] asus-wmi: Add support for custom fan curves
Date:   Sun, 12 Sep 2021 18:35:58 +1200
Message-Id: <20210912063559.14663-1-luke@ljones.dev>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current version is v12, this is to be considered the final patch *unless*
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

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 607 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 601 insertions(+), 8 deletions(-)

-- 
2.32.0

