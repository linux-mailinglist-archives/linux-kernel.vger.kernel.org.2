Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F397B4027FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbhIGLqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:46:16 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36209 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229827AbhIGLqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:46:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AC96D5C00FE;
        Tue,  7 Sep 2021 07:45:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Sep 2021 07:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rzp/06KSg17CA95z5
        zuCstXPs2EnExhE7oilBk0+Dfs=; b=Y7RLfJ9veG/UtW4Sd9U8kFDqAlPkVyX3X
        eMNe//wZKs9N5/7gXywgg3VWUgU484EUAiI2xEd4fNmSY9T2zR6rmprE1NPdaRoa
        Dl1C/DdhJLTMRY76yzGo5FYOGN6Vir7jaswLX0zNf7qn6R6uvk6KB5vMrDOdAP3b
        94lUI9iRT53D2/6lJ6/kibUuyjdC3LDAbDyr2vYlSK7gu/wzZFHyI38uYlaV4YLq
        GTMqhT4136An83hqENDBNnFGqxQqUVUMs/454Lhrfyz10xbTsAX43DfMhiZgxMYm
        x83HM/GCOvWwuUDf3kbZJAUkN9J+ruj1Eyf7w5FHDMnHQq5w49Cgg==
X-ME-Sender: <xms:w1A3YUSugx82Em4dGxeLa-tKMjjq07-OhIjJg3iAZAlVIzR-X8QpjA>
    <xme:w1A3YRxnSKDIKS3zWNw-ch7ELMLdLrTGNqgO0otVDPuYp956PiaTOmlqPBkK6x7es
    u4-RS2XZ5aySPZ-u3s>
X-ME-Received: <xmr:w1A3YR1np5joHB0xVg8e0IMgINWQMa0J2XCFZbZTigoRnIZ7uSsFwYp_DXMz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:w1A3YYBhit8zC-FFwlXwJMx026dK-y-e8E66QrCOxXrfB9G8E4lWTQ>
    <xmx:w1A3YdhHyJ8goqiEljJeP_nRJsPGiHvzuj5IKD7v1CNUx2tKwNBiGQ>
    <xmx:w1A3YUpD2QR5x5Abk8Wg06iRoO5nw1kDyvsZ9TFScucpMqgUBq7Okw>
    <xmx:xFA3Yde7LPpWc6zK1BLkbsIC7_PeW5-m-B0-1qUSGaFlSK9zZvkH2A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 07:45:03 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, hadess@hadess.net,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v10 0/1] asus-wmi: Add support for custom fan curves
Date:   Tue,  7 Sep 2021 23:44:55 +1200
Message-Id: <20210907114456.65315-1-luke@ljones.dev>
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
  + Ensure the same for pwm1_enable_store()
- V10
  - Better handling of conditions in asus_wmi_evaluate_method_buf()
  - Correct a mistaken conversion to percentage for temperature
  - Remove unused function
  - Formating corrections
  - Update or remove various comments
  - Update commit message to better reflect purpose of patch

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 652 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 646 insertions(+), 8 deletions(-)

-- 
2.31.1

