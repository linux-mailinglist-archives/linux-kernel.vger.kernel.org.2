Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE4390254
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhEYN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:27:20 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33211 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233240AbhEYN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:26:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A0F0B580729;
        Tue, 25 May 2021 09:24:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 May 2021 09:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=hGHCrNM0M2y01
        6SG38SN0lpQyVWkJTBkFC7xFnRt9z8=; b=MFuEG1Z+Zp0+p7jr0t4fLH5hVzAIk
        aLYaBtymMtqZuzP/TXqshbTg3LpTGpdBvhpS9diIY/dYNJzR9nfDYy6rP1KjrhkA
        sCT4dCPzSa/Gn5XZn6zAw6sbhJHYMefgY2ppc5LtZoimVqKUsfuZzGKHIpWO+rhp
        W4X6YUL3/3bC8OtHjo8kjjRCMbcq87glKwGWRW+TBSQepCFAEylyK6r0kE/J7mEk
        aQubZfrEarAgCi1u3h/9iYM+rrI9WKNp+hhxjTMdXGPOlf4BsQBqSWwbEWrW3M78
        HucjQc3mmtIXYuGJ88Vt0WVFkqV72uOEWdHnosVn1HtqzCS2v1xFd3r2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hGHCrNM0M2y016SG38SN0lpQyVWkJTBkFC7xFnRt9z8=; b=RjuipA83
        vxl71CUaAicSglE6oP505P+gT6EUQKtyErrnVaboQJdKOGtkJAy7TfG8TfI+HL7w
        VSaIaxh6yPVTBw0lgoHmY6R0wovJtUpsqJs8MPSq2UWgh0yqiz+ipeO9xsihNpGP
        Ny1TNEq8JEs/7dwBrieryX5bmt7MrRXlHw3Y/T4+QfD6joVSl+1XmURJWHrpg7f1
        jiOzdrW9daRrCAqG67DfqQMBvlz//n4UWUg6zm+rO08fEUyXhK68vYtyxU2wuKOw
        sWSqYKpCTOGxPzdn4ytTvUDK7EtsuNTesiRi0ayzUqdgb1xCithxiWaK4oGwQSYM
        uRYeRqRw1xQjGg==
X-ME-Sender: <xms:jfqsYC2TzYciIcNKlOhuwg2yG2NMvYCJnZSQGKzi0QMr8tIheWPIIw>
    <xme:jfqsYFE0NIBO5ZJrHr_XZVSn31fW6N-h3Dw5-6vzmFwB6C5jKozR4hI74DtVYHI3p
    IP0P_eetc_9UzeOpKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jfqsYK5kR-0KEPm81XR_K_IGdYeIutKQ8zu0SxO_g9X3Lj-wrd7sJQ>
    <xmx:jfqsYD2eJSVsDSzbI2bK_QSVrPvBVbCTptDOtvyQXd6rRJ87XuHSJw>
    <xmx:jfqsYFHyrp8M4Z5fPRIR48n0oTS5us70osuIXHqeEeM8KOqeh_zAcg>
    <xmx:jvqsYIbSgvJbcQjV7pEbeW48B0w2ZW5Vdvp7jJhNEquYKGAQfU0epQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 09:24:29 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>
Subject: [PATCH v2 12/12] ARM: dts: bcm2711: Tune DMA parameters for HDMI audio
Date:   Tue, 25 May 2021 15:23:54 +0200
Message-Id: <20210525132354.297468-13-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525132354.297468-1-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dom Cobley <popcornmix@gmail.com>

Enable NO_WAIT_RESP, DMA_WIDE_SOURCE, DMA_WIDE_DEST, and bump the DMA
panic and AXI priorities to avoid any DMA transfer error with HBR audio
(8 channel, 192Hz).

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2711.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 720beec54d61..9d1dde973680 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -344,7 +344,7 @@ hdmi0: hdmi@7ef00700 {
 			interrupt-names = "cec-tx", "cec-rx", "cec-low",
 					  "wakeup", "hpd-connected", "hpd-removed";
 			ddc = <&ddc0>;
-			dmas = <&dma 10>;
+			dmas = <&dma (10 | (1 << 27) | (1 << 24)| (15 << 20) | (10 << 16))>;
 			dma-names = "audio-rx";
 			status = "disabled";
 		};
@@ -385,7 +385,7 @@ hdmi1: hdmi@7ef05700 {
 				     <9>, <10>, <11>;
 			interrupt-names = "cec-tx", "cec-rx", "cec-low",
 					  "wakeup", "hpd-connected", "hpd-removed";
-			dmas = <&dma 17>;
+			dmas = <&dma (17 | (1 << 27) | (1 << 24)| (15 << 20) | (10 << 16))>;
 			dma-names = "audio-rx";
 			status = "disabled";
 		};
-- 
2.31.1

