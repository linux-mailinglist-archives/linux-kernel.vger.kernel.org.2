Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DAE3B9A9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhGBB5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhGBB5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:57:42 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C9C061762;
        Thu,  1 Jul 2021 18:55:10 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso2095106ood.7;
        Thu, 01 Jul 2021 18:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WaoPoeTCrAC2vIfpSCgYtHuCtmyF+Wrtr0uyihf3GIs=;
        b=WwDH+tynJJgVTcXCwrORn3XIs6Y3FBPejoM2o3hmZ1icCnWKFWUUZo93K9jeso/iVm
         hCGBnade7YaC3IhopOHBTgaEmclSIXcVWR4R7GveF8NPU5zNO9JhyqActjyxzXPKRKfJ
         qLXuBR26kwBQNoNybjgmzLRO3JOX+TVK6LLWnCVY825WBy4SGZRtGTtALkePPaUPHa3P
         7E86Kh2w+v8Gbhlmm/lbnOxMtvnduT+oTVETEOj/QpjoUkuZztQ4XcKsnWFxMKkCEZB6
         PLMqObKMMQLd/rYlyBdFFaxbb2JJxmKEA34GMgld0V3DgIGoY4JzvyBYP96cZGfeDmAi
         s70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WaoPoeTCrAC2vIfpSCgYtHuCtmyF+Wrtr0uyihf3GIs=;
        b=kx9IZQSb+2NNHoTWOR/q0JD2nbNKI0IHc+IPisAaTjn+hPAtwJw3oc0ddAClgbq6ie
         RXxxuwz4a9H7TYQpaCpVGV9Cav4m+viXnpk7uJlJsQuNCOzMyNuetUH/8UZm72eObyNs
         6YfUJQHCNaaskpSip8aeQIizj0ukI2dEd1OW6hC/83JULKVzmQ1qy2+QoNuJ56w7Hy8n
         Zmv75NApmMjmESVlP/I3jDftNb+A4I/ctpzEeZVJ0xYzFEro4WDRexYzCYc9NhHw/U3f
         d1+7Z3R7TztThuJFSUWNFnBX/zVBiF7Bhg1DnbOrPtm/VhaQ/sZ00TZgeGwcMBYoicFg
         XaqA==
X-Gm-Message-State: AOAM530j9x7ekZJZhrZE25sS9Tdt2KgCS3g7DdhOU6y0FAgjjZRciOno
        ZeRsmfAs/WrCNnvFFZcKSlc=
X-Google-Smtp-Source: ABdhPJxcRnLem9fQUbYpz5NizuRSnByRt59qSD4DN6QnvDJVfXCkpZRqCZ3uV99e96l8Rt4CtgUKPg==
X-Received: by 2002:a05:6820:168:: with SMTP id k8mr2311001ood.76.1625190909863;
        Thu, 01 Jul 2021 18:55:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o17sm370466oie.56.2021.07.01.18.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 18:55:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20210424110608.15748-1-michael@walle.cc>
 <20210424110608.15748-6-michael@walle.cc>
 <20210701213420.GA1131789@roeck-us.net>
 <f48661d2d54b37db395fb73af8b52359@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 5/5] mtd: core: add OTP nvmem provider support
Message-ID: <e89da7a0-2e46-349c-9b25-f0b555a72b46@roeck-us.net>
Date:   Thu, 1 Jul 2021 18:55:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f48661d2d54b37db395fb73af8b52359@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/21 3:10 PM, Michael Walle wrote:
> Hi Guenter,
> 
> Am 2021-07-01 23:34, schrieb Guenter Roeck:
>> Hi,
>>
>> On Sat, Apr 24, 2021 at 01:06:08PM +0200, Michael Walle wrote:
>>> Flash OTP regions can already be read via user space. Some boards have
>>> their serial number or MAC addresses stored in the OTP regions. Add
>>> support for them being a (read-only) nvmem provider.
>>>
>>> The API to read the OTP data is already in place. It distinguishes
>>> between factory and user OTP, thus there are up to two different
>>> providers.
>>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>
>> This patch causes a boot failure with one of my qemu tests.
>> With the patch in place, the flash fails to instantiate.
>>
>> [    1.156578] Creating 3 MTD partitions on "physmap-flash":
>> [    1.157192] 0x000000000000-0x000000040000 : "U-Boot Bootloader"
>> [    1.184632] 0x000000040000-0x000000060000 : "U-Boot Environment"
>> [    1.201767] 0x000000060000-0x000000800000 : "Flash"
>> [    1.222320] Deleting MTD partitions on "physmap-flash":
>> [    1.222744] Deleting U-Boot Bootloader MTD partition
>> [    1.303597] Deleting U-Boot Environment MTD partition
>> [    1.368751] Deleting Flash MTD partition
>> [    1.430619] physmap-flash: probe of physmap-flash failed with error -61
>>
>> -61 is -ENODATA.
>>
>> Other boot tests with different flash chips can still boot.
>> Reverting this patch (as well as the follow-up patches) fixes
>> the problem.
>>
>> I do not know if this is a problem with qemu or a problem with the
>> patch, but, as I mentioned, other flash chips do still instantiate.
>>
>> Do you have an idea what to look for when I try to track down the problem ?
> 
> I'd start by looking at the return code of mtd_otp_size() because that
> should be the only function which communicates with the flash at probe
> time.
> 
> Can you share how to reproduce that problem? Like the qemu commandline
> and involved images?
> 

qemu-system-arm -M z2 -kernel arch/arm/boot/zImage -no-reboot \
     -snapshot -drive file=/tmp/flash,format=raw,if=pflash \
     --append "root=/dev/mtdblock2 console=ttyS0" \
     -nographic -monitor null -serial stdio

This is with qemu v6.0 and pxa_defconfig. The actual flash image doesn't
really matter (an empty file with a size of 1024*1024*8 bytes is sufficient).

Debugging shows that -ENODATA is reported by cfi_intelext_otp_walk(),
thanks to:

[    0.737244] #### FeatureSupport: 0x0 NumProtectionFields: 1

which seems to suggest that there are indeed flash chips which don't support
OTP data. With this in mind, is it indeed appropriate to disable support for
all flash chips which don't support OTP data ?

Thanks,
Guenter
