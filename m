Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC33E32D6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhHGC6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:58:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50827 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhHGC6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:58:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 14F2B5C0113;
        Fri,  6 Aug 2021 22:58:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 06 Aug 2021 22:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=njDtMWRM16AJBu880
        tPSeIqZ+blh8ZeYRYFeHbMBJM0=; b=IVi0R4gvN+iAOy0dn4tM5v9C3kak8VyaF
        w56ao26LboMStQYVgPXWWPZ+hsXlC8w/4q8raTVTSMz43Y2s2PQzgUWGe+fn1GS6
        aZYEXLQymZcodMZHB+eMXrdusz10i0nkV0Nl9fhYDS69ZtJbpWVHMhGAqhEpkjIA
        tyeo0fORU7WFsW27vzmhdvOcVDHLrPUHVFI1zN11Psxe66FPAlGBybiqrxB7mUWI
        jEy4OdmY2TU5DqAfpMORYIh6dysuGd91hQmRlLwSRow/2WQ/0WzoGye11KoNGsTS
        stsuApc47+eiPU2LhKG34MI4BFEVQdVowjIyc9waAbElLL6Pp68VA==
X-ME-Sender: <xms:yfYNYVqcj9KlzsqQZ0ATL4fJhTkRwdmFgRAfUoDR-jH05J97HGDFuw>
    <xme:yfYNYXqKjCTPqajHeGbJzWJ21lGteQ_GTxdl7wsmQavIM2FruBOjzbeCoWpoQNuRV
    ipWMMaf5nipF0MQJRo>
X-ME-Received: <xmr:yfYNYSPqGECJIH05WgfbtOpGujvBA-xcr94TZhht7MmP6GQumv1riN96f0SH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedvgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnheplefflefhledthfdtveeugfevueeukeegte
    eigfeihffgjedvtedvueevtdfhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:yfYNYQ6PHiSGqcNg29qUbTEFsDdtGJLxpDyiGg-xm6ukufhwTaREPA>
    <xmx:yfYNYU5BtRaVIWeZsg-ZUi5sgmmL1uZTay5MLIp6TsUCwKQ5Zc-7nw>
    <xmx:yfYNYYh-p9xF6uaYJ5sizlgR623oH7XEV_Ah3vyn5iZ9y_-CshC6tg>
    <xmx:yvYNYZgI_nhKQXBDnybyuDoG4s8-WewFcBP8QCd0wPsZx1XWVohadQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 22:58:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda: Add quirk for ASUS Flow x13
Date:   Sat,  7 Aug 2021 14:58:05 +1200
Message-Id: <20210807025805.27321-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS GV301QH sound appears to work well with the quirk for
ALC294_FIXUP_ASUS_DUAL_SPK.

Signed-off-by: Luke D Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ab5113cccffa..34f007946ad6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8369,6 +8369,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.31.1

