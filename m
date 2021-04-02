Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860393525E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 06:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhDBEAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 00:00:01 -0400
Received: from m34-101.88.com ([104.250.34.101]:16305 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233718AbhDBD77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 23:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=nXBh8i0olLeu1pRPuUQnUh9dQp3obguK3tDR3
        JHeJS4=; b=hJ9fIml+VjAoZjUHp+4Hk0gyPQsuXCK9/BN2zR/yJWbpw0E+InJI5
        c3T8HSSUd9xEADBaThaXXWPQP9bQRz7ephvejKzxYglKgwOBuKkIlF5/shOlXdH1
        NoZRxsO53MtxQ36pHvEolUYu8ChQmmOZXrBeks/bdRSGrZpsfhRShk=
Received: from mipc (unknown [120.238.248.129])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAXoiJjlmZgxJlWAA--.59891S2;
        Fri, 02 Apr 2021 11:58:29 +0800 (CST)
Date:   Fri, 2 Apr 2021 11:58:27 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] Documentation/translations/zh_CN/dev-tools/
Message-ID: <20210402035826.GA16473@mipc>
References: <20210401132732.70612-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401132732.70612-1-bernard@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgAXoiJjlmZgxJlWAA--.59891S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tFyxJFy7Xw48KFWkWr1fCrg_yoW8XF18Ko
        Wj9w4rCw47CFW5Aw15CrZxJr1YkF17WFZ7Aw43Kr98W345tF1fZ3WUAw15K3yfZrW3JF13
        tr9rXr4fJan8A3Zxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5_7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
        IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vE
        x4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262
        IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
        6F4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2
        kIc2xKxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWx
        Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jABM_UUUUU=
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

On Thu, Apr 01, 2021 at 06:27:16AM -0700, Bernard Zhao wrote:

Why the charset in your email header is 'y' ?
    "Content-Type: text/plain; charset=y"
<https://lore.kernel.org/linux-doc/20210401132732.70612-1-bernard@vivo.com/raw>

> Add translations to dev-tools gcov
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> Reviewed-by: Wu X.C <bobwxc@email.cn>
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  This reviewed-by tag is invalid.

Please do not pick review-by tag before one give it.

> ---
> Changes since V1:
> * add index.rst in dev-tools and link to to zh_CN/index.rst
> * fix some inaccurate translation
> 
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1405740/
> ---
>  .../translations/zh_CN/dev-tools/gcov.rst     | 279 ++++++++++++++++++
>  .../translations/zh_CN/dev-tools/index.rst    |  39 +++
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  3 files changed, 319 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/gcov.rst
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/index.rst
> 
> diff --git a/Documentation/translations/zh_CN/dev-tools/gcov.rst b/Documentation/translations/zh_CN/dev-tools/gcov.rst
> new file mode 100644
> index 000000000000..e8ffb99b566d

Why replaced all '，' '。' with ',' '.' in zh_CN/dev-tools/gcov.rst ？
And also the columns in the v2 are much shorter than v1.
Please recover the above two points.

