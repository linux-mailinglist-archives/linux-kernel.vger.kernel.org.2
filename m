Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313CF350124
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhCaNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:21:29 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:34696 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhCaNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:21:10 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id ED9D354027F;
        Wed, 31 Mar 2021 21:14:14 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] translations/zh_CN: add translations to dev-tools gcov
Date:   Wed, 31 Mar 2021 06:14:05 -0700
Message-Id: <20210331131408.61061-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHx8eGkNNGEIeGUwaVkpNSkxKQk1PTk5JQklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBg6Tzo6AT8KEjUuGS9WKzEr
        NzBPFAJVSlVKTUpMSkJNT05OTU9PVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFKSk5LTTcG
X-HM-Tid: 0a78886b952eb038kuuued9d354027f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add translations to dev-tools gcov

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 .../translations/zh_CN/dev-tools/gcov.rst     | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/dev-tools/gcov.rst

diff --git a/Documentation/translations/zh_CN/dev-tools/gcov.rst b/Documentation/translations/zh_CN/dev-tools/gcov.rst
new file mode 100644
index 000000000000..5ebbc55e5881
--- /dev/null
+++ b/Documentation/translations/zh_CN/dev-tools/gcov.rst
@@ -0,0 +1,274 @@
+Chinese translated version of Documentation/dev-tools/gcov.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Chinese maintainer: Bernard Zhao <bernard@vivo.com>
+---------------------------------------------------------------------
+Documentation/dev-tools/gcov.rst 的中文翻译
+
+如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
+交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
+译存在问题，请联系中文版维护者。
+
+中文版维护者： 赵军奎 Bernard Zhao <bernard@vivo.com>
+中文版翻译者： 赵军奎 Bernard Zhao <bernard@vivo.com>
+
+以下为正文
+---------------------------------------------------------------------
+
+在Linux内核里使用gcov做代码覆盖率检查
+===============================
+gcov是linux中已经集成的一个分析模块，该模块在内核中对GCC的代码覆盖率统
+计提供了支持。
+linux内核运行时的代码覆盖率数据会以gcov兼容的格式存储在debug-fs中，可
+以通过如下的方式获得指定文件的代码运行覆盖率统计数据（需要跳转到内核
+编译路径下并且要有root权限）：
+
+    # cd /tmp/linux-out
+    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel spinlock.c
+
+这个命令会在当前编译路径下创建带有注释的代码实际运行次数的计数源文件。
+在获得这些统计文件后，可以使用图形化的gcov前端工具（比如lcov），
+来实现自动化处理linux kernel的覆盖率运行数据，同时生成易于阅读的HTML格
+式文件。
+
+可能的用途：
+
+* 调试（用来判断每一行的代码是否已经运行过）
+* 测试改进（如何修改测试代码，尽可能地覆盖到没有运行过的代码）
+* 内核配置优化（对于某一个config配置，如果关联的代码从来没有运行过，是
+否还需要这个配置）
+
+gcov和lcov的关联网站
+.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
+.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
+
+
+准备
+-----------
+
+打开如下配置：
+
+        CONFIG_DEBUG_FS=y
+        CONFIG_GCOV_KERNEL=y
+
+获取整个内核的覆盖率数据，还需要打开：
+
+        CONFIG_GCOV_PROFILE_ALL=y
+
+需要注意的是，整个kernel开启覆盖率统计回造成kernel镜像文件尺寸的增大，
+同时kernel运行的也会变慢一些。
+另外，并不是所有的架构都支持整个kernel开启覆盖率统计。
+
+代码运行覆盖率数据只在debugfs挂载完成后才可以访问：
+
+        mount -t debugfs none /sys/kernel/debug
+
+
+客制化
+-------------
+
+如果要单独针对某一个路径或者文件进行代码覆盖率统计，可以在kernel相应路
+径的Makefile中增加如下的配置：
+
+- 单独统计单个文件（例如main.o）
+
+	GCOV_PROFILE_main.o := y
+
+- 单独统计某一个路径
+
+	GCOV_PROFILE := y
+
+如果要在整个kernel的覆盖率统计（开启CONFIG_GCOV_PROFILE_ALL）中单独排除
+某一个文件或者路径，可以使用如下的方法：
+
+- 不统计单个文件（例如main.o）
+
+	GCOV_PROFILE_main.o := n
+
+- 不统计某一个路径
+
+	GCOV_PROFILE := n
+
+
+关联的文件
+-------------
+
+gcov功能需要在debugfs中创建如下文件
+
+``/sys/kernel/debug/gcov``
+    gcov相关功能的根路径
+
+``/sys/kernel/debug/gcov/reset``
+    gcov复位，向该文件写入数据后会将所有的gcov统计数据清0
+
+``/sys/kernel/debug/gcov/path/to/compile/dir/file.gcda``
+    gcov工具可以识别的覆盖率统计数据文件
+
+``/sys/kernel/debug/gcov/path/to/compile/dir/file.gcno``
+    gcov工具需要的软连接文件（指向编译时生成的信息统计文件），这个文件是
+    在gcc编译时如果配置了选项-ftest-coverage时生成的。
+
+
+针对module的统计
+-------
+
+kernel中的模块会动态的加载和卸载，模块卸载时对应的数据会被清除掉。
+gcov提供了一种机制，通过保留相关数据的副本来收集这部分卸载模块的覆盖率数据。
+模块卸载后这些备份数据在debugfs中会继续存在。
+一旦这个模块重新加载，模块关联的运行统计会被初始化成debugfs中备份的数据。
+
+可以通过对内核参数gcov_persist的修改来停用gcov对module的备份机制：
+
+        gcov_persist = 0
+
+在运行时，用户还可以通过写入模块的数据文件或者写入gcov复位文件来丢弃已卸
+载模块的数据。
+
+
+分离的编译和运行设备
+---------------------------------
+
+gcov的内核分析架构支持内核的编译和分析是在同一台设备上，也可以编译和运
+行是在不同的设备上。
+如果内核编译和运行是不同的设备，那么需要额外的准备工作，这取决于gcov tools
+是在哪里使用的：
+
+a) gcov如果运行在测试设备上
+
+    测试设备上面gcov工具的版本必须要跟设备内核编译使用的gcc版本相兼容，
+    同时下面的文件要从编译设备拷贝到测试设备上：
+
+    从源代码中：
+      - 所有的C文件和头文件
+	  
+    从编译目录中：
+      - 所有的C文件和头文件
+      - 所有的.gcda文件和.gcno文件
+      - 所有目录的链接
+
+    需要注意的是，测试机器上面的目录结构跟编译机器上面的目录机构必须完全一致。
+    如果文件是软链接，需要替换成真正的目录文件（这是由make的当前工作目录变量
+    CURDIR引起的）。
+
+b) gcov如果运行在编译设备上
+
+    测试用例运行结束后，如下的文件需要从测试设备中拷贝到编译设备上：
+	
+    从sysfs中的gcov目录中：
+      - 所有的.gcda文件
+      - 所有的.gcno文件软链接
+
+    这些文件可以拷贝到编译设备的任意目录下，gcov使用-o选项指定拷贝的目录。
+	
+    比如一个是示例的目录结构如下：
+      /tmp/linux:    内核源码目录
+      /tmp/out:      内核编译文件路径（make O=指定）
+      /tmp/coverage: 从测试机器上面拷贝的数据文件路径
+	
+      [user@build] cd /tmp/out
+      [user@build] gcov -o /tmp/coverage/tmp/out/init main.c
+
+
+关于编译器的注意事项
+-----------------
+
+GCC和LLVM gcov工具不一定兼容。
+如果编译器是GCC，使用gcov_来处理.gcno和.gcda文件，如果是Clang编译器，
+则使用llvm-cov_。
+
+gcc gcov和llvm cov的关联网站
+.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
+.. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html
+
+GCC和Clang gcov之间的版本差异由Kconfig处理的。
+kconfig会根据编译工具链的检查自动选择合适的gcov格式。
+
+问题定位
+---------------
+
+可能出现的问题1
+    编译到链接阶段报错终止
+
+问题原因
+    分析标志指定在了源文件但是没有链接到主内核，或者客制化了链接程序
+
+解决方法
+    通过在Makefile中使用GCOV_PROFILE := n或者
+    GCOV_PROFILE_basename.o := n来将链接报错的文件排除掉
+
+可能出现的问题2
+    文件从sysfs拷贝时不存在或者不可访问
+
+问题原因
+    由于seq_file的工作方式，某些工具（例如cp或tar）可能无法正确地从
+    sysfs复制文件。
+
+解决方法
+    使用cat读取.gcda文件，使用cp -d复制链接，或者使用附录B中所示的
+    机制。
+
+
+附录A：collect_on_build.sh
+------------------------------
+
+用于在编译设备上收集覆盖率编译中间数据文件的示例脚本
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
+-----------------------------
+
+用于在测试设备上收集覆盖里统计数据数据文件的示例脚本
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
-- 
2.31.0

