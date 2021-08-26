Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306F43F9102
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhHZXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:44:01 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49819 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhHZXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:44:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3AE423200947;
        Thu, 26 Aug 2021 19:43:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Aug 2021 19:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fZOcR1E8avVH2/V2C
        3iPXJTHIEC4k7DfXpKxPA2s4BY=; b=MLtMTAB1T4nokmfVq+rTKszD1HK0gBibv
        zVzf2I3R1u7VsZKlDE3KEnDST8cxnSOaKjnE9UrU/2dO1Zjj/PzCf/luHAluS2b5
        7p6l9oDL1vkn9B5RgjD5cNdjMgGj+Da1hZtkEu/CG2wOJ2I+aC8uPFcM8bw8JqOH
        6hR66GNPpgGkQpfIel/yY29rKlgWqgCk4dIwD/t8gfX3LjRPNJ6WTpTUc4DLWp0m
        xPc0dPuc3N7dXZKIfML/ppEJUvY58z95gFdY4+MjoUcSiPsR3bnSX0tLbUome907
        KhVmSeOrJJmhJqlB8qlNFSlydXgHy5l+Yu1bWlSwBr5hWmJJqX9Pg==
X-ME-Sender: <xms:DicoYdAmPJgLQBZrQCwIIvtXiBGAdYQP8A2weFdUbcnZIfhhbLzHfw>
    <xme:DicoYbiCMUwWoMVUKJ8cZxUHXyDaD3O9Pkk0xsQki6PpqIPbeW2_B6vGGtY-DxWQm
    OSrmVfq3-BSrwSl9L4>
X-ME-Received: <xmr:DicoYYlQhvVG9YdcIhjwjPTCmo-cLO-u2yU5hy7SPsas3fS4mPViM5PsGydK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:DicoYXzMuocjk6eZ-s_jdhZYBlUeqjhm1W6InnqftqxONYpInD7iSA>
    <xmx:DicoYSQ91OQ4wno4xS8O0PWmhkgCIJGCXupcJO-_uBCssoRDT6bmcA>
    <xmx:DicoYab8YjO5dA_r-r3v3NRh__acvB-VKDi0ruGfG9eK_STtl_Xu6Q>
    <xmx:DycoYddKVEB2-uqtqkKg0VA4og1bPo3ryDfXTiA0y5ugByhk9cpOeg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 19:43:07 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v5 0/1] asus-wmi: Add support for custom fan curves
Date:   Fri, 27 Aug 2021 11:42:58 +1200
Message-Id: <20210826234259.5980-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for custom fan curves found on some ASUS ROG laptops.

The patch has gone through a few revisions as others tested it and
requested bahaviour changes or reported issues. V4 should be considered
finalised for now and I won't submit a new version until V4 has been
reviewed.

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
  + Remove '\n' causing double-up of '\n\n'

Luke D. Jones (1):
  asus-wmi: Add support for custom fan curves

 drivers/platform/x86/asus-wmi.c            | 618 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 619 insertions(+), 1 deletion(-)

--
2.31.1

