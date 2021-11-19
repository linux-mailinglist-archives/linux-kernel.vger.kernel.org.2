Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8204571A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhKSPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:35:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53841C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:32:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n29so18754056wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wV4wJJpmYh6HipReI3fDsUH0fiBx6SdFL0Swu7E3zSM=;
        b=jZ7ti0B2QFWlCsplqAy6+Ws8mZ27llC4yvy+YUma3SYSQG2DB9dRYtiNmUxSfdOTE3
         2QL67rF36z3kwAXvHKfg1ji3ZE6SqcOB9QRL27DtCfuRKesbWKifdT6Bgk3FCjLhEsLz
         C7513+Uz2xmLnKnrL74GOvLzgoeAU6MaJs8CBOCjw0a0cypPRkuyTooQa4j4P1QwrKQB
         ejMV2kdyl6GXPS7bozasvYzWO/g6xpSUK3m0Kxih/PohKfXQkbSnLqsWBPt69PIzUH2s
         uzgDE3bYscnrwmu91cOAvTsrkA8/VqQgP2BjgvniXWdYlYzK1Xt3tQ4XZ8plimdMIWKR
         ag2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wV4wJJpmYh6HipReI3fDsUH0fiBx6SdFL0Swu7E3zSM=;
        b=iXf1ZSk5a/B3dju2AIDcU+uWRLeSkiL2Zj1IyPgTyyuwnrlB8+W2GtkZW49R8C3BnB
         ghL5L44TOwEcaFpoi07Ogr2e7n0R2bUdZfEBcXKNnVEocKLRgOWbielYQeyV2sLx2euD
         lotidBIPA1aMWqy9y78Xv5ILjmU3rqQchv4EepnzjQnx7x3OONBODgJ5CO8zwDoWFZbh
         e8BZBy4WU/RxIlPr0c86Y4Mf2amzAGyFSdE4thwKlXR+c1OUgd6jQqiB1tGI0UdXpN5v
         7Zpbh2C2suLwe1DgDUPWghqb4buz4p8kZoNgI07zbszeSbSzDjS/kqIwo3MJmStL8ApR
         ZkRA==
X-Gm-Message-State: AOAM5336ztJDe5eVp+H/0UJIyFgYBheT+8MJq5IzA55ZjI4Tz6M5YpHo
        +llraWp0JbYHX52ujdurBHA=
X-Google-Smtp-Source: ABdhPJyTJgseNDu/9/ebEyQ05sPai0RRt7zg3xAszWFi3cybeqoZoKd4/WrhEp2a34XyfkRiDEa0cw==
X-Received: by 2002:a05:6000:10c7:: with SMTP id b7mr8749257wrx.160.1637335953831;
        Fri, 19 Nov 2021 07:32:33 -0800 (PST)
Received: from [192.168.1.10] ([176.251.126.168])
        by smtp.googlemail.com with ESMTPSA id q123sm12372543wma.30.2021.11.19.07.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:32:30 -0800 (PST)
Message-ID: <3212e538-f846-40ba-7a2a-a687c24c8b1a@googlemail.com>
Date:   Fri, 19 Nov 2021 15:32:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Intel bluetooth regression in 5.15.3
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rafael.j.wysocki@intel.com
References: <371c6dde-ee04-cf2e-1463-113ba8a2ac22@googlemail.com>
 <YZe2iVBCPIdsWmZd@kroah.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <YZe2iVBCPIdsWmZd@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2021 14:36, Greg Kroah-Hartman wrote:
> On Fri, Nov 19, 2021 at 01:43:32PM +0000, Chris Clayton wrote:
>> Hi,
>>
>> I built and installed 5.15.3 this morning and found that my bluetooth devices no longer work. 5.15.2 and 5.10.80 are
>> both OK.
>>
>> I've bisected it and landed on:
>>
>> cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039 is the first bad commit
>> commit cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039
>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Date:   Sat Oct 9 16:22:09 2021 +0200
>>
>>     ACPI: scan: Release PM resources blocked by unused objects
>>
>>     [ Upstream commit c10383e8ddf4810b9a5c1595404c2724d925a0a6 ]
>>
>>     On some systems the ACPI namespace contains device objects that are
>>     not used in certain configurations of the system.  If they start off
>>     in the D0 power state configuration, they will stay in it until the
>>     system reboots, because of the lack of any mechanism possibly causing
>>     their configuration to change.  If that happens, they may prevent
>>     some power resources from being turned off or generally they may
>>     prevent the platform from getting into the deepest low-power states
>>     thus causing some energy to be wasted.
>>
>>     Address this issue by changing the configuration of unused ACPI
>>     device objects to the D3cold power state one after carrying out
>>     the ACPI-based enumeration of devices.
>>
>>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
>>     Link: https://lore.kernel.org/linux-acpi/20211007205126.11769-1-mario.limonciello@amd.com/
>>     Reported-by: Mario Limonciello <mario.limonciello@amd.com>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>     Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>>  drivers/acpi/glue.c     | 25 +++++++++++++++++++++++++
>>  drivers/acpi/internal.h |  1 +
>>  drivers/acpi/scan.c     |  6 ++++++
>>  3 files changed, 32 insertions(+)
>>
>> 5.15.3 with that commit reverted works fine.
>>
>> Let me know if you need any additional diagnostics or patches tested but please cc me as I'm not subscribed.
> 
> Is 5.16-rc1 also a problem for you and your devices?
> 
> thanks,
> 

No, 5.16-rc1+, built after a git pull just a few minutes ago, woks fine. Looking at Linus's tree, the commit I
identified in the bisection was reverted a couple of days ago (commit 3b2b49e6dfdcf423506a771bf44cee842596351a).

Thanks

Chris
> greg k-h
> 
