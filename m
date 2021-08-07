Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4706C3E32C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhHGChe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:37:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45155 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230036AbhHGChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:37:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 310B35C009C;
        Fri,  6 Aug 2021 22:37:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 22:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7b2lHa5GOEjXYljkX
        n4bj4EGutPgcs6R2OrehqWbryg=; b=MZFQvACgboM40bAbI3htJXxITVrpUBHzn
        H6WxzOSZEFvyqiuJ+VMPPjkE3vp0TXp+qQcn+NkBsN5UP1BbkAcgJPb+cYiCrgHv
        uSzqgoSB5DRCDxVrTQRjLMMKKISz/nMHIXRazFRccZkZDHrZKlnqapsz2owicVRN
        Q+P1Xt0fDPvFqBjkPZKijqSXI5ZdF+/wK6rEQzSp39y/S+bOlLBxjN7kH+5mRAJJ
        9qWo2mq0Rr5E8k0xfrMOKBcGGnEh9QDXn6ldL39XSDcRzt4hY+Ao409yhelhpcEw
        cRLNphfhtGStXquDKMjiltUs8xp1WT91en/N1Bg9IBMMZ2xYJCOeg==
X-ME-Sender: <xms:2_ENYSW3tezaI6qxdNQgZq9_F6bNGhzAnMTHWhZKwd5cTu1ym4mY5g>
    <xme:2_ENYelU_D-RVPI8a8RreTEWqb0EZH14VbAqu09De3qQQIMwcSjzGk7RmVfs36YOV
    TVoOHXurhVb7onw3XU>
X-ME-Received: <xmr:2_ENYWbV5T5hQaQc8ZEMs0rvZnS98CsA_ao7e1J1aX0Xy_e8OVvXizduNCgS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeukeegte
    eigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2_ENYZXsgLj13uDR4pZ_WprvFRyc_w6-LsT2HPQqQw0YYFpctAS-Ag>
    <xmx:2_ENYcldEu_94h6betwmFj-iphln_IeDx9MMJERTkSlPppftun8VwA>
    <xmx:2_ENYecgR4-kBqAlPwwj6AVXl2j-Po0NJXoogpIpIsAp7A0H4ngAag>
    <xmx:3PENYWgcpsWv6_egJkFCHSwPu6vetMXpBg0dPpTdsDnW2zwF3tcp_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 22:37:12 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        corentin.chary@gmail.com, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/3] Support for ASUS egpu, dpgu disable, panel overdrive
Date:   Sat,  7 Aug 2021 14:36:53 +1200
Message-Id: <20210807023656.25020-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for some functions that are found on newer
ASUS gaming laptops:

- Panel overdrive: Some laptops can drive the LCD matrix slightly faster
  to eliminate or reduce ghosting artifacts

- dGPU disable: ASUS added a function in ACPI to disable or enable the dGPU
  which removes it from the PCI bus. Presumably this was to help prevent
  Windows apps from using the dGPU when the user didn't want them to but
  because of how it works it also means that when rebooted to Linux the dGPU
  no-longer exits. This patch enables a user to echo 0/1 to a WMI path to
  re-enable it (or disable, but the drivers *must* be unloaded first).

- eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and an optional
  eGPU. This patch enables the user to echo 0/1 to a WMI path to enable or
  disable the eGPU. In ACPI this also appears to remove the dGPU from the
  PCI bus.

All of the above patches have been tested over the course of a few months.
There is a small possibility of user error perhaps, where the user tries to
enable or disable the dGPU/eGPU while drivers are loaded which would cause
a system hang, but it is expected that almost all users would be using the
`asusctl` daemon and dbus methods to manage the above which then eliminates
these issues.

Luke D. Jones (3):
  asus-wmi: Add panel overdrive functionality
  asus-wmi: Add dgpu disable method
  asus-wmi: Add egpu enable method

 drivers/platform/x86/asus-wmi.c            | 289 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   7 +
 2 files changed, 296 insertions(+)

--
2.31.1

