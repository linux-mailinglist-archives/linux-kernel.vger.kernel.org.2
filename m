Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68A43E4DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhHIUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhHIUhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:37:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC8C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 13:37:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l4so10849792ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vpR69HXsk/s5UOiJBvZ32SD+9AorlJL97AWRHAd5f4w=;
        b=ptKlvk19cJfKgsrEJj3fDf/R0ciya8LQMyQTOjOMSvverprTI0RI8ADvXOJlTPjaxm
         Bcw58KTG56ZlODpcVLnTKmrdIk7/delDWwvRMg44w6MT3NFmmsh157SOzyD63hTifses
         PFckI20NtdfxyGtZ3WcjQ4/+PIwbxcRLIQIOBh7HwS5l8DCVBUJEnOrjX2chdMpBrWMH
         U4wZJSqAtVFZl54fdk5BhO3DWDaraisZK6UNQ2nTv+1YYJxxIydiLZsiG6lTz2hUqnKA
         IlKMyRE/zOZOdhnp2eN28JKe5e4yXQRSaoPjGFX2pcxwGlkTO9yS51kfZ5d+zfA+TXwi
         vVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vpR69HXsk/s5UOiJBvZ32SD+9AorlJL97AWRHAd5f4w=;
        b=Gv1f3YoBM22nZ3Utc0fiu50YLsD72YGpQ/i0RJTpVnfzlcLOAAX026GMtunU5CSrau
         rPPWRRXUhPsXgwDvWrpft0oH3Wy9yPkLiZ1t2uGi2UG0J9vKK6G5WWyzbmTstjFDcURl
         Eg8CQHq45A/YT+2JW6T7GUSs6DR3MT52rHERrX0eyNr16Z5JFhPYhnHKtAlGfLQDUMyw
         YTrjtDG52kDh+FzNBKsKPUEmEUDy0lTH/wEjnzpzbDulH+u7CJPHlIJRUBDqnxLKHthu
         nK1fGOfp+kNPykXJe3SaPeRB8Hz59sQ2mSBfOcGCdG9tkmQTgvXY5zAV2wcxNiofwQRc
         +Vaw==
X-Gm-Message-State: AOAM530b6FCIJF7aR6ULeQRp21U3NWNP5Q/wC25rQ1mKYLUUZG1CQUJm
        rgdqatfzlDSvGKnpchWQHmfCJIBQK0rgHg==
X-Google-Smtp-Source: ABdhPJzL02bvJFAQtbVyNKa/WyBoknfJuGiU0wxQ00OlCpAbUQt+RefQqzDTGZYUlUZ80lSgOp+l1w==
X-Received: by 2002:a2e:5005:: with SMTP id e5mr4003093ljb.253.1628541430190;
        Mon, 09 Aug 2021 13:37:10 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id bp17sm745656lfb.176.2021.08.09.13.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 13:37:09 -0700 (PDT)
Subject: Re: drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret'
 is never read [clang-analyzer-deadcode.DeadStores]
To:     kernel test robot <rong.a.chen@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202108080902.ZhmxmJZr-lkp@intel.com>
 <28df02cc-8b34-3d4e-2ed6-30af0ff44a42@intel.com>
 <94550f41-1204-8996-ef32-c25429481ceb@gmail.com> <YRF1t5kx6hTrv5LC@carbon>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <538445a9-3f96-5099-fb83-517e756a93fa@gmail.com>
Date:   Mon, 9 Aug 2021 23:37:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRF1t5kx6hTrv5LC@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 9:36 PM, Petko Manolov wrote:
> On 21-08-09 14:06:11, Pavel Skripkin wrote:
>> On 8/9/21 1:37 PM, kernel test robot wrote:
>> > 
>> > tree:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > head:   85a90500f9a1717c4e142ce92e6c1cb1a339ec78
>> > commit: 8a160e2e9aeb8318159b48701ad8a6e22274372d net: usb: pegasus:
>> > Check the return value of get_geristers() and friends;
>> > date:   4 days ago
>> > :::::: branch date: 8 hours ago
>> > :::::: commit date: 4 days ago
>> > config: x86_64-randconfig-c001-20210808 (attached as .config)
>> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
>> > 41a6b50c25961addc04438b567ee1f4ef9e40f98)
>> > reproduce (this is a W=1 build):
>> >           wget
>> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> > -O ~/bin/make.cross
>> >           chmod +x ~/bin/make.cross
>> >           # install x86_64 cross compiling tool for clang build
>> >           # apt-get install binutils-x86-64-linux-gnu
>> >           #
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a160e2e9aeb8318159b48701ad8a6e22274372d
>> >           git remote add linus
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> >           git fetch --no-tags linus master
>> >           git checkout 8a160e2e9aeb8318159b48701ad8a6e22274372d
>> >           # save the attached .config to linux build tree
>> >           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
>> > ARCH=x86_64 clang-analyzer
>> > If you fix the issue, kindly add following tag as appropriate
>> > Reported-by: kernel test robot <lkp@intel.com>
>> 
>> Hi, @Petko!
>> 
>> For you not to scan all these warnings:
>> 
>> > > > drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
>> >              ret = set_registers(pegasus, EthCtrl0, 3, data);
>> >              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >      drivers/net/usb/pegasus.c:461:2: note: Value stored to 'ret' is
>> > never read
>> >              ret = set_registers(pegasus, EthCtrl0, 3, data);
>> >              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> This is the real bug, I think. Can be fixed like this:
>> 
>> diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
>> index 22353bab76c8..f2b8891c7b36 100644
>> --- a/drivers/net/usb/pegasus.c
>> +++ b/drivers/net/usb/pegasus.c
>> @@ -459,6 +459,8 @@ static int enable_net_traffic(struct net_device *dev,
>> struct usb_device *usb)
>> 
>>  	memcpy(pegasus->eth_regs, data, sizeof(data));
>>  	ret = set_registers(pegasus, EthCtrl0, 3, data);
>> +	if (ret < 0)
>> +		goto fail;
>> 
>>  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
>>  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||
>> 
>> 
>> It was caused by our last refactoring: enable_net_traffic() now returns 0 on
>> success and this ret is never checked.
> 
> I'd rather remove the 'ret = ' part and leave set_registers() alone.  If this
> particular write operation fail, it doesn't mean the adapter won't work at all.
> Perhaps it won't be the most optimal mode, but it will work.  There are some
> legal checks after set_registers() that also make sense to pass.  So the patch i
> suggest looks like:
> 
> 
> diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
> index 652e9fcf0b77..49cfc720d78f 100644
> --- a/drivers/net/usb/pegasus.c
> +++ b/drivers/net/usb/pegasus.c
> @@ -433,7 +433,7 @@ static int enable_net_traffic(struct net_device *dev, struct usb_device *usb)
>          data[2] = loopback ? 0x09 : 0x01;
> 
>          memcpy(pegasus->eth_regs, data, sizeof(data));
> -       ret = set_registers(pegasus, EthCtrl0, 3, data);
> +       set_registers(pegasus, EthCtrl0, 3, data);
> 
>          if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
>              usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||
> 

It works. I am not aware of device specifics, so I decided to handle the 
error instead of ignoring.

Will you take care of posting this patch, or I can do it with 
Suggested-by tag?



With regards,
Pavel Skripkin
