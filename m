Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450F34032DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347492AbhIHDQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhIHDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:16:33 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C4C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 20:15:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id a93so1336786ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 20:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGL7umbcke/doOMh5kpYlO1h2Ked2/KDpAEFqS8ijq8=;
        b=MhCwnGi35eOJzZgtvc1wH7ht7ZAk2Lw5vPhmPHjgo5N5+Hs8CIlgULuK3OjynZsUPq
         B2ueqooWfvITraHfZGVwYfV1dc668k5/uD+XGxQVU1ZwWXw6R93E47/ihDHc0z25RmLS
         hXHDeq0K+vDTAMjKTMfA5XG4WV9afSTMPMCC8uMvUXowduTTB/2qtROWh3BilTd63g+h
         mWGhkEPsRu7gPgE4X4suc6WEucSphSd7Gr3pA/he5+2bRolmW1TTiDo/E//lqawHCzmG
         yb1M0fCLdocto3qlCvS3VOjUxMJLx6khkUhOZTLyAuZZqnGdG8HiTLY20UT5jylTctU1
         AwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGL7umbcke/doOMh5kpYlO1h2Ked2/KDpAEFqS8ijq8=;
        b=oFi64OPPhwA68kA8cQKDRTCerlL+aBk+EoZlq8QjR82RGL7jz9mqKEYNYysi4zzPoQ
         4mLwmEwLk7+AmqFaQKksRXtIR03dClCf5lb10oqlG2ip71F1r4AtHCjfU7ZRsAYwqek6
         IcbaEdENA1VhkL7n7OWyakuPALxd4qOW8cdHJLTiXIVZqEi882PFBoO/58vt8nOHGhE4
         r9B3j32GJaw/LMegkJKiyJ2r+7MvXFAxIZeHQaoS/TzDJcuhZXOEZAB2R6dL+AR+Jpk+
         49ffl2V1flwmtOHla54KCL+PZSpu1QzegE/uK0vxc8K25E8X4je6J0B7hst8bex+/Vza
         iAcg==
X-Gm-Message-State: AOAM531gSRRDEpEDd9hzF/+ZN9L2QbmwXRcJCsdAuRf6+rlHT0iuYSHR
        AwpLlF9/Nh7VAaNuar2CiWfPixgsWS5Spotar+AI4Q==
X-Google-Smtp-Source: ABdhPJxK4AxEbuTO1XBLzAPo3criMMzyA3JzcSjsFTm3I78gbA1NROP4ai3jxJ1PNbNC+FONtDi777GbHYbSg3K3hPw=
X-Received: by 2002:a25:b94:: with SMTP id 142mr2054194ybl.508.1631070925782;
 Tue, 07 Sep 2021 20:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de> <CAGETcx9eFg7jR=ibBLhU3q+VnpqJXQCVmQcEyMpozddRiCXFLQ@mail.gmail.com>
 <97044cb9-b7a9-d8af-93e7-d33a81a1cfe2@web.de>
In-Reply-To: <97044cb9-b7a9-d8af-93e7-d33a81a1cfe2@web.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Sep 2021 20:14:49 -0700
Message-ID: <CAGETcx9NpKou1jOEksX4tayRuEVYcy-T4H6QhQU-AUz3Zg1NaQ@mail.gmail.com>
Subject: Re: [Bisected Regression] OLPC XO-1.5: Internal drive and SD card
 (mmcblk*) gone since commit ea718c699055
To:     Andre Muller <andre.muller@web.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 7:12 PM Andre Muller <andre.muller@web.de> wrote:
>
> On 08/09/2021 00.05, Saravana Kannan wrote:
> > On Sun, Sep 5, 2021 at 1:15 AM Andre Muller <andre.muller@web.de> wrote:
> >>
> >> With linux-5.13 and linux-5.14, the internal drive and SD card reader are gone from the XO-1.5. I bisected the issue to come up with ea718c699055:
> >>
> >> # first bad commit: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
> >>
> >> The /dev/mmcblk* nodes are not generated since this patch.
> >>
> >> Please find the output of lspsi -vv and lshw below.
> >>
> >> I will be happy to provide more info and/or test patches.
> >
> > Hi Andre,
> >
> > Can you point me to the dts file in upstream that corresponds to this system?
> >
> > Also, if you can give the output of:
> > cat /sys/kernel/debug/devices_deferred
>
> Hi Saravana,
>
>
> /sys/kernel/debug/devices_deferred is empty.
> I used the last good commit b6f617.

Sorry, I wanted that with the bad commit.

>
> The XO-1.5 has an x86 compatible VIA C7 processor.
> It uses the VX855 chip for about all I/O tasks, including SDIO.
> I am not aware of a device tree file for it.
>
> It is a bit of a strange beast, it uses OFW to initialize the hardware and provide a FORTH shell.
> Which also is the boot manager, configured via FORTH scripts.
>
>  From the linux side of the fence, dmesg's line 2 is:
>
> "OFW detected in memory, cif @ 0xff83ae68 (reserving top 8MB)"
>
> AIUI, this mechanism is used in lieu of a device tree file, like UEFI on most x86 hardware.
> But my understanding of device trees is severely limited, I might be allwrong.

Uhh... I'm so confused. If Linux doesn't use OF, then none of the code
enabled by fw_devlink=on should be executed.

The only thing that might remotely even execute is:
efifb_add_links() in drivers/firmware/efi/efi-init.c

If you want you can just do an early return 0; in that to see if it
makes a difference (unlikely).

Rob, Do you know what's going on with OLPC and DT?

>
>
> Anyway, the firmware source is here:
> http://dev.laptop.org/git/users/quozl/openfirmware/
>
> This file is the closest dt-analogous thing for the XO-1.5 I can find therein:
> cpu/x86/pc/olpc/via/devices.fth

That file is all gibberish to me.

>
> My machine runs the latest version:
> http://wiki.laptop.org/go/OLPC_Firmware_q3c17
>
> The XO-1.5 hardware specs are here:
> http://wiki.laptop.org/images/f/f0/CL1B_Hdwe_Design_Spec.pdf
> http://wiki.laptop.org/go/Hardware_specification_1.5
>
> Would the .config or dmesg help?

At this point, why not? When you do send them, please send them as
attachments and not inline.

Also, when you collect the dmesg logs, the following could help:
Enable the existing dev_dbg logs in these functions:
device_link_add()
device_links_check_suppliers()

And add the following log to fwnode_link_add():
+++ b/drivers/base/core.c
@@ -87,6 +87,8 @@ int fwnode_link_add(struct fwnode_handle *con,
struct fwnode_handle *sup)
                goto out;
        }

+       pr_info("Link fwnode %pfwP as a consumer of fwnode %pfwP\n", con, sup);
+
        link->supplier = sup;
        INIT_LIST_HEAD(&link->s_hook);
        link->consumer = con;

Thanks,
Saravana
