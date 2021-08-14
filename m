Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7538F3EC02E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 06:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhHNEO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 00:14:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46727 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhHNEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 00:14:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D0A1D5C012C;
        Sat, 14 Aug 2021 00:14:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 14 Aug 2021 00:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qD9/C4/DTi5elKfbH
        zB+50Zeob4PmdZYE9Kxnev/By0=; b=EdaRg4I96Z2iEVke+BY7F/u36KJa/85rw
        Jl3hipyvNBci7WPX7LQ6RiTm00pOvhnNGpiz6Zf7xEnETFJymQydMqWDVWyAC506
        rXMkBu5Ri6DBZoQvYrzkWZfQ0dYfbdj2aIh8DEFNU1wr1TCPchRkNQ/1L16RJqC2
        YPsQj8O4BXtRqeoj866Q4jgXSiW5A93Ada8gN3yuXQxpXvzxkP5TLpQLs/FCuCHw
        wNYFoUDDmTa3jNFs8sueTLBzMmKI0zNoAYvl9c1tfABx29tLKlhoBZ/HW1NMGnIz
        8jOLvMvikxHmkZR8vTxhJuhYFzz2CwDsLf7y8HKoOTRakaSZWpKeg==
X-ME-Sender: <xms:IkMXYS3Z3qxKn1OzQIopeW9XxP9Km557OD03K4zwViis6-DgHc6Xtg>
    <xme:IkMXYVECc1VJqgO3tkLO5TLJbqhTM7BJER_oByschRbuSSyRwEcvizXuEY8ZDbopI
    fXE8ZfwlGNoS2PwP4E>
X-ME-Received: <xmr:IkMXYa4aGQ60M1iYQvg6T-U1S5pbN8VmudfbTYYQiG56DC7pJ_UV3fPBBhtW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeigdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeukeegte
    eigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:IkMXYT0c9E8yLq0dgqqUKnjfo1ykU8AnUs1YdECwsOmvDQNb33ySBg>
    <xmx:IkMXYVGYzobwnqqz5cI4sicMFg10q33XW3HqvUJNL-qEzNNITKVJsA>
    <xmx:IkMXYc88YiyKOzQ_1KfipWzClD9iT4ZWSBusKi_2fAxlSwnK3D3Myw>
    <xmx:I0MXYaT-u8Bnt872ZUE7XhK6Uc5pKZ2CXMffkf3wy0FuP5RjcB2p6Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Aug 2021 00:14:24 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] asus-wmi: add platform_profile support
Date:   Sat, 14 Aug 2021 16:14:08 +1200
Message-Id: <20210814041409.2128394-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
- Correctly unregister from platform_profile if throttle_thermal_policy
  fails
- Do platform_profile_notify() in both throttle_thermal_policy_store()
  and in throttle_thermal_policy_switch_next()
- Remove unnecessary prep for possible fan-boost modes as this doesn't
  match expected platform_profile behaviour

Luke D. Jones (1):
  asus-wmi: Add support for platform_profile

 drivers/platform/x86/asus-wmi.c | 134 +++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

--
2.31.1

