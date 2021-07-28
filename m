Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0203D89FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhG1IsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1IsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:48:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B8C061757;
        Wed, 28 Jul 2021 01:48:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 38E131F4328D
Subject: Re: renesas/master bisection:
 baseline-nfs.bootrr.rockchip-usb2phy0-probed on rk3399-gru-kevin
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernelci-results@groups.io, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Helen Koike <helen.koike@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com>
 <c52f6cfb-1316-dd6a-46fa-17abfcc4bf18@collabora.com>
 <CAMuHMdUi_=xnvYFgiWXxSyrfoMn0JJCcH+TXFUh+1JUf=4u87A@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <2fc2b898-434c-3288-2052-70b1e1427b39@collabora.com>
Date:   Wed, 28 Jul 2021 09:48:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUi_=xnvYFgiWXxSyrfoMn0JJCcH+TXFUh+1JUf=4u87A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 09:17, Geert Uytterhoeven wrote:
> Hi Guillaume et al,
> 
> On Wed, Jul 28, 2021 at 8:05 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>> Please see the bisection report below about usb2phy failing to
>> probe on rk3399-gru-kevin.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
> 
> Thanks for your report!
> 
>> The bisection was run in the Renesas tree but the same regression
>> is present in mainline for both usb2phy0 and usb2phy1 devices:
> 
> Exactly, the faulty commit is part of v5.14-rc1.
> 
>>> Breaking commit found:
>>>
>>> -------------------------------------------------------------------------------
>>> commit 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
>>> Author: Johan Jonker <jbx6244@gmail.com>
>>> Date:   Tue Jun 1 18:47:59 2021 +0200
>>>
>>>     arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
> 
> P.S. KernelCI is sending lots of reports to linux-reneas-soc[1] for
>      (a) issues on non-Renesas platforms[2], and

One thing to distinguish here is that changes in a tree like the
Renesas one might actually break other platforms, even if it
seems unlikely.  But the improvement explained below addresses
this issue.

>      (b) issues not originating in the renesas-devel tree, like this one.

That is just because I found the bisection report from the
Renesas tree before getting one from mainline.  As we're manually
triaging reports, I mentioned it in my email.  And you're right,
we would need to take this into account before having all the
bisection reports sent automatically.

> Suggestions for improvement:
>   1. If a regression is detected in an upstream tree, there is no
>      need to report it for downstream trees, unless it affects
>      the downstream tree, or originated there.

That's right, we're working on an improvement to be able to
detect "2nd order" regressions, that is to say new failures in a
branch relatively to new failures in an upstream branch.  That
would be typically mainline or stable, but sometimes a subsystem
specific one.

>   2. If a regression is detected for a platform, there is no need
>      to report it for different platform trees, unless it originated
>      there.
> 
> BTW, I do look at the reports for Renesas platforms, but usually I
> don't see what's wrong, and the same platform works fine locally.

Until this has been improved, maybe we can just stop sending
email reports to linux-reneas-soc if they're mostly noise.  The
bisections will still run and reports like this one are sent to
the people and lists who are related to the changes in the patch
rather than the git tree so it's always relevant to them.

> Note that yesterday and today I get "Error while loading data from the
> server (error code: 500). Please contact the website administrator".

Yes that's because the Mongo DB service keeps crashing.  It's a
sysadmin issue that should hopefully get resolved soon, sorry for
the inconvenience.


Thanks for your feedback.

Best wishes,
Guillaume

> [1] https://lore.kernel.org/linux-renesas-soc/?q=kernelci.org
> [2] https://lore.kernel.org/linux-renesas-soc/60ff86ff.1c69fb81.dfe6f.6a7c@mx.google.com/

