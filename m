Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE431F721
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBSKNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:13:02 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54499 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhBSKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:12:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 67BFE5C0067;
        Fri, 19 Feb 2021 05:12:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Feb 2021 05:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=noauOSqHA0OnOCd+HOhkFdK4W1
        n9NJ/pdqNhatTbfmA=; b=gKHgGNVYWsMPVK95WZk3o730KT2NIRsEwhlDYxRxDN
        U/RmFEE8+2avzuPMIumiLx7ViGsblo4pPtE3lqYW6t86oUyiRKg4a4y9CgGiLv0+
        28k1uivnNQI9OEYdRm1ub393iZBRA8SuoYxW7veoqnd9m4rK5/B5qx+QISLdKwv7
        n/QqckRjOCUAgSnoxhfqJO55mJX6is9xiL/lRJCMEw/hmbCm0Cy27QwhfQGlxTJO
        GVaJaGir9Y4n6PHLlwetJyr8oCQz5Yx9PP5dyV/2EZxz9FzKk6nLH2Au1slmdgfV
        K2PDo5ZX6soIkd4JkemGADyUwVW3iKEX14aGN49ZVHog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=noauOSqHA0OnOCd+H
        OhkFdK4W1n9NJ/pdqNhatTbfmA=; b=G/Bl4wz6dT20ThMe9LphKL0akFtgzIEjh
        RA/iIZidOOQlOF3lP+FUAQ2ChO/hnOlIULDdVY09pV4YXsuf1785qmRs9U2i8zj5
        qgmFJKSGJIKDjh4DAEKZnfwLnl/AHfbGKbrOqviTFAuwGtItzr5OJTrdYKHwhCY1
        XjedAAlAAcIUtyxPb2vTVNQM0/chWwyolLqBruIw+6lNfqsMuTRfoFMyv31GOEPH
        uTJ0snE2j5+UyXmdTqtg5860MDNv/LUzSPrWDmcYlq89RkVbjZCpbDvM4kkCs6z1
        cLfDuKCqeTrvSSO+lKuc1ewSdwOB+eddln4sO/lyRWvbYkpfM9zpw==
X-ME-Sender: <xms:-Y4vYPWPaEIg71BxnbZNWr6KSmoU21qJ8Y96WA0ZlDkWYfcHb9O55A>
    <xme:-Y4vYFix8Lm9BGJZkZWieMv4_f93kX01ks_jPXE6tto2BV2OViIFnFPBRHEljKj7t
    SWuhV5Sm5hML9xYDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhephghilhhlihgrmhcu
    ffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtthgvrh
    hnpeffheeikeeuieelueefueetgeevueegjeeflefhveekhffhvddtvdejudefkeefueen
    ucfkphepudefvddrvdeftddrudelgedrjeefnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:-Y4vYNvTYS88Qwx1HOm4hJ27o63XbCE4Luk16r5JgmR0WNR2x7RaYA>
    <xmx:-Y4vYO5QpZFIjuzFIbUTk7IZ3I2wRXNq-m8CF-LdAqAzpuT2huKyCg>
    <xmx:-Y4vYBO5bm0pjvwSSPTaDKnQGeOZGP5d1E48b2Z4Ka_hUnAolRiMRA>
    <xmx:-o4vYKguykz5o0vVJHsI9FQ1NWap0xmUIjHqe4DVxjzgKWB8Wf21YA>
Received: from vagrant.eduroam-fp.privat (ufr-132-230-194-73.eduroam-nat.uni-freiburg.de [132.230.194.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 61BF9108005F;
        Fri, 19 Feb 2021 05:12:09 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: rtl8192e: ba_param_set union cleanups
Date:   Fri, 19 Feb 2021 10:12:00 +0000
Message-Id: <20210219101206.18036-1-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the checkpatch issues related to the `ba_param_set`
union defined in `rtl8192e/rtl819x_BA.h` (avoid camelcase).

William Durand (6):
  staging: rtl8192e: rename charData to char_data in ba_param_set union
  staging: rtl8192e: rename shortData to short_data in ba_param_set
    union
  staging: rtl8192e: rename BAPolicy to ba_policy in ba_param_set union
  staging: rtl8192e: rename BufferSize to buffer_size in ba_param_set
    union
  staging: rtl8192e: rename AMSDU_Support to amsdu_support in
    ba_param_set union
  staging: rtl8192e: rename TID to tid in ba_param_set union

 drivers/staging/rtl8192e/rtl819x_BA.h     | 12 +++++-----
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 29 +++++++++++------------
 2 files changed, 20 insertions(+), 21 deletions(-)

--
2.30.0

