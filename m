Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173BC3AC767
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFRJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:30:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFRJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:30:44 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1luAni-00047d-RO
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 09:28:34 +0000
Received: by mail-pf1-f198.google.com with SMTP id e17-20020aa798110000b02902f12fffef4eso5418187pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2GptbyilHSJibKkapjpgEo+GB+erd/HF+VFbdT2MZPQ=;
        b=pEZw7WQGD2SKnGIB25Wg651SDH2lIuXzK9gzYYNItvy5exeEZ/WMbTduIpSeI91yiA
         pL3yVebmgud1VTwCMB/1NFZg4est4RQo96CJYGxvmqCAPQT4ERC+qKdN3Jyq19kehWm/
         8o2QqdM2acXoIXr3igWgsLg6DaBa+AtsgVAF9OgTRJehNdJk4SC3qoiFyHkoAQP3pO90
         aHGA7FZ2j7N+vmyeQ1T+1F7dlQ93MG874oFjYBKOQxPjKf5pAhTb/rKuEMQR8KvB7HxE
         yIJnw1LHNjymRYpqN0ua4ZWd4lY+THkBMLUuBUXnpCfDW6d1jIG5WCMPNPU+xcOlqDcw
         iIqw==
X-Gm-Message-State: AOAM5314bPGyPvePQHZN3L9xa4doPcpDj2XN/BMGT79y+vLbF3K8/9QX
        i1Z05kcQeRU7qNXgdhAc7fu0DHzrJHVJBa8ViF8OCYwuVeOQ4jK4FKIHgi2F+FVhtlVhRi3CIG2
        667W3PB/kmu5Mn/ArSXAoOTj1tnYT5TSacETbA4imUg==
X-Received: by 2002:a65:67c8:: with SMTP id b8mr141810pgs.109.1624008513650;
        Fri, 18 Jun 2021 02:28:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXnIVc7lGI0Dljcv1tKbxWJjIbevKkXW7lVWuJgHjr5aEGwcz2xPra6ux+5/PHdNe91AuNMw==
X-Received: by 2002:a65:67c8:: with SMTP id b8mr141797pgs.109.1624008513503;
        Fri, 18 Jun 2021 02:28:33 -0700 (PDT)
Received: from [192.168.0.101] (36-224-193-219.dynamic-ip.hinet.net. [36.224.193.219])
        by smtp.gmail.com with ESMTPSA id y7sm1654573pja.8.2021.06.18.02.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 02:28:32 -0700 (PDT)
Subject: [PATCH 2/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 445 G8
From:   Andy Chi <andy.chi@canonical.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de
References: <7797aabe-83c7-a63c-7749-73dea0e25f54@canonical.com>
Message-ID: <5c5790ba-d21b-20ff-7ded-b92ca597f9a2@canonical.com>
Date:   Fri, 18 Jun 2021 17:28:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7797aabe-83c7-a63c-7749-73dea0e25f54@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From f6d2556f8f6bcdd2261b48604b8086fb67ae9a03 Mon Sep 17 00:00:00 2001
From: Andy Chi <andy.chi@canonical.com>
Date: Fri, 18 Jun 2021 16:23:06 +0800
Subject: [PATCH 2/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 445 G8

The HP ProBook 445 G8 using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
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
-- 
2.25.1

