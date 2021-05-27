Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D33924AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhE0CC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:02:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhE0CCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:02:20 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <jeremy.szu@canonical.com>)
        id 1lm5KI-00008x-Ud
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 02:00:46 +0000
Received: by mail-wm1-f71.google.com with SMTP id b67-20020a1ce4460000b029017517d833b9so1341973wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO/Q7/DwdHgvkIjY5sWiF4+6czPdEPcOWJ8cjVak3Sg=;
        b=k/0hSS3LfpqJZvDyc5p6/kWG+v2wxkLL1mJQxvP07iaMw2pXJW09iD/+eDGTaFJ3Dm
         Smq8JnEttp3cQYyZ3LBIA4dfdhfrkLhVEvoEb/E39+A+hUxD5I5cOJd/mauS+df2K5mF
         sYNfBMgYIDdT0XTJPBM15Xr14smjA7rSeliKHfPQoId97yK7sh4L1j8BH64TEhiYDUzr
         vAiR39YU+w8b+yRtu5okBgyM4D1ZZjNS258GG07bW5iycpeUYTTEKzx2qcvNJ9/jUk0K
         ZK/ppLLy8y8FXAhXTLOOXBHnNTKjVctqNJ6/ir6VES+lvD8L/eCdARVuKJxUmtLhzrqH
         vqTQ==
X-Gm-Message-State: AOAM532E1726JR47LulnTx8scOMef2ZubPVT/7tYne5dlfGFb0NxndEz
        p56Gl4ovLjXE+jPdwM690VcMtZxgMoiC2ukopuiD5MQwVxsBsnhjZxg8oAfQR6BM1VWiVtTDzyq
        3pbMDgUojSZooQ2nHni04tuK5gLl8ASqgiYSMw4yNWpt9FJGtacFd5L5c6w==
X-Received: by 2002:a05:600c:35c3:: with SMTP id r3mr1054043wmq.23.1622080846091;
        Wed, 26 May 2021 19:00:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEvsKjX5vb6v9LJQTnIbKsJVPCMP26VU/hVaoqYsv3G8T765p39uC6V4zYsYwNTnZ7ewtnItkx8x5xAUazLDc=
X-Received: by 2002:a05:600c:35c3:: with SMTP id r3mr1054034wmq.23.1622080845788;
 Wed, 26 May 2021 19:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
In-Reply-To: <20210519170357.58410-1-jeremy.szu@canonical.com>
From:   Jeremy Szu <jeremy.szu@canonical.com>
Date:   Thu, 27 May 2021 10:00:34 +0800
Message-ID: <CAKzWQkyzbUU8FekwX+_pkxSVFv0_1xjOQa7ztJRMR02cunP+tQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855 G8
To:     tiwai@suse.com
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        PeiSen Hou <pshou@realtek.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

Would you please help to review these quirks? Many thanks.


On Thu, May 20, 2021 at 1:04 AM Jeremy Szu <jeremy.szu@canonical.com> wrote:
>
> The HP EliteBook 855 G8 Notebook PC is using ALC285 codec which needs
> ALC285_FIXUP_HP_MUTE_LED fixup to make it works. After applying the
> fixup, the mute/micmute LEDs work good.
>
> Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 552e2cb73291..9d68f591c6bf 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -8291,6 +8291,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
>         SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
>         SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
> +       SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
>         SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
>         SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
>         SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
> --
> 2.31.1
>


-- 
Sincerely,
Jeremy Su
