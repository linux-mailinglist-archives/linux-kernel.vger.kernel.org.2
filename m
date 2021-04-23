Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49381368EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbhDWITP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:19:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34230 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbhDWITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:19:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 91FA31F438CD
Subject: Re: next/master bisection: baseline.dmesg.alert on bcm2837-rpi-3-b
To:     Tudor.Ambarus@microchip.com, sboyd@kernel.org,
        saravanak@google.com, gregkh@linuxfoundation.org,
        kernelci-results@groups.io
Cc:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
References: <60809bd4.1c69fb81.7752a.1894@mx.google.com>
 <bd28c734-4964-319f-fe4e-f6787ffe22fd@collabora.com>
 <db57f885-1c04-c050-7352-872562b72422@microchip.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <0473d87f-1982-eda7-9147-6ba245044d07@collabora.com>
Date:   Fri, 23 Apr 2021 09:18:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <db57f885-1c04-c050-7352-872562b72422@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 05:38, Tudor.Ambarus@microchip.com wrote:
> On 4/23/21 12:33 AM, Guillaume Tucker wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi Tudor,
> 
> Hi, Guillaume,
> 
>>
>> Please see the bisection report below about a NULL pointer
>> dereference on RPi-3B with 64K pages.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
>>
> 
> Thanks, few other people reported it. There are some suggestions in
> the thread of the patch and I thought they are materialized in a fixing
> patch already.

The bisection was run for next-20210421 and I can see the problem
is still there in 20210422:

  https://linux.kernelci.org/test/case/id/608158c23ad9136bb59b782c/

I can keep an eye on linux-next results to see if it gets fixed
today or Monday and report here.

Best wishes,
Guillaume


