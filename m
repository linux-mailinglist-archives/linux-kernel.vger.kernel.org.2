Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACA40DE93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhIPPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:51:06 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35893 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239127AbhIPPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:50:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id CFC43580E74;
        Thu, 16 Sep 2021 11:49:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 Sep 2021 11:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Zh6CdkZjA6wvOyQTH00eBmRM6e
        sKnexFeXTctqmVuOQ=; b=VWpAcdhx+hyf3OPMJA7S19GJ2l8CSjVgDuRARFWk8l
        Gqd1Lvxj0GKVl4dspizab8JHplN7M6KMJWrIx+ku9/rfLIh1kbCXQNUEkF2IRvht
        CQzex+djiELhnWcUU+1jbgDxVoWaT6nlxBIQMAxURGhzCNolVmbHicjnxXPg3cg6
        VUl3rDhU2ho5HZUn/0jbTP6RVL+OeAdFWJTx0elKu+vk7Dc1/lXsTp3KD4wGAlR4
        WHE0OcmWiL9yLDhtTm23cgvpN4Pg7ViRz54DPTWWwPJbCJ8lq+2/Hpkhnb/+Bruv
        lIoGD6GBshKfTAMTbVi08ywX/BNNeZeOwp3cxK9dFK+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Zh6CdkZjA6wvOyQTH
        00eBmRM6esKnexFeXTctqmVuOQ=; b=wm1MBX4H3YfNHp491Sv7cm+5Vwm4bs7vH
        Eo1HlApGat8OIN2g16QI4bRX9eaTI4ALzTlWEkHRdcUXzaSQH7O0wUx8JRW07dEX
        1gMn1wTz92tIFI6AEuyuoprZns/EydLgNcSiox3ifH0jwm0qLy/x+vXLb+UeRuBF
        324lOGkhj0xmp0/KD3Z7aH86HDOcjKTxEuluS5X4/tCNzSkCt1fOKzzoFvF5cqbA
        8D6Kq71LLOSHHmn5txZNcPBVaAvlJCUN5RoY5CLal2hHxJBqldPdhXJpnBtNYSG2
        O5qnEl+2mwBRo5/3Fb//gq0ZWzLQYfdkI7sbtZfFMPg2QJZjO9uHg==
X-ME-Sender: <xms:imdDYVkIXMDita-9ZdFpItzBQYqXVVInbgUW2tfi7rzs_eR13ntXzg>
    <xme:imdDYQ2gsb55H5dHZYaulKUlluDH_IzCnKBg_fYNoEJKcAPCssu6xV05_kWohBm6W
    5gjDD-sgEQBi21Uypk>
X-ME-Received: <xmr:imdDYboryZDci6vx6rh5ZIZVA4fLigVCK-HiEpzwkOsMI31gRkxPd46GITSYbL0M2bCQzj4Q2RU-hFG524Z_2fqNF4sLB6tZqe3dQOAeCizNtFQdSPKOGuWgo6PD3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:imdDYVkmTEO2xRynJ5xKPRuNo1vLAFRL9q-EFYvLwKTpheq3VVWhaw>
    <xmx:imdDYT0OMNYGmFx-2s55JbOvz-L7GkWhxVpRWZ8HUD_sEJqkd70t5Q>
    <xmx:imdDYUt6Y-aTcIxVnyjiw7cP1Ju-R1e-CIDME4zNVVfUIwSDCDHjpQ>
    <xmx:i2dDYVyPC4xRLF__6lW1dNLjmlSX2g7lErQndSl1l-67YdaFKJs0Mg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Sep 2021 11:49:28 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Apple Mailbox Controller support
Date:   Thu, 16 Sep 2021 17:49:09 +0200
Message-Id: <20210916154911.3168-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of my series which adds support for the mailbox
controllers found on the Apple M1.

v1: https://lore.kernel.org/lkml/20210907145501.69161-1-sven@svenpeter.dev/

Thanks to Jassi, Mark and Alyssa for the initial review. I've addressed
your comments with the following changes:

 - switched to txdone_irq instead of introducing a new mode
 - switched to a threaded interrupt handler for receiving messages
 - added co-processor examples to the device tree binding 
 - reformatted the register defines and clarified multiple comments

Best,

Sven

Sven Peter (2):
  dt-bindings: mailbox: Add Apple mailbox bindings
  mailbox: apple: Add driver for Apple mailboxes

 .../bindings/mailbox/apple,mailbox.yaml       |  84 ++++
 MAINTAINERS                                   |   3 +
 drivers/mailbox/Kconfig                       |  12 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/apple-mailbox.c               | 431 ++++++++++++++++++
 include/linux/apple-mailbox.h                 |  18 +
 6 files changed, 550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h

-- 
2.25.1

