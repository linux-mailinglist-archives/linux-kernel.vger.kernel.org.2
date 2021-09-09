Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A648405FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348243AbhIIXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231814AbhIIXLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:11:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58C4861132;
        Thu,  9 Sep 2021 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631228997;
        bh=e4QUsy+zf5w6b1TL2+XmWPqN3eMaWq09xzxEIhZbNx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dVNQ+I9N8aenhEG9I1gi+9i+yg7X95d1+UqL+ONd+ftFTwNxvoiVdSvbiKVyLqw7I
         JZYH7+XnAIpuWAVsvEZrG5wnGacYADx0KsZakXgc3/amnj7N8kPmrhZQ9iP62Opevh
         m0GyO2s3bZhCtnFRsEscrZ8RRHbrlY0U4eIKlySFtGzVGSzx3BpuNn/bUJHJ8rrzBT
         VTh11md6awr+5mPDhSZ06X5qMi5gm2XjgpQNOY6OMXXTKLlNJuuArP+QY2Q/Mvh9ur
         6Hs4dq69u033jexDOVe4c+UPOHLW0KUtXZkDCTFGZ/mLyKGKVyTc2ndHa5LgU7hYg+
         +BOGqmSTf98Cw==
Received: by mail-ed1-f43.google.com with SMTP id v5so4906180edc.2;
        Thu, 09 Sep 2021 16:09:57 -0700 (PDT)
X-Gm-Message-State: AOAM5336hBI66mwaCqb1SEIPHVgRW8Dra+lMkden+mKaTKfq1YMF75LY
        X6bdbBE0Fc/cqHD2vjRLK0qcdvG5L8dOOLYXAw==
X-Google-Smtp-Source: ABdhPJzpV+YK8H+eOjIUnGL+G8b30xtmk5wvjw8nV8uPxNpZrJr1gIYe7KCFGSQy6LImGOoBPlp4VFXn2jcL//LeX6g=
X-Received: by 2002:a05:6402:4314:: with SMTP id m20mr5831003edc.6.1631228995886;
 Thu, 09 Sep 2021 16:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de> <CAGETcx9eFg7jR=ibBLhU3q+VnpqJXQCVmQcEyMpozddRiCXFLQ@mail.gmail.com>
 <97044cb9-b7a9-d8af-93e7-d33a81a1cfe2@web.de> <CAGETcx9NpKou1jOEksX4tayRuEVYcy-T4H6QhQU-AUz3Zg1NaQ@mail.gmail.com>
 <CAL_JsqL8sGc7sA7q+SFcMKF02NWpqOUUEWew1qOY+vdpKVFJ6w@mail.gmail.com>
 <ac715ac4-eb2d-7dd0-9752-4cbe95b0e88d@web.de> <CAL_Jsq+mqpHF5hn0iD8+nz3iOH4-doqqB0hgiV-MLKS2_s9oBg@mail.gmail.com>
 <CAGETcx-qbmmPOH4+pyHGSnukTA3PgXTxYyZg5fSEuD=Uy3YVMQ@mail.gmail.com>
In-Reply-To: <CAGETcx-qbmmPOH4+pyHGSnukTA3PgXTxYyZg5fSEuD=Uy3YVMQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Sep 2021 18:09:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKsMdv8rTUB936SU-JnZ3ULrF=jeN6V_3hY_eVg1D-yUw@mail.gmail.com>
Message-ID: <CAL_JsqKsMdv8rTUB936SU-JnZ3ULrF=jeN6V_3hY_eVg1D-yUw@mail.gmail.com>
Subject: Re: [Bisected Regression] OLPC XO-1.5: Internal drive and SD card
 (mmcblk*) gone since commit ea718c699055
