Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9873AC7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFRJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:49:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49801 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhFRJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:49:50 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1luB6C-0005rg-Ud
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 09:47:40 +0000
Received: by mail-pj1-f69.google.com with SMTP id gp23-20020a17090adf17b029016f3623a819so3188977pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=USuKvuil11nrB9Z4+xl7NbrE0IqPqqNfEPXFaP8ZsFM=;
        b=MDq6IwsLJuSxfbk5kESc0qCFUP0QswS5fov3dKvSVb+nbd+a3gUz97xVJZ28KWIu+7
         M2fSVM4HmigJk2ypsRZdhOdf2RJHyj/oTH7IkneR+t6Tl357UIOH1chuwZuiARgs0OoY
         WQh03D85qo0IiqmRDkleSLZZnFbi6C1kE3+YqWDWddHqwPkeku5E8t1BD7VbscvIiXmp
         vj4cbjk5OUwOAnt7OcCRqPGtGabLE0k2/zgBXfdzpiBtG7S6Sk9TDLMnuPVASQhImGDI
         uTAXG0FGj71QOzzUGqksWMFtaVhJq4WFJNxknESf78pjLetcNOCfz9G/30HwfK2mZFp/
         UP3g==
X-Gm-Message-State: AOAM531mWRyWm/hoKqEWAVZ/e+g2fO9zQE6Q9ofckE9gYAFAKDcgigKA
        bAD3A3qrnJxVqF/m0HLBI8J7xqZx2G5VbzvC1T+FQAmJuGPWAIxS3k48UegEDV7nM6Dl44zLn6q
        o4iRjRUAJn50yqQ4paRSCpxA0S7veJfafdC5lAOLsUA==
X-Received: by 2002:a17:90a:5511:: with SMTP id b17mr21343750pji.121.1624009659703;
        Fri, 18 Jun 2021 02:47:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaVe1n6xD1nnBjU9sdmtLxXfcu0BEKi7dgHi8+dNchto/0omPNzTYbrCzcVflAVcst4l65gg==
X-Received: by 2002:a17:90a:5511:: with SMTP id b17mr21343731pji.121.1624009659445;
        Fri, 18 Jun 2021 02:47:39 -0700 (PDT)
Received: from [192.168.0.101] (36-224-193-219.dynamic-ip.hinet.net. [36.224.193.219])
        by smtp.gmail.com with ESMTPSA id g13sm7202339pfv.65.2021.06.18.02.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 02:47:38 -0700 (PDT)
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de
From:   Andy Chi <andy.chi@canonical.com>
Subject: [PATCH v2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
 450 G8
Message-ID: <0d0420f6-ff0f-2f7b-e50f-1fa09f39b175@canonical.com>
Date:   Fri, 18 Jun 2021 17:47:36 +0800
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
Subject: [PATCH v2] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook
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
+    SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC",
ALC236_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
     SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 2.25.1