> Stephen, do you know if there's already a patch addressing this? I wasn't
> Cc-ed. Do you want me to scratch a patch with one of the proposed methods?
> I'll skim through the linux-clk patchwork.
> 
> Cheers,
> ta
>  
>> This is the kernel error message in the full boot log:
>>
>>   https://storage.kernelci.org/next/master/next-20210421/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html#L336
>>
>> More details can be found here:
>>
>>   https://linux.kernelci.org/test/case/id/60801a28ecf57fef7d9b77af/
>>
>>
>> Please let us know if you need any help to debug this issue or
>> try a fix.
>>
>> Best wishes,
>> Guillaume
>>
>>
>> On 21/04/2021 22:40, KernelCI bot wrote:
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>> * This automated bisection report was sent to you on the basis  *
>>> * that you may be involved with the breaking commit it has      *
>>> * found.  No manual investigation has been done to verify it,   *
>>> * and the root cause of the problem may be somewhere else.      *
>>> *                                                               *
>>> * If you do send a fix, please include this trailer:            *
>>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>>> *                                                               *
>>> * Hope this helps!                                              *
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>>
>>> next/master bisection: baseline.dmesg.alert on bcm2837-rpi-3-b
>>>
>>> Summary:
>>>   Start:      b74523885a71 Add linux-next specific files for 20210421
>>>   Plain log:  https://storage.kernelci.org/next/master/next-20210421/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
>>>   HTML log:   https://storage.kernelci.org/next/master/next-20210421/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
>>>   Result:     6579c8d97ad7 clk: Mark fwnodes when their clock provider is added
>>>
>>> Checks:
>>>   revert:     PASS
>>>   verify:     PASS
>>>
>>> Parameters:
>>>   Tree:       next
>>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>   Branch:     master
>>>   Target:     bcm2837-rpi-3-b
>>>   CPU arch:   arm64
>>>   Lab:        lab-baylibre
>>>   Compiler:   gcc-8
>>>   Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
>>>   Test case:  baseline.dmesg.alert
>>>
>>> Breaking commit found:
>>>
>>> -------------------------------------------------------------------------------
>>> commit 6579c8d97ad7fc5671ee60234f3b8388abee5f77
>>> Author: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> Date:   Wed Feb 10 13:44:35 2021 +0200
>>>
>>>     clk: Mark fwnodes when their clock provider is added
>>>
>>>     This is a follow-up for:
>>>     commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
>>>
>>>     The above commit updated the deprecated of_clk_add_provider(),
>>>     but missed to update the preferred of_clk_add_hw_provider().
>>>     Update it now.
>>>
>>>     Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>     Acked-by: Stephen Boyd <sboyd@kernel.org>
>>>     Reviewed-by: Saravana Kannan <saravanak@google.com>
>>>     Link: https://lore.kernel.org/r/20210210114435.122242-2-tudor.ambarus@microchip.com
>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index 5052541a0986..60e12e0c036a 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -4615,6 +4615,8 @@ int of_clk_add_hw_provider(struct device_node *np,
>>>       if (ret < 0)
>>>               of_clk_del_provider(np);
>>>
>>> +     fwnode_dev_initialized(&np->fwnode, true);
>>> +
>>>       return ret;
>>>  }
>>>  EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);
>>> -------------------------------------------------------------------------------
>>>
>>>
>>> Git bisection log:
>>>
>>> -------------------------------------------------------------------------------
>>> git bisect start
>>> # good: [1fe5501ba1abf2b7e78295df73675423bd6899a0] Merge tag 'trace-v5.12-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
>>> git bisect good 1fe5501ba1abf2b7e78295df73675423bd6899a0
>>> # bad: [b74523885a715463203d4ccc3cf8c85952d3701a] Add linux-next specific files for 20210421
>>> git bisect bad b74523885a715463203d4ccc3cf8c85952d3701a
>>> # good: [a59aa904b6f45af01f1f87179437e31ba98506fc] Merge remote-tracking branch 'crypto/master'
>>> git bisect good a59aa904b6f45af01f1f87179437e31ba98506fc
>>> # good: [58af1162bdd0819bbec853afb574190f2be62464] Merge remote-tracking branch 'tip/auto-latest'
>>> git bisect good 58af1162bdd0819bbec853afb574190f2be62464
>>> # bad: [2e490d45230a23b07b7b2dc5f89ec213b677b032] Merge remote-tracking branch 'vfio/next'
>>> git bisect bad 2e490d45230a23b07b7b2dc5f89ec213b677b032
>>> # bad: [5941c9263bb2b27b5018f66a6f4111a6ba659a49] Merge remote-tracking branch 'driver-core/driver-core-next'
>>> git bisect bad 5941c9263bb2b27b5018f66a6f4111a6ba659a49
>>> # good: [3fe24bd182cc22c8e7e577553ae8efe3b4236afe] Merge remote-tracking branch 'kvm/next'
>>> git bisect good 3fe24bd182cc22c8e7e577553ae8efe3b4236afe
>>> # good: [dbb7b6249662b1a303e275c2e0dcdbefbae681bc] Merge remote-tracking branch 'percpu/for-next'
>>> git bisect good dbb7b6249662b1a303e275c2e0dcdbefbae681bc
>>> # good: [e5b20246d0707a4deee2e172b55a73b05309c05d] Merge remote-tracking branch 'drivers-x86/for-next'
>>> git bisect good e5b20246d0707a4deee2e172b55a73b05309c05d
>>> # bad: [c8a9c285f136f0cc65ac8328cd1710b155ad3df8] debugfs: drop pointless nul-termination in debugfs_read_file_bool()
>>> git bisect bad c8a9c285f136f0cc65ac8328cd1710b155ad3df8
>>> # bad: [b82a7b018b93d282d0f1a41a854ca3d071e02759] platform/x86: gpd pocket fan: Clean-up by using managed work init
>>> git bisect bad b82a7b018b93d282d0f1a41a854ca3d071e02759
>>> # good: [b6f617df4fa936c1ab1831c2b23563f6c1add6c4] driver core: Update device link status properly for device_bind_driver()
>>> git bisect good b6f617df4fa936c1ab1831c2b23563f6c1add6c4
>>> # bad: [53f95c55349e75b73f69ce36b0ae2a83b3f28fde] devcoredump: avoid -Wempty-body warnings
>>> git bisect bad 53f95c55349e75b73f69ce36b0ae2a83b3f28fde
>>> # bad: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
>>> git bisect bad 6579c8d97ad7fc5671ee60234f3b8388abee5f77
>>> # good: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Revert "driver core: Set fw_devlink=on by default""
>>> git bisect good ea718c699055c8566eb64432388a04974c43b2ea
>>> # first bad commit: [6579c8d97ad7fc5671ee60234f3b8388abee5f77] clk: Mark fwnodes when their clock provider is added
>>> -------------------------------------------------------------------------------
>>>
>>>
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>> Groups.io Links: You receive all messages sent to this group.
>>> View/Reply Online (#10226): https://groups.io/g/kernelci-results/message/10226
>>> Mute This Topic: https://groups.io/mt/82249004/924702
>>> Group Owner: kernelci-results+owner@groups.io
>>> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>>
>>>
>>
> 

