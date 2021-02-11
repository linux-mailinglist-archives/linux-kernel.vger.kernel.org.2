Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004A2318E37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 16:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhBKPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 10:23:16 -0500
Received: from m12-13.163.com ([220.181.12.13]:48941 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhBKO5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=Q/+NP
        hN+99lUgbabLKtXpk35WqE8GnVeyhv0MG+hTYY=; b=W3b4NGNPzNlQV2ms/tD3v
        jjCEhE8qDKNEEMUbAvL0QfgGOvgQIUh9D8v/EWhDXhxgee7w72zNdLOwLHrcntDK
        kNspimnZtNlCq49QIiwXxhIHUJMIGoDU7tmAsnfJnPwvQ4+68KtBYBCEqy0NvHIu
        eNdIxdJ6tZJD1nSMwK2hYQ=
Received: from [192.168.31.184] (unknown [61.152.197.77])
        by smtp9 (Coremail) with SMTP id DcCowACH5o5uDiVgMq9qew--.26070S2;
        Thu, 11 Feb 2021 19:01:03 +0800 (CST)
Subject: Re: [PATCH] kswapd: no need reclaim cma pages triggered by unmovable
 allocation
To:     Michal Hocko <mhocko@suse.com>
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rostedt@goodmis.org, mingo@redhat.com, vbabka@suse.cz,
        rientjes@google.com, willy@linux.intel.com,
        pankaj.gupta.linux@gmail.com, bhe@redhat.com, ying.huang@intel.com,
        minchan@kernel.org, ruxian.feng@transsion.com,
        kai.cheng@transsion.com, zhao.xu@transsion.com,
        yunfeng.lan@transsion.com, zhouxianrong@tom.com,
        zhou xianrong <xianrong.zhou@transsion.com>
References: <20210209082313.21969-1-xianrong_zhou@163.com>
 <YCJUnWLlcSGoR1sT@dhcp22.suse.cz>
 <bc294334-eec3-f755-cb51-0e302e82809b@163.com>
 <YCPcRj/e9NdQIV9S@dhcp22.suse.cz>
From:   zhou xianrong <xianrong_zhou@163.com>
Message-ID: <d692865c-82ae-103f-b48e-9b7682de28b6@163.com>
Date:   Thu, 11 Feb 2021 19:01:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCPcRj/e9NdQIV9S@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DcCowACH5o5uDiVgMq9qew--.26070S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryfJF4rKrykGryfGr1kGrg_yoW8JFyxpF
        Z3W3WUKa1kJFW5JrnFvw1FgFyIkw48Kry3J3WUurnIv3sxCrya9395Cr1j9FyFyr1UAF1Y
        vrWjga47Xr1kZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNUUbUUUUU=
X-Originating-IP: [61.152.197.77]
X-CM-SenderInfo: h0ld02prqjs6xkrxqiywtou0bp/xtbBUQ82z1aD95lSwQAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/10 下午9:14, Michal Hocko wrote:
> On Wed 10-02-21 12:07:57, zhou xianrong wrote:
>> On 2021/2/9 下午5:23, Michal Hocko wrote:
>>> On Tue 09-02-21 16:23:13, zhou wrote:
>>>> From: zhou xianrong <xianrong.zhou@transsion.com>
>>>>
>>>> For purpose of better migration cma pages are allocated after
>>>> failure movalbe allocations and are used normally for file pages
>>>> or anonymous pages.
>>>>
>>>> In reclaim path so many cma pages if configurated are reclaimed
>>>> from lru lists in kswapd mainly or direct reclaim triggered by
>>>> unmovable or reclaimable allocations. But these cma pages can not
>>>> be used by original unmovable or reclaimable allocations. So the
>>>> reclaim are unnecessary.
>>>>
>>>> In a same system if the cma pages were configurated to large then
>>>> more failture unmovable (vmalloc etc.) or reclaimable (slab etc.)
>>>> allocations are arised and then more kswapd rounds are triggered
>>>> and then more cma pages are reclaimed.
>>> Could you be more specific? Do you have any numbers and an example
>>> configuration when this is visible?
>> It should be implicit.
> Right but the scale of the problem is an important part of _any_ patch
> justification.
Sorry. The relative description is  not suitable and should be removed.

