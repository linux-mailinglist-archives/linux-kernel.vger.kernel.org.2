Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338653A0CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhFIG4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:56:24 -0400
Received: from m32-153.88.com ([43.250.32.153]:39462 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhFIG4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=8jmEclklsmRzTtzgSlse4dg8+WXuBay1/M9lH
        Axugcs=; b=EOVhK0Bag684GSjfmq+syQTA20ntFmSRPvkT1z4esZauG7QE5qM1+
        aNjuTsaO7mYYEOi9EW2wd8JBJAsNli3pgCIY6YRWqPZ+Zi8O8EjZTwUToPgkO/E0
        uwMZkiFVUaLYi5t4WaoFwU6uzcXd++JCkykpM/OUvD9ivA8pIpR79g=
Received: from [0.0.0.0] (unknown [113.251.9.88])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAH3vycZcBgRl0HAA--.21196S3;
        Wed, 09 Jun 2021 14:54:21 +0800 (CST)
Subject: Re: [PATCH v3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Wu X.C." <bobwxc@email.cn>, Bernard Zhao <bernard@vivo.com>,
        Fangrui Song <maskray@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210605120504.40246-1-src.res@email.cn>
 <CAMU9jJqRBdKgjUZYL1itw9rz+-v2AFTv87NtGj7HCEah=4eZCA@mail.gmail.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <1ef8effe-c7c3-53fe-977e-972dcff04570@email.cn>
Date:   Wed, 9 Jun 2021 14:54:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMU9jJqRBdKgjUZYL1itw9rz+-v2AFTv87NtGj7HCEah=4eZCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgAH3vycZcBgRl0HAA--.21196S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xWF1rCF1xXF4kJw15XFb_yoWfWFWxpF
        4vgr97KF4UZryUA348KFyjqr12kF97GF47tF18ta4Sqr1vya9YkrsFqFyqg34fWrW8ZF98
        ZF1rKFyjkw1jyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv
        8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU00PfPUUUUU==
X-Originating-IP: [113.251.9.88]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/9 上午11:22, teng sterling 写道:
> Hi Haowen
>
> Thank you for your translation！
>
> Hu Haowen <src.res@email.cn> 于2021年6月5日周六 下午8:13写道：
>> Create new translations for dev-tools/testing-overview.rst and link it
>> to dev-tools/index.rst with TODOList modifications.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>   .../translations/zh_CN/dev-tools/index.rst    |   5 +
>>   .../zh_CN/dev-tools/testing-overview.rst      | 110 ++++++++++++++++++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>> index fd73c479917b..6424590ea382 100644
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>> @@ -11,6 +11,9 @@
>>   目前这些文档已经整理在一起，不需要再花费额外的精力。
>>   欢迎任何补丁。
>>
>> +有关测试专用工具的简要概述，参见
>> +Documentation/dev-tools/translations/zh_CN/testing-overview.rst
>> +
>>   .. class:: toc-title
>>
>>             目录
>> @@ -19,6 +22,7 @@
>>      :maxdepth: 2
>>
>>      gcov
>> +   testing-overview
>>
>>   Todolist:
>>
>> @@ -29,6 +33,7 @@ Todolist:
>>    - ubsan
>>    - kmemleak
>>    - kcsan
>> + - kfence
>>    - gdb-kernel-debugging
>>    - kgdb
>>    - kselftest
>> diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>> new file mode 100644
>> index 000000000000..a2746c81033b
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>> @@ -0,0 +1,110 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/dev-tools/testing-overview.rst
>> +:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
>> +
>> +============
>> +内核测试指南
>> +============
>> +
>> +有许多不同的工具可以用于测试Linux内核，因此了解什么时候使用它们可能
> here origin doc: There are a number of different tools for testing the
> Linux kernel, so knowing when to use *each of them* can be a
> challenge.
>
> how about?
>   有许多不同的工具可以用于测试Linux内核，因此搞明白使用每一种工具的时机可能是一个挑战。


Nice advice. Thanks for pointing it out. I'll send patch v4.


Thx,

Hu Haowen


>
> Your translation is fine, so decide for yourself which one you want to use.
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>
> Thanks，
> Yanteng
>
>> +很困难。本文档粗略概述了它们之间的区别，并阐释了它们是怎样糅合在一起
>> +的。
>> +
>> +编写和运行测试
>> +==============
>> +
>> +大多数内核测试都是用kselftest或KUnit框架之一编写的。它们都让运行测试
>> +更加简化，并为编写新测试提供帮助。
>> +
>> +如果你想验证内核的行为——尤其是内核的特定部分——那你就要使用kUnit或
>> +kselftest。
>> +
>> +KUnit和kselftest的区别
>> +----------------------
>> +
>> +.. note::
>> +     由于本文段中部分术语尚无较好的对应中文释义，可能导致与原文含义
>> +     存在些许差异，因此建议读者结合原文
>> +     （Documentation/dev-tools/testing-overview.rst）辅助阅读。
>> +
>> +     如对部分翻译有异议或有更好的翻译意见，欢迎联系译者进行修订。
>> +
>> +KUnit（Documentation/dev-tools/kunit/index.rst）是用于“白箱”测
>> +试的一个完整的内核内部系统：因为测试代码是内核的一部分，所以它能够访
>> +问用户空间不能访问到的内部结构和功能。
>> +
>> +因此，KUnit测试最好针对内核中较小的、自包含的部分，以便能够独立地测
>> +试。“单元”测试的概念亦是如此。
>> +
>> +比如，一个KUnit测试可能测试一个单独的内核功能（甚至通过一个函数测试
>> +一个单一的代码路径，例如一个错误处理案例），而不是整个地测试一个特性。
>> +
>> +这也使得KUnit测试构建和运行非常地快，从而能够作为开发流程的一部分被
>> +频繁地运行。
>> +
>> +有关更详细的介绍，请参阅KUnit测试代码风格指南
>> +Documentation/dev-tools/kunit/style.rst
>> +
>> +kselftest（Documentation/dev-tools/kselftest.rst），相对来说，大量用
>> +于用户空间，并且通常测试用户空间的脚本或程序。
>> +
>> +这使得编写复杂的测试，或者需要操作更多全局系统状态的测试更加容易（诸
>> +如生成进程之类）。然而，从kselftest直接调用内核函数是不行的。这也就
>> +意味着只有通过某种方式（如系统调用、驱动设备、文件系统等）导出到了用
>> +户空间的内核功能才能使用kselftest来测试。为此，有些测试包含了一个伴
>> +生的内核模块用于导出更多的信息和功能。不过，对于基本上或者完全在内核
>> +中运行的测试，KUnit可能是更佳工具。
>> +
>> +kselftest也因此非常适合于全部功能的测试，因为这些功能会将接口暴露到
>> +用户空间，从而能够被测试，而不是展现实现细节。“system”测试和
>> +“end-to-end”测试亦是如此。
>> +
>> +比如，一个新的系统调用应该伴随有新的kselftest测试。
>> +
>> +代码覆盖率工具
>> +==============
>> +
>> +支持两种不同代码之间的覆盖率测量工具。它们可以用来验证一项测试执行的
>> +确切函数或代码行。这有助于决定内核被测试了多少，或用来查找合适的测试
>> +中没有覆盖到的极端情况。
>> +
>> +:doc:`gcov` 是GCC的覆盖率测试工具，能用于获取内核的全局或每个模块的
>> +覆盖率。与KCOV不同的是，这个工具不记录每个任务的覆盖率。覆盖率数据可
>> +以通过debugfs读取，并通过常规的gcov工具进行解释。
>> +
>> +:doc:`kcov` 是能够构建在内核之中，用于在每个任务的层面捕捉覆盖率的一
>> +个功能。因此，它对于模糊测试和关于代码执行期间信息的其它情况非常有用，
>> +比如在一个单一系统调用里使用它就很有用。
>> +
>> +动态分析工具
>> +============
>> +
>> +内核也支持许多动态分析工具，用以检测正在运行的内核中出现的多种类型的
>> +问题。这些工具通常每个去寻找一类不同的缺陷，比如非法内存访问，数据竞
>> +争等并发问题，或整型溢出等其他未定义行为。
>> +
>> +如下所示：
>> +
>> +* kmemleak检测可能的内存泄漏。参阅
>> +  Documentation/dev-tools/kmemleak.rst
>> +* KASAN检测非法内存访问，如数组越界和释放后重用（UAF）。参阅
>> +  Documentation/dev-tools/kasan.rst
>> +* UBSAN检测C标准中未定义的行为，如整型溢出。参阅
>> +  Documentation/dev-tools/ubsan.rst
>> +* KCSAN检测数据竞争。参阅 Documentation/dev-tools/kcsan.rst
>> +* KFENCE是一个低开销的内存问题检测器，比KASAN更快且能被用于批量构建。
>> +  参阅 Documentation/dev-tools/kfence.rst
>> +* lockdep是一个锁定正确性检测器。参阅
>> +  Documentation/locking/lockdep-design.rst
>> +* 除此以外，在内核中还有一些其它的调试工具，大多数能在
>> +  lib/Kconfig.debug 中找到。
>> +
>> +这些工具倾向于对内核进行整体测试，并且不像kselftest和KUnit一样“传递”。
>> +它们可以通过在启用这些工具时运行内核测试以与kselftest或KUnit结合起来：
>> +之后你就能确保这些错误在测试过程中都不会发生了。
>> +
>> +一些工具与KUnit和kselftest集成，并且在检测到问题时会自动打断测试。
>> +
>> --
>> 2.25.1
>>

