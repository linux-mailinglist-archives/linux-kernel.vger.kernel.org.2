Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EDD35F262
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350529AbhDNL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:27:17 -0400
Received: from m34-101.88.com ([104.250.34.101]:57918 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350480AbhDNL0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=Mk69kr+VMpYpmRXIv0VTPSQ0fdaHcqExBQnVV
        ZbP+/s=; b=lWWyqy18WLb7a1aU81tBpmJ/6LOMz/Kg0U5Ps4suOdECGb0pCWY3k
        R3BIDLdJ8I8Q60PtbM3UhVfFZ6i12onbRdoeA+dhB4D0cJ+ki6zMNZdBGBRvWONm
        b+IT+SmytGGLR2DDllzRCjvmcS8uJ3tCbYHBh7cS2ElfN/pXg7I5EQ=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDnWdDX0HZg1VhcAA--.12543S2;
        Wed, 14 Apr 2021 19:24:09 +0800 (CST)
Date:   Wed, 14 Apr 2021 19:24:07 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Alex Shi <alexs@kernel.org>, Bernard Zhao <bernard@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        YanTeng Si <sterlingteng@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v4] docs/zh_CN: add translations in zh_CN/dev-tools/gcov
Message-ID: <20210414112405.GA8262@bobwxc.top>
References: <20210414082316.15160-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414082316.15160-1-bernard@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgDnWdDX0HZg1VhcAA--.12543S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KFyxKFW7Ww4rZw1fCF4fGrg_yoWkKw47pr
        sxKrWxKF1xCFy7ArW8WFyUXF1xCas5u3WUKFykJ34Fqr1kZFWFkr47tFyvqr93WFyqyas8
        Xa45WFW8Kw1UA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMx
        AIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU-KZX
        DUUUU
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Zhao <bernard@vivo.com>

Add new zh translations
* zh_CN/dev-tools/gcov.rst
* zh_CN/dev-tools/index.rst
and link them to zh_CN/index.rst

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Reviewed-by: Wu Xiangcheng <bobwxc@email.cn>
Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
base: linux-next
commit 269dd42f4776 ("docs/zh_CN: add riscv to zh_CN index")

Changes since V3:
* update to newest linux-next
* fix ``
* fix tags
* fix list indent

Changes since V2:
* fix some inaccurate translation

Changes since V1:
* add index.rst in dev-tools and link to to zh_CN/index.rst
* fix some inaccurate translation

 .../translations/zh_CN/dev-tools/gcov.rst     | 265 ++++++++++++++++++
 .../translations/zh_CN/dev-tools/index.rst    |  35 +++
 Documentation/translations/zh_CN/index.rst    |   1 +
 3 files changed, 301 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/dev-tools/gcov.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/index.rst

