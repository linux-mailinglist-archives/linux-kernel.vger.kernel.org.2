Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381C83AC8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhFRK0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:26:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51003 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhFRK0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:26:35 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1luBfl-0001BX-8C
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 10:24:25 +0000
Received: by mail-pg1-f198.google.com with SMTP id t28-20020a63461c0000b0290221e90ef795so5694166pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=759SUMUfqmtYBedo4nGFAc0MmuBPt151bJbCzRn83co=;
        b=q5Vc9SDd7movrWYcjIjhdiyy63d3XvLwm1OgkrUlq3rDOVu2WFtwJk6NqyJYnXoOnw
         N4vNC0c3FJSB1+M9/OloObENgm6MhBblhTxDwvB+lmVVP0DhtDUUwdEXphwJLLJ9SGZf
         mtO33PflVHPcy13Lri20zhBPnPF3VYNeZYfl04MMsqYYlLlr73zpAv27tga6hcs68d0/
         vOeaufdukVbp+hV0sdyqMw6ugBxfRgaMf91DP4N6we8uo44sJQ7COArOjooaF1PlROc1
         JVkaNVn9kgO7bZsLtgG/+BikK5/m+ORrD+S2msM7soVpYxEZf236hvprudbyoeSG+P85
         Hovw==
X-Gm-Message-State: AOAM533TkNcfa5ZnIglynmjp2YcP0PeIwzU7GnEXjQzoQrt4SAPecs3P
        PrOX44E4HWsMIOfq4PDh9/aV9Q0b0PRGjPnT9nVBUyXEE3kM0AzEK0qL6kP8S4n6y7jUsArxgMf
        mzSvyJLt30sVL9bcnmk+rRPk3HNAAsyAquqWrfHq3nA==
X-Received: by 2002:a65:48ca:: with SMTP id o10mr9315012pgs.296.1624011863892;
        Fri, 18 Jun 2021 03:24:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTpSV/htT6r/ZqZk45Ir07zo69nWItNQjbvbD9gx8YF7HLHoX6dbabV91DqYgXXGw4/uc9fQ==
X-Received: by 2002:a65:48ca:: with SMTP id o10mr9315000pgs.296.1624011863677;
        Fri, 18 Jun 2021 03:24:23 -0700 (PDT)
Received: from [192.168.0.101] (36-224-193-219.dynamic-ip.hinet.net. [36.224.193.219])
        by smtp.gmail.com with ESMTPSA id t14sm9412182pgm.9.2021.06.18.03.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 03:24:23 -0700 (PDT)
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de
From:   Andy Chi <andy.chi@canonical.com>
Subject: [PATCH v3 1/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP
 ProBook 450 G8
Message-ID: <89f7d50a-7fec-15e0-0196-804198c6c5e7@canonical.com>
Date:   Fri, 18 Jun 2021 18:24:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From fdeab6f32dbdbfd83c9af6efc5a51f91021b6578 Mon Sep 17 00:00:00 2001
From: Andy Chi <andy.chi@canonical.com>
Date: Fri, 18 Jun 2021 16:17:48 +0800
Subject: [PATCH v3 1/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 450 G8

The HP ProBook 450 G8 using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 v2 -> v3: no changes.
 v1 -> v2: fix typo from HP ProBook 440 to HP ProBook 450 G8 (https://lkml.org/lkml/2021/6/18/325)

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ab5113cccffa..70bc5b11acfd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8336,6 +8336,7 @@ static const struct snd_pci_quirk
alc269_fixup_tbl[] = {
               ALC285_FIXUP_HP_GPIO_AMP_INIT),
     SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
+    SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 2.25.1

