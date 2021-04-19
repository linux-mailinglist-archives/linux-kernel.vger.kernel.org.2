Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BBA363995
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhDSDFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:05:04 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47927 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231921AbhDSDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:04:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 403602393;
        Sun, 18 Apr 2021 23:04:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 18 Apr 2021 23:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PrOcHHFjzXKX2Ja1y
        caapbHixLxJ7oQd8IfTQ5NlARA=; b=CAePTiRRNxkbokWAAOxtUpQdP5l6h+mav
        Ofx1reP35MXo22Cfw/X0lLEYVh5QdcIyPmvvQkWCj1aTJ+rXkFsOtkiSCfuF4afm
        r1mZsGFN8qCbNqf7gFDhCsip8AyTU/UdFjGDJgyH/0+GCzXohDQBw1sLT4SDgXw7
        iP9uejYCxR2YtaH44iHME20FURg/O5geLFOykb1bvqc+eO7E/uifY8PNS+YCvGKP
        sHTHVwN+oQdrf1pfXGqUtmC7g75gGb0xD4o1wFUy1yrQ3cDAiQxtbmIfrDUm837R
        +On0NOKlHXFS/yEKUZXAWu5cni8mC1s+OoPqSaSdNMdoboaas9/Uw==
X-ME-Sender: <xms:PPN8YNToraQIyQHnFtTVFAmxC6swwMMdVKTQyeCtUr3B6dyjAuqtvA>
    <xme:PPN8YGy2oCBPoypb1tTY0GoC-X78XLAiUZ2EjrnaFRSX119gsp0SZ0lNaJbHXoQpe
    OXLi7AwR8gMtqL5bso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefnuhhkvgcuffculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpeffgffhheehkefgtddtiefhudegteekudeihf
    dvudejudeigfdtheeijeetvdejvdenucfkphepudduiedrvdehuddrudelfedrudelieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:PPN8YC0MQxO51LhyO8a7eZKOwDbJCPWU8njfEJMiMmbGb6bnt7lqEA>
    <xmx:PPN8YFAJ3PQhVEFcL6Uo9d0aItoKidj0101AFAZCfZUB38kIhG1lLQ>
    <xmx:PPN8YGibESQL-YQReBlG9Yl5u08u_-hoGA-y8sZluXVJoE46z2uKlw>
    <xmx:PfN8YBUrd9dTG1M1CICPXPn9yZQGOxFY5b7cUQcTbrNLdfD268LFCg>
Received: from fedora.. (unknown [116.251.193.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA9AA1080066;
        Sun, 18 Apr 2021 23:04:24 -0400 (EDT)
From:   Luke D Jones <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, kailang@realtek.com, jhp@endlessos.org,
        kai.heng.feng@canonical.com, hui.wang@canonical.com,
        chenhuacai@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Luke D Jones <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: GA503 use same quirks as GA401
Date:   Mon, 19 Apr 2021 15:04:11 +1200
Message-Id: <20210419030411.28304-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GA503 has almost exactly the same default setup as the GA401
model with the same issues. The GA401 quirks solve all the issues
so we will use the full quirk chain.

Signed-off-by: Luke D Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 290645516313..9a5546df1e6a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8019,6 +8019,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
+	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
-- 
2.31.1