diff --git a/Documentation/translations/zh_CN/dev-tools/gcov.rst b/Documentation/translations/zh_CN/dev-tools/gcov.rst
new file mode 100644
index 000000000000..7515b488bc4e
--- /dev/null
+++ b/Documentation/translations/zh_CN/dev-tools/gcov.rst
@@ -0,0 +1,265 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/dev-tools/gcov.rst
+:Translator: 赵军奎 Bernard Zhao <bernard@vivo.com>
+
+在Linux内核里使用gcov做代码覆盖率检查
+=====================================
+
+gcov是linux中已经集成的一个分析模块，该模块在内核中对GCC的代码覆盖率统
+计提供了支持。
+linux内核运行时的代码覆盖率数据会以gcov兼容的格式存储在debug-fs中，可
+以通过gcov的 ``-o`` 选项（如下示例）获得指定文件的代码运行覆盖率统计数据
+（需要跳转到内核编译路径下并且要有root权限）::
+
+    # cd /tmp/linux-out
+    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel spinlock.c
+
+这将在当前目录中创建带有执行计数注释的源代码文件。
+在获得这些统计文件后，可以使用图形化的 gcov_ 前端工具（比如 lcov_ ），来实现
+自动化处理linux内核的覆盖率运行数据，同时生成易于阅读的HTML格式文件。
+
+可能的用途:
+
+* 调试（用来判断每一行的代码是否已经运行过）
+* 测试改进（如何修改测试代码，尽可能地覆盖到没有运行过的代码）
+* 内核配置优化（对于某一个选项配置，如果关联的代码从来没有运行过，是
+  否还需要这个配置）
+
+.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
+.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
+
+
+准备
+----
+
+内核打开如下配置::
+
+        CONFIG_DEBUG_FS=y
+        CONFIG_GCOV_KERNEL=y
+
+获取整个内核的覆盖率数据，还需要打开::
+
+        CONFIG_GCOV_PROFILE_ALL=y
+
+需要注意的是，整个内核开启覆盖率统计会造成内核镜像文件尺寸的增大，
+同时内核运行的也会变慢一些。
+另外，并不是所有的架构都支持整个内核开启覆盖率统计。
+
+代码运行覆盖率数据只在debugfs挂载完成后才可以访问::
+
+        mount -t debugfs none /sys/kernel/debug
+
+
+客制化
+------
+
+如果要单独针对某一个路径或者文件进行代码覆盖率统计，可以在内核相应路
+径的Makefile中增加如下的配置:
+
+- 单独统计单个文件（例如main.o）::
+
+    GCOV_PROFILE_main.o := y
+
+- 单独统计某一个路径::
+
+    GCOV_PROFILE := y
+
+如果要在整个内核的覆盖率统计（开启CONFIG_GCOV_PROFILE_ALL）中单独排除
+某一个文件或者路径，可以使用如下的方法::
+
+    GCOV_PROFILE_main.o := n
+
+和::
+
+    GCOV_PROFILE := n
+
+此机制仅支持链接到内核镜像或编译为内核模块的文件。
+
+
+相关文件
+--------
+
+gcov功能需要在debugfs中创建如下文件:
+
+``/sys/kernel/debug/gcov``
+    gcov相关功能的根路径
+
+``/sys/kernel/debug/gcov/reset``
+    全局复位文件:向该文件写入数据后会将所有的gcov统计数据清0
+
+``/sys/kernel/debug/gcov/path/to/compile/dir/file.gcda``
+    gcov工具可以识别的覆盖率统计数据文件，向该文件写入数据后
+	  会将本文件的gcov统计数据清0
+
+``/sys/kernel/debug/gcov/path/to/compile/dir/file.gcno``
+    gcov工具需要的软连接文件（指向编译时生成的信息统计文件），这个文件是
+    在gcc编译时如果配置了选项 ``-ftest-coverage`` 时生成的。
+
+
+针对模块的统计
+--------------
+
+内核中的模块会动态的加载和卸载，模块卸载时对应的数据会被清除掉。
+gcov提供了一种机制，通过保留相关数据的副本来收集这部分卸载模块的覆盖率数据。
+模块卸载后这些备份数据在debugfs中会继续存在。
+一旦这个模块重新加载，模块关联的运行统计会被初始化成debugfs中备份的数据。
+
+可以通过对内核参数gcov_persist的修改来停用gcov对模块的备份机制::
+
+        gcov_persist = 0
+
+在运行时，用户还可以通过写入模块的数据文件或者写入gcov复位文件来丢弃已卸
+载模块的数据。
+
+
+分离的编译和运行设备
+--------------------
+
+gcov的内核分析架构支持内核的编译和分析是在同一台设备上，也可以编译和运
+行是在不同的设备上。
+如果内核编译和运行是不同的设备，那么需要额外的准备工作，这取决于gcov工具
+是在哪里使用的:
+
+.. _gcov-test_zh:
+
+a) 若gcov运行在测试设备上
+
+    测试设备上面gcov工具的版本必须要跟设备内核编译使用的gcc版本相兼容，
+    同时下面的文件要从编译设备拷贝到测试设备上:
+
+    从源代码中:
+      - 所有的C文件和头文件
+
+    从编译目录中:
+      - 所有的C文件和头文件
+      - 所有的.gcda文件和.gcno文件
+      - 所有目录的链接
+
+    特别需要注意，测试机器上面的目录结构跟编译机器上面的目录机构必须
+    完全一致。
+    如果文件是软链接，需要替换成真正的目录文件（这是由make的当前工作
+    目录变量CURDIR引起的）。
+
+.. _gcov-build_zh:
+
+b) 若gcov运行在编译设备上
+
+    测试用例运行结束后，如下的文件需要从测试设备中拷贝到编译设备上:
+
+    从sysfs中的gcov目录中:
+      - 所有的.gcda文件
+      - 所有的.gcno文件软链接
+
+    这些文件可以拷贝到编译设备的任意目录下，gcov使用-o选项指定拷贝的
+    目录。
+
+    比如一个是示例的目录结构如下::
+
+      /tmp/linux:    内核源码目录
+      /tmp/out:      内核编译文件路径（make O=指定）
+      /tmp/coverage: 从测试机器上面拷贝的数据文件路径
+
+      [user@build] cd /tmp/out
+      [user@build] gcov -o /tmp/coverage/tmp/out/init main.c
+
+
+关于编译器的注意事项
+--------------------
+
+GCC和LLVM gcov工具不一定兼容。
+如果编译器是GCC，使用 gcov_ 来处理.gcno和.gcda文件，如果是Clang编译器，
+则使用 llvm-cov_ 。
+
+.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
+.. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html
+
+GCC和Clang gcov之间的版本差异由Kconfig处理的。
+kconfig会根据编译工具链的检查自动选择合适的gcov格式。
+
+问题定位
+--------
+
+可能出现的问题1
+    编译到链接阶段报错终止
+
+问题原因
+    分析标志指定在了源文件但是没有链接到主内核，或者客制化了链接程序
+
+解决方法
+    通过在相应的Makefile中使用 ``GCOV_PROFILE := n``
+    或者 ``GCOV_PROFILE_basename.o := n`` 来将链接报错的文件排除掉
+
+可能出现的问题2
+    从sysfs复制的文件显示为空或不完整
+
+问题原因
+    由于seq_file的工作方式，某些工具（例如cp或tar）可能无法正确地从
+    sysfs复制文件。
+
+解决方法
+    使用 ``cat`` 读取 ``.gcda`` 文件，使用 ``cp -d`` 复制链接，或者使用附录B
+    中所示的机制。
+
+
+附录A：collect_on_build.sh
+--------------------------
+
+用于在编译设备上收集覆盖率编译中间数据文件的示例脚本
+（见 :ref:`分离的编译和运行设备 a. <gcov-test_zh>` ）
+
+.. code-block:: sh
+
+    #!/bin/bash
+
+    KSRC=$1
+    KOBJ=$2
+    DEST=$3
+
+    if [ -z "$KSRC" ] || [ -z "$KOBJ" ] || [ -z "$DEST" ]; then
+      echo "Usage: $0 <ksrc directory> <kobj directory> <output.tar.gz>" >&2
+      exit 1
+    fi
+
+    KSRC=$(cd $KSRC; printf "all:\n\t@echo \${CURDIR}\n" | make -f -)
+    KOBJ=$(cd $KOBJ; printf "all:\n\t@echo \${CURDIR}\n" | make -f -)
+
+    find $KSRC $KOBJ \( -name '*.gcno' -o -name '*.[ch]' -o -type l \) -a \
+                     -perm /u+r,g+r | tar cfz $DEST -P -T -
+
+    if [ $? -eq 0 ] ; then
+      echo "$DEST successfully created, copy to test system and unpack with:"
+      echo "  tar xfz $DEST -P"
+    else
+      echo "Could not create file $DEST"
+    fi
+
+
+附录B：collect_on_test.sh
+-------------------------
+
+用于在测试设备上收集覆盖里统计数据数据文件的示例脚本
+（见 :ref:`分离的编译和运行设备 b. <gcov-build_zh>` ）
+
+.. code-block:: sh
+
+    #!/bin/bash -e
+
+    DEST=$1
+    GCDA=/sys/kernel/debug/gcov
+
+    if [ -z "$DEST" ] ; then
+      echo "Usage: $0 <output.tar.gz>" >&2
+      exit 1
+    fi
+
+    TEMPDIR=$(mktemp -d)
+    echo Collecting data..
+    find $GCDA -type d -exec mkdir -p $TEMPDIR/\{\} \;
+    find $GCDA -name '*.gcda' -exec sh -c 'cat < $0 > '$TEMPDIR'/$0' {} \;
+    find $GCDA -name '*.gcno' -exec sh -c 'cp -d $0 '$TEMPDIR'/$0' {} \;
+    tar czf $DEST -C $TEMPDIR sys
+    rm -rf $TEMPDIR
+
+    echo "$DEST successfully created, copy to build system and unpack with:"
+    echo "  tar xfz $DEST"
diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
new file mode 100644
index 000000000000..53e57a170440
--- /dev/null
+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
@@ -0,0 +1,35 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/dev-tools/index.rst
+:Translator: 赵军奎 Bernard Zhao <bernard@vivo.com>
+
+============
+内核开发工具
+============
+
+本文档是有关内核开发工具文档的合集。
+目前这些文档已经整理在一起，不需要再花费额外的精力。
+欢迎任何补丁。
+
+.. class:: toc-title
+
+	   目录
+
+.. toctree::
+   :maxdepth: 2
+
+   gcov
+
+Todolist:
+
+ - coccinelle
+ - sparse
+ - kcov
+ - kasan
+ - ubsan
+ - kmemleak
+ - kcsan
+ - gdb-kernel-debugging
+ - kgdb
+ - kselftest
+ - kunit/index
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index bc23f6171eca..fdc51aba9a73 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -18,6 +18,7 @@
 
    admin-guide/index
    process/index
+   dev-tools/index
    kernel-hacking/index
    filesystems/index
    arm64/index
-- 
2.20.1

