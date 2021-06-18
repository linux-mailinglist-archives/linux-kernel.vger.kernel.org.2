Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8663AC8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhFRK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:28:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:28:37 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1luBhk-0001Qs-01
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 10:26:28 +0000
Received: by mail-pl1-f197.google.com with SMTP id d1-20020a1709027281b0290112c70b86f1so2861149pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=i51N7OFQgUge8M8rgTD9bGoP/nO/lCSHMBC1i1xqXdQ=;
        b=SOQ+k20qm7RgRuOvhv6F7O8H44cHfB3owX9AzjlmXGrf/JmoOCWKcdpcf2nU5/xtWj
         BL+O28Nq4qpXa8CwoDxoYaz+4Xlo299B8bEKmjttPkzaeSZCryQCFywh/+I3ku7Iuy1y
         oaNqTbPcM1LmdvhJybYj4dfATn8qJhCQRvCz08qJBtGXbqZxxK6F90gOVl0Y712Eua6K
         YYvoa7ohEct8YcQiW0GIMkma6+Gf0tcYbRpPJcuycyqJ6TtqlkVFklG+4Lc8VB2JfV7/
         6Tkz0Ha9bqkJqST5HInZccfX+NwNmn11JZDNcEe8bFvbYrE2gC2NVIhWBYMM+lRu9R/0
         bOdA==
X-Gm-Message-State: AOAM5321bfrzTSz1EUHOQsJMV+XhyrhD6juneqYDf7QcB7HvYj9UdKB/
        /+z3g5bzf+2/5yxz89fgs5CTIshfn+jGGwCVMpGG4xHEAtww3rlz6LotcuwJRl8tENCvTEtQ6nC
        dSYGx+gY6qgPBvNKtHgFbwCIiQzufIYPpD7kyn4Bvrg==
X-Received: by 2002:a62:cdc6:0:b029:2ec:8ee0:57bd with SMTP id o189-20020a62cdc60000b02902ec8ee057bdmr4282613pfg.78.1624011986757;
        Fri, 18 Jun 2021 03:26:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP9TP2lIab50kwFisgDvoY1EowBbXFKViPv3/hTx+FKR8CQkqKPpIiMOnEh980wtMb4vCHmw==
X-Received: by 2002:a62:cdc6:0:b029:2ec:8ee0:57bd with SMTP id o189-20020a62cdc60000b02902ec8ee057bdmr4282604pfg.78.1624011986568;
        Fri, 18 Jun 2021 03:26:26 -0700 (PDT)
Received: from [192.168.0.101] (36-224-193-219.dynamic-ip.hinet.net. [36.224.193.219])
        by smtp.gmail.com with ESMTPSA id z6sm4425663pfj.117.2021.06.18.03.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 03:26:26 -0700 (PDT)
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de
From:   Andy Chi <andy.chi@canonical.com>
Subject: [PATCH v3 2/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP
 ProBook 445 G8
Message-ID: <02b15330-be55-1584-55bc-ba680f6b934c@canonical.com>
Date:   Fri, 18 Jun 2021 18:26:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From f6d2556f8f6bcdd2261b48604b8086fb67ae9a03 Mon Sep 17 00:00:00 2001
From: Andy Chi <andy.chi@canonical.com>
Date: Fri, 18 Jun 2021 16:23:06 +0800
Subject: [PATCH v3 2/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 445 G8

The HP ProBook 445 G8 using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 v2 -> v3: no changes.
 v1 -> v2: no changes.

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70bc5b11acfd..a1e62b2de167 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8344,6 +8344,7 @@ static const struct snd_pci_quirk
alc269_fixup_tbl[] = {
     SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC",
ALC285_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook
PC", ALC285_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC",
ALC285_FIXUP_HP_GPIO_LED),
+    SND_PCI_QUIRK(0x103c, 0x8863, "HP ProBook 445 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile
Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
     SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile
Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
     SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile
Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 2.25.1

