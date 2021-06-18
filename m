Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D13AC75E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhFRJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:27:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhFRJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:27:23 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1luAkT-0003qa-F1
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 09:25:13 +0000
Received: by mail-pf1-f197.google.com with SMTP id i13-20020aa78b4d0000b02902ea019ef670so5421044pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=E7KqypH/WQUMF9Du8fxlBjjhwnPAUXJyG3rzSTA+emY=;
        b=Pj/DjlJ+nfhlGwjauZu4GYt7FPmq9sCHh4srt7ZwdcKUjtrQ1NynoTLsI03W4lDPGo
         Ueutq8M+shnkG30+BSuoLLl5gPSMzCau+EON+pSnWOQAC5Uy/6xF68FY8z8LOa00+vkq
         aaZI2yyTWEexW/F2AaGp59nH5+J9RXBv6Z0aLQ94fXo5XeVIo9iLZoCIpKW+I186Zb9j
         r+7MqXL7fZAmwgkf/q6K/URTdqvEqAaj3OzWd9oRDuZn6JdtlWQyxWAYbiJp3q9u4VG5
         RmXWxmq5whSi7dNjhCHBTfrDGhMLxRQFgFjaiyjfHheGHgveWHZUMQM0/xMfTvKrqvPm
         8zQA==
X-Gm-Message-State: AOAM533c6ttvHOg3WDlYzpr7dUaA28TyPwFP+gdGhjQXjEm5jcMr3MsB
        BUmqn2AFn3tJ9PWsrOqaSuW+eRtLANLwiqqagqQhX/tbeRE05TZ7RtPD00CNFtVrWR9GT+Z32hS
        1fS3iV7btGxlSQQfnSMv6qZ6fuNt5s4ISh8nqeUjM4Q==
X-Received: by 2002:a17:902:e04f:b029:eb:66b0:6d08 with SMTP id x15-20020a170902e04fb02900eb66b06d08mr4000875plx.50.1624008312205;
        Fri, 18 Jun 2021 02:25:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBfPjy4mQOWDzzfnsRaE2kmGYfR4rlU94En6udVPlvJdf1w5SSLHY/oatMVmTc+0nXg05gHw==
X-Received: by 2002:a17:902:e04f:b029:eb:66b0:6d08 with SMTP id x15-20020a170902e04fb02900eb66b06d08mr4000863plx.50.1624008311911;
        Fri, 18 Jun 2021 02:25:11 -0700 (PDT)
Received: from [192.168.0.101] (36-224-193-219.dynamic-ip.hinet.net. [36.224.193.219])
        by smtp.gmail.com with ESMTPSA id r19sm7292633pfh.152.2021.06.18.02.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 02:25:11 -0700 (PDT)
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de
From:   Andy Chi <andy.chi@canonical.com>
Subject: [PATCH 1/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 450 G8
Message-ID: <7797aabe-83c7-a63c-7749-73dea0e25f54@canonical.com>
Date:   Fri, 18 Jun 2021 17:25:09 +0800
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
Subject: [PATCH 1/2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 450 G8

The HP ProBook 450 G8 using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
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
+    SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 440 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.25.1

