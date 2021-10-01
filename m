Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD241F1E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJAQOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhJAQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:14:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C163619EC;
        Fri,  1 Oct 2021 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633104752;
        bh=ox895Oq9qFS1PKv8V5m0rsu1D0HlaWuGE2HEaripARo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c5BH2gQV7/qZRbkSOuErZ5vkNlrsnRyiBbgWojxyTeUuhES3hZX8m6SyJeuTz4EvM
         IwATn2L0ckhkA8Fek7c2z2xhUq/Snor89NibPjhIHXHu71Mco7gnEMpc6DAcJl1M7P
         GFuiJrwjzHd/CNeIgMmyhXj7Bk5+IOcmnaV4VDOtckCpVU4fAyMEc1nJ7sDXlc6W19
         F3hN4psREvXwHyyub+TV0xzedtKCljtwelYfpkCkBLz4EwNd4+fdlZByHFgRQfeUqv
         1KP6EzPQ1wTKkvP2THQyUYt45ve9cb519JNTsKTXUYM107drlESMGpkQ5HBfxuFzwh
         1phEqaBYa0pig==
Received: by mail-ed1-f49.google.com with SMTP id b8so2090337edk.2;
        Fri, 01 Oct 2021 09:12:32 -0700 (PDT)
X-Gm-Message-State: AOAM533NRbPseC/40yr6fl6TaVKc62SFV+jto5EuBtebXGS++DoO2LvV
        H7XQ0FE+OHCWHFOvejKTLzPhzrjPOrd5IkSdjg==
X-Google-Smtp-Source: ABdhPJxYJeZDGEts2sPVn9fU8k7VfiLOni0mJXmJh9Dddqk8qlE5U87fsWl/G3xLDxMcoSv8VKyGh0BQz1GTipuGAvI=
X-Received: by 2002:a17:906:c10e:: with SMTP id do14mr7543427ejc.84.1633104751005;
 Fri, 01 Oct 2021 09:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com> <cff1e2d1-ceee-eee8-de14-a268429acbc3@collabora.com>
 <878s1qer35.wl-maz@kernel.org> <5095423.31r3eYUQgx@diego> <9b45ceaf-abbb-7345-bbc9-af1d94e2efbc@collabora.com>
In-Reply-To: <9b45ceaf-abbb-7345-bbc9-af1d94e2efbc@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 1 Oct 2021 11:12:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGx_MwX9ynMiCUm_xP3t6xWbrtiUi-F+2ceXqZ2Su5tA@mail.gmail.com>
Message-ID: <CAL_JsqJGx_MwX9ynMiCUm_xP3t6xWbrtiUi-F+2ceXqZ2Su5tA@mail.gmail.com>
Subject: Re: Annotation for dtbscheck to ignore a defect (Was: Re:
 renesas/master bisection: baseline-nfs.bootrr.rockchip-usb2phy0-probed on rk3399-gru-kevin)
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        kernelci-results@groups.io, Johan Jonker <jbx6244@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>, devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 5:00 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hello Rob,

I'm adding a few more here as I think there's a wider topic of probing
and modules.

>
> On 28/07/2021 11:51, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 28. Juli 2021, 11:16:14 CEST schrieb Marc Zyngier:
> >> On Wed, 28 Jul 2021 09:59:49 +0100,
> >> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> >>>
> >>> On 28/07/2021 09:39, Robin Murphy wrote:
> >>>> Hi Guillaume,
> >>>>
> >>>> Not sure what I did to get CC'd on this, but since I'm here...
> >>>
> >>> You were listed by get_maintainer.pl for the patch found by the
> >>> bisection:
> >>>
> >>>   Robin Murphy <robin.murphy@arm.com> (authored:1/8=3D12%,added_lines=
:9/71=3D13%,removed_lines:16/41=3D39%,added_lines:11/45=3D24%,removed_lines=
:18/32=3D56%,authored:1/12=3D8%,added_lines:22/83=3D27%,removed_lines:29/69=
=3D42%)
> >>>
> >>> Maybe the logic to automatically build the list of recipients
> >>> could look at those stats and apply some threshold if too many
> >>> people get listed because of small contributions to some files.
> >>> It's not a common issue though, usually the recipients are all
> >>> pretty relevant.
> >>>
> >>>> On 2021-07-28 07:04, Guillaume Tucker wrote:
> >>>>> Please see the bisection report below about usb2phy failing to
> >>>>> probe on rk3399-gru-kevin.
> >>>>>
> >>>>> Reports aren't automatically sent to the public while we're
> >>>>> trialing new bisection features on kernelci.org but this one
> >>>>> looks valid.
> >>>>>
> >>>>> The bisection was run in the Renesas tree but the same regression
> >>>>> is present in mainline for both usb2phy0 and usb2phy1 devices:
> >>>>>
> >>>>>    https://linux.kernelci.org/test/plan/id/6100af012344eef9b85018f3=
/
> >>>>>    https://linux.kernelci.org/test/case/id/6100af012344eef9b85018fa=
/
>
> This issue is still present and it got bisected yet again
> yesterday by KernelCI.
>
> >>>>> I don't see any errors in the logs, it looks like the driver is
> >>>>> just not probing.
> >>>>
> >>>> What's the actual testcase for "rockchip-usb2phy0-probed"? If it's l=
ooking for a hard-coded path like "/sys/bus/platform/devices/ff770000.sysco=
n:usb2-phy@e450/driver" then it can be expected to fail, since changing the=
 node name is reflected in the device name.

