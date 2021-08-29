Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9023FA9E3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhH2HPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 03:15:23 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39469 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234585AbhH2HPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 03:15:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ECD3F3200708;
        Sun, 29 Aug 2021 03:14:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 29 Aug 2021 03:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4AHjEELaqjFBa5MWN
        mtK5IDvE1oequb+iJmn2xWNJhY=; b=lH5jO1Ee62W4no8GnikedxQCVGXKK5h4R
        OkJpnkmuN1e4doNYMesnX6HBIFyPy92pgMyjiv8aVd7xv4oSF+O6dr76hW8oOQfF
        gg86OuiBPUyEcn339u2IiS9hIhge6mYKj9YCEV9uAU/O4FBD0Snp3lfYeBvVyuW+
        iY7u5J+tdU+o79efZsw9revyLqk+43AqNC9NNfjXdQ5ti4Zrk7c8Zcy8Y/QnNezo
        zpHEAfifWWhiOI8xV8BTNTL94ziu4r4je7XHPzTj9Gk4Zr8lSpakvPyZWiCnm8+E
        03bqqHkfL0Z79IMWeWdZHh+FjLcZZKoqPYid5/vDtra0Zp/qLBLsA==
X-ME-Sender: <xms:1DMrYcbizJbQfpdDvFem0ZhGpqdnYRy14bY18HK95Vx97Jbk-VIFjg>
    <xme:1DMrYXaOeFPNyLOln8GrHjNvy1k9QIViZJUm-wNX3tQNLLXT1bijcds3-IFuL_i_l
    rlzkcoH068a80D-DFE>
X-ME-Received: <xmr:1DMrYW8Ee3rdKolUTXxnEk61KgsJsrXFKw8jZnlQSp7ILcbYZVC_mmHyRmlK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeuke
    egteeigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:1DMrYWoJlEmrNZqabj3xS7AaCvum0DWZcneBkqKRgLa8RvpQ5jVPyw>
    <xmx:1DMrYXoCeSr9DdABQojBbhSmLCOgfdMa8Bn4UMf2l_mtV1vWoUStyw>
    <xmx:1DMrYURGHmMZUkKCjZ0A6J9tJQEyV4mBZj-KOVm51ChbBX-x6C3K5Q>
    <xmx:1TMrYWWwB97-nZe2UhATvwU4hdnnVMM5ZVSjrWPg6TLO7mQ9sDITzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Aug 2021 03:14:25 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v6 0/1] asus-wmi: Add support for custom fan curves
Date:   Sun, 29 Aug 2021 19:14:01 +1200
Message-Id: <20210829071402.576380-1-luke@ljones.dev>
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

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 617 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 617 insertions(+), 2 deletions(-)

--
2.31.1

