Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFE3D5219
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGZDVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhGZDVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:21:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B1C061764
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:02:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so8562737wrx.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OAGvUT/kXC9dCKrJ4XapF6slBWwOhbYOVHaafdEp/tM=;
        b=v8JDrOVUtls1FoQTqc5CyiVAhbR19hifbzmcSfXSY24Icy+D9698bnVhJhDfHkxjNi
         LfRpjpBYpGWkPp7C9T9kH69jAPAQmo0c2FI34+uX4zmEmdKWzhnJaw/IweVbo3dgfYuY
         JmsNCdkyE7oI9BKSpOOjTb+AG6yrYaZPI1bMvU9i5x1jfs6RotFuwzXm/dxbDAW91vGA
         9E70nZRb4TSoTh3T0VB4ZEDydE9Wu5CO+sdbAidSYrtwSVPsNz6tktLs7T7/wD/SW9GU
         JRL/ZzyKepS2seIe7kkSWoPkvov053pL3s5LRNrpKkhx8gf+wqv8KRbXesxuKvBfL9aJ
         00kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OAGvUT/kXC9dCKrJ4XapF6slBWwOhbYOVHaafdEp/tM=;
        b=YE33S+PYSA+P8dpP3yASqLfTCgNgNl4IeVeyid+2d9101cN3qZWWGOSqe7zn94iiS4
         fLRzVTjUSrtS7gbGckm+kMVqcwOUW3aczMbPxg0H5boccy+Pcr/oHhhO3Oe9ySzaDQx7
         C/GA2iKGDAcIFWoDN8RUvNttKUhpXDtnY6BzmO7sSgrDFGAOBjDvftI6PNBNeVXaR2HQ
         NuKm7sv6KaMEM3sWWxoLJuZi6l6A6v7CIH1onEsw58VpLQlNR5DnBaAKmSek5FZj9lxu
         MNgY14YUr4q1nyX5AEBqwtcug9co+5koqETiCdzxVHsd9H0llQ26HWUWTURNYXizlucp
         YCCg==
X-Gm-Message-State: AOAM5302kJldrooe6Ck0xAiJuPUrmBhzyalT8ho+hTdMSlr5Trhrl6Fv
        yGEYKKowmszL29Ag+iJmGmKF21kXvU1NM0+mmfmOHA==
X-Google-Smtp-Source: ABdhPJw585+OF8XW1vFb2TNPoadvCSK7Bd8Kiiz38Ij6LI7300i0MvGlTkFPqXcpU1JbUgbu9sw23VkptVhzXERcccs=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr3985900wrn.262.1627272131775;
 Sun, 25 Jul 2021 21:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <57AE120A-78AE-4990-8D7F-BA8D8077B610@holtmann.org> <CAJQfnxFzj9m43wntnb2gvXkJS6B5+aQGsu7v6hc4H4ktAopk7g@mail.gmail.com>
 <A2D33DB0-40DD-4F14-BFB9-9FB34DB003A8@holtmann.org>
In-Reply-To: <A2D33DB0-40DD-4F14-BFB9-9FB34DB003A8@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 26 Jul 2021 12:02:00 +0800
Message-ID: <CAJQfnxFikFjkGn6_+n=ycH4byzTMWY51C=+VJOycg_ZXmg=qqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Fri, 23 Jul 2021 at 20:17, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>> Some RTL chips resets the FW on suspend, so wakeup is disabled on
> >>> those chips. This patch introduces this WAKEUP_DISABLE flag so that
> >>> chips that doesn't reset FW on suspend can leave the flag unset and
> >>> is allowed to wake the host.
> >>>
> >>> This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
> >>> allowing it to wake the host, and preventing reprobing on resume.
> >>>
> >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >>> Reviewed-by: Hilda Wu <hildawu@realtek.com>
> >>>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> * Remove unnecessary variable
> >>>
> >>> drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++----------=
-
> >>> 1 file changed, 59 insertions(+), 24 deletions(-)
> >>
> >> so the set does not apply cleanly to bluetooth-next
> >>
> >> Applying: Bluetooth: hci_h5: Add runtime suspend
> >> error: patch failed: drivers/bluetooth/hci_h5.c:11
> >> error: drivers/bluetooth/hci_h5.c: patch does not apply
> >
> > Hmm, it applies cleanly for me. Not sure what's going on.
> > Anyway I rebased and made a little change as v3, please take a look!
>
> the v3 applied cleanly.
>
> >>
> >>
> >> And I am really close to not accepting any patches for hci_h5.c anymor=
e. This thing turns into crazy hacking and nobody is taking my hint to redo=
 this as clean H:5 3-Wire serdev standalone driver.
> >
> > Pardon my unfamiliarity, but could you share more about your vision of
> > a clean h5 driver? Should the RTL component be moved out to btrtl?
> > Do we have something as a reference?
>
> so a while back I send a bt3wire.c sample driver around. That would be a =
good starting point.
>
> Anyhow, the problem is that hci_uart.ko is inherent a line discipline dri=
ver from 2.4.x kernel days and it has been stacked and hacked on top of it.=
 It has become a burden, especially in the light that you can have clean se=
rdev based drivers now (like btmtkuart.c).
>
> And yes, it would be following the 3-Wire H:5 spec and then deal with ven=
dor specific details like btusb.c for example. And my hope would be that es=
pecially in the Realtek and Broadcom (RPi3 etc.) cases this can move into v=
endor specific blocks and shared between USB and UART transports.
>
> I also send around a btuart.c sample driver that is solely serdev based a=
nd should replace all the cases where we have H:4 as transport.
>

Thanks for the pointers!

The files you mentioned are rather hard to find, so below I paste the
URL where I found them in case anyone else is also interested.

[RFC v2] Bluetooth: Add new serdev based driver for UART attached controlle=
rs
https://www.spinics.net/lists/linux-bluetooth/msg74918.html

[RFC] Bluetooth: Add new serdev based driver for 3-Wire attached controller=
s
https://www.spinics.net/lists/linux-bluetooth/msg74839.html

Thanks,
Archie
