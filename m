Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCA410636
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhIRMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:11:47 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41769 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239660AbhIRMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6107580A5C;
        Sat, 18 Sep 2021 08:09:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 18 Sep 2021 08:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=aYT97P9LX1/CrOxaSoudeK3fXw
        xxiS4F831wyG9oDcg=; b=qfepKXpnbljIPlZEaeDOO1oub/6zE2OeU6V5EeoUHs
        dGjLDRl5hdXKw+DHJOC84gKwgtOIT4eZFRoAWHrSBqUWnoD788TFSFI9+GMVXXRj
        IPdMlfAcp/1bTAdXXVejIBNtvlnZrf/Pbviwz9Pc3XY2IBeclNIJE91AxhZKAtTH
        VAl3xm0sI3LtZ94U0lpLdrtv3WTN/vwGVdmKcNoeyLTEnNavKSs7nC2PqSjj6RI0
        8ajNG7aPeg3wTAZL6dUwDkCBX0oRFJSVBx7AvmZj0Nem50NWIzBqIG3fsjikq++E
        O6nHcJVEdREwgQZkxNdE1ACjAi8qtov6B9Fhy6hdvJnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aYT97P9LX1/CrOxaS
        oudeK3fXwxxiS4F831wyG9oDcg=; b=Yvqqrtk683JVs0pDMN8n4w9lyDfWleWwR
        9H927kU4wGiPbV56C5deKyvCN5j2agE1fKRzW3KIISpsDhvmvBQHG8E1MnBukLAq
        YW/1HS1EE+eo29Zn8gv2PM53yCeBYyuWSD3bc7GbgZ88iTgGIK7V+427i7t20DR2
        VO+T086GAbcayTdltx5irqG/4caUhOy3lOtZ1Fv6NTF9JsFVvQq3M1m2l7W8EgTJ
        7reWy4tSWCpr3C99zvCeIdZ60zNj/Iy3XBNbONDDQDPbobdRGU7ZKVz7zbwFeNME
        2qzuVZ/HwqWOnRgdtyznh8bzgnptLH/sR9fHf2CjOLsKktae9xhNg==
X-ME-Sender: <xms:DtdFYWSOKJru_pdbz_AQnwJTPFvIn1zLCSaiOLXOfvag5Qyw7bnNMQ>
    <xme:DtdFYbyUWFeM1-6blXu_ldYrZV0JAFCWbDxvN9-U_LWbrua__M3n5_6-JKSSX1uTu
    1EeVKqwPOt7MsHuDMw>
X-ME-Received: <xmr:DtdFYT2UCOOa_ZJkOfw-2EneUc-EnCsWUkLXycD0rPaB-EzOZ6HLW7sgnTDU3kQvi2BPhhfRaoD0YldgOFENnquTlc04godSeMHjeMiT8sA3N8iCiBIYPag4jBDeng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    ephfejvdduiedttddtjeevffekuddtjedviedtkeehleeuudduveeiffdttddtvddtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:DtdFYSBY9TIu0v_RTGnFAybiXKlQaPNBhyxGk5m-UE-OFChU94Hbcg>
    <xmx:DtdFYfgJZ1mbcZehrXppvEWhVIN4TA09uXh84opf2dhxmKC5e6Vsbg>
    <xmx:DtdFYeqqWmUwe3HoDXkYs-f9RAr22tBZANWnbx3Bm0W9rAA4UJUdzA>
    <xmx:D9dFYSpM-eGcG95zJd0BpqopT1mrVLG6wKe5wouHr68hi3FztznRmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:09:48 -0400 (EDT)
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
Subject: [RFT PATCH 0/9] usb: typec: tipd: Add Apple M1 support
Date:   Sat, 18 Sep 2021 14:09:25 +0200
Message-Id: <20210918120934.28252-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds initial support for the Apple CD3217/3218 chip which is also
known as Apple ACE1/2. These chips are used on Apple M1 machines.
They are based on the TI TPS6598x chips with a few differences:

	- The interrupt numbers have been changed
	- The secondary i2c bus and its interrupt controller are connected to the
	  system management controller and must not be disturbed
	- The chip comes up in a low power state and must be booted using the
	  "SPSS" (System Power State Switch maybe) command which is not
	  documented in the TI manual
	- The interrupt mask must be set up explicitely

The first patches prepare for adding support and introduce almost no
functional changes to the driver. Only the interrupt mask is set up for
those as well since I think that makes sense either way.
Then the last patches enable the different behavior required for the Apple
chip selected by a new compatible in the device tree.

I'm only able to test this on my M1 and would appreciate if someone could
confirm this does not break the regular TPS chips. I'm also interested to
see if the normal chips also support the "SPSS" command.

Testing this on the M1 additionaly requires a pinctrl/gpio and a i2c driver
which are not ready to be submitted upstream yet. I've collected the current
work-in-progress state in a branch at [1] though if anyone wants to give
those a try.


Best,


Sven


[1] https://github.com/AsahiLinux/linux/tree/sven/i2c-tipd-WIP

Sven Peter (9):
  dt-bindings: usb: tps6598x: Add Apple CD321x compatible
  usb: typec: tipd: Prepare supporting different variants
  usb: typec: tipd: Allow irq controller selection
  usb: typec: tipd: Add short-circuit for no irqs
  usb: typec: tipd: Allow to configure irq bits
  usb: typec: tipd: Setup IntMask explicitly
  usb: typec: tipd: Add support for apple,cd321x
  usb: typec: tipd: Switch power state to S0 for Apple variant
  usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |   4 +
 drivers/usb/typec/tipd/core.c                 | 140 ++++++++++++++++--
 drivers/usb/typec/tipd/tps6598x.h             |  12 ++
 drivers/usb/typec/tipd/trace.h                |  27 ++++
 4 files changed, 168 insertions(+), 15 deletions(-)

-- 
2.25.1

