Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D050418E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhI0D7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 23:59:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50824
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232539AbhI0D7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 23:59:18 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C3C940760
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632715060;
        bh=5ki9l5OsCpLPnWIggruSBOrmMERubOSdSamcoZTPmKc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pmct9NrXsqWkMGFAYN7xtYVAGT1TdVHkx31s54AZc/mV3iI+TdBodKgPsqfBLCMmJ
         ygLz7qOBpoB6QgvWB/2Oi/fAddx5NUb77qiLQ/xs5ZfmS0WxBMhE4nfdU3gLyKRTTn
         YEpYowPVVPe8oniEs/IDIQANp+zDLyH/8S9k8z66mfHpwZp/NorWejdIqdQDsEN8Ru
         iQXRvXbwesyZMxVbKUHKq/m9BGpim7CRom1ueBjv+jGTmXKQ6r2WLw7kYQ1YFb1LVZ
         8XZvot3ZgltwTlyfnaKIPgqHv1mzStZG1q4A0fhYtNBk7eQIbfXyNtHpbWIZLM0a6r
         HAoQ5hLDnI+Qw==
Received: by mail-oi1-f200.google.com with SMTP id m3-20020aca1e03000000b00268ff33ea91so12420802oic.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 20:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ki9l5OsCpLPnWIggruSBOrmMERubOSdSamcoZTPmKc=;
        b=An/VYu1ZY8pwId1H206B7fK+LDzUd8vSpJebzCSb2jNgZcOHr9YEOMc9pG30omhVZh
         QKZwhzHr2057WWNpY+XbGuMc/zcjNbLITyz2ovF66RSmiwBD8fRtDTrAC/JVYYklN2Bt
         hGusbn6s3HM9Xl3IIUmfmGamLq/koUNXCwbwsoYaUTVzt1+Tpdbp6i1TzhOglDnBjLul
         Ulj95enPi5VpKfV03jYk8+paLrjh2ZNTueshAWyE2Vc8GVVJkV7w+aBNMLK0lNvNfCtt
         J9c0FkO3v17RkJ1cIlN/+GNsGtZAKTzeb2ftcK7ay+MV+/qLvG8dAcgmx1f+NecA2zyY
         /vJg==
X-Gm-Message-State: AOAM533+S6q1HJxfS+5JHzyzeBKF1zeekMdlC04Sx3YL13rQ8ELbwLge
        Txbj4IUvvRNVFEfOLgIVrSkVExOGjgtxoaumWVPGJ91jU6ssEfdTMui95z/ZcxowLsT/2UuqZq1
        3ENmrMii/Qnw4MG2UlqfWVG6ASUCQAMuHtl2mj/9UUXBvthQonIcYnOmWfA==
X-Received: by 2002:aca:2116:: with SMTP id 22mr10293467oiz.146.1632715059310;
        Sun, 26 Sep 2021 20:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrMUNmM2TKBd46aaLEZZWt2k58/o0MikovBLl9uf6633KaCEat4Xun2W/Fdqndrr42e5iGxW/gGEI3Ic2NGM0=
X-Received: by 2002:aca:2116:: with SMTP id 22mr10293455oiz.146.1632715059087;
 Sun, 26 Sep 2021 20:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210926202027.GA588220@bhelgaas> <70a472b8-7a3e-1792-efe4-125584231824@kylinos.cn>
In-Reply-To: <70a472b8-7a3e-1792-efe4-125584231824@kylinos.cn>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 27 Sep 2021 11:57:27 +0800
Message-ID: <CAAd53p6gfx-=x8aagdFUerz8wKKScLYPu+q96Q=g73RC-WXO5g@mail.gmail.com>
Subject: Re: [PATCH] PCI/sysfs: add write attribute for boot_vga
To:     =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:46 AM =E6=9D=8E=E7=9C=9F=E8=83=BD <lizhenneng@ky=
linos.cn> wrote:
>
>
> =E5=9C=A8 2021/9/27 =E4=B8=8A=E5=8D=884:20, Bjorn Helgaas =E5=86=99=E9=81=
=93:
> > On Sun, Sep 26, 2021 at 03:15:39PM +0800, Zhenneng Li wrote:
> >> Add writing attribute for boot_vga sys node,
> >> so we can config default video display
> >> output dynamically when there are two video
> >> cards on a machine.
> >>
> >> Xorg server will determine running on which
> >> video card based on boot_vga node's value.
> > When you repost this, please take a look at the git commit log history
> > and make yours similar.  Specifically, the subject should start with a
> > capital letter, and the body should be rewrapped to fill 75
> > characters.
> >
> > Please contrast this with the existing VGA arbiter.  See
> > Documentation/gpu/vgaarbiter.rst.  It sounds like this may overlap
> > with the VGA arbiter functionality, so this should explain why we need
> > both and how they interact.
>
> "Some "legacy" VGA devices implemented on PCI typically have the same
> hard-decoded addresses as they did on ISA. When multiple PCI devices are
> accessed at same time they need some kind of coordination. ", this is
> the explain of config VGA_ARB, that is to say, some legacy vga devices
> need use the same pci bus address, if user app(such as xorg) want access
> card A, but card A and card B have same bus address,  then VGA
> agaarbiter will determine will card to be accessed.
>
> And xorg will read boot_vga to determine which graphics card is the
> primary graphics output device.
>
> That is the difference about boot_vga and vgaarbiter.

So does kernel select the wrong card for boot VGA?
Or is this a feature that to switch Xorg's graphics renderer?
From what you described, it seems to be the latter one, and I think it
should be implemented in Xorg.

Kai-Heng

>
>
>
> >
> >> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> >> ---
> >>   drivers/pci/pci-sysfs.c | 24 +++++++++++++++++++++++-
> >>   1 file changed, 23 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index 7bbf2673c7f2..a6ba19ce7adb 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -664,7 +664,29 @@ static ssize_t boot_vga_show(struct device *dev, =
struct device_attribute *attr,
> >>                        !!(pdev->resource[PCI_ROM_RESOURCE].flags &
> >>                           IORESOURCE_ROM_SHADOW));
> >>   }
> >> -static DEVICE_ATTR_RO(boot_vga);
> >> +
> >> +static ssize_t boot_vga_store(struct device *dev, struct device_attri=
bute *attr,
> >> +                          const char *buf, size_t count)
> >> +{
> >> +    unsigned long val;
> >> +    struct pci_dev *pdev =3D to_pci_dev(dev);
> >> +    struct pci_dev *vga_dev =3D vga_default_device();
> >> +
> >> +    if (kstrtoul(buf, 0, &val) < 0)
> >> +            return -EINVAL;
> >> +
> >> +    if (val !=3D 1)
> >> +            return -EINVAL;
> >> +
> >> +    if (!capable(CAP_SYS_ADMIN))
> >> +            return -EPERM;
> >> +
> >> +    if (pdev !=3D vga_dev)
> >> +            vga_set_default_device(pdev);
> >> +
> >> +    return count;
> >> +}
> >> +static DEVICE_ATTR_RW(boot_vga);
> >>
> >>   static ssize_t pci_read_config(struct file *filp, struct kobject *ko=
bj,
> >>                             struct bin_attribute *bin_attr, char *buf,
> >> --
> >> 2.25.1
> >>
> >>
> >> No virus found
> >>              Checked by Hillstone Network AntiVirus
