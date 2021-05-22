Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EA938D41D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhEVHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 03:05:33 -0400
Received: from m12-16.163.com ([220.181.12.16]:48563 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhEVHFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 03:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=7TBd/
        TLOmDZEIbXi8YCj4bDz7mwKDtKfsIP98K1VuFU=; b=V3yNnOz3jUO1C2U9rkbKf
        kDBe5+hSDcELLlu/pFOR2EN+fCzBAZKh/PHKpgjsu/2gGKYFfjZsn34QhvvQaEeQ
        V6NvFbqpXjJVUk0Jl0gwvg4xT03G3C0TDu/0IAvJQdwwk5KwnHWnQvX85/K8Yzzd
        XZ00rSLXiOB1/WBKFZo7XU=
Received: from [192.168.31.187] (unknown [36.170.35.140])
        by smtp12 (Coremail) with SMTP id EMCowADH1FjUrKhgzCd7sg--.25948S2;
        Sat, 22 May 2021 15:03:49 +0800 (CST)
Subject: Re: [PATCH v2] docs/zh_CN: Add zh_CN/admin-guide/lockup-watchdogs.rst
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
References: <20210522012150.117072-1-liuhailongg6@163.com>
 <CAMU9jJoqKkx3OFr+Da_8m9JGjPAPe1ppji3VonzL3F=zoKCBjQ@mail.gmail.com>
From:   Hailong Liu <liuhailongg6@163.com>
Message-ID: <79a5a52d-0252-980f-743e-3aebcf685e79@163.com>
Date:   Sat, 22 May 2021 15:03:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMU9jJoqKkx3OFr+Da_8m9JGjPAPe1ppji3VonzL3F=zoKCBjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADH1FjUrKhgzCd7sg--.25948S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFW3CrWDKr17Jw1xtFWUJwb_yoWxGrWxpF
        yqkFyxKa1xJryDW3WSqF9rJF1Ik3W8XrsrJr18tw18G3ZYkFn5tF10yrZ8K393urs3AF4U
        ZrZ0gFy8GrW0yrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jpCJPUUUUU=
X-Originating-IP: [36.170.35.140]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbiPRWaYFSIkh1iBgAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 10:30 AM, teng sterling wrote:
> Hailong Liu <liuhailongg6@163.com> 于2021年5月22日周六 上午9:22写道：
>>
>> From: Hailong Liu <liu.hailong6@zte.com.cn>
>>
>> Add translation zh_CN/admin-guide/lockup-watchdogs.rst and link it to
>> zh_CN/admin-guide/index.rst while clean its todo entry.
>>
>> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
>> ---
>>  .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>>  .../zh_CN/admin-guide/lockup-watchdogs.rst    | 66 +++++++++++++++++++
>>  2 files changed, 67 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst
>>
>> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
>> index be835ec8e632..460034cbc2ab 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
>> @@ -65,6 +65,7 @@ Todolist:
>>
>>     clearing-warn-once
>>     cpu-load
>> +   lockup-watchdogs
>>     unicode
>>
>>  Todolist:
>> @@ -100,7 +101,6 @@ Todolist:
>>     laptops/index
>>     lcd-panel-cgram
>>     ldm
>> -   lockup-watchdogs
>>     LSM/index
>>     md
>>     media/index
>> diff --git a/Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst b/Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst
>> new file mode 100644
>> index 000000000000..8474d325c534
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst
>> @@ -0,0 +1,66 @@
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: :doc:`../../../admin-guide/lockup-watchdogs`
> Now we don't write like that。In its place::
> 
> :Original: Documentation/admin-guide/lockup-watchdogs.rst
> 
Maybe I was referring to some outdated translation documents. 
 
>> +
>> +:译者:
>> +
>> + 刘海龙 Hailong Liu <liu.hailong6@zte.com.cn>
> blank line
> .. _cn_lockup-watchdogs:
Ok, thanks.

>> +
>> +=================================================
>> +Softlockup与hardlockup检测机制(又名:nmi_watchdog)
>> +=================================================
>> +
>> +Linux中内核实现了一种用以检测系统发生softlockup和hardlockup的看门狗机制。
>> +
>> +Softlockup是一种会引发系统在内核态中一直循环超过20秒（详见下面“实现”小节）导致
>> +其他任务没有机会得到运行的BUG。一旦检测到'softlockup'发生，默认情况下系统会打
>> +印当前堆栈跟踪信息并进入锁定状态。也可配置使其在检测到'softlockup'后进入panic
>> +状态；通过sysctl命令设置“kernel.softlockup_panic”、使用内核启动参数
>> +“softlockup_panic”（详见Documentation/admin-guide/kernel-parameters.rst）以及使
>> +能内核编译选项“BOOTPARAM_SOFTLOCKUP_PANIC”都可实现这种配置。
>> +
>> +而'hardlockup'是一种会引发系统在内核态一直循环超过10秒钟（详见"实现"小节）导致其
>> +他中断没有机会运行的缺陷。与'softlockup'情况类似，除了使用sysctl命令设置
>> +'hardlockup_panic'、使能内核选项“BOOTPARAM_HARDLOCKUP_PANIC”以及使用内核参数
>> +"nmi_watchdog"(详见:”Documentation/admin-guide/kernel-parameters.rst“)外，一旦检
>> +测到'hardlockup'默认情况下系统打印当前堆栈跟踪信息，然后进入锁定状态。
>> +
>> +这个panic选项也可以与panic_timeout结合使用（这个panic_timeout是通过稍具迷惑性的
>> +sysctl命令"kernel.panic"来设置），使系统在panic指定时间后自动重启。
>> +
>> +实现
>> +====
>> +
>> +Softlockup和hardlockup分别建立在hrtimer(高精度定时器)和perf两个子系统上而实现。
>> +这也就意味着理论上任何架构只要实现了这两个子系统就支持这两种检测机制。
>> +
>> +Hrtimer用于周期性产生中断并唤醒watchdog线程；NMI perf事件则以”watchdog_thresh“
>> +(编译时默认初始化为10秒，也可通过”watchdog_thresh“这个sysctl接口来进行配置修改)
>> +为间隔周期产生以检测 hardlockups。如果一个CPU在这个时间段内没有检测到hrtimer中
>> +断发生，'hardlockup 检测器'(即NMI perf事件处理函数)将会视系统配置而选择产生内核
>> +警告或者直接panic。
>> +
>> +而watchdog线程本质上是一个高优先级内核线程，每调度一次就对时间戳进行一次更新。
>> +如果时间戳在2*watchdog_thresh(这个是softlockup的触发门限)这段时间都未更新,那么
>> +"softlocup 检测器"(内部hrtimer定时器回调函数)会将相关的调试信息打印到系统日志中，
>> +然后如果系统配置了进入panic流程则进入panic，否则内核继续执行。
>> +
>> +Hrtimer定时器的周期是2*watchdog_thresh/5，也就是说在hardlockup被触发前hrtimer有
>> +2~3次机会产生时钟中断。
>> +
>> +如上所述,内核相当于为系统管理员提供了一个可调节hrtimer定时器和perf事件周期长度
>> +的调节旋钮。如何通过这个旋钮为特定使用场景配置一个合理的周期值要对lockups检测的
>> +响应速度和lockups检测开销这二者之间进行权衡。
>> +
>> +默认情况下所有在线cpu上都会运行一个watchdog线程。不过在内核配置了”NO_HZ_FULL“的
>> +情况下watchdog线程默认只会运行在管家(housekeeping)cpu上，而”nohz_full“启动参数指
>> +定的cpu上则不会有watchdog线程运行。试想，如果我们允许watchdog线程在”nohz_full“指
>> +定的cpu上运行，这些cpu上必须得运行时钟定时器来激发watchdog线程调度；这样一来就会
>> +使”nohz_full“保护用户程序免受内核干扰的功能失效。当然，副作用就是”nohz_full“指定
>> +的cpu即使在内核产生了lockup问题我们也无法检测到。不过，至少我们可以允许watchdog
>> +线程在管家(non-tickless)核上继续运行以便我们能继续正常的监测这些cpus上的lockups
>> +事件。
>> +
>> +不论哪种情况都可以通过sysctl命令kernel.watchdog_cpumask来对没有运行watchdog线程
>> +的cpu集合进行调节。对于nohz_full而言,如果nohz_full cpu上有异常挂住的情况，通过
>> +这种方式打开这些cpu上的watchdog进行调试可能会有所作用。
>> --
>> 2.17.1
>>
>>
> I have tested it.
> 
> Together with the above two places
> 
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> 
Thank you very much!

And I'm going to send a patch of v3 to fix these issues.

Hailong Liu