To:     Saravana Kannan <saravanak@google.com>
Cc:     Andre Muller <andre.muller@web.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 2:24 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Sep 9, 2021 at 8:15 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 9, 2021 at 9:09 AM Andre Muller <andre.muller@web.de> wrote:
> > >
> > > On 09/09/2021 00.31, Rob Herring wrote:
> > > > On Tue, Sep 7, 2021 at 10:15 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >>
> > > >> On Tue, Sep 7, 2021 at 7:12 PM Andre Muller <andre.muller@web.de> wrote:
> > > >>>
> > > >>> On 08/09/2021 00.05, Saravana Kannan wrote:
> > > >>>> On Sun, Sep 5, 2021 at 1:15 AM Andre Muller <andre.muller@web.de> wrote:
> > > >>>>>
> > > >>>>> With linux-5.13 and linux-5.14, the internal drive and SD card reader are gone from the XO-1.5. I bisected the issue to come up with ea718c699055:
> > > >>>>>
> > > >>>>> # first bad commit: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
> > > >>>>>
> > > >>>>> The /dev/mmcblk* nodes are not generated since this patch.
> > > >>>>>
> > > >>>>> Please find the output of lspsi -vv and lshw below.
> > > >>>>>
> > > >>>>> I will be happy to provide more info and/or test patches.
> > > >>>>
> > > >>>> Hi Andre,
> > > >>>>
> > > >>>> Can you point me to the dts file in upstream that corresponds to this system?
> > > >>>>
> > > >>>> Also, if you can give the output of:
> > > >>>> cat /sys/kernel/debug/devices_deferred
> > > >>>
> > > >>> Hi Saravana,
> > > >>>
> > > >>>
> > > >>> /sys/kernel/debug/devices_deferred is empty.
> > > >>> I used the last good commit b6f617.
> > > >>
> > > >> Sorry, I wanted that with the bad commit.
> > >
> > > Uh-oh, my bad...
> > >
> > > The bad case says
> > > # cat devices_deferred
> > > 0000:00:0c.0
> > >
> > > That's the SD Host controller.
> > >
> > > >>
> > > >>>
> > > >>> The XO-1.5 has an x86 compatible VIA C7 processor.
> > > >>> It uses the VX855 chip for about all I/O tasks, including SDIO.
> > > >>> I am not aware of a device tree file for it.
> > > >>>
> > > >>> It is a bit of a strange beast, it uses OFW to initialize the hardware and provide a FORTH shell.
> > > >>> Which also is the boot manager, configured via FORTH scripts.
> > > >>>
> > > >>>   From the linux side of the fence, dmesg's line 2 is:
> > > >>>
> > > >>> "OFW detected in memory, cif @ 0xff83ae68 (reserving top 8MB)"
> > > >>>
> > > >>> AIUI, this mechanism is used in lieu of a device tree file, like UEFI on most x86 hardware.
> > > >>> But my understanding of device trees is severely limited, I might be allwrong.
> > > >>
> > > >> Uhh... I'm so confused. If Linux doesn't use OF, then none of the code
> > > >> enabled by fw_devlink=on should be executed.
> > > >
> > > > Linux does, but maybe not for memory (like UEFI on arm64).
> > > >
> > > >> The only thing that might remotely even execute is:
> > > >> efifb_add_links() in drivers/firmware/efi/efi-init.c
> > > >>
> > > >> If you want you can just do an early return 0; in that to see if it
> > > >> makes a difference (unlikely).
> > > >>
> > > >> Rob, Do you know what's going on with OLPC and DT?
> > > >
> > > > Not really. I have an XO-1 DT dump[1]. It's probably a similar looking
> > > > DT though. It's pretty ancient lacking anything we've invented for DT
> > > > in the last 10 years. There's not really much to it as about the only
> > > > phandle I see is for interrupts.
> > > >
> > > >>> Anyway, the firmware source is here:
> > > >>> http://dev.laptop.org/git/users/quozl/openfirmware/
> > > >>>
> > > >>> This file is the closest dt-analogous thing for the XO-1.5 I can find therein:
> > > >>> cpu/x86/pc/olpc/via/devices.fth
> > > >>
> > > >> That file is all gibberish to me.
> > > >
> > > > Running this on a booted system would help:
> > > >
> > > > dtc -f -I fs -O dts /proc/device-tree > dump.dts
> > >
> > > Ah, thanks. I never knew about the DT in there...
> > > XO-1.5_dump.dts is attached.
> > >
> > > >
> > > > If you don't have dtc on the system, then you'll have to zip up
> > > > /proc/device-tree contents and run dtc elsewhere (or just post that).
> > > >
> > > >>> My machine runs the latest version:
> > > >>> http://wiki.laptop.org/go/OLPC_Firmware_q3c17
> > > >>>
> > > >>> The XO-1.5 hardware specs are here:
> > > >>> http://wiki.laptop.org/images/f/f0/CL1B_Hdwe_Design_Spec.pdf
> > > >>> http://wiki.laptop.org/go/Hardware_specification_1.5
> > > >>>
> > > >>> Would the .config or dmesg help?
> > > >>
> > > >> At this point, why not? When you do send them, please send them as
> > > >> attachments and not inline.
> > > >>
> > > >> Also, when you collect the dmesg logs, the following could help:
> > > >> Enable the existing dev_dbg logs in these functions:
> > > >> device_link_add()
> > > >> device_links_check_suppliers()
> > > >>
> > > >> And add the following log to fwnode_link_add():
> > > >> +++ b/drivers/base/core.c
> > > >> @@ -87,6 +87,8 @@ int fwnode_link_add(struct fwnode_handle *con,
> > > >> struct fwnode_handle *sup)
> > > >>                  goto out;
> > > >>          }
> > > >>
> > > >> +       pr_info("Link fwnode %pfwP as a consumer of fwnode %pfwP\n", con, sup);
> > > >> +
> > > >
> > >
> > > OK. The dmesg with debug info is attached as well (for the broken case).
> >
> > Humm, ACPI and DT together...
> >
> > Looks to me like it's waiting for the wrong interrupt-parent. The log
> > says it is waiting for 'interrupt-controller@i20' which is the only
> > interrupt-controller found in the DT, but the parent is the PCI bridge
> > with whatever interrupt-map is pointing to. That's not clear as the
> > phandle (0x767a4) doesn't exist in the DT. I suppose the parent is
> > defined in ACPI?
>
> After staring at it for a while, I realized that
> interrupt-controller@i20 is indeed the right node. Looks like we need
> to do endian conversion of the ".node" property in the interrupt
> controller and it would match with 0x767a4.

Ah yes, I failed on doing the endian conversion.

> > pci 0000:00:0c.0: probe deferral - wait for supplier interrupt-controller@i20
> The SD controller is waiting forever on interrupt-controller@i20 to be
> added as a device.
>
> Rob,
>
> My guess is that the fwnode value is not getting set for ISA devices
> populated when isa@11 is added. Any idea how/where those child devices
> are populated? I thought they'd be platform devices, but it doesn't
> look like that's the case?

Sometimes they are. Sometimes there's no driver I think. I couldn't
figure out what code corresponds to this node in the kernel.

> > If there's not an easy fix, just disable devlinks for x86. There's
> > only one other DT platform, ce4100, and I really doubt it is even used
> > at all.
>
> I think the easy fix is to set the ISA device's fwnode when it's
> added, but I can't tell how they are getting added. But yeah, if that
> turns out to be hard, then I'd vote for disabling it for x86 too.

Just disable it.

Rob
