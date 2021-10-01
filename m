Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93441EA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbhJAKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:02:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbhJAKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:02:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 6FA851F45428
Subject: Re: Annotation for dtbscheck to ignore a defect (Was: Re:
 renesas/master bisection: baseline-nfs.bootrr.rockchip-usb2phy0-probed on
 rk3399-gru-kevin)
To:     robh+dt@kernel.org, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, kernelci-results@groups.io,
        Johan Jonker <jbx6244@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>, devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com>
 <cff1e2d1-ceee-eee8-de14-a268429acbc3@collabora.com>
 <878s1qer35.wl-maz@kernel.org> <5095423.31r3eYUQgx@diego>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <9b45ceaf-abbb-7345-bbc9-af1d94e2efbc@collabora.com>
Date:   Fri, 1 Oct 2021 12:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5095423.31r3eYUQgx@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 28/07/2021 11:51, Heiko Stübner wrote:
> Am Mittwoch, 28. Juli 2021, 11:16:14 CEST schrieb Marc Zyngier:
>> On Wed, 28 Jul 2021 09:59:49 +0100,
>> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>>>
>>> On 28/07/2021 09:39, Robin Murphy wrote:
>>>> Hi Guillaume,
>>>>
>>>> Not sure what I did to get CC'd on this, but since I'm here...
>>>
>>> You were listed by get_maintainer.pl for the patch found by the
>>> bisection:
>>>
>>>   Robin Murphy <robin.murphy@arm.com> (authored:1/8=12%,added_lines:9/71=13%,removed_lines:16/41=39%,added_lines:11/45=24%,removed_lines:18/32=56%,authored:1/12=8%,added_lines:22/83=27%,removed_lines:29/69=42%)
>>>
>>> Maybe the logic to automatically build the list of recipients
>>> could look at those stats and apply some threshold if too many
>>> people get listed because of small contributions to some files.
>>> It's not a common issue though, usually the recipients are all
>>> pretty relevant.
>>>
>>>> On 2021-07-28 07:04, Guillaume Tucker wrote:
>>>>> Please see the bisection report below about usb2phy failing to
>>>>> probe on rk3399-gru-kevin.
>>>>>
>>>>> Reports aren't automatically sent to the public while we're
>>>>> trialing new bisection features on kernelci.org but this one
>>>>> looks valid.
>>>>>
>>>>> The bisection was run in the Renesas tree but the same regression
>>>>> is present in mainline for both usb2phy0 and usb2phy1 devices:
>>>>>
>>>>>    https://linux.kernelci.org/test/plan/id/6100af012344eef9b85018f3/
>>>>>    https://linux.kernelci.org/test/case/id/6100af012344eef9b85018fa/

This issue is still present and it got bisected yet again
yesterday by KernelCI.

>>>>> I don't see any errors in the logs, it looks like the driver is
>>>>> just not probing.
>>>>
>>>> What's the actual testcase for "rockchip-usb2phy0-probed"? If it's looking for a hard-coded path like "/sys/bus/platform/devices/ff770000.syscon:usb2-phy@e450/driver" then it can be expected to fail, since changing the node name is reflected in the device name.
>>>
>>> Dang, you're right.  This is the test case:
>>>
>>>   https://github.com/kernelci/bootrr/blob/main/boards/google%2Ckevin#L119
>>>
>>> assert_driver_present rockchip-usb2phy-driver-present rockchip-usb2phy
>>> assert_device_present rockchip-usb2phy0-probed rockchip-usb2phy ff770000.syscon:usb2-phy@e450
>>> assert_device_present rockchip-usb2phy1-probed rockchip-usb2phy ff770000.syscon:usb2-phy@e460
>>>
>>> Now that needs a conditional depending on the kernel version.  Or
>>> we could try to make it more dynamic rather than with hard-coded
>>> paths, but doing that has its own set of issues too.
>>
>> And this shows once more that DT churn has consequences: it breaks a
>> userspace ABI. Changing userspace visible paths for the sake of
>> keeping a build-time checker quiet seems counter-productive. My
>> preference would be to just revert this patch, and instead have an
>> annotation acknowledging the deviation from the 'standard' and keeping
>> the checker at bay.
> 
> I'd be fine with that, if that is the consensus. And an annotation comment
> would be good in that case, just to keep a similar change  from getting
> submitted.
> 
> I guess the interesting question is if dtbscheck has some sort of tooling
> to detect these "this is meant to be that way for backwards compatibility"
> hence adding Rob for that question.

Could you please take a look at Heiko's suggestion above to see
if this should be solved in dtbs_check?  If not then we would
need to change the KernelCI test definition to look for a
different name based on the kernel version (which sounds like
breaking user-space).

Thanks,
Guillaume


GitHub: https://github.com/kernelci/kernelci-project/issues/55

-------------------------------------------------------------------------------

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

mainline/master bisection: baseline.bootrr.rockchip-usb2phy1-probed on rk3399-gru-kevin

Summary:
  Start:      02d5e016800d Merge tag 'sound-5.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
  Plain log:  https://storage.kernelci.org/mainline/master/v5.15-rc3-135-g02d5e016800d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:   https://storage.kernelci.org/mainline/master/v5.15-rc3-135-g02d5e016800d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Result:     8c3d64251ac5 arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       mainline
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  Branch:     master
  Target:     rk3399-gru-kevin
  CPU arch:   arm64
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     defconfig
  Test case:  baseline.bootrr.rockchip-usb2phy1-probed

Breaking commit found:

-------------------------------------------------------------------------------
commit 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
Author: Johan Jonker <jbx6244@gmail.com>
Date:   Tue Jun 1 18:47:59 2021 +0200

    arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
