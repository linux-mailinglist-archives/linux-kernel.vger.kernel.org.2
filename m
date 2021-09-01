Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE23FD182
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbhIACwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:52:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40193 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231588AbhIACwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:52:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DEDA5C01A0;
        Tue, 31 Aug 2021 22:51:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Aug 2021 22:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=h6mkqTj0IPa8aXBcl
        zyhfaTXQ0S5i0ciy6PPsLCCCew=; b=X9K7ltETgS0aclxAnkH5nsNbhPi6Pknqf
        ZRV0JOMn3uLdvcIMTtRmwz9gt32hxlNrqgdGlJIfMuQWyD+z+gJpfZ4Ns91Q184c
        dRM8QnJEakRuYunvc6gJoEV55gcooJnuPufJ9CnEVdBPGKDxaZkRBTHtyvC/2ePP
        wsLxUT/5ZdHcdV7GsDTw5jaFf+JwliDfqunLc0Vnt+Y9wBRT6hNdLLbPIkZfx3Fc
        RtopxiKTbj4inEH/ooF74r4fqU6Gzvc+dt5xqOjtbJOAH0LSukp4wob+iG1t6XdZ
        FySfQ9gsU2CQkVnFpUWBybglXoHLntjGwV0EnTf/gR2xQmPjgA20A==
X-ME-Sender: <xms:x-ouYeQhxdJMBaRdqTVI3JumPHCk_19y2-hdJeaKRObfeHMRN6Wzrg>
    <xme:x-ouYTxiiBgveBFiUUOcMd0oJeQAU1ZKPYYRdYjCbImbMNfsKZQKvnKANl0f30-pn
    yKMqDJZKhgdNuWb3XY>
X-ME-Received: <xmr:x-ouYb0TBIkUXiOV1E9X78W7U5U1eJGOwMaxO1OPs3G5S3pU5WOA7rji8pKB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:x-ouYaChl12wK1ErYFdHeEcn7NJpuFS-7AxuMvkyA_qGX8hF7zl5Cg>
    <xmx:x-ouYXhViRBTod-qj74f9wbidVRIUY0F7ZbYWBa4C30y6vq9QIY0qg>
    <xmx:x-ouYWrQych7LvU4aarW6wl5MjYjINnMbVqmkcCEbXMKacRaE9Jx-Q>
    <xmx:yOouYUsZcBVw4eRI-e5HqRb8mLyguZpuHYx3lRDDtJYRHoCIWFuNrw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Aug 2021 22:51:48 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v8 0/1] asus-wmi: Add support for custom fan curves
Date:   Wed,  1 Sep 2021 14:51:40 +1200
Message-Id: <20210901025141.1225029-1-luke@ljones.dev>
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
    but do have a single custom fan curve. Thes machines can't use a 
    throttle_thermal mode change to reset the fans to factory default if
    fan curve is disabled so we need to write their stored default back.
  + Formatting tidy and dev_err() use
  + Extra comments to make certain things (such as above) more clear
  + Give generated hwmon a more descriptive `name asus_custom_fan_curve`

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 494 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 492 insertions(+), 4 deletions(-)

-- 
2.31.1

