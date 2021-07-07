Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3C3BE5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGGJx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:53:59 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:32887 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231173AbhGGJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:53:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8BDD12B0075D;
        Wed,  7 Jul 2021 05:51:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 07 Jul 2021 05:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm3; bh=X+Nr2nD08pDDAocweScJPsMCDC
        ja4sGjAQHn0pyZ8Uc=; b=RAePxdemKPqWRWt0KrtqnanMdr7TjbOZceJwKmoAcQ
        2ncfGUbQsjI9zQl5t0vXVTyvFsLzDecmX3CQRwuw53S2J2bHZ1VRJ4QzXkh3QtYm
        6/W0EOI7/WiZm3mJrPCF4YU9HMOQM3DByuwrJ4EQ98huXBc1MLWV6dFtHotzYgb3
        fx+XpwJDKhfKDXQxM8oNCRiLQgckz9oXI5eK108S7lFVHZXA//JLrs2jElL6PCZM
        fUn9/rPf+5aRfZvw0PSf+8sUIrUj06qpXKHfCfNccSnSXKDvAesBy3/T+XzjsOg2
        oaQdijXbeZXjYTfahMruuZn3Bkr7t8RHIOLGEXyVFPnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=X+Nr2n
        D08pDDAocweScJPsMCDCja4sGjAQHn0pyZ8Uc=; b=vQYEsPrJyXQ4UzScoxg+I4
        eebNzOOwMnMl8crHdiHMXnOCr/VVFnTjelGqkIwGLeqWJMNDVnXcCN1k9nszrNKM
        JKA6cSh9DZ3ODI/Ym4eV6Ii837qRk2Wk+4ll4mtblZ/RcOu7mY1LykYsvxgKYjbQ
        GemXppIhuOHH8yjM+xKMTnLKMx3C3nh7eyR8F2LChYJSMSezgZCT1IHBWmeUsGm8
        s6QxsnTqwaJTemeW9HlCqB/k/uwmtaUeAw6jL8b2DV9ElDwXtwXTfMW6M4UL9osf
        y1I7GqNF0BPqtu4QVDEoevH48haj+eCrBRoJ2CkZQEqtOhECDaTTe1CWELxj7jfg
        ==
X-ME-Sender: <xms:EnnlYHgHV9KgcAXOIp2VLnmJEF-0m7-TPE4qnUVtayrCbbWBh8J9Zg>
    <xme:EnnlYEAaWvq6sCTymqDU4XzXs5iq3fLtzLmMdTin6mQq9H1JD41dIrYP5FQ7DKkDf
    GoCmoASiPi9SclHzAE>
X-ME-Received: <xmr:EnnlYHEFUzZxEW5gPapTs6QPQgNZ6xBe0FEoHSPuxxXbUNdn7LmVOGGjTEldY-dgUA_2EfCa947zKkxVnoX6wkpWWv_pCBwmp4yU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgtggfgsehtqhertdertdejnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepteeikefgffekgeekledtheduteetjefgkeeuvefhhfetgedugfektdeugeffgfef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgi
    himhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:EnnlYERDTP9S7GnxGIq8d46gYByOxrVYNfZTanB1n4Fn6ak2gu5TTA>
    <xmx:EnnlYEyA225uXks-7XzKwkfW1QVXZdalUxoYtEIFRw9YELaGRmGONg>
    <xmx:EnnlYK6EsBcjO-HoWHpZF3Al7vekLDbfGqyBsFTskOTp0WevuUeqkw>
    <xmx:FXnlYJiEogbySqKy1e0-bwOfJlc4Xi6ALzKE9O68cLMGk2av-aCWVjckMcw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 05:51:14 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH 0/3] drm/vc4: hdmi: Interrupt fixes
Date:   Wed,  7 Jul 2021 11:51:09 +0200
Message-Id: <20210707095112.1469670-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0D
=0D
Those are three fixes for race conditions we currently have in the vc4 HDMI=
=0D
driver with regard to the interrupts handling.=0D
=0D
The first two are fixing an issue where the handler will be removed by devm=
=0D
after the resources it uses have been free'd already.=0D
=0D
The last one is there to deal with an interrupt coming in the window betwee=
n=0D
the end of the driver's bind and the  DRM device registration.=0D
=0D
Let me know what you think,=0D
Maxime=0D
=0D
Maxime Ripard (3):=0D
  drm/vc4: hdmi: Drop devm interrupt handler for CEC interrupts=0D
  drm/vc4: hdmi: Drop devm interrupt handler for hotplug interrupts=0D
  drm/vc4: hdmi: Only call into DRM framework if registered=0D
=0D
 drivers/gpu/drm/vc4/vc4_hdmi.c | 92 +++++++++++++++++++++++-----------=0D
 1 file changed, 62 insertions(+), 30 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D
