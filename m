Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8113ADD3A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 07:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhFTFbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 01:31:02 -0400
Received: from m32-153.88.com ([43.250.32.153]:63961 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhFTFbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 01:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=hARJpl8QPsmU4gxfeUE/0yUtUY+ecSUZA5XZb
        hQcGzI=; b=B+ywPpYTFauqko39K5BYgX3KupWNS7MlVO0IoF0LyGruZrSI6rALS
        RUD11OEl1XjAsyNGXK8KMnWVhQ9qSp1q+71apS6cpAJ4vN2lOtW9L8OlgaAS3LwQ
        /sjWmzS0pfrAk1A4n1uWimxGN49VTFjSyj/EL+11EGBJmnzPMJ6De0=
Received: from bobwxc.top (unknown [120.238.248.220])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCnfv0L0s5gAN8fAA--.1649S2;
        Sun, 20 Jun 2021 13:28:45 +0800 (CST)
Date:   Sun, 20 Jun 2021 13:28:43 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
Message-ID: <20210620052841.GA22083@bobwxc.top>
References: <20210617070051.32794-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617070051.32794-1-src.res@email.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgCnfv0L0s5gAN8fAA--.1649S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr17KFy3JF1fXw1xCryfJFb_yoW3uF1kpr
        4v9r97K3WUZry7A3y8Ka4jqr1UCF97WF43tF18Ja4Sqr1kAFsYkrsFgFyqqay3WrW8ZF98
        AF4rKFyj9w10y3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1UJwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI4
        8JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
        1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
        svtCUUUUU
X-Originating-IP: [120.238.248.220]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hu Haowen <src.res@email.cn>

Create new translations for dev-tools/testing-overview.rst and link it
to dev-tools/index.rst with TODOList modifications.

Signed-off-by: Hu Haowen <src.res@email.cn>
Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
Jon, sorry for previous inconvience.
v6: fix link tag
    rebase to newest docs-next

 .../translations/zh_CN/dev-tools/index.rst    |   5 +
 .../zh_CN/dev-tools/testing-overview.rst      | 108 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-overview.rst

diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
index e6c99f2f543f..0f770b8664e9 100644
--- a/Documentation/translations/zh_CN/dev-tools/index.rst
+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
@@ -11,6 +11,9 @@
 目前这些文档已经整理在一起，不需要再花费额外的精力。
 欢迎任何补丁。
 
+有关测试专用工具的简要概述，参见
+Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+
 .. class:: toc-title
 
 	   目录
@@ -18,6 +21,7 @@
 .. toctree::
    :maxdepth: 2
 
+   testing-overview
    gcov
    kasan
 
@@ -29,6 +33,7 @@ Todolist:
  - ubsan
  - kmemleak
  - kcsan
+ - kfence
  - gdb-kernel-debugging
  - kgdb
  - kselftest
diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
new file mode 100644
index 000000000000..8206d5b477e2
--- /dev/null
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/dev-tools/testing-overview.rst
+:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+
+============
+内核测试指南
+============
+
+有许多不同的工具可以用于测试Linux内核，因此了解什么时候使用它们可能
+很困难。本文档粗略概述了它们之间的区别，并阐释了它们是怎样糅合在一起
+的。
+
+编写和运行测试
+==============
+
+大多数内核测试都是用kselftest或KUnit框架之一编写的。它们都让运行测试
+更加简化，并为编写新测试提供帮助。
+
+如果你想验证内核的行为——尤其是内核的特定部分——那你就要使用kUnit或
+kselftest。
+
+KUnit和kselftest的区别
+----------------------
+
+.. note::
+     由于本文段中部分术语尚无较好的对应中文释义，可能导致与原文含义
+     存在些许差异，因此建议读者结合原文
+     （Documentation/dev-tools/testing-overview.rst）辅助阅读。
+     如对部分翻译有异议或有更好的翻译意见，欢迎联系译者进行修订。
+
+KUnit（Documentation/dev-tools/kunit/index.rst）是用于“白箱”测
+试的一个完整的内核内部系统：因为测试代码是内核的一部分，所以它能够访
+问用户空间不能访问到的内部结构和功能。
+
+因此，KUnit测试最好针对内核中较小的、自包含的部分，以便能够独立地测
+试。“单元”测试的概念亦是如此。
+
+比如，一个KUnit测试可能测试一个单独的内核功能（甚至通过一个函数测试
+一个单一的代码路径，例如一个错误处理案例），而不是整个地测试一个特性。
+
+这也使得KUnit测试构建和运行非常地快，从而能够作为开发流程的一部分被
+频繁地运行。
+
+有关更详细的介绍，请参阅KUnit测试代码风格指南
+Documentation/dev-tools/kunit/style.rst
+
+kselftest（Documentation/dev-tools/kselftest.rst），相对来说，大量用
+于用户空间，并且通常测试用户空间的脚本或程序。
+
+这使得编写复杂的测试，或者需要操作更多全局系统状态的测试更加容易（诸
+如生成进程之类）。然而，从kselftest直接调用内核函数是不行的。这也就
+意味着只有通过某种方式（如系统调用、驱动设备、文件系统等）导出到了用
+户空间的内核功能才能使用kselftest来测试。为此，有些测试包含了一个伴
+生的内核模块用于导出更多的信息和功能。不过，对于基本上或者完全在内核
+中运行的测试，KUnit可能是更佳工具。
+
+kselftest也因此非常适合于全部功能的测试，因为这些功能会将接口暴露到
+用户空间，从而能够被测试，而不是展现实现细节。“system”测试和
+“end-to-end”测试亦是如此。
+
+比如，一个新的系统调用应该伴随有新的kselftest测试。
+
+代码覆盖率工具
+==============
+
+支持两种不同代码之间的覆盖率测量工具。它们可以用来验证一项测试执行的
+确切函数或代码行。这有助于决定内核被测试了多少，或用来查找合适的测试
+中没有覆盖到的极端情况。
+
+Documentation/translations/zh_CN/dev-tools/gcov.rst 是GCC的覆盖率测试工具，能用于获取内核的全局或每个模块的
+覆盖率。与KCOV不同的是，这个工具不记录每个任务的覆盖率。覆盖率数据可
+以通过debugfs读取，并通过常规的gcov工具进行解释。
+
+Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每个任务的层面捕捉覆盖率的一
+个功能。因此，它对于模糊测试和关于代码执行期间信息的其它情况非常有用，
+比如在一个单一系统调用里使用它就很有用。
+
+动态分析工具
+============
+
+内核也支持许多动态分析工具，用以检测正在运行的内核中出现的多种类型的
+问题。这些工具通常每个去寻找一类不同的缺陷，比如非法内存访问，数据竞
+争等并发问题，或整型溢出等其他未定义行为。
+
+如下所示：
+
+* kmemleak检测可能的内存泄漏。参阅
+  Documentation/dev-tools/kmemleak.rst
+* KASAN检测非法内存访问，如数组越界和释放后重用（UAF）。参阅
+  Documentation/dev-tools/kasan.rst
+* UBSAN检测C标准中未定义的行为，如整型溢出。参阅
+  Documentation/dev-tools/ubsan.rst
+* KCSAN检测数据竞争。参阅 Documentation/dev-tools/kcsan.rst
+* KFENCE是一个低开销的内存问题检测器，比KASAN更快且能被用于批量构建。
+  参阅 Documentation/dev-tools/kfence.rst
+* lockdep是一个锁定正确性检测器。参阅
+  Documentation/locking/lockdep-design.rst
+* 除此以外，在内核中还有一些其它的调试工具，大多数能在
+  lib/Kconfig.debug 中找到。
+
+这些工具倾向于对内核进行整体测试，并且不像kselftest和KUnit一样“传递”。
+它们可以通过在启用这些工具时运行内核测试以与kselftest或KUnit结合起来：
+之后你就能确保这些错误在测试过程中都不会发生了。
+
+一些工具与KUnit和kselftest集成，并且在检测到问题时会自动打断测试。
-- 
2.20.1

