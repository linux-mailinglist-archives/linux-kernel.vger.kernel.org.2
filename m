Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36F3EC083
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 06:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhHNEbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 00:31:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41139 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhHNEbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 00:31:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 94F3F5C00A6;
        Sat, 14 Aug 2021 00:31:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 14 Aug 2021 00:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pu6jlI1VgzGHRQsyE
        znaSiuT28fMKDrVWr0LHoQsgaw=; b=h398o9HnDJ3y2iuD+MlS6iXQ2c+fpvHac
        zm0V4ZCLaH1lqZqK5GIcINbX/pFybvHJ31e1lXm+h6F9Lixn6FgxsvFKI3ZEz6Lr
        YOjO3u31l6Zxc4O0j0CLelQxXS4npFT8IxCf2TZqbj4rUne2YinN+ngjI9lpJKJ8
        K87RAjHkaQbVdGNNMq6SKJSd78zUNwgNua30RkCRS0efUuWgwl55sxx+2lTe3ETt
        zj9pyy21Y9axtchJiefpLYBG19DuJwqjCkC14TR/ziy2xfRbPZwo6Zwf3eH6ooQ+
        bPhhSTSAwGRF54YKLVJXkCM6WnbXo/J1K2O2fxzSg3p8q9I0j931Q==
X-ME-Sender: <xms:EkcXYVZMx3mmokK1aev-Ipm52KBCnb31eTuyf64bDAR7kGexfo0nMA>
    <xme:EkcXYcbgriPoWNJ3BYbZpnWB3HkOO2LY84FMbLNM-lgnCx67tCsiAiGcRfS-yUDbo
    SSU79Bi6-3NgoEvT_s>
X-ME-Received: <xmr:EkcXYX_wTzE13deH4I-5aITGNrvZ6R3s9OPaxUMRL4g_QlEZjJjdffFORCBh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeukeegte
    eigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:EkcXYTrsEu3rksGLSyHdLyU4wdUZ5jaNyQkT9jWxjMODNVCpneLSGg>
    <xmx:EkcXYQp1Bj_B1b_ZBSfJfODew4CX6jIhrhQEJ2SbKBem0Q37cQEJVQ>
    <xmx:EkcXYZRtBbUoAz7SYes3YOD2Oh_cZCnGOm68ZAc9ryZeEDEE6erFlg>
    <xmx:E0cXYX1Zw_8AmF01H4KSgI7AHLkVHV9I8St8-dzPRDvNNVVLyiYXhg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Aug 2021 00:31:11 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/1] asus-wmi: add platform_profile support
Date:   Sat, 14 Aug 2021 16:31:02 +1200
Message-Id: <20210814043103.2535842-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
- V2
  + Correctly unregister from platform_profile if
    throttle_thermal_policy fails
  + Do platform_profile_notify() in both throttle_thermal_policy_store()
    and in throttle_thermal_policy_switch_next()
  + Remove unnecessary prep for possible fan-boost modes as this
    doesn't match expected platform_profile behaviour
- V3
  + Add missing declaration for err in
    throttle_thermal_policy_switch_next

Luke D. Jones (1):
  asus-wmi: Add support for platform_profile

 drivers/platform/x86/asus-wmi.c | 139 +++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 4 deletions(-)

-- 
2.31.1