/sys/bus/platform/devices/ paths are not an ABI. I'll consider
nodenames an ABI if a change is noticed, but not for sysfs path.

From sysfs testings/sys-devices (what /sys/bus/platform/devices/ links to):

What:           /sys/devices
Date:           February 2006
Contact:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Description:
                The /sys/devices tree contains a snapshot of the
                internal state of the kernel device tree.  Devices will
                be added and removed dynamically as the machine runs,
                and between different kernel versions, the layout of the
                devices within this tree will change.

                Please do not rely on the format of this tree because of
                this.  If a program wishes to find different things in
                the tree, please use the /sys/class structure and rely
                on the symlinks there to point to the proper location
                within the /sys/devices tree of the individual devices.
                Or rely on the uevent messages to notify programs of
                devices being added and removed from this tree to find
                the location of those devices.

                Note that sometimes not all devices along the directory
                chain will have emitted uevent messages, so userspace
                programs must be able to handle such occurrences.

> >>>
> >>> Dang, you're right.  This is the test case:
> >>>
> >>>   https://github.com/kernelci/bootrr/blob/main/boards/google%2Ckevin#=
L119
> >>>
> >>> assert_driver_present rockchip-usb2phy-driver-present rockchip-usb2ph=
y
> >>> assert_device_present rockchip-usb2phy0-probed rockchip-usb2phy ff770=
000.syscon:usb2-phy@e450
> >>> assert_device_present rockchip-usb2phy1-probed rockchip-usb2phy ff770=
000.syscon:usb2-phy@e460

Why do you even care about the USB PHY probing directly? It is not
usable on its own. What you care about is whether the USB
controller(s) probed and USB is working.

> >>> Now that needs a conditional depending on the kernel version.  Or
> >>> we could try to make it more dynamic rather than with hard-coded
> >>> paths, but doing that has its own set of issues too.
> >>
> >> And this shows once more that DT churn has consequences: it breaks a
> >> userspace ABI. Changing userspace visible paths for the sake of
> >> keeping a build-time checker quiet seems counter-productive. My
> >> preference would be to just revert this patch, and instead have an
> >> annotation acknowledging the deviation from the 'standard' and keeping
> >> the checker at bay.
> >
> > I'd be fine with that, if that is the consensus. And an annotation comm=
ent
> > would be good in that case, just to keep a similar change  from getting
> > submitted.
> >
> > I guess the interesting question is if dtbscheck has some sort of tooli=
ng
> > to detect these "this is meant to be that way for backwards compatibili=
ty"
> > hence adding Rob for that question.

I would like to have some way to disable specific warnings and/or have
warning levels. The problem is there's not any sort of identifier to
key off of at a granularity smaller than a schema file. So in this
case, we'd have to disable the PHY binding entirely (that's not
actually too bad here). The second problem is where do we put that
control. We could do some sort of source annotation. That would have
to be maintained in the yaml encoded output and also would not work
when we don't have dts source. The schema checks currently require dts
source as we use some of the annotations like /bits/ that are lost in
the dtb, but addressing that to support running the checks on a
running system is something I'm actively working on.

> Could you please take a look at Heiko's suggestion above to see
> if this should be solved in dtbs_check?  If not then we would
> need to change the KernelCI test definition to look for a
> different name based on the kernel version (which sounds like
> breaking user-space).

Looking at the above check, that looks horrible to create and maintain
(regardless of this issue). I was actually just wondering if there
were any tests for devices that didn't probe. On the recent VExpress
breakages, we only noticed on the boards that failed to init their
timer. Newer boards that use the arch timer still booted, but a bunch
of devices didn't probe.

Can't we extract every device not bound to a driver, get the
compatible string or modalias, and then compare that to the aliases of
all the modules? Of course, that doesn't work in the built-in case.
That's perhaps something we should fix though. (I'd also like to be
able to extract all driver DT compatibles at build time and have the
same issue.)

Alternatively, couldn't this test list the compatible string instead
of node name and then you search devices for a match?

Or maybe there is a much more simple fix. We could just log failed
probes in a standard way for tools to understand.

Rob
