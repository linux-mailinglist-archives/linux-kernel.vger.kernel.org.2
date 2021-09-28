Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475FA41B353
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbhI1P47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:56:59 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40811 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241514AbhI1P46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:56:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE551580C23;
        Tue, 28 Sep 2021 11:55:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Sep 2021 11:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Y1NfofkeQMpms15HG9J/5g3fXC
        eHBXSK7jIqptB1puk=; b=LdxjyLA5MaFR81GrboLqtJEg2m/YdTRRtZEQQlgyGO
        8qm6HQTRhH1w9egzWPPLPCHczeyO0Pbof7fjAeUM55+kh8ji/d37qCcpD2LLFKte
        pLRP7OrP6POJTH72DpXt7cdw4NqbHFfXINRFRoFQA21HJU+PRwo8qUVTd3C5481h
        PhfI5zlhZSIM9cghiDIQ1hGic4gJ3RTHrv2MF30MV4IyN2Hz6M5/Vipmgd8HXDso
        tw7ywYhryv5d5OiYJSifqZATHqa8SohOIVXoK/iRmtIEqhPakUSOcv9Gdc2+ZQcB
        2v/GGMcneHzGf9dUcWYbUms2ouroJngZqIenRv/IaguA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y1NfofkeQMpms15HG
        9J/5g3fXCeHBXSK7jIqptB1puk=; b=sqjwF3v4I+i4Uv9lr76WJz0jwetf+WEQv
        +mLGp3KEgNfDKy0PAIJdt7rf/uJDH9t5pIcitodH6jTxbpweHuhtEpuAL75dd8OI
        bgaaNe1/o2uNd2qtWcTbJ4r1Bu6IIIkh3dc8LnBBAmAOKIXqhX55P7nbbps2yTlI
        B+FNaAhhqnX6LBwVjQAAx3/rurGZ6Zl96okgTHVImGAAUPfyH4ztJfwPrnK7P0y3
        +8TKPs0d/TudWavX9inz1SGN6IhuZvI8p166bHJ6HMuo6vPjCCPEdr7vTLCvJDBD
        KGcDGkLvPa/Jkx5acrTcse+1BcdP9olWjeJtyrTxttz4hmSSHgpFg==
X-ME-Sender: <xms:5jpTYcCxO4Ukf_E02ob-rLeNEvrXVjnHaJbDuVQUBIgyOGo4aJMZow>
    <xme:5jpTYehKEwFPsW1paw-lC96MqoHI-rcMN4VYDmfIYJeXIhtYOl8JSa1gDU7N99Yuw
    Ju5Gp4gZGlMlu8-nO4>
X-ME-Received: <xmr:5jpTYfmsw_8KZaA9-snSOdSqduFZAs4cCjImURMjVdgW_cT9QZ9k2FvIRR01yYREQS_3hgHHGF-5kt3nJhp4IlPo6F9dYJ88IzvMbWO3PgkTZBy1c6cfWwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:5jpTYSzIJ1zluxu6ETaJXC78WPpTpEnRPwj_qHxue9xfEgq8-Ob2BA>
    <xmx:5jpTYRSHm-cJKMBaC-yGRuOGsVHEEWs6nK2dx5mfDSk-zn303gzbSw>
    <xmx:5jpTYdYX67dy9ytZrbf2dqicBajEqICuH_ImRhtfaa6k5uDCPq-PBQ>
    <xmx:5jpTYRbMbtRqQ6abL6Plxhz2MNP8gd8QfLwd4ER_xvHIag217YrnRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 11:55:16 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v3 0/6] usb: typec: tipd: Add Apple M1 support
Date:   Tue, 28 Sep 2021 17:54:56 +0200
Message-Id: <20210928155502.71372-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v1: https://lore.kernel.org/linux-usb/20210918120934.28252-1-sven@svenpeter.dev/
v2: https://lore.kernel.org/linux-usb/20210923181321.3044-1-sven@svenpeter.dev/ 
Thanks again to Heikki for your review of v2!

This series adds initial support for the Apple CD3217/3218 chip which is also
known as Apple ACE1/2. These chips are used on Apple M1 machines.
They are based on the TI TPS6598x chips with a few differences:

	- The interrupt numbers have been changed
	- The secondary i2c bus and its interrupt controller are connected to the
	  system management controller and must not be disturbed
	- The chip comes up in a low power state and must be booted using the
	  "SPSS" (System Power State Switch maybe) command which is not
	  documented in the TI manual
	- The interrupt mask must be set up explicitly

The only difference to v2 is that now of_device_is_compatible instead of
of_device_get_match_data is used to switch to the CD321x logic as suggested
by Heikki.

Best,

Sven

Sven Peter (6):
  dt-bindings: usb: tps6598x: Add Apple CD321x compatible
  usb: typec: tipd: Split interrupt handler
  usb: typec: tipd: Add short-circuit for no irqs
  usb: typec: tipd: Add support for Apple CD321X
  usb: typec: tipd: Switch CD321X power state to S0
  usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |   4 +
 drivers/usb/typec/tipd/core.c                 | 206 +++++++++++++++---
 drivers/usb/typec/tipd/tps6598x.h             |  12 +
 drivers/usb/typec/tipd/trace.h                |  23 ++
 4 files changed, 209 insertions(+), 36 deletions(-)

-- 
2.25.1

