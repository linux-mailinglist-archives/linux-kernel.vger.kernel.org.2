Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4638D33A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhEVDOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 23:14:48 -0400
Received: from [43.250.32.171] ([43.250.32.171]:47332 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231166AbhEVDOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 23:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=hntywSLJbmMc0eS0eUn+J3DcmqniTqDW0KyMV
        DsmkPc=; b=X5mfsgmG6uSgO9TPcVm3HmqPDR1Xsp7r2QiZvUnXeW/fFZ7jHVMN2
        mdJNpQskJlBN2Wkd7OV+pc6Y+0xyqrg+GD178McF6Ccu3N2wh+a1JL/iHhRH9bGi
        1dWAnR0TdaSn0KIpkOGtqjaefAcqrYFMdRECHKosqObICNVsNMpVvE=
Received: from localhost.localdomain (unknown [113.251.14.223])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCnbkHMdqhgA+A3AA--.18569S3;
        Sat, 22 May 2021 11:13:18 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net, bobwxc@email.cn,
        maskray@google.com, bernard@vivo.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH v2 2/3] docs/zh_CN: create new translations for zh_CN/dev-tools/testing-overview
Date:   Sat, 22 May 2021 11:13:14 +0800
Message-Id: <20210522031314.57982-2-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210522031314.57982-1-src.res@email.cn>
References: <20210522031314.57982-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgCnbkHMdqhgA+A3AA--.18569S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr17KFykGF18tF1rJr4DXFb_yoWxuw13pF
        Wvgr97K3WUZry7A340k3WUXF18KFn7ur43tF18Ja4Sqr18AFsYyFsFgFyqq343WrW8ZF98
        AF4rKFyj93s2yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Jr0_Jr4l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2
        AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjVlksUUUUU=
X-Originating-IP: [113.251.14.223]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new translations for dev-tools/testing-overview.rst and link it
to dev-tools/index.rst with TODOList modifications.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../translations/zh_CN/dev-tools/index.rst    |  2 +
 .../zh_CN/dev-tools/testing-overview.rst      | 99 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-overview.rst

diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
index 7ba02fc392a6..b6b6d3b09acc 100644
--- a/Documentation/translations/zh_CN/dev-tools/index.rst
+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
@@ -22,6 +22,7 @@ Documentation/dev-tools/testing-overview.rst
    :maxdepth: 2
 
    gcov
+   testing-overview
 
 Todolist:
 
@@ -32,6 +33,7 @@ Todolist:
  - ubsan
  - kmemleak
  - kcsan
+ - kfence
  - gdb-kernel-debugging
  - kgdb
  - kselftest
diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
new file mode 100644
index 000000000000..6e2046ac53ff
--- /dev/null
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -0,0 +1,99 @@
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
+有许多不同的工具可以用于测试Linux内核，因此知道什么时候使用它们可能
+很困难。该文档提供了它们之间区别的一个粗略概览，并阐释了它们怎样糅
+合在一起的。
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
+KUnit（Documentation/zh_CN/dev-tools/kunit/index.rst）是用于“白箱”测
+试的一个完整的内核内部系统：因为测试代码是内核的一部分，所以它能够访
+问用户空间不能访问到的内部结构和功能。
+
+因此，KUnit测试最好不要写得太小，也不要有内核中本身包含的部分，以便
+能够独立地测试。‘单元’测试的概念亦是如此。
+
+比如，一个KUnit测试可能测试一个单独的内核功能（甚至通过一个函数测试
+一个单一的代码路径），而不是整个地测试一个特性。
+
+这也使得KUnit测试构建和运行非常地快，从而能够作为开发流程的一部分被
+频繁地运行。
+
+有关更详细的介绍，请参阅KUnit测试代码风格指南
+Documentation/translations/zh_CN/dev-tools/kunit/style.rst
+
+kselftest（Documentation/translations/zh_CN/dev-tools/kselftest.rst），
+另一方面，大量地在用户空间被实现，并且测试通常是用户空间的脚本或程序。
+
+这使得编写复杂的测试，或者需要操作更多全局系统状态的测试更加容易（诸
+如生成进程之类）。然而，从kselftest直接调用内核函数是不行的。这也就
+意味着只有通过某种方式（如系统调用、驱动设备、文件系统等）导出到了用
+户空间的内核功能才能使用kselftest来测试。为此，有些测试包含了一个伴
+生的内核模块用于导出更多的信息和功能。不过，对于基本上或者完全在内核
+中运行的测试，KUnit可能是更佳工具。
+
+比如，一个新的系统调用应该伴随有新的kselftest测试。
+
+代码覆盖率工具
+==============
+
+Linux内核支持不同代码之间的覆盖率测量工具。这能被用来验证一个测试是
+执行的特定的函数或者特定行的代码。这有助于决定内核被测试了多少，或
+用来查找合适的测试中没有覆盖到的极端情况。
+
+:doc:`gcov` 是GCC的覆盖率测试工具，能用于获取内核的全局或每个模块的
+覆盖率。与KCOV不同的是，这个工具不记录每个任务的覆盖率。覆盖率数据可
+以通过debugfs读取，并通过常规的gcov工具进行解释。
+
+:doc:`kcov` 是能够构建在内核之中，用于在每个任务的层面捕捉覆盖率的一
+个功能。因此，对于代码执行位置信息的其它情况，它是非常有用的，比如在
+一个单一系统调用里使用它就很有用。
+
+动态分析工具
+============
+
+内核也支持许多动态分析工具，用以检测正在运行的内核中出现的多种类型的
+问题。这些工具尤其用于不同类型的漏洞，比如非法内存访问，诸如数据竞争
+的并发问题，或者整型溢出的其它未定义的行为。
+
+一些工具如下：
+
+* kmemleak检测可能的内存泄漏。参阅
+  Documentation/dev-tools/kmemleak.rst
+* KASAN检测非法内存访问，如数组越界和释放内存后再使用的错误。参阅
+  Documentation/dev-tools/kasan.rst
+* UBSAN检测C标准中未定义的行为，如整型溢出。参阅
+  Documentation/dev-tools/ubsan.rst
+* KCSAN检测数据竞争。参阅 Documentation/dev-tools/kcsan.rst
+* KFENCE是一个低开销的内存问题检测器，比KASAN更快而能被用于批量构建。
+  参阅 Documentation/dev-tools/kfence.rst
+* lockdep是一个锁定正确性检测器。参阅
+  Documentation/locking/lockdep-design.rst
+* 除此以外，在内核中还有一些其它的调试工具，大多数能在
+  lib/Kconfig.debug 中找到。
+
+这些工具倾向于对内核进行整体测试，并且不像kselftest和KUnit一样“传递”。
+它们能与kselftest和KUnit结合起来，通过激活这些工具在一个内核上运行测
+试：之后你就能确保这些错误在测试过程中都不会发生了。
+
+一些工具与KUnit和kselftest集成，并且当问题被检测时测试会自动失败。
+
-- 
2.25.1

