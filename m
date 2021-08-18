Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7803F0B81
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhHRTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:08:37 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39991 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233345AbhHRTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:08:20 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B60C5C00A8;
        Wed, 18 Aug 2021 15:07:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Aug 2021 15:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eEgrABKc0YaPQCAPJ
        dueUZRUNAq3v/sTJPZXnT1m/8A=; b=rDrfqOtn2Spg4afPEjlWbPnTAadS+9wUI
        mAW1I/xMMUoMif7lG3kadvdKf5jabnjQf/m3ERijq0XCXJDk9pgAzZmr4ceoexvk
        EC5KthnIio1P1QutnDZC6oT+JOTmarJLyt+7qF02m9GJSjzELl8TCuQ/toFvZ4BV
        itHDuntJENPQLHl8Z6eWfwazHMetfzjEr95fP/zGEBwF8J1D+c4e6M6mg3POrDQS
        lMYjMwhKbge3D/dDZ9NHYXY7zIXkaLGSjj3VhzXs+R11BH0FOo65e+chvGwLVInj
        FXGjW5rccld+l4UHKH2CkcJZB7YKYQNRhM4WAe6Yzivm5iMESr7Zw==
X-ME-Sender: <xms:fVodYTsJ3AMhD6v5dUnkV6M9_NQCKXcv5jwWW60STmdDBpgH4ryi7Q>
    <xme:fVodYUcMVUl9w3AFBmEQqKB9Yzpz4g2f28Ry6jDEUpfOcCZ6J7mQ5Eh6bCriyCevb
    BFNSh8asuhvbKKSTwA>
X-ME-Received: <xmr:fVodYWxcEn3U5MU67Y-9j3_p2FZ2uGOjgSCAJTxUFAKfC64cp7iuCGC3J8Go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:fVodYSPOTeAfhpPdqbGIk8NVx7aEnw2q4bWnT-jj74ivgYwNfMLxlA>
    <xmx:fVodYT_72wYr5qd1Bq9O2wPTeZVQ-WrUDtEcssEUYeXsPa5wr6fSRw>
    <xmx:fVodYSUwX1DVLNw-61Fx_SQP_Z49Yj8nhhBaIXlurhdBrIAdZXcGew>
    <xmx:flodYVKRTbHZobAMZt5PkahhefCF7ExTm9UNM8O64UkwHKiYg9batQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 15:07:38 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v5 0/1] asus-wmi: add platform_profile support
Date:   Thu, 19 Aug 2021 07:07:30 +1200
Message-Id: <20210818190731.19170-1-luke@ljones.dev>
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
- V4
  + Update some return codes to use -ENODATA
  + Switch pr_info() to dev_info()
  + Restructure some if/else blocks
  + Add "select ACPI_PLATFORM_PROFILE" to ASUS_WMI kconfig
- V5
  + Remove unrequired include asm-generic/errno.h
  + Collapse if blocks with only one line (remove parens)
  + Remove unrequired throttle_thermal_policy checks
  + Remove leftover comment from previous versions

Luke D. Jones (1):
  asus-wmi: Add support for platform_profile

 drivers/platform/x86/Kconfig    |   1 +
 drivers/platform/x86/asus-wmi.c | 130 +++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 4 deletions(-)

-- 
2.31.1

