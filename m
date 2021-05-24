Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BE38E667
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhEXMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:15:29 -0400
Received: from m32-153.88.com ([43.250.32.153]:38068 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232494AbhEXMP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=ca01UQN7MZOW4z+sPN6rox4MNbO2qaQWStCJC
        ISGBaY=; b=EYSKUlu3RVXVYp9Sa7Uil1LuDFe2/XHR971fpYoPeP+7yRSXKvhfU
        MDKb9t+u9uoEVOi/PYs3xBQ0no2y/gb9pl/+BsRif9jGpI3pblNgio+HCFHqmD5j
        H+tfxir5HQpByg6FDUA3LHJuqOJXC2rBDopp3MilQnEPNVaO8FuGug=
Received: from [0.0.0.0] (unknown [113.204.183.194])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBHl1l+mKtgZwNGAA--.40980S2;
        Mon, 24 May 2021 20:13:51 +0800 (CST)
Subject: Re: [PATCH v2 2/3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, maskray@google.com,
        bernard@vivo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210523140332.GA1097@bobwxc.top>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <c5f5ee6a-46f8-ff72-059d-baeba42d234f@email.cn>
Date:   Mon, 24 May 2021 20:13:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523140332.GA1097@bobwxc.top>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgBHl1l+mKtgZwNGAA--.40980S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr17KFWUJw17CF47uw1xXwb_yoWfurW3pF
        WvgF97Ka1UZryUA348K3WUXr1akF929F43tF18ta4Sqr1kAFZakrZFqFyqg34fWry8ZF98
        ZayFgFyj9w1qyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JrC_JFWl8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x0Jj-VyxUUUUU=
X-Originating-IP: [113.204.183.194]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/23 下午10:03, Wu X.C. 写道:
>> Create new translations for dev-tools/testing-overview.rst and link it
>> to dev-tools/index.rst with TODOList modifications.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>   .../translations/zh_CN/dev-tools/index.rst    |  2 +
>>   .../zh_CN/dev-tools/testing-overview.rst      | 99 +++++++++++++++++++
>>   2 files changed, 101 insertions(+)
>>   create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>> index 7ba02fc392a6..b6b6d3b09acc 100644
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>> @@ -22,6 +22,7 @@ Documentation/dev-tools/testing-overview.rst
>>      :maxdepth: 2
>>   
>>      gcov
>> +   testing-overview
>>   
>>   Todolist:
>>   
>> @@ -32,6 +33,7 @@ Todolist:
>>    - ubsan
>>    - kmemleak
>>    - kcsan
>> + - kfence
>>    - gdb-kernel-debugging
>>    - kgdb
>>    - kselftest
>> diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>> new file mode 100644
>> index 000000000000..6e2046ac53ff
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>> @@ -0,0 +1,12 @@
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
>> +有许多不同的工具可以用于测试Linux内核，因此知道什么时候使用它们可能
> s/知道/了解/
>
>> +很困难。该文档提供了它们之间区别的一个粗略概览，并阐释了它们怎样糅
> maybe
> 本文档粗略概述了它们之间的区别
>
> 是怎样
>
>> +合在一起的。
>> +
>> +编写和运行测试
>> +==============
>> +
>> +大多数内核测试都是用kselftest或KUnit框架之一编写的。它们都让运行测试
>>
>> 都提供了让运行测试更简单的的基础设施，
>>
>> +更加简化，并为编写新测试提供帮助。
>> +
>> +如果你想验证内核的行为——尤其是内核的特定部分——那你就要使用kUnit或
>> +kselftest。
>> +
>> +KUnit和kselftest的区别
>> +----------------------
>> +
>> +KUnit（Documentation/zh_CN/dev-tools/kunit/index.rst）是用于“白箱”测
> Seems we don't have this translation yet, so plese use the link point to En version.
> So as followed paths.
>
>> +试的一个完整的内核内部系统：因为测试代码是内核的一部分，所以它能够访
>> +问用户空间不能访问到的内部结构和功能。
>> +
>> +因此，KUnit测试最好不要写得太小，也不要有内核中本身包含的部分，以便
> seems a translation mistake?
>
> against small, self-contained parts of the Kernel
> 最好针对内核中较小的、自包含的部分，
>
>> +能够独立地测试。‘单元’测试的概念亦是如此。
> ‘’ -> “” would be better
>
>> +
>> +比如，一个KUnit测试可能测试一个单独的内核功能（甚至通过一个函数测试
>> +一个单一的代码路径），而不是整个地测试一个特性。
> missed a sentence
>         , such as an error handling case
>
>> +
>> +这也使得KUnit测试构建和运行非常地快，从而能够作为开发流程的一部分被
> 的测试构建和运行非常快
>
>> +频繁地运行。
>> +
>> +有关更详细的介绍，请参阅KUnit测试代码风格指南
>> +Documentation/translations/zh_CN/dev-tools/kunit/style.rst
> ^path
>
>> +
>> +kselftest（Documentation/translations/zh_CN/dev-tools/kselftest.rst），
> ^path
>
>> +另一方面，大量地在用户空间被实现，并且测试通常是用户空间的脚本或程序。
> 相对来说，大量用于用户空间，并且通常测试用户空间的脚本或程序。
>
>> +
>> +这使得编写复杂的测试，或者需要操作更多全局系统状态的测试更加容易（诸
>> +如生成进程之类）。然而，从kselftest直接调用内核函数是不行的。这也就
>> +意味着只有通过某种方式（如系统调用、驱动设备、文件系统等）导出到了用
>> +户空间的内核功能才能使用kselftest来测试。为此，有些测试包含了一个伴
>> +生的内核模块用于导出更多的信息和功能。不过，对于基本上或者完全在内核
>> +中运行的测试，KUnit可能是更佳工具。
>> +
> missed a paragraph
>
>         kselftest is therefore suited well to tests of whole features, as these will
>         expose an interface to userspace, which can be tested, but not implementation
>         details. This aligns well with 'system' or 'end-to-end' testing.
>
>
>> +比如，一个新的系统调用应该伴随有新的kselftest测试。
>> +
>> +代码覆盖率工具
>> +==============
>> +
>> +Linux内核支持不同代码之间的覆盖率测量工具。这能被用来验证一个测试是
> 支持两种不同的代码覆盖率测试工具。
>
> 它们可以用来验证一项测试执行的确切函数或代码行。
>
>> +执行的特定的函数或者特定行的代码。这有助于决定内核被测试了多少，或
>> +用来查找合适的测试中没有覆盖到的极端情况。
>> +
>> +:doc:`gcov` 是GCC的覆盖率测试工具，能用于获取内核的全局或每个模块的
>> +覆盖率。与KCOV不同的是，这个工具不记录每个任务的覆盖率。覆盖率数据可
>> +以通过debugfs读取，并通过常规的gcov工具进行解释。
>> +
>> +:doc:`kcov` 是能够构建在内核之中，用于在每个任务的层面捕捉覆盖率的一
>> +个功能。因此，对于代码执行位置信息的其它情况，它是非常有用的，比如在
> 因此，它对于模糊测试和关于代码执行期间信息的其它情况非常有用。
>
>> +一个单一系统调用里使用它就很有用。
>> +
>> +动态分析工具
>> +============
>> +
>> +内核也支持许多动态分析工具，用以检测正在运行的内核中出现的多种类型的
>> +问题。这些工具尤其用于不同类型的漏洞，比如非法内存访问，诸如数据竞争
> 这些工具通常每个去寻找一类不同的缺陷，比如非法内存访问，数据竞争等并发问题，
> 或整型溢出等其他未定义行为。
>
>> +的并发问题，或者整型溢出的其它未定义的行为。
>> +
>> +一些工具如下：
> 如下所示
>
>> +
>> +* kmemleak检测可能的内存泄漏。参阅
>> +  Documentation/dev-tools/kmemleak.rst
>> +* KASAN检测非法内存访问，如数组越界和释放内存后再使用的错误。参阅
> 释放后重用（UAF）
>
>> +  Documentation/dev-tools/kasan.rst
>> +* UBSAN检测C标准中未定义的行为，如整型溢出。参阅
>> +  Documentation/dev-tools/ubsan.rst
>> +* KCSAN检测数据竞争。参阅 Documentation/dev-tools/kcsan.rst
>> +* KFENCE是一个低开销的内存问题检测器，比KASAN更快而能被用于批量构建。
> 而 -> 且
>
>> +  参阅 Documentation/dev-tools/kfence.rst
>> +* lockdep是一个锁定正确性检测器。参阅
>> +  Documentation/locking/lockdep-design.rst
>> +* 除此以外，在内核中还有一些其它的调试工具，大多数能在
>> +  lib/Kconfig.debug 中找到。
>> +
>> +这些工具倾向于对内核进行整体测试，并且不像kselftest和KUnit一样“传递”。
>> +它们能与kselftest和KUnit结合起来，通过激活这些工具在一个内核上运行测
>> +试：之后你就能确保这些错误在测试过程中都不会发生了。
> 它们可以通过在启用这些工具时运行内核测试以与kselftest或KUnit结合起来：
>
>> +
>> +一些工具与KUnit和kselftest集成，并且当问题被检测时测试会自动失败。
> 并且在检测到问题时会自动打断测试。
>
>> +
>> -- 
>> 2.25.1
> And please re-arrange your patches in appropriate thread and remember to change
> version each time when you send them, or may let Corbet confused.


OK, I'll correct them.


Because this is my first time to kernel translation work, there might
be something wrong, after all thanks for pointing them out.


> Thanks,
>          Wu X.C.
>

