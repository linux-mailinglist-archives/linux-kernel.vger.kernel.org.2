Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35138C93E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhEUObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:31:44 -0400
Received: from m12-12.163.com ([220.181.12.12]:50094 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhEUObm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=9E886
        vx/OO/P//cwyNBUwq6A5knojODRU6jbrRSsoSk=; b=pnEgiCjLyv2zZWqwrV3Jp
        AqNcQmSIkD+oqE3Fyh/z3D5QK1pQ4Bn2Z3YKflNXo41YWUEI07lLlOfUhq/txgxT
        QBmia6A6NGrIxeULDlzuZNsGxvFbv4iQ2eodXRa2CzAgzrIkO4ww9CrWRiHz2a37
        Vrd0PNhLCNS9hvPrJVF+rQ=
Received: from [192.168.31.187] (unknown [36.170.35.140])
        by smtp8 (Coremail) with SMTP id DMCowAB3p1vrw6dgrcOfFQ--.47192S2;
        Fri, 21 May 2021 22:30:05 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: Add zh_CN/admin-guide/lockup-watchdogs.rst
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Yanteng Si <siyanteng@loongson.cn>
References: <20210513154425.93603-1-liuhailongg6@163.com>
 <CAMU9jJrXQfg_7jVe4MhDSRO3-q1EhDCFRKASfV5REO6PQJxVaw@mail.gmail.com>
From:   Hailong Liu <liuhailongg6@163.com>
Message-ID: <46dd6bb8-84bc-e28e-e463-95b5b6b68e2c@163.com>
Date:   Fri, 21 May 2021 22:30:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMU9jJrXQfg_7jVe4MhDSRO3-q1EhDCFRKASfV5REO6PQJxVaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAB3p1vrw6dgrcOfFQ--.47192S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry3Aw4xtw1UGFW7AFW3trb_yoW5ZFW8pF
        ZxAa4fKw48J34kXa47J348WF1Yk34kJrW5Ga4ktryUJw1Ykrn5Aw4Utr45Waya9F4Syr4j
        qF1Ut34kJFyDJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLXocUUUUU=
X-Originating-IP: [36.170.35.140]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbi8A2ZYFuob4d6TQAAso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 5:38 PM, teng sterling wrote:
> CC siyanteng@loongson.cn
> 
> BTW：
> 
> I don't know why, but your email was treated as spam by gmail. I use
> gmail email to subscribe to doc-list, so I didn't find it before,
> maybe many people are like me. :-)
> 
Oh, that's too bad. Unforunately I don't know this at all. I promise, I
have never done anything to annoy gmail. :-)


>> @@ -0,0 +1,65 @@
> refer to other Chinese translations, add maintainer information and
> tags and original documentation links.
> 
Alright, got it. 

>> +===============================================================
>> +Softlockup与hardlockup检测机制(又名:nmi_watchdog)
>> +===============================================================
> the line is too long，align it with the text
> 
Ok, I will try to fix it in 2nd version.

>> +Softlockup是一种在内核持续循使用CPU超过20秒（详见下面“实现”小节）
> origindoc: A ‘softlockup’ is defined as a bug that causes the kernel
> to loop in kernel mode for more than 20 seconds
> 
> It's not right for you to translate it that way. Although there are
> not many cases where the kernel uses the cpu continuously for more
> than 20s, it doesn't mean it doesn't exist, let alone conclude that it
> will definitely panic.
> 
> btw：
> 
> bug：计算机领域专业术语，bug原意是“臭虫”，现在用来指代计算机上存在的漏洞，原因是系统安全策略上存在的缺陷，有攻击者能够在未授权的情况下访问的危害。
I have to admit that this paragraph is indeed not precise enough.

>> +导致其他任务无法得到运行的内核问题。一旦检测到'softlockup'发生，默认
>> +情况下系统会打印当前堆栈跟踪信息并进入锁定状态。也可配置使其在检测到
>> +'softlockup'后进入panic状态；通过sysctl命令设置
>> +“kernel.softlockup_panic”、使用内核启动参数“softlockup_panic”（详见
>> +Documentation/admin-guide/kernel-parameters.rst）以及使能内核编译选项
>> +“BOOTPARAM_SOFTLOCKUP_PANIC”都可实现这种配置。
>> +
>> +而'hardlockup'是内核中持续循环超过10秒钟（详见"实现"小节）导致其他中
> maybe 内核态？
You are right. "内核态" is more appropriate.

>> +断无法运行的问题。与'softlockup'情况类似，除了使用sysctl命令设置
> 不给其他中断运行的机会 != 其他中断无法运行 
Thanks for correcting!

>> +Hrtimer用于周期性产生中断并唤醒watchdog任务；而NMI perf事件则以
>> +”watchdog_thresh“(编译时默认初始化为10秒，也可通过”watchdog_thresh“这
>> +个sysctl接口来进行配置修改)为间隔周期产生以检测 hardlockups。如果一个
>> +CPU在这个时间段内没有检测到hrtimer中断发生，'hardlockup 检测器'(即
>> +NMI perf事件处理函数)将会视系统配置而选择产生内核告警或者直接panic。
> 内核警告
Ok, got it.

>> +如上所述,内核相当于为系统管理员提供了一个可调节hrtimer定时器和perf事件
>> +的周期长短的旋钮。对于特定的场景通过这个旋钮配置一个合理的周期值需要权
>> +衡lockups检测的响应速度和检测的开销。
>> +
>> +默认情况下所有在线cpu上都会运行一个watchdog任务。不过在内核配置了
> maybe watchdog线程/进程？
> 
I prefer to choose "线程".

I'm grateful to you for verifying my patch word by word, I will
try to fix and optimize them in patch v2 later.

Thanks,

Hailong


