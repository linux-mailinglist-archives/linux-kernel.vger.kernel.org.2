Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C325639023F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhEYN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:26:40 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56609 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233254AbhEYNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:25:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E7696580712;
        Tue, 25 May 2021 09:24:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 May 2021 09:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Hm66TN2+4rFj2
        +hvHW2sdkOXUymQe5MbU4IMHCfHuAI=; b=fghqbZjjxyJ77b9oDV6xmd/Cu5Xzx
        zOuj5ZDE7A3L++IKqsBFXrp+RbRagqC5zO3SPA0iwIsy+qAMuFzUhsKCrX5bOw2H
        6B8bV/iV3yq/rc7VxUmarj8CuxCQnQ95wpjVKRFZcAwkavkYhrQCwPnYbAgFnvmg
        MMRqqsP5uXtajgPRcrwnK7UkNdwxtzNg1aZCoQcRUXCX0Al+xAM1a/uqf86WCvW3
        HJuf4bwmR2xkwJrqBxjv7Dy4Z6tRE64PoNT5f98YcVz1eT4HYMEF/8HzCDg/OTzS
        OfeXrg3DdphUqr8ijvDJZuEe8PpAxT4TAUm7OznEWAAF6lWzCTO1kDmng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Hm66TN2+4rFj2+hvHW2sdkOXUymQe5MbU4IMHCfHuAI=; b=OMSHDlqU
        eHcSPgjMwHct8SnnWXxBm8hqPpoFOc01qe9wsU1CLPtn9br8m5h8+d5kQ70TZ8/6
        0Q+Ut4nuCp7Ovt8AQ/ERm/V/Gc+ioD1tsMEyL/WZ/mY4294JusGyYD/34kE5v5Yk
        TGeEB0bpl+CWdNDiy6/8+ZY9qYdrAvatmAyP1LvxoACZynTNaLdjgKZeIhGvAHIF
        Et+CB92zqZUf1V5Ht+We2i5aiJxCJYgfA/iCKVWRWTwaIVPJ54nYo20BcvnAQFW+
        pvmAiWd+RdEoxBMxwsRmpQpX1H9WL1Kv5/c3hJgswvg3nMDTukLfU+NI/2SOYyD1
        wc5Bd8m4eKExgA==
X-ME-Sender: <xms:fPqsYIAIBi1AHfMpeMP_a9lw7hog8Y_d8s5jxHcQopwsU4MqY5jsQA>
    <xme:fPqsYKi6KrWELa47jglk9d6YfoMCMjeWoeq_hYXjn0-RXjb5t6jNH0rzTvuVFu-DQ
    belJs_u42F78LO36lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fPqsYLnBJEGUZccy9pBuTLrE4Dhs6lYaYhIJ2HvQWmNk8tMWYiWObQ>
    <xmx:fPqsYOwdIgywVGf9YNw7d6SMeV2uBgruCRVHj5T9CAPwV62boSkmFQ>
    <xmx:fPqsYNSJPEvcDB7U_Io1pHvuzy1ywPMTMFjfWQh8K0tO_AzqcbdPYw>
    <xmx:fPqsYIln-RYW99UGONrnHxbcERhOWrUJxnBKjyaSXkLQjmxePKoRHQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 09:24:12 -0400 (EDT)
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
Subject: [PATCH v2 06/12] drm/vc4: hdmi: Set HD_CTL_WHOLSMP and HD_CTL_CHALIGN_SET
Date:   Tue, 25 May 2021 15:23:48 +0200
Message-Id: <20210525132354.297468-7-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525132354.297468-1-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dom Cobley <popcornmix@gmail.com>

Symptom is random switching of speakers when using multichannel.

Repeatedly running speakertest -c8 occasionally starts with
channels jumbled. This is fixed with HD_CTL_WHOLSMP.

The other bit looks beneficial and apears harmless in testing so
I'd suggest adding it too.

Documentation says: HD_CTL_WHILSMP_SET
Wait for whole sample. When this bit is set MAI transmit will start
only when there is at least one whole sample available in the fifo.

Documentation says: HD_CTL_CHALIGN_SET
Channel Align When Overflow. This bit is used to realign the audio
channels in case of an overflow.
If this bit is set, after the detection of an overflow, equal
amount of dummy words to the missing words will be written to fifo,
filling up the broken sample and maintaining alignment.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index c27b287d2053..212b5df11d73 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1267,7 +1267,9 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 		HDMI_WRITE(HDMI_MAI_CTL,
 			   VC4_SET_FIELD(vc4_hdmi->audio.channels,
 					 VC4_HD_MAI_CTL_CHNUM) |
-			   VC4_HD_MAI_CTL_ENABLE);
+					 VC4_HD_MAI_CTL_WHOLSMP |
+					 VC4_HD_MAI_CTL_CHALIGN |
+					 VC4_HD_MAI_CTL_ENABLE);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		HDMI_WRITE(HDMI_MAI_CTL,
-- 
2.31.1