> --- /dev/null
> +++ b/Documentation/translations/zh_CN/dev-tools/gcov.rst
> @@ -0,0 +1,279 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/dev-tools/gcov.rst <dev-tools_gcov>`

the original text have no article tag, simply use this
:Original: Documentation/dev-tools/gcov.rst

> +:Translator: 赵军奎 Bernard Zhao <bernard@vivo.com>
> +
> +.. _dev-tools_gcov:

Please remove above line, no need

> +
> +在Linux内核里使用gcov做代码覆盖率检查
> +====================================

Still got a lot of warning.
Please using monospaced font to fix this.
Build log:

/test/linux/Documentation/translations/zh_CN/dev-tools/gcov.rst:11: WARNING: Title underline too short.

在Linux内核里使用gcov做代码覆盖率检查
====================================
/test/linux/Documentation/translations/zh_CN/dev-tools/gcov.rst:110: WARNING: Title underline too short.

针对模块的统计
-------
/test/linux/Documentation/translations/zh_CN/dev-tools/gcov.rst:110: WARNING: Title underline too short.

针对模块的统计
-------
/test/linux/Documentation/translations/zh_CN/dev-tools/gcov.rst:154: WARNING: Block quote ends without a blank line; unexpected unindent.
/test/linux/Documentation/translations/zh_CN/dev-tools/gcov.rst:179: WARNING: Title underline too short.

关于编译器的注意事项
-----------------
/test/linux/Documentation/translations/zh_CN/dev-tools/gcov.rst:179: WARNING: Title underline too short.

关于编译器的注意事项
-----------------


> +
> +gcov是linux中已经集成的一个分析模块,该模块在内核中对
> +GCC的代码覆盖率统计提供了支持.
> +linux内核运行时的代码覆盖率数据会以gcov兼容的格式存储
> +在debug-fs中,可以通过gcov的“-o”选项（如下示例）获得
> +指定文件的代码运行覆盖率统计数据（需要跳转到内核编
> +译路径下并且要有root权限）::
> +
> +    # cd /tmp/linux-out
> +    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel spinlock.c
> +
> +这将在当前目录中创建带有执行计数注释的源代码文件.
> +在获得这些统计文件后,可以使用图形化的gcov[1]前端工
> +具（比如lcov[2]）,来实现自动化处理linux 内核的覆
> +盖率运行数据,同时生成易于阅读的HTML格式文件.

Sorry for the inconvenience,
I test again, found the url tags seems would not make namespace conflicts.
Thus,

在获得这些统计文件后,可以使用图形化的 gcov_ 前端工
具（比如 lcov_ ）,来实现自动化处理linux 内核的覆

> +
> +可能的用途:
> +
> +* 调试（用来判断每一行的代码是否已经运行过）
> +* 测试改进（如何修改测试代码,尽可能地覆盖到没有运
> +  行过的代码）
> +* 内核配置优化（对于某一个选项配置,如果关联的代码
> +  从来没有运行过,是否还需要这个配置）
> +
> +[1]_gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> +[2]_lcov: http://ltp.sourceforge.net/coverage/lcov.php

.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php

> +
> +
> +准备
> +-----------
> +
> +内核打开如下配置::
> +
> +        CONFIG_DEBUG_FS=y
> +        CONFIG_GCOV_KERNEL=y
> +
> +获取整个内核的覆盖率数据,还需要打开::
> +
> +        CONFIG_GCOV_PROFILE_ALL=y
> +
> +需要注意的是,整个内核开启覆盖率统计会造成内核镜像
> +文件尺寸的增大,同时内核运行的也会变慢一些.
> +另外,并不是所有的架构都支持整个内核开启覆盖率统计
> +
> +代码运行覆盖率数据只在debugfs挂载完成后才可以访问::
> +
> +        mount -t debugfs none /sys/kernel/debug
> +
> +
> +客制化
> +-------------
> +
> +如果要单独针对某一个路径或者文件进行代码覆盖率统计
> +可以在内核相应路径的Makefile中增加如下的配置:
> +
> +- 单独统计单个文件（例如main.o）::
> +
> +    GCOV_PROFILE_main.o := y
> +
> +- 单独统计某一个路径::
> +
> +    GCOV_PROFILE := y
> +
> +如果要在整个内核的覆盖率统计（CONFIG_GCOV_PROFILE_ALL）
> +中单独排除某一个文件或者路径,可以使用如下的方法::
> +
> +    GCOV_PROFILE_main.o := n
> +
> +和::
> +
> +    GCOV_PROFILE := n
> +
> +此机制仅支持链接到内核镜像或编译为内核模块的文件.
> +
> +
> +相关文件
> +-------------
> +
> +gcov功能需要在debugfs中创建如下文件:
> +
> +``/sys/kernel/debug/gcov``
> +    gcov相关功能的根路径
> +
> +``/sys/kernel/debug/gcov/reset``
> +    全局复位文件:向该文件写入数据后会将所有的gcov统计
> +    数据清0
> +
> +``/sys/kernel/debug/gcov/path/to/compile/dir/file.gcda``
> +    gcov工具可以识别的覆盖率统计数据文件,向该文件写入
> +    数据后会将本文件的gcov统计数据清0
> +
> +``/sys/kernel/debug/gcov/path/to/compile/dir/file.gcno``
> +    gcov工具需要的软连接文件（指向编译时生成的信息统
> +    计文件）,这个文件是在gcc编译时如果配置了选项
> +    “-ftest-coverage”时生成的.

``something`` is a code style mark, do not replace it with “”

``-ftest-coverage``

> +
> +
> +针对模块的统计
> +-------
> +
> +内核中的模块会动态的加载和卸载,模块卸载时对应的
> +数据会被清除掉.
> +gcov提供了一种机制,通过保留相关数据的副本来收集
> +这部分卸载模块的覆盖率数据.
> +模块卸载后这些备份数据在debugfs中会继续存在.
> +一旦这个模块重新加载,模块关联的运行统计会被初始
> +化成debugfs中备份的数据.
> +
> +可以通过对内核参数gcov_persist的修改来停用gcov
> +对模块的备份机制::
> +
> +        gcov_persist = 0
> +
> +在运行时,用户还可以通过写入模块的数据文件或者写入
> +gcov复位文件来丢弃已卸载模块的数据.
> +
> +
> +分离的编译和运行设备
> +---------------------------------
> +
> +gcov的内核分析架构支持内核的编译和分析是在同一台
> +设备上,也可以编译和运行是在不同的设备上.
> +如果内核编译和运行是不同的设备,那么需要额外的准备
> +工作,这取决于gcov工具是在哪里使用的:
> +
> +a) 若gcov运行在测试设备上
> +
> +    测试设备上面gcov工具的版本必须要跟设备内核编
> +    译使用的gcc版本相兼容,同时下面的文件要从编译
> +    设备拷贝到测试设备上:
> +
> +    从源代码中:
> +      - 所有的C文件和头文件
> +
> +    从编译目录中:
> +      - 所有的C文件和头文件
> +      - 所有的.gcda文件和.gcno文件
> +      - 所有目录的链接
> +
> +    特别需要注意,测试机器上面的目录结构跟编译机器
> +    上面的目录机构必须完全一致.
> +    如果文件是软链接,需要替换成真正的目录文件
> +   （这是由make的当前工作目录变量CURDIR引起的）
> +
> +b) 若gcov运行在编译设备上
> +
> +    测试用例运行结束后,如下的文件需要从测试设备中
> +    拷贝到编译设备上:
> +
> +    从sysfs中的gcov目录中:
> +      - 所有的.gcda文件
> +      - 所有的.gcno文件软链接
> +
> +    这些文件可以拷贝到编译设备的任意目录下,gcov使
> +    用-o选项指定拷贝的目录.
> +
> +    比如一个是示例的目录结构如下::
> +
> +      /tmp/linux:    内核源码目录
> +      /tmp/out:      内核编译文件路径（make O=指定）
> +      /tmp/coverage: 从测试机器上面拷贝的数据文件路径
> +
> +      [user@build] cd /tmp/out
> +      [user@build] gcov -o /tmp/coverage/tmp/out/init main.c
> +
> +
> +关于编译器的注意事项
> +-----------------
> +
> +GCC和LLVM gcov工具不一定兼容.
> +如果编译器是GCC,使用gcov_[3]来处理.gcno和.gcda文件
> +如果是Clang编译器,则使用llvm-cov_[4].
> +

如果编译器是GCC，使用 gcov_ 来处理.gcno和.gcda文件
如果是Clang编译器，则使用 llvm-cov_ 。

> +[3]_gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> +[4]_llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html

.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
.. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html

> +
> +GCC和Clang gcov之间的版本差异由Kconfig处理的.
> +kconfig会根据编译工具链的检查自动选择合适的gcov格式.
> +
> +问题定位
> +---------------
> +
> +可能出现的问题1
> +    编译到链接阶段报错终止
> +
> +问题原因
> +    分析标志指定在了源文件但是没有链接到主内核
> +    或者客制化了链接程序
> +
> +解决方法
> +    通过在相应的Makefile中使用“GCOV_PROFILE := n”
> +    或者“GCOV_PROFILE_basename.o := n”来将链接报错的文件
> +    排除掉

same `` problem

``GCOV_PROFILE := n``
``GCOV_PROFILE_basename.o := n``

> +
> +可能出现的问题2
> +    从sysfs复制的文件显示为空或不完整
> +
> +问题原因
> +    由于seq_file的工作方式,某些工具（例如cp或tar）
> +    可能无法正确地从sysfs复制文件.
> +
> +解决方法
> +    使用“cat”读取“.gcda”文件,使用“cp -d”复制链接
> +    或者使用附录B中所示的机制.

same ``

``cat``
``.gcda``
``cp -d``

> +
> +
> +附录A::collect_on_build.sh
> +------------------------------
> +
> +用于在编译设备上收集覆盖率编译中间数据文件
> +的示例脚本
> +（如下6a示例）

actually is 上

> +
> +.. code-block:: sh
> +
> +    #!/bin/bash
> +
> +    KSRC=$1
> +    KOBJ=$2
> +    DEST=$3
> +
> +    if [ -z "$KSRC" ] || [ -z "$KOBJ" ] || [ -z "$DEST" ]; then
> +      echo "Usage: $0 <ksrc directory> <kobj directory> <output.tar.gz>" >&2
> +      exit 1
> +    fi
> +
> +    KSRC=$(cd $KSRC; printf "all:\n\t@echo \${CURDIR}\n" | make -f -)
> +    KOBJ=$(cd $KOBJ; printf "all:\n\t@echo \${CURDIR}\n" | make -f -)
> +
> +    find $KSRC $KOBJ \( -name '*.gcno' -o -name '*.[ch]' -o -type l \) -a \
> +                     -perm /u+r,g+r | tar cfz $DEST -P -T -
> +
> +    if [ $? -eq 0 ] ; then
> +      echo "$DEST successfully created, copy to test system and unpack with:"
> +      echo "  tar xfz $DEST -P"
> +    else
> +      echo "Could not create file $DEST"
> +    fi
> +
> +
> +附录B::collect_on_test.sh
> +-----------------------------
> +
> +用于在测试设备上收集覆盖里统计数据数据文件的示例脚本
> +（如下6b示例）

actually is 上

> +
> +.. code-block:: sh
> +
> +    #!/bin/bash -e
> +
> +    DEST=$1
> +    GCDA=/sys/kernel/debug/gcov
> +
> +    if [ -z "$DEST" ] ; then
> +      echo "Usage: $0 <output.tar.gz>" >&2
> +      exit 1
> +    fi
> +
> +    TEMPDIR=$(mktemp -d)
> +    echo Collecting data..
> +    find $GCDA -type d -exec mkdir -p $TEMPDIR/\{\} \;
> +    find $GCDA -name '*.gcda' -exec sh -c 'cat < $0 > '$TEMPDIR'/$0' {} \;
> +    find $GCDA -name '*.gcno' -exec sh -c 'cp -d $0 '$TEMPDIR'/$0' {} \;
> +    tar czf $DEST -C $TEMPDIR sys
> +    rm -rf $TEMPDIR
> +
> +    echo "$DEST successfully created, copy to build system and unpack with:"
> +    echo "  tar xfz $DEST"
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
> new file mode 100644
> index 000000000000..0c6b5c2f4a7f
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/dev-tools/gcov.rst <development_dev-tools_index>`

:Original: Documentation/dev-tools/gcov.rst

> +:Translator: 赵军奎 Bernard Zhao <bernard@vivo.com>
> +
> +.. _development_dev-tools_index:

remove above line

> +
> +================================
> +内核开发工具
> +================================
> +
> +本文档是有关内核开发工具文档的合集。
> +目前这些文档已经整理在一起，不需要再花费额外的精力。
> +欢迎任何补丁。
> +
> +.. class:: toc-title
> +
> +   目录
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   gcov
> +
> +Todolist:
> +
> +   coccinelle
> +   sparse
> +   kcov
> +   kasan
> +   ubsan
> +   kmemleak
> +   kcsan
> +   gdb-kernel-debugging
> +   kgdb
> +   kselftest
> +   kunit/index
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index be6f11176200..a5e483b0c7f2 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -20,6 +20,7 @@
>     process/index
>     filesystems/index
>     arm64/index
> +   dev-tools/index
>  
>  目录和表格
>  ----------
> -- 
> 2.31.0

Thanks!

Wu X.C.

