Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312983D8B20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhG1JwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:52:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48546 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231761AbhG1JwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:52:03 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m8gEA-0004pC-76; Wed, 28 Jul 2021 11:51:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, kernelci-results@groups.io,
        Johan Jonker <jbx6244@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>, devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Helen Koike <helen.koike@collabora.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Annotation for dtbscheck to ignore a defect (Was: Re: renesas/master bisection: baseline-nfs.bootrr.rockchip-usb2phy0-probed on rk3399-gru-kevin)
Date:   Wed, 28 Jul 2021 11:51:48 +0200
Message-ID: <5095423.31r3eYUQgx@diego>
In-Reply-To: <878s1qer35.wl-maz@kernel.org>
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com> <cff1e2d1-ceee-eee8-de14-a268429acbc3@collabora.com> <878s1qer35.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. Juli 2021, 11:16:14 CEST schrieb Marc Zyngier:
> On Wed, 28 Jul 2021 09:59:49 +0100,
> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> > 
> > On 28/07/2021 09:39, Robin Murphy wrote:
> > > Hi Guillaume,
> > > 
> > > Not sure what I did to get CC'd on this, but since I'm here...
> > 
> > You were listed by get_maintainer.pl for the patch found by the
> > bisection:
> > 
> >   Robin Murphy <robin.murphy@arm.com> (authored:1/8=12%,added_lines:9/71=13%,removed_lines:16/41=39%,added_lines:11/45=24%,removed_lines:18/32=56%,authored:1/12=8%,added_lines:22/83=27%,removed_lines:29/69=42%)
> > 
> > Maybe the logic to automatically build the list of recipients
> > could look at those stats and apply some threshold if too many
> > people get listed because of small contributions to some files.
> > It's not a common issue though, usually the recipients are all
> > pretty relevant.
> > 
> > > On 2021-07-28 07:04, Guillaume Tucker wrote:
> > >> Please see the bisection report below about usb2phy failing to
> > >> probe on rk3399-gru-kevin.
> > >>
> > >> Reports aren't automatically sent to the public while we're
> > >> trialing new bisection features on kernelci.org but this one
> > >> looks valid.
> > >>
> > >> The bisection was run in the Renesas tree but the same regression
> > >> is present in mainline for both usb2phy0 and usb2phy1 devices:
> > >>
> > >>    https://linux.kernelci.org/test/plan/id/6100af012344eef9b85018f3/
> > >>    https://linux.kernelci.org/test/case/id/6100af012344eef9b85018fa/
> > >>
> > >> I don't see any errors in the logs, it looks like the driver is
> > >> just not probing.
> > > 
> > > What's the actual testcase for "rockchip-usb2phy0-probed"? If it's looking for a hard-coded path like "/sys/bus/platform/devices/ff770000.syscon:usb2-phy@e450/driver" then it can be expected to fail, since changing the node name is reflected in the device name.
> > 
> > Dang, you're right.  This is the test case:
> > 
> >   https://github.com/kernelci/bootrr/blob/main/boards/google%2Ckevin#L119
> > 
> > assert_driver_present rockchip-usb2phy-driver-present rockchip-usb2phy
> > assert_device_present rockchip-usb2phy0-probed rockchip-usb2phy ff770000.syscon:usb2-phy@e450
> > assert_device_present rockchip-usb2phy1-probed rockchip-usb2phy ff770000.syscon:usb2-phy@e460
> > 
> > Now that needs a conditional depending on the kernel version.  Or
> > we could try to make it more dynamic rather than with hard-coded
> > paths, but doing that has its own set of issues too.
> 
> And this shows once more that DT churn has consequences: it breaks a
> userspace ABI. Changing userspace visible paths for the sake of
> keeping a build-time checker quiet seems counter-productive. My
> preference would be to just revert this patch, and instead have an
> annotation acknowledging the deviation from the 'standard' and keeping
> the checker at bay.

I'd be fine with that, if that is the consensus. And an annotation comment
would be good in that case, just to keep a similar change  from getting
submitted.

I guess the interesting question is if dtbscheck has some sort of tooling
to detect these "this is meant to be that way for backwards compatibility"
hence adding Rob for that question.


Heiko


