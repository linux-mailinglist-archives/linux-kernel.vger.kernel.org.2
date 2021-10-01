Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3BC41E782
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352147AbhJAGaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 02:30:55 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43666
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352084AbhJAGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 02:30:53 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 76529405FB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 06:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633069744;
        bh=YyJ0fdVjmCzXOoJiRjIyyp/ZqjWN0zD1fovbCCHJr+U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XRkENSfuFYXI5sMhFl8teFJIdWys63K9lBgfQ207w2t04Rtjxnw4+P4zyA76UDBbP
         vniveY3Dfe4smfDeyDl+j42+CiFtilTL0KMZKjkPCA8v/QgOTnzBY3srw1FOczKlr0
         4MzyhHpJmTLFFUZ+cRw1elXDCgdND7NCS9nIU8P9QxS8xrx/GRgkUP7CRR1tcFAuuK
         s3HJIcMqgeGcwAjeJlG1b3sGc1GMUjwVzmi0aUZxBzdA25t4gmlPNLy674KUptzbzn
         D8+i6GJcOh5oqGy8ae7k3D2Dxje+OsCWeKvkDyA9GMepKjl88gFw+Rxe4jVgdvs4UE
         rDfOzy7kl09Og==
Received: by mail-pg1-f198.google.com with SMTP id 15-20020a630d4f000000b00287c5b3f77bso5779023pgn.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyJ0fdVjmCzXOoJiRjIyyp/ZqjWN0zD1fovbCCHJr+U=;
        b=yrJYdLhF020wUjNPT1Itgw/sltEWsRIo38Nb/B+ASjjvw942gGLcGWouI/MMaJFPZb
         fE9+yhYhPUI8HUbgeZQELj1xrlrk7Wu+yCrPicVNAdls+cBTsK93Q2Ue63uu40CliGU+
         BS6jnDk8ndTCyyvbKruzOuMU6w02RSOpHb4cS/LnilD+TBayA0C4kRlWCxdYucI0iM1q
         IgpPXOZWFVQz2eDhRv9Q0lIab9WgK7+Wkw7hgnIAXeJMZ6c+RYvoJOP3dqowE9MlG1lw
         oFPwCDf33TRhvt73nGKbqn6O55BrScFali5R+j43jpfpzXR4Fuxqv9IwqEWZeVdURfg0
         9RzA==
X-Gm-Message-State: AOAM531zkhF3K7VWOnHzSavdjZ6Ub2oX7fCp3HDz1lpRUgZ+daY+s/8k
        fSCmMcPhDmUYC4kmY2G7Cc2IhsAClaypHICk1EF5GJzPMUww9cQnElcNYM6qv3iQU0nRPYoHxtS
        78WqjlivWrOnRqh9ibeYmtKHILm17kf0cCDLZlOsryg==
X-Received: by 2002:a17:90b:1909:: with SMTP id mp9mr4617161pjb.55.1633069742661;
        Thu, 30 Sep 2021 23:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw22K5pK3MVs8uNXMcL4NftP/1Hm0OOcm0nnlcZc5uStWijE4TWaDDvLPPzDw9g93zW0yrxNw==
X-Received: by 2002:a17:90b:1909:: with SMTP id mp9mr4617134pjb.55.1633069742351;
        Thu, 30 Sep 2021 23:29:02 -0700 (PDT)
Received: from localhost.localdomain (111-240-125-184.dynamic-ip.hinet.net. [111.240.125.184])
        by smtp.gmail.com with ESMTPSA id t3sm1461124pfb.100.2021.09.30.23.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:29:02 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     tiwai@suse.com, kailang@realtek.com, hui.wang@canonical.com,
        jhp@endlessos.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] ALSA: hda - Enable headphone mic on Dell Latitude laptops with ALC3254
Date:   Fri,  1 Oct 2021 14:28:56 +0800
Message-Id: <20211001062856.1037901-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headphone mic is not working on Dell Latitude laptops with ALC3254.
The codec vendor id is 0x10ec0295 and share the same pincfg as defined
in ALC295_STANDARD_PINS. So the ALC269_FIXUP_DELL1_MIC_NO_PRESENCE will
be applied per alc269_pin_fixup_tbl[] but actually the headphone mic is
using NID 0x1b instead of 0x1a. The ALC269_FIXUP_DELL4_MIC_NO_PRESENCE
need to be applied instead.

Use ALC269_FIXUP_DELL4_MIC_NO_PRESENCE for particular models before
a generic fixup comes out.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4407f7da57c4..70778aa137cf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8452,6 +8452,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0a30, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a58, "Dell", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a61, "Dell XPS 15 9510", ALC289_FIXUP_DUAL_SPK),
+	SND_PCI_QUIRK(0x1028, 0x0a9d, "Dell Latitude 5430", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0a9e, "Dell Latitude 5430", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.20.1

