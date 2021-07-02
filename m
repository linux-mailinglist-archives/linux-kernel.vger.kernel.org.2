Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D053B9E49
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGBJgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhGBJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:36:29 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE8C061762;
        Fri,  2 Jul 2021 02:33:57 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A18722249;
        Fri,  2 Jul 2021 11:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625218433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIgpNtb6bk7Xip9BGn8GnsVHJ/WF1JakLymLgy2KJk8=;
        b=vXXDkhNWvpBcLBM8QHfOVJrNveocFevI0aNqo7+KH7yxb8jtCBDkFe6ywlDnqZnmU33PIB
        IPkPWUsKu+G054p7+1WZFel7W1hLym/PvYufL8YYAjBKSR2r1tvEoJFCzdQfbB57xy9QCg
        oMlJNs0xrND8IVHhmZ7zh4zTMprfC6Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 02 Jul 2021 11:33:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 5/5] mtd: core: add OTP nvmem provider support
In-Reply-To: <e89da7a0-2e46-349c-9b25-f0b555a72b46@roeck-us.net>
References: <20210424110608.15748-1-michael@walle.cc>
 <20210424110608.15748-6-michael@walle.cc>
 <20210701213420.GA1131789@roeck-us.net>
 <f48661d2d54b37db395fb73af8b52359@walle.cc>
 <e89da7a0-2e46-349c-9b25-f0b555a72b46@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5ce79af321eb04e33178b78e4e3f45f0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-07-02 03:55, schrieb Guenter Roeck:
> On 7/1/21 3:10 PM, Michael Walle wrote:
>> Hi Guenter,
>> 
>> Am 2021-07-01 23:34, schrieb Guenter Roeck:
>>> Hi,
>>> 
>>> On Sat, Apr 24, 2021 at 01:06:08PM +0200, Michael Walle wrote:
>>>> Flash OTP regions can already be read via user space. Some boards 
>>>> have
>>>> their serial number or MAC addresses stored in the OTP regions. Add
>>>> support for them being a (read-only) nvmem provider.
>>>> 
>>>> The API to read the OTP data is already in place. It distinguishes
>>>> between factory and user OTP, thus there are up to two different
>>>> providers.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> 
>>> This patch causes a boot failure with one of my qemu tests.
>>> With the patch in place, the flash fails to instantiate.
>>> 
>>> [    1.156578] Creating 3 MTD partitions on "physmap-flash":
>>> [    1.157192] 0x000000000000-0x000000040000 : "U-Boot Bootloader"
>>> [    1.184632] 0x000000040000-0x000000060000 : "U-Boot Environment"
>>> [    1.201767] 0x000000060000-0x000000800000 : "Flash"
>>> [    1.222320] Deleting MTD partitions on "physmap-flash":
>>> [    1.222744] Deleting U-Boot Bootloader MTD partition
>>> [    1.303597] Deleting U-Boot Environment MTD partition
>>> [    1.368751] Deleting Flash MTD partition
>>> [    1.430619] physmap-flash: probe of physmap-flash failed with 
>>> error -61
>>> 
>>> -61 is -ENODATA.
>>> 
>>> Other boot tests with different flash chips can still boot.
>>> Reverting this patch (as well as the follow-up patches) fixes
>>> the problem.
>>> 
>>> I do not know if this is a problem with qemu or a problem with the
>>> patch, but, as I mentioned, other flash chips do still instantiate.
>>> 
>>> Do you have an idea what to look for when I try to track down the 
>>> problem ?
>> 
>> I'd start by looking at the return code of mtd_otp_size() because that
>> should be the only function which communicates with the flash at probe
>> time.
>> 
>> Can you share how to reproduce that problem? Like the qemu commandline
>> and involved images?
>> 
> 
> qemu-system-arm -M z2 -kernel arch/arm/boot/zImage -no-reboot \
>     -snapshot -drive file=/tmp/flash,format=raw,if=pflash \
>     --append "root=/dev/mtdblock2 console=ttyS0" \
>     -nographic -monitor null -serial stdio
> 
> This is with qemu v6.0 and pxa_defconfig. The actual flash image 
> doesn't
> really matter (an empty file with a size of 1024*1024*8 bytes is 
> sufficient).

For completeness: with pxa_defconfig, I guess.

> Debugging shows that -ENODATA is reported by cfi_intelext_otp_walk(),
> thanks to:

Thanks for already looking into this.

> 
> [    0.737244] #### FeatureSupport: 0x0 NumProtectionFields: 1
> 
> which seems to suggest that there are indeed flash chips which don't 
> support
> OTP data. With this in mind, is it indeed appropriate to disable 
> support for
> all flash chips which don't support OTP data ?

Yes of course. The SPI NOR drivers doesn't register the callbacks if
there is no OTP support. The others return ENODATA, which I missed.

I'll send a patch shortly.

-michael
