Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2A404106
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhIHWcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhIHWcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:32:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CABE460F23;
        Wed,  8 Sep 2021 22:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631140273;
        bh=CEZnMdCaJnqR1gLr3Yht5YBKu/wGwx/F6NVjNDH3qqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ABfCMef81Sh+tKw7PbfptrK/4w9DzKITy06nLfdUmKdpTr7psAsykceCwUbPYQm70
         b64AuBLaPkg6y0JZad1R2xUIGIkgdCkN2dxIqmW6XsbbSS4l06GGFd/1OVMtOZMiTS
         Q5IaU7PqWOlTf6SnEY7IeHt7MoAkwcTeB8EXdaTeRhdQmEJXewOVa4W1Wz+uBGbk1+
         tvjUpDNsAcXfpSRs+HekwnQ2RaUsX0VAA0xG6KKeRjklLSAO+zaJjSEeDhbbegROPX
         rliN2YKc3UBRttKem1Sc+U9pOE17AyFK/F8hRzS0MVzNKUuA0XPXuhYtcE6V3LS8j1
         Y+yvh37GMWQIg==
Received: by mail-ed1-f49.google.com with SMTP id s25so5093104edw.0;
        Wed, 08 Sep 2021 15:31:13 -0700 (PDT)
X-Gm-Message-State: AOAM533Y0IFEFj6Jxn67OKFCqcOJAKoqfh+5Gfsbmd1avhGGYFArbY6u
        bExyHMqTHDwby/o2w/U1NmZXMMHitYTJzMVdag==
X-Google-Smtp-Source: ABdhPJx0UCjjskaqV1A5cfxvMrUdRuzgUcj94Xm4J1nuDTk7RXMpw22lOl8EgUrxXZKtaFANPXHgdtHPKaF0Vg77wkk=
X-Received: by 2002:aa7:d645:: with SMTP id v5mr552075edr.145.1631140272407;
 Wed, 08 Sep 2021 15:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de> <CAGETcx9eFg7jR=ibBLhU3q+VnpqJXQCVmQcEyMpozddRiCXFLQ@mail.gmail.com>
 <97044cb9-b7a9-d8af-93e7-d33a81a1cfe2@web.de> <CAGETcx9NpKou1jOEksX4tayRuEVYcy-T4H6QhQU-AUz3Zg1NaQ@mail.gmail.com>
In-Reply-To: <CAGETcx9NpKou1jOEksX4tayRuEVYcy-T4H6QhQU-AUz3Zg1NaQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Sep 2021 17:31:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8sGc7sA7q+SFcMKF02NWpqOUUEWew1qOY+vdpKVFJ6w@mail.gmail.com>
Message-ID: <CAL_JsqL8sGc7sA7q+SFcMKF02NWpqOUUEWew1qOY+vdpKVFJ6w@mail.gmail.com>
Subject: Re: [Bisected Regression] OLPC XO-1.5: Internal drive and SD card
 (mmcblk*) gone since commit ea718c699055
To:     Saravana Kannan <saravanak@google.com>,
        Andre Muller <andre.muller@web.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 10:15 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Sep 7, 2021 at 7:12 PM Andre Muller <andre.muller@web.de> wrote:
> >
> > On 08/09/2021 00.05, Saravana Kannan wrote:
> > > On Sun, Sep 5, 2021 at 1:15 AM Andre Muller <andre.muller@web.de> wrote:
> > >>
> > >> With linux-5.13 and linux-5.14, the internal drive and SD card reader are gone from the XO-1.5. I bisected the issue to come up with ea718c699055:
> > >>
> > >> # first bad commit: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
> > >>
> > >> The /dev/mmcblk* nodes are not generated since this patch.
> > >>
> > >> Please find the output of lspsi -vv and lshw below.
> > >>
> > >> I will be happy to provide more info and/or test patches.
> > >
> > > Hi Andre,
> > >
> > > Can you point me to the dts file in upstream that corresponds to this system?
> > >
> > > Also, if you can give the output of:
> > > cat /sys/kernel/debug/devices_deferred
> >
> > Hi Saravana,
> >
> >
> > /sys/kernel/debug/devices_deferred is empty.
> > I used the last good commit b6f617.
>
> Sorry, I wanted that with the bad commit.
>
> >
> > The XO-1.5 has an x86 compatible VIA C7 processor.
> > It uses the VX855 chip for about all I/O tasks, including SDIO.
> > I am not aware of a device tree file for it.
> >
> > It is a bit of a strange beast, it uses OFW to initialize the hardware and provide a FORTH shell.
> > Which also is the boot manager, configured via FORTH scripts.
> >
> >  From the linux side of the fence, dmesg's line 2 is:
> >
> > "OFW detected in memory, cif @ 0xff83ae68 (reserving top 8MB)"
> >
> > AIUI, this mechanism is used in lieu of a device tree file, like UEFI on most x86 hardware.
> > But my understanding of device trees is severely limited, I might be allwrong.
>
> Uhh... I'm so confused. If Linux doesn't use OF, then none of the code
> enabled by fw_devlink=on should be executed.

Linux does, but maybe not for memory (like UEFI on arm64).

> The only thing that might remotely even execute is:
> efifb_add_links() in drivers/firmware/efi/efi-init.c
>
> If you want you can just do an early return 0; in that to see if it
> makes a difference (unlikely).
>
> Rob, Do you know what's going on with OLPC and DT?

Not really. I have an XO-1 DT dump[1]. It's probably a similar looking
DT though. It's pretty ancient lacking anything we've invented for DT
in the last 10 years. There's not really much to it as about the only
phandle I see is for interrupts.

> > Anyway, the firmware source is here:
> > http://dev.laptop.org/git/users/quozl/openfirmware/
> >
> > This file is the closest dt-analogous thing for the XO-1.5 I can find therein:
> > cpu/x86/pc/olpc/via/devices.fth
>
> That file is all gibberish to me.

Running this on a booted system would help:

dtc -f -I fs -O dts /proc/device-tree > dump.dts

If you don't have dtc on the system, then you'll have to zip up
/proc/device-tree contents and run dtc elsewhere (or just post that).

> > My machine runs the latest version:
> > http://wiki.laptop.org/go/OLPC_Firmware_q3c17
> >
> > The XO-1.5 hardware specs are here:
> > http://wiki.laptop.org/images/f/f0/CL1B_Hdwe_Design_Spec.pdf
> > http://wiki.laptop.org/go/Hardware_specification_1.5
> >
> > Would the .config or dmesg help?
>
> At this point, why not? When you do send them, please send them as
> attachments and not inline.
>
> Also, when you collect the dmesg logs, the following could help:
> Enable the existing dev_dbg logs in these functions:
> device_link_add()
> device_links_check_suppliers()
>
> And add the following log to fwnode_link_add():
> +++ b/drivers/base/core.c
> @@ -87,6 +87,8 @@ int fwnode_link_add(struct fwnode_handle *con,
> struct fwnode_handle *sup)
>                 goto out;
>         }
>
> +       pr_info("Link fwnode %pfwP as a consumer of fwnode %pfwP\n", con, sup);
> +

Please add something like this that can be enabled easily with dynamic debug.

Rob

[1] https://pastebin.com/um0kAZym
