Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E993D114A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhGUNqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:46:04 -0400
Received: from [43.250.32.171] ([43.250.32.171]:52478 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S239674AbhGUNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=KvPl5N/aV5EPUutGWuRiRIXwvm+Hdj+YFMzRG
        h9umS8=; b=ff5VBtJYbvb1n8G+NbugVvH9F3AMqS0YsJps85OPUZI62Z5UZKfJN
        7UoPhKeX/3iFYs0Tx16NiAggEoDiIcKXeqAH3nBrMPsoj73npu8G07f2shrsB8D8
        V49NiY8KP4qa3WbCqUtfqOsybDW2C8gsqj22nY0qcgszMElorhLe/U=
Received: from localhost.localdomain (unknown [180.120.41.43])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCnQzdlLvhgL8VVAA--.36318S2;
        Wed, 21 Jul 2021 22:25:41 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH v4 1/2] docs: add traditional Chinese translation for kernel Documentation
Date:   Wed, 21 Jul 2021 22:25:36 +0800
Message-Id: <20210721142537.29409-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgCnQzdlLvhgL8VVAA--.36318S2
X-Coremail-Antispam: 1UD129KBjvAXoWkXw1xZw45Zw15XFy3Jw43ZFb_yoWkWr4fto
        WI9ay5C34kAF4aqFyrGa1UJFWxGw13CFs8uwsrKrn8Gr1UCFy5t3Wvq3y5KrWa93y5Wa1f
        Ja4FvF1Sy3W5AFyDn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5s7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM28lY4IE
        w2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84
        ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry5MxAIw28IcVCjz4
        8v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYY7kG6IIYr7
        AKxVW8JVW5JwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUIuyIUUUU
        U
X-Originating-IP: [180.120.41.43]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add traditional Chinese translation (zh_TW) for the Linux Kernel
documentation with a series of translated files.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/index.rst          |    1 +
 Documentation/translations/zh_TW/IRQ.txt      |   41 +
 .../translations/zh_TW/admin-guide/README.rst |  351 +++++
 .../zh_TW/admin-guide/bug-bisect.rst          |   85 ++
 .../zh_TW/admin-guide/bug-hunting.rst         |  344 +++++
 .../zh_TW/admin-guide/clearing-warn-once.rst  |   16 +
 .../zh_TW/admin-guide/cpu-load.rst            |  112 ++
 .../translations/zh_TW/admin-guide/index.rst  |  135 ++
 .../translations/zh_TW/admin-guide/init.rst   |   58 +
 .../zh_TW/admin-guide/reporting-issues.rst    | 1337 +++++++++++++++++
 .../zh_TW/admin-guide/security-bugs.rst       |   78 +
 .../zh_TW/admin-guide/tainted-kernels.rst     |  161 ++
 .../zh_TW/admin-guide/unicode.rst             |  174 +++
 .../translations/zh_TW/disclaimer-zh_TW.rst   |   11 +
 Documentation/translations/zh_TW/gpio.txt     |  651 ++++++++
 Documentation/translations/zh_TW/index.rst    |  162 ++
 .../translations/zh_TW/io_ordering.txt        |   68 +
 .../translations/zh_TW/oops-tracing.txt       |  212 +++
 Documentation/translations/zh_TW/sparse.txt   |   91 ++
 19 files changed, 4088 insertions(+)
 create mode 100644 Documentation/translations/zh_TW/IRQ.txt
 create mode 100644 Documentation/translations/zh_TW/admin-guide/README.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/cpu-load.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/index.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/init.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/security-bugs.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/unicode.rst
 create mode 100644 Documentation/translations/zh_TW/disclaimer-zh_TW.rst
 create mode 100644 Documentation/translations/zh_TW/gpio.txt
 create mode 100644 Documentation/translations/zh_TW/index.rst
 create mode 100644 Documentation/translations/zh_TW/io_ordering.txt
 create mode 100644 Documentation/translations/zh_TW/oops-tracing.txt
 create mode 100644 Documentation/translations/zh_TW/sparse.txt

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index 556b050884fc..1175a47d07f0 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -8,6 +8,7 @@ Translations
    :maxdepth: 1
 
    zh_CN/index
+   zh_TW/index
    it_IT/index
    ko_KR/index
    ja_JP/index
diff --git a/Documentation/translations/zh_TW/IRQ.txt b/Documentation/translations/zh_TW/IRQ.txt
new file mode 100644
index 000000000000..73d435a0d1e7
--- /dev/null
+++ b/Documentation/translations/zh_TW/IRQ.txt
@@ -0,0 +1,41 @@
+Chinese translated version of Documentation/core-api/irq/index.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Eric W. Biederman <ebiederman@xmission.com>
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/core-api/irq/index.rst 的繁體中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
+者翻譯存在問題，請聯繫繁體中文版維護者。
+
+英文版維護者： Eric W. Biederman <ebiederman@xmission.com>
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+
+
+以下爲正文
+---------------------------------------------------------------------
+何爲 IRQ?
+
+一個 IRQ 是來自某個設備的一個中斷請求。目前，它們可以來自一個硬體引腳，
+或來自一個數據包。多個設備可能連接到同個硬體引腳，從而共享一個 IRQ。
+
+一個 IRQ 編號是用於告知硬體中斷源的內核標識。通常情況下，這是一個
+全局 irq_desc 數組的索引，但是除了在 linux/interrupt.h 中的實現，
+具體的細節是體系結構特定的。
+
+一個 IRQ 編號是設備上某個可能的中斷源的枚舉。通常情況下，枚舉的編號是
+該引腳在系統內中斷控制器的所有輸入引腳中的編號。對於 ISA 總線中的情況，
+枚舉的是在兩個 i8259 中斷控制器中 16 個輸入引腳。
+
+架構可以對 IRQ 編號指定額外的含義，在硬體涉及任何手工配置的情況下，
+是被提倡的。ISA 的 IRQ 是一個分配這類額外含義的典型例子。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
new file mode 100644
index 000000000000..b752e50359e6
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -0,0 +1,351 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/README.rst
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+Linux內核5.x版本 <http://kernel.org/>
+=========================================
+
+以下是Linux版本5的發行註記。仔細閱讀它們，
+它們會告訴你這些都是什麼，解釋如何安裝內核，以及遇到問題時該如何做。
+
+什麼是Linux？
+---------------
+
+  Linux是Unix作業系統的克隆版本，由Linus Torvalds在一個鬆散的網絡黑客
+  （Hacker，無貶義）團隊的幫助下從頭開始編寫。它旨在實現兼容POSIX和
+  單一UNIX規範。
+
+  它具有在現代成熟的Unix中應當具有的所有功能，包括真正的多任務處理、虛擬內存、
+  共享庫、按需加載、共享的寫時拷貝（COW）可執行文件、恰當的內存管理以及包括
+  IPv4和IPv6在內的複合網絡棧。
+
+  Linux在GNU通用公共許可證，版本2（GNU GPLv2）下分發，詳見隨附的COPYING文件。
+
+它能在什麼樣的硬體上運行？
+-----------------------------
+
+  雖然Linux最初是爲32位的x86 PC機（386或更高版本）開發的，但今天它也能運行在
+  （至少）Compaq Alpha AXP、Sun SPARC與UltraSPARC、Motorola 68000、PowerPC、
+  PowerPC64、ARM、Hitachi SuperH、Cell、IBM S/390、MIPS、HP PA-RISC、Intel 
+  IA-64、DEC VAX、AMD x86-64 Xtensa和ARC架構上。
+
+  Linux很容易移植到大多數通用的32位或64位體系架構，只要它們有一個分頁內存管理
+  單元（PMMU）和一個移植的GNU C編譯器（gcc；GNU Compiler Collection，GCC的一
+  部分）。Linux也被移植到許多沒有PMMU的體系架構中，儘管功能顯然受到了一定的
+  限制。
+  Linux也被移植到了其自己上。現在可以將內核作爲用戶空間應用程式運行——這被
+  稱爲用戶模式Linux（UML）。
+
+文檔
+-----
+網際網路上和書籍上都有大量的電子文檔，既有Linux專屬文檔，也有與一般UNIX問題相關
+的文檔。我建議在任何Linux FTP站點上查找LDP（Linux文檔項目）書籍的文檔子目錄。
+本自述文件並不是關於系統的文檔：有更好的可用資源。
+
+ - 網際網路上和書籍上都有大量的（電子）文檔，既有Linux專屬文檔，也有與普通
+   UNIX問題相關的文檔。我建議在任何有LDP（Linux文檔項目）書籍的Linux FTP
+   站點上查找文檔子目錄。本自述文件並不是關於系統的文檔：有更好的可用資源。
+
+ - 文檔/子目錄中有各種自述文件：例如，這些文件通常包含一些特定驅動程序的
+   內核安裝說明。請閱讀
+   :ref:`Documentation/process/changes.rst <changes>` 文件，它包含了升級內核
+   可能會導致的問題的相關信息。
+
+安裝內核原始碼
+---------------
+
+ - 如果您要安裝完整的原始碼，請把內核tar檔案包放在您有權限的目錄中（例如您
+   的主目錄）並將其解包::
+
+     xz -cd linux-5.x.tar.xz | tar xvf -
+
+   將「X」替換成最新內核的版本號。
+
+   【不要】使用 /usr/src/linux 目錄！這裡有一組庫頭文件使用的內核頭文件
+   （通常是不完整的）。它們應該與庫匹配，而不是被內核的變化搞得一團糟。
+
+ - 您還可以通過打補丁在5.x版本之間升級。補丁以xz格式分發。要通過打補丁進行
+   安裝，請獲取所有較新的補丁文件，進入內核原始碼（linux-5.x）的目錄並
+   執行::
+
+     xz -cd ../patch-5.x.xz | patch -p1
+
+   請【按順序】替換所有大於當前原始碼樹版本的「x」，這樣就可以了。您可能想要
+   刪除備份文件（文件名類似xxx~ 或 xxx.orig)，並確保沒有失敗的補丁（文件名
+   類似xxx# 或 xxx.rej）。如果有，不是你就是我犯了錯誤。
+
+   與5.x內核的補丁不同，5.x.y內核（也稱爲穩定版內核）的補丁不是增量的，而是
+   直接應用於基本的5.x內核。例如，如果您的基本內核是5.0，並且希望應用5.0.3
+   補丁，則不應先應用5.0.1和5.0.2的補丁。類似地，如果您運行的是5.0.2內核，
+   並且希望跳轉到5.0.3，那麼在應用5.0.3補丁之前，必須首先撤銷5.0.2補丁
+   （即patch -R）。更多關於這方面的內容，請閱讀
+   :ref:`Documentation/process/applying-patches.rst <applying_patches>` 。
+
+   或者，腳本 patch-kernel 可以用來自動化這個過程。它能確定當前內核版本並
+   應用找到的所有補丁::
+
+     linux/scripts/patch-kernel linux
+
+   上面命令中的第一個參數是內核原始碼的位置。補丁是在當前目錄應用的，但是
+   可以將另一個目錄指定爲第二個參數。
+
+ - 確保沒有過時的 .o 文件和依賴項::
+
+     cd linux
+     make mrproper
+
+   現在您應該已經正確安裝了原始碼。
+
+軟體要求
+---------
+
+   編譯和運行5.x內核需要各種軟體包的最新版本。請參考
+   :ref:`Documentation/process/changes.rst <changes>`
+   來了解最低版本要求以及如何升級軟體包。請注意，使用過舊版本的這些包可能會
+   導致很難追蹤的間接錯誤，因此不要以爲在生成或操作過程中出現明顯問題時可以
+   只更新包。
+
+爲內核建立目錄
+---------------
+
+   編譯內核時，默認情況下所有輸出文件都將與內核原始碼放在一起。使用
+   ``make O=output/dir`` 選項可以爲輸出文件（包括 .config）指定備用位置。
+   例如::
+
+     kernel source code: /usr/src/linux-5.x
+     build directory:    /home/name/build/kernel
+
+   要配置和構建內核，請使用::
+
+     cd /usr/src/linux-5.x
+     make O=/home/name/build/kernel menuconfig
+     make O=/home/name/build/kernel
+     sudo make O=/home/name/build/kernel modules_install install
+
+   請注意：如果使用了 ``O=output/dir`` 選項，那麼它必須用於make的所有調用。
+
+配置內核
+---------
+
+   即使只升級一個小版本，也不要跳過此步驟。每個版本中都會添加新的配置選項，
+   如果配置文件沒有按預定設置，就會出現奇怪的問題。如果您想以最少的工作量
+   將現有配置升級到新版本，請使用 ``makeoldconfig`` ，它只會詢問您新配置
+   選項的答案。
+
+ - 其他配置命令包括::
+
+     "make config"      純文本界面。
+
+     "make menuconfig"  基於文本的彩色菜單、選項列表和對話框。
+
+     "make nconfig"     增強的基於文本的彩色菜單。
+
+     "make xconfig"     基於Qt的配置工具。
+
+     "make gconfig"     基於GTK+的配置工具。
+
+     "make oldconfig"   基於現有的 ./.config 文件選擇所有選項，並詢問
+                        新配置選項。
+
+     "make olddefconfig"
+                        類似上一個，但不詢問直接將新選項設置爲默認值。
+
+     "make defconfig"   根據體系架構，使用arch/$arch/defconfig或
+                        arch/$arch/configs/${PLATFORM}_defconfig中的
+                        默認選項值創建./.config文件。
+
+     "make ${PLATFORM}_defconfig"
+                        使用arch/$arch/configs/${PLATFORM}_defconfig中
+                        的默認選項值創建一個./.config文件。
+                        用「makehelp」來獲取您體系架構中所有可用平台的列表。
+
+     "make allyesconfig"
+                        通過儘可能將選項值設置爲「y」，創建一個
+                        ./.config文件。
+
+     "make allmodconfig"
+                        通過儘可能將選項值設置爲「m」，創建一個
+                        ./.config文件。
+
+     "make allnoconfig" 通過儘可能將選項值設置爲「n」，創建一個
+                        ./.config文件。
+
+     "make randconfig"  通過隨機設置選項值來創建./.config文件。
+
+     "make localmodconfig" 基於當前配置和加載的模塊（lsmod）創建配置。禁用
+                           已加載的模塊不需要的任何模塊選項。
+
+                           要爲另一台計算機創建localmodconfig，請將該計算機
+                           的lsmod存儲到一個文件中，並將其作爲lsmod參數傳入。
+
+                           此外，通過在參數LMC_KEEP中指定模塊的路徑，可以將
+                           模塊保留在某些文件夾或kconfig文件中。
+
+                   target$ lsmod > /tmp/mylsmod
+                   target$ scp /tmp/mylsmod host:/tmp
+
+                   host$ make LSMOD=/tmp/mylsmod \
+                           LMC_KEEP="drivers/usb:drivers/gpu:fs" \
+                           localmodconfig
+
+                           上述方法在交叉編譯時也適用。
+
+     "make localyesconfig" 與localmodconfig類似，只是它會將所有模塊選項轉換
+                           爲內置（=y）。你可以同時通過LMC_KEEP保留模塊。
+
+     "make kvmconfig"   爲kvm客體內核支持啓用其他選項。
+
+     "make xenconfig"   爲xen dom0客體內核支持啓用其他選項。
+
+     "make tinyconfig"  配置儘可能小的內核。
+
+   更多關於使用Linux內核配置工具的信息，見文檔
+   Documentation/kbuild/kconfig.rst。
+
+ - ``make config`` 注意事項:
+
+    - 包含不必要的驅動程序會使內核變大，並且在某些情況下會導致問題：
+      探測不存在的控制器卡可能會混淆其他控制器。
+
+    - 如果存在協處理器，則編譯了數學仿真的內核仍將使用協處理器：在
+      這種情況下，數學仿真永遠不會被使用。內核會稍微大一點，但不管
+      是否有數學協處理器，都可以在不同的機器上工作。
+
+    - 「kernel hacking」配置細節通常會導致更大或更慢的內核（或兩者
+      兼而有之），甚至可以通過配置一些例程來主動嘗試破壞壞代碼以發現
+      內核問題，從而降低內核的穩定性（kmalloc()）。因此，您可能應該
+      用於研究「開發」、「實驗」或「調試」特性相關問題。
+
+編譯內核
+---------
+
+ - 確保您至少有gcc 4.9可用。
+   有關更多信息，請參閱 :ref:`Documentation/process/changes.rst <changes>` 。
+
+   請注意，您仍然可以使用此內核運行a.out用戶程序。
+
+ - 執行 ``make`` 來創建壓縮內核映像。如果您安裝了lilo以適配內核makefile，
+   那麼也可以進行 ``makeinstall`` ，但是您可能需要先檢查特定的lilo設置。
+
+   實際安裝必須以root身份執行，但任何正常構建都不需要。
+   無須徒然使用root身份。
+
+ - 如果您將內核的任何部分配置爲模塊，那麼還必須執行 ``make modules_install`` 。
+
+ - 詳細的內核編譯/生成輸出：
+
+   通常，內核構建系統在相當安靜的模式下運行（但不是完全安靜）。但是有時您或
+   其他內核開發人員需要看到編譯、連結或其他命令的執行過程。爲此，可使用
+   「verbose（詳細）」構建模式。
+   向 ``make`` 命令傳遞 ``V=1`` 來實現，例如::
+
+     make V=1 all
+
+   如需構建系統也給出內個目標重建的願意，請使用 ``V=2`` 。默認爲 ``V=0`` 。
+
+ - 準備一個備份內核以防出錯。對於開發版本尤其如此，因爲每個新版本都包含
+   尚未調試的新代碼。也要確保保留與該內核對應的模塊的備份。如果要安裝
+   與工作內核版本號相同的新內核，請在進行 ``make modules_install`` 安裝
+   之前備份modules目錄。
+
+   或者，在編譯之前，使用內核配置選項「LOCALVERSION」向常規內核版本附加
+   一個唯一的後綴。LOCALVERSION可以在「General Setup」菜單中設置。
+
+ - 爲了引導新內核，您需要將內核映像（例如編譯後的
+   .../linux/arch/x86/boot/bzImage）複製到常規可引導內核的位置。
+
+ - 不再支持在沒有LILO等啓動裝載程序幫助的情況下直接從軟盤引導內核。
+
+   如果從硬碟引導Linux，很可能使用LILO，它使用/etc/lilo.conf文件中
+   指定的內核映像文件。內核映像文件通常是/vmlinuz、/boot/vmlinuz、
+   /bzImage或/boot/bzImage。使用新內核前，請保存舊映像的副本，並複製
+   新映像覆蓋舊映像。然後您【必須重新運行LILO】來更新加載映射！否則，
+   將無法啓動新的內核映像。
+
+   重新安裝LILO通常需要運行/sbin/LILO。您可能希望編輯/etc/lilo.conf
+   文件爲舊內核映像指定一個條目（例如/vmlinux.old)防止新的不能正常
+   工作。有關更多信息，請參閱LILO文檔。
+
+   重新安裝LILO之後，您應該就已經準備好了。關閉系統，重新啓動，盡情
+   享受吧！
+
+   如果需要更改內核映像中的默認根設備、視頻模式等，請在適當的地方使用
+   啓動裝載程序的引導選項。無需重新編譯內核即可更改這些參數。
+
+ - 使用新內核重新啓動並享受它吧。
+
+若遇到問題
+-----------
+
+ - 如果您發現了一些可能由於內核缺陷所導致的問題，請檢查MAINTAINERS（維護者）
+   文件看看是否有人與令您遇到麻煩的內核部分相關。如果無人在此列出，那麼第二
+   個最好的方案就是把它們發給我（torvalds@linux-foundation.org），也可能發送
+   到任何其他相關的郵件列表或新聞組。
+
+ - 在所有的缺陷報告中，【請】告訴我們您在說什麼內核，如何復現問題，以及您的
+   設置是什麼的（使用您的常識）。如果問題是新的，請告訴我；如果問題是舊的，
+   請嘗試告訴我您什麼時候首次注意到它。
+
+ - 如果缺陷導致如下消息::
+
+     unable to handle kernel paging request at address C0000010
+     Oops: 0002
+     EIP:   0010:XXXXXXXX
+     eax: xxxxxxxx   ebx: xxxxxxxx   ecx: xxxxxxxx   edx: xxxxxxxx
+     esi: xxxxxxxx   edi: xxxxxxxx   ebp: xxxxxxxx
+     ds: xxxx  es: xxxx  fs: xxxx  gs: xxxx
+     Pid: xx, process nr: xx
+     xx xx xx xx xx xx xx xx xx xx
+
+   或者類似的內核調試信息顯示在屏幕上或在系統日誌里，請【如實】複製它。
+   可能對你來說轉儲（dump）看起來不可理解，但它確實包含可能有助於調試問題的
+   信息。轉儲上方的文本也很重要：它說明了內核轉儲代碼的原因（在上面的示例中，
+   是由於內核指針錯誤）。更多關於如何理解轉儲的信息，請參見
+   Documentation/admin-guide/bug-hunting.rst。
+
+ - 如果使用 CONFIG_KALLSYMS 編譯內核，則可以按原樣發送轉儲，否則必須使用
+   ``ksymoops`` 程序來理解轉儲（但通常首選使用CONFIG_KALLSYMS編譯）。
+   此實用程序可從
+   https://www.kernel.org/pub/linux/utils/kernel/ksymoops/ 下載。
+   或者，您可以手動執行轉儲查找：
+
+ - 在調試像上面這樣的轉儲時，如果您可以查找EIP值的含義，這將非常有幫助。
+   十六進位值本身對我或其他任何人都沒有太大幫助：它會取決於特定的內核設置。
+   您應該做的是從EIP行獲取十六進位值（忽略 ``0010:`` ），然後在內核名字列表
+   中查找它，以查看哪個內核函數包含有問題的地址。
+
+   要找到內核函數名，您需要找到與顯示症狀的內核相關聯的系統二進位文件。就是
+   文件「linux/vmlinux」。要提取名字列表並將其與內核崩潰中的EIP進行匹配，
+   請執行::
+
+     nm vmlinux | sort | less
+
+   這將爲您提供一個按升序排序的內核地址列表，從中很容易找到包含有問題的地址
+   的函數。請注意，內核調試消息提供的地址不一定與函數地址完全匹配（事實上，
+   這是不可能的），因此您不能只「grep」列表：不過列表將爲您提供每個內核函數
+   的起點，因此通過查找起始地址低於你正在搜索的地址，但後一個函數的高於的
+   函數，你會找到您想要的。實際上，在您的問題報告中加入一些「上下文」可能是
+   一個好主意，給出相關的上下幾行。
+
+   如果您由於某些原因無法完成上述操作（如您使用預編譯的內核映像或類似的映像），
+   請儘可能多地告訴我您的相關設置信息，這會有所幫助。有關詳細信息請閱讀
+   『Documentation/admin-guide/reporting-issues.rst』。
+
+ - 或者，您可以在正在運行的內核上使用gdb（只讀的；即不能更改值或設置斷點）。
+   爲此，請首先使用-g編譯內核；適當地編輯arch/x86/Makefile，然後執行 ``make
+   clean`` 。您還需要啓用CONFIG_PROC_FS（通過 ``make config`` ）。
+
+   使用新內核重新啓動後，執行 ``gdb vmlinux /proc/kcore`` 。現在可以使用所有
+   普通的gdb命令。查找系統崩潰點的命令是 ``l *0xXXXXXXXX`` （將xxx替換爲EIP
+   值）。
+
+   用gdb無法調試一個當前未運行的內核是由於gdb（錯誤地）忽略了編譯內核的起始
+   偏移量。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
new file mode 100644
index 000000000000..41a39aebb8d6
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
@@ -0,0 +1,85 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../admin-guide/bug-bisect`
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+二分（bisect）缺陷
++++++++++++++++++++
+
+（英文版）最後更新：2016年10月28日
+
+引言
+=====
+
+始終嘗試由來自kernel.org的原始碼構建的最新內核。如果您沒有信心這樣做，請將
+錯誤報告給您的發行版供應商，而不是內核開發人員。
+
+找到缺陷（bug）並不總是那麼容易，不過仍然得去找。如果你找不到它，不要放棄。
+儘可能多的向相關維護人員報告您發現的信息。請參閱MAINTAINERS文件以了解您所
+關注的子系統的維護人員。
+
+在提交錯誤報告之前，請閱讀「Documentation/admin-guide/reporting-issues.rst」。
+
+設備未出現（Devices not appearing）
+====================================
+
+這通常是由udev/systemd引起的。在將其歸咎於內核之前先檢查一下。
+
+查找導致缺陷的補丁
+===================
+
+使用 ``git`` 提供的工具可以很容易地找到缺陷，只要缺陷是可復現的。
+
+操作步驟：
+
+- 從git原始碼構建內核
+- 以此開始二分 [#f1]_::
+
+	$ git bisect start
+
+- 標記損壞的變更集::
+
+	$ git bisect bad [commit]
+
+- 標記正常工作的變更集::
+
+	$ git bisect good [commit]
+
+- 重新構建內核並測試
+- 使用以下任一與git bisect進行交互::
+
+	$ git bisect good
+
+  或::
+
+	$ git bisect bad
+
+  這取決於您測試的變更集上是否有缺陷
+- 在一些交互之後，git bisect將給出可能導致缺陷的變更集。
+
+- 例如，如果您知道當前版本有問題，而4.8版本是正常的，則可以執行以下操作::
+
+	$ git bisect start
+	$ git bisect bad                 # Current version is bad
+	$ git bisect good v4.8
+
+
+.. [#f1] 您可以（可選地）在開始git bisect的時候提供good或bad參數
+         ``git bisect start [BAD] [GOOD]``
+
+如需進一步參考，請閱讀：
+
+- ``git-bisect`` 的手冊頁
+- `Fighting regressions with git bisect（用git bisect解決回歸）
+  <https://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html>`_
+- `Fully automated bisecting with "git bisect run"（使用git bisect run
+  來全自動二分） <https://lwn.net/Articles/317154>`_
+- `Using Git bisect to figure out when brokenness was introduced
+  （使用Git二分來找出何時引入了錯誤） <http://webchick.net/node/99>`_
+
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
new file mode 100644
index 000000000000..4d813aec77d2
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
@@ -0,0 +1,344 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../admin-guide/bug-hunting`
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+追蹤缺陷
+=========
+
+內核錯誤報告通常附帶如下堆棧轉儲::
+
+	------------[ cut here ]------------
+	WARNING: CPU: 1 PID: 28102 at kernel/module.c:1108 module_put+0x57/0x70
+	Modules linked in: dvb_usb_gp8psk(-) dvb_usb dvb_core nvidia_drm(PO) nvidia_modeset(PO) snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd soundcore nvidia(PO) [last unloaded: rc_core]
+	CPU: 1 PID: 28102 Comm: rmmod Tainted: P        WC O 4.8.4-build.1 #1
+	Hardware name: MSI MS-7309/MS-7309, BIOS V1.12 02/23/2009
+	 00000000 c12ba080 00000000 00000000 c103ed6a c1616014 00000001 00006dc6
+	 c1615862 00000454 c109e8a7 c109e8a7 00000009 ffffffff 00000000 f13f6a10
+	 f5f5a600 c103ee33 00000009 00000000 00000000 c109e8a7 f80ca4d0 c109f617
+	Call Trace:
+	 [<c12ba080>] ? dump_stack+0x44/0x64
+	 [<c103ed6a>] ? __warn+0xfa/0x120
+	 [<c109e8a7>] ? module_put+0x57/0x70
+	 [<c109e8a7>] ? module_put+0x57/0x70
+	 [<c103ee33>] ? warn_slowpath_null+0x23/0x30
+	 [<c109e8a7>] ? module_put+0x57/0x70
+	 [<f80ca4d0>] ? gp8psk_fe_set_frontend+0x460/0x460 [dvb_usb_gp8psk]
+	 [<c109f617>] ? symbol_put_addr+0x27/0x50
+	 [<f80bc9ca>] ? dvb_usb_adapter_frontend_exit+0x3a/0x70 [dvb_usb]
+	 [<f80bb3bf>] ? dvb_usb_exit+0x2f/0xd0 [dvb_usb]
+	 [<c13d03bc>] ? usb_disable_endpoint+0x7c/0xb0
+	 [<f80bb48a>] ? dvb_usb_device_exit+0x2a/0x50 [dvb_usb]
+	 [<c13d2882>] ? usb_unbind_interface+0x62/0x250
+	 [<c136b514>] ? __pm_runtime_idle+0x44/0x70
+	 [<c13620d8>] ? __device_release_driver+0x78/0x120
+	 [<c1362907>] ? driver_detach+0x87/0x90
+	 [<c1361c48>] ? bus_remove_driver+0x38/0x90
+	 [<c13d1c18>] ? usb_deregister+0x58/0xb0
+	 [<c109fbb0>] ? SyS_delete_module+0x130/0x1f0
+	 [<c1055654>] ? task_work_run+0x64/0x80
+	 [<c1000fa5>] ? exit_to_usermode_loop+0x85/0x90
+	 [<c10013f0>] ? do_fast_syscall_32+0x80/0x130
+	 [<c1549f43>] ? sysenter_past_esp+0x40/0x6a
+	---[ end trace 6ebc60ef3981792f ]---
+
+這樣的堆棧跟蹤提供了足夠的信息來識別內核原始碼中發生錯誤的那一行。根據問題的
+嚴重性，它還可能包含 **「Oops」** 一詞，比如::
+
+	BUG: unable to handle kernel NULL pointer dereference at   (null)
+	IP: [<c06969d4>] iret_exc+0x7d0/0xa59
+	*pdpt = 000000002258a001 *pde = 0000000000000000
+	Oops: 0002 [#1] PREEMPT SMP
+	...
+
+儘管有 **Oops** 或其他類型的堆棧跟蹤，但通常需要找到出問題的行來識別和處理缺
+陷。在本章中，我們將參考「Oops」來了解需要分析的各種堆棧跟蹤。
+
+如果內核是用 ``CONFIG_DEBUG_INFO`` 編譯的，那麼可以使用文件：
+`scripts/decode_stacktrace.sh` 。
+
+連結的模塊
+-----------
+
+受到汙染或正在加載/卸載的模塊用「（…）」標記，汙染標誌在
+`Documentation/admin-guide/tainted-kernels.rst` 文件中進行了描述，「正在被加
+載」用「+」標註，「正在被卸載」用「-」標註。
+
+
+Oops消息在哪？
+---------------
+
+通常，Oops文本由klogd從內核緩衝區讀取，然後交給 ``syslogd`` ，後者將其寫入
+syslog文件，通常是 ``/var/log/messages`` （取決於 ``/etc/syslog.conf`` ）。
+在使用systemd的系統上，它也可以由 ``journald`` 守護進程存儲，並通過運行
+``journalctl`` 命令進行訪問。
+
+有時 ``klogd`` 會掛掉，這種情況下您可以運行 ``dmesg > file`` 從內核緩衝區
+讀取數據並保存它。或者您可以 ``cat /proc/kmsg > file`` ，但是您必須適時
+中斷以停止傳輸，因爲 ``kmsg`` 是一個「永無止境的文件」。
+
+如果機器嚴重崩潰，無法輸入命令或磁碟不可用，那還有三個選項：
+
+(1) 手動複製屏幕上的文本，並在機器重新啓動後輸入。很難受，但這是突然崩潰下
+    唯一的選擇。或者你可以用數位相機拍下屏幕——雖然不那麼好，但總比什麼都沒
+    有好。如果消息滾動超出控制台頂部，使用更高解析度（例如 ``vga=791`` ）
+    引導啓動將允許您閱讀更多文本。（警告：這需要 ``vesafb`` ，因此對「早期」
+    的Oppses沒有幫助）
+
+(2) 從串口終端啓動（參見
+    :ref:`Documentation/admin-guide/serial-console.rst <serial_console>` ），
+    在另一台機器上運行數據機然後用你喜歡的通信程序捕獲輸出。
+    Minicom運行良好。
+
+(3) 使用Kdump（參閱 Documentation/admin-guide/kdump/kdump.rst ），使用
+    Documentation/admin-guide/kdump/gdbmacros.txt 中的dmesg gdbmacro從舊內存
+    中提取內核環形緩衝區。
+
+找到缺陷位置
+-------------
+
+如果你能指出缺陷在內核原始碼中的位置，則報告缺陷的效果會非常好。這有兩種方法。
+通常來說使用 ``gdb`` 會比較容易，不過內核需要用調試信息來預編譯。
+
+gdb
+^^^^
+
+GNU 調試器（GNU debugger， ``gdb`` ）是從 ``vmlinux`` 文件中找出OOPS的確切
+文件和行號的最佳方法。
+
+在使用 ``CONFIG_DEBUG_INFO`` 編譯的內核上使用gdb效果最好。可通過運行以下命令
+進行設置::
+
+  $ ./scripts/config -d COMPILE_TEST -e DEBUG_KERNEL -e DEBUG_INFO
+
+在用 ``CONFIG_DEBUG_INFO`` 編譯的內核上，你可以直接從OOPS複製EIP值::
+
+ EIP:    0060:[<c021e50e>]    Not tainted VLI
+
+並使用GDB來將其翻譯成可讀形式::
+
+  $ gdb vmlinux
+  (gdb) l *0xc021e50e
+
+如果沒有啓用 ``CONFIG_DEBUG_INFO`` ，則使用OOPS的函數偏移::
+
+ EIP is at vt_ioctl+0xda8/0x1482
+
+並在啓用 ``CONFIG_DEBUG_INFO`` 的情況下重新編譯內核::
+
+  $ ./scripts/config -d COMPILE_TEST -e DEBUG_KERNEL -e DEBUG_INFO
+  $ make vmlinux
+  $ gdb vmlinux
+  (gdb) l *vt_ioctl+0xda8
+  0x1888 is in vt_ioctl (drivers/tty/vt/vt_ioctl.c:293).
+  288	{
+  289		struct vc_data *vc = NULL;
+  290		int ret = 0;
+  291
+  292		console_lock();
+  293		if (VT_BUSY(vc_num))
+  294			ret = -EBUSY;
+  295		else if (vc_num)
+  296			vc = vc_deallocate(vc_num);
+  297		console_unlock();
+
+或者若您想要更詳細的顯示::
+
+  (gdb) p vt_ioctl
+  $1 = {int (struct tty_struct *, unsigned int, unsigned long)} 0xae0 <vt_ioctl>
+  (gdb) l *0xae0+0xda8
+
+您也可以使用對象文件作爲替代::
+
+  $ make drivers/tty/
+  $ gdb drivers/tty/vt/vt_ioctl.o
+  (gdb) l *vt_ioctl+0xda8
+
+如果你有調用跟蹤，類似::
+
+     Call Trace:
+      [<ffffffff8802c8e9>] :jbd:log_wait_commit+0xa3/0xf5
+      [<ffffffff810482d9>] autoremove_wake_function+0x0/0x2e
+      [<ffffffff8802770b>] :jbd:journal_stop+0x1be/0x1ee
+      ...
+
+這表明問題可能在 :jbd: 模塊中。您可以在gdb中加載該模塊並列出相關代碼::
+
+  $ gdb fs/jbd/jbd.ko
+  (gdb) l *log_wait_commit+0xa3
+
+.. note::
+
+     您還可以對堆棧跟蹤處的任何函數調用執行相同的操作，例如::
+
+	 [<f80bc9ca>] ? dvb_usb_adapter_frontend_exit+0x3a/0x70 [dvb_usb]
+
+     上述調用發生的位置可以通過以下方式看到::
+
+	$ gdb drivers/media/usb/dvb-usb/dvb-usb.o
+	(gdb) l *dvb_usb_adapter_frontend_exit+0x3a
+
+objdump
+^^^^^^^^
+
+要調試內核，請使用objdump並從崩潰輸出中查找十六進位偏移，以找到有效的代碼/匯
+編行。如果沒有調試符號，您將看到所示例程的彙編程序代碼，但是如果內核有調試
+符號，C代碼也將可見（調試符號可以在內核配置菜單的hacking項中啓用）。例如::
+
+    $ objdump -r -S -l --disassemble net/dccp/ipv4.o
+
+.. note::
+
+   您需要處於內核樹的頂層以便此獲得您的C文件。
+
+如果您無法訪問原始碼，仍然可以使用以下方法調試一些崩潰轉儲（如Dave Miller的
+示例崩潰轉儲輸出所示）::
+
+     EIP is at 	+0x14/0x4c0
+      ...
+     Code: 44 24 04 e8 6f 05 00 00 e9 e8 fe ff ff 8d 76 00 8d bc 27 00 00
+     00 00 55 57  56 53 81 ec bc 00 00 00 8b ac 24 d0 00 00 00 8b 5d 08
+     <8b> 83 3c 01 00 00 89 44  24 14 8b 45 28 85 c0 89 44 24 18 0f 85
+
+     Put the bytes into a "foo.s" file like this:
+
+            .text
+            .globl foo
+     foo:
+            .byte  .... /* bytes from Code: part of OOPS dump */
+
+     Compile it with "gcc -c -o foo.o foo.s" then look at the output of
+     "objdump --disassemble foo.o".
+
+     Output:
+
+     ip_queue_xmit:
+         push       %ebp
+         push       %edi
+         push       %esi
+         push       %ebx
+         sub        $0xbc, %esp
+         mov        0xd0(%esp), %ebp        ! %ebp = arg0 (skb)
+         mov        0x8(%ebp), %ebx         ! %ebx = skb->sk
+         mov        0x13c(%ebx), %eax       ! %eax = inet_sk(sk)->opt
+
+`scripts/decodecode` 文件可以用來自動完成大部分工作，這取決於正在調試的CPU
+體系結構。
+
+報告缺陷
+---------
+
+一旦你通過定位缺陷找到了其發生的地方，你可以嘗試自己修復它或者向上游報告它。
+
+爲了向上游報告，您應該找出用於開發受影響代碼的郵件列表。這可以使用 ``get_maintainer.pl`` 。
+
+
+例如，您在gspca的sonixj.c文件中發現一個缺陷，則可以通過以下方法找到它的維護者::
+
+	$ ./scripts/get_maintainer.pl -f drivers/media/usb/gspca/sonixj.c
+	Hans Verkuil <hverkuil@xs4all.nl> (odd fixer:GSPCA USB WEBCAM DRIVER,commit_signer:1/1=100%)
+	Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB),commit_signer:1/1=100%)
+	Tejun Heo <tj@kernel.org> (commit_signer:1/1=100%)
+	Bhaktipriya Shridhar <bhaktipriya96@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:4/4=100%,removed_lines:9/9=100%)
+	linux-media@vger.kernel.org (open list:GSPCA USB WEBCAM DRIVER)
+	linux-kernel@vger.kernel.org (open list)
+
+請注意它將指出：
+
+- 最後接觸原始碼的開發人員（如果這是在git樹中完成的）。在上面的例子中是Tejun
+  和Bhaktipriya（在這個特定的案例中，沒有人真正參與這個文件的開發）；
+- 驅動維護人員（Hans Verkuil）；
+- 子系統維護人員（Mauro Carvalho Chehab）；
+- 驅動程序和/或子系統郵件列表（linux-media@vger.kernel.org）；
+- Linux內核郵件列表（linux-kernel@vger.kernel.org）。
+
+通常，修復缺陷的最快方法是將它報告給用於開發相關代碼的郵件列表（linux-media
+ML），抄送驅動程序維護者（Hans）。
+
+如果你完全不知道該把報告寄給誰，且 ``get_maintainer.pl`` 也沒有提供任何有用
+的信息，請發送到linux-kernel@vger.kernel.org。
+
+感謝您的幫助，這使Linux儘可能穩定:-)
+
+修復缺陷
+---------
+
+如果你懂得編程，你不僅可以通過報告錯誤來幫助我們，還可以提供一個解決方案。
+畢竟，開源就是分享你的工作，你不想因爲你的天才而被認可嗎？
+
+如果你決定這樣做，請在制定解決方案後將其提交到上游。
+
+請務必閱讀
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` ，
+以幫助您的代碼被接受。
+
+
+---------------------------------------------------------------------------
+
+用 ``klogd`` 進行Oops跟蹤的注意事項
+------------------------------------
+
+爲了幫助Linus和其他內核開發人員， ``klogd`` 對保護故障的處理提供了大量支持。
+爲了完整支持地址解析，至少應該使用 ``sysklogd`` 包的1.3-pl3版本。
+
+當發生保護故障時， ``klogd`` 守護進程會自動將內核日誌消息中的重要地址轉換爲
+它們的等效符號。然後通過 ``klogd`` 使用的任何報告機制來轉發這個已翻譯的內核
+消息。保護錯誤消息可以直接從消息文件中剪切出來並轉發給內核開發人員。
+
+``klogd`` 執行兩種類型的地址解析，靜態翻譯和動態翻譯。靜態翻譯使用System.map
+文件。爲了進行靜態轉換， ``klogd`` 守護進程必須能夠在守護進程初始化時找到系
+統映射文件。有關 ``klogd`` 如何搜索映射文件的信息，請參見klogd手冊頁。
+
+當使用內核可加載模塊時，動態地址轉換非常重要。由於內核模塊的內存是從內核的
+動態內存池中分配的，因此無論是模塊的開頭還是模塊中的函數和符號都沒有固定的
+位置。
+
+內核支持系統調用，允許程序確定加載哪些模塊及其在內存中的位置。klogd守護進程
+使用這些系統調用構建了一個符號表，可用於調試可加載內核模塊中發生的保護錯誤。
+
+klogd至少會提供產生保護故障的模塊的名稱。如果可加載模塊的開發人員選擇從模塊
+導出符號信息，則可能會有其他可用的符號信息。
+
+由於內核模塊環境可以是動態的，因此當模塊環境發生變化時，必須有一種通知
+``klogd`` 守護進程的機制。有一些可用的命令行選項允許klogd向當前正在執行的守
+護進程發出信號示意應該刷新符號信息。有關更多信息，請參閱 ``klogd`` 手冊頁。
+
+sysklogd發行版附帶了一個補丁，它修改了 ``modules-2.0.0`` 包，以便在加載或
+卸載模塊時自動向klogd發送信號。應用此補丁基本上可無縫支持調試內核可加載模塊
+發生的保護故障。
+
+以下是 ``klogd`` 處理的可加載模塊中的保護故障示例::
+
+	Aug 29 09:51:01 blizard kernel: Unable to handle kernel paging request at virtual address f15e97cc
+	Aug 29 09:51:01 blizard kernel: current->tss.cr3 = 0062d000, %cr3 = 0062d000
+	Aug 29 09:51:01 blizard kernel: *pde = 00000000
+	Aug 29 09:51:01 blizard kernel: Oops: 0002
+	Aug 29 09:51:01 blizard kernel: CPU:    0
+	Aug 29 09:51:01 blizard kernel: EIP:    0010:[oops:_oops+16/3868]
+	Aug 29 09:51:01 blizard kernel: EFLAGS: 00010212
+	Aug 29 09:51:01 blizard kernel: eax: 315e97cc   ebx: 003a6f80   ecx: 001be77b   edx: 00237c0c
+	Aug 29 09:51:01 blizard kernel: esi: 00000000   edi: bffffdb3   ebp: 00589f90   esp: 00589f8c
+	Aug 29 09:51:01 blizard kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
+	Aug 29 09:51:01 blizard kernel: Process oops_test (pid: 3374, process nr: 21, stackpage=00589000)
+	Aug 29 09:51:01 blizard kernel: Stack: 315e97cc 00589f98 0100b0b4 bffffed4 0012e38e 00240c64 003a6f80 00000001
+	Aug 29 09:51:01 blizard kernel:        00000000 00237810 bfffff00 0010a7fa 00000003 00000001 00000000 bfffff00
+	Aug 29 09:51:01 blizard kernel:        bffffdb3 bffffed4 ffffffda 0000002b 0007002b 0000002b 0000002b 00000036
+	Aug 29 09:51:01 blizard kernel: Call Trace: [oops:_oops_ioctl+48/80] [_sys_ioctl+254/272] [_system_call+82/128]
+	Aug 29 09:51:01 blizard kernel: Code: c7 00 05 00 00 00 eb 08 90 90 90 90 90 90 90 90 89 ec 5d c3
+
+---------------------------------------------------------------------------
+
+::
+
+  Dr. G.W. Wettstein           Oncology Research Div. Computing Facility
+  Roger Maris Cancer Center    INTERNET: greg@wind.rmcc.com
+  820 4th St. N.
+  Fargo, ND  58122
+  Phone: 701-234-7556
+
diff --git a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
new file mode 100644
index 000000000000..bdc1a22046cf
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+
+清除 WARN_ONCE
+--------------
+
+WARN_ONCE / WARN_ON_ONCE / printk_once 僅僅列印一次消息.
+
+echo 1 > /sys/kernel/debug/clear_warn_once
+
+可以清除這種狀態並且再次允許列印一次告警信息，這對於運行測試集後重現問題
+很有用。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
new file mode 100644
index 000000000000..be087cef1967
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+
+========
+CPU 負載
+========
+
+Linux通過``/proc/stat``和``/proc/uptime``導出各種信息，用戶空間工具
+如top(1)使用這些信息計算系統花費在某個特定狀態的平均時間。
+例如：
+
+    $ iostat
+    Linux 2.6.18.3-exp (linmac)     02/20/2007
+
+    avg-cpu:  %user   %nice %system %iowait  %steal   %idle
+              10.01    0.00    2.92    5.44    0.00   81.63
+
+    ...
+
+這裡系統認爲在默認採樣周期內有10.01%的時間工作在用戶空間，2.92%的時
+間用在系統空間，總體上有81.63%的時間是空閒的。
+
+大多數情況下``/proc/stat``的信息幾乎真實反映了系統信息，然而，由於內
+核採集這些數據的方式/時間的特點，有時這些信息根本不可靠。
+
+那麼這些信息是如何被搜集的呢？每當時間中斷觸發時，內核查看此刻運行的
+進程類型，並增加與此類型/狀態進程對應的計數器的值。這種方法的問題是
+在兩次時間中斷之間系統（進程）能夠在多種狀態之間切換多次，而計數器只
+增加最後一種狀態下的計數。
+
+舉例
+---
+
+假設系統有一個進程以如下方式周期性地占用cpu::
+
+     兩個時鐘中斷之間的時間線
+    |-----------------------|
+     ^                     ^
+     |_ 開始運行           |
+                           |_ 開始睡眠
+                           （很快會被喚醒）
+
+在上面的情況下，根據``/proc/stat``的信息（由於當系統處於空閒狀態時，
+時間中斷經常會發生）系統的負載將會是0
+
+大家能夠想像內核的這種行爲會發生在許多情況下，這將導致``/proc/stat``
+中存在相當古怪的信息::
+
+	/* gcc -o hog smallhog.c */
+	#include <time.h>
+	#include <limits.h>
+	#include <signal.h>
+	#include <sys/time.h>
+	#define HIST 10
+
+	static volatile sig_atomic_t stop;
+
+	static void sighandler (int signr)
+	{
+	(void) signr;
+	stop = 1;
+	}
+	static unsigned long hog (unsigned long niters)
+	{
+	stop = 0;
+	while (!stop && --niters);
+	return niters;
+	}
+	int main (void)
+	{
+	int i;
+	struct itimerval it = { .it_interval = { .tv_sec = 0, .tv_usec = 1 },
+				.it_value = { .tv_sec = 0, .tv_usec = 1 } };
+	sigset_t set;
+	unsigned long v[HIST];
+	double tmp = 0.0;
+	unsigned long n;
+	signal (SIGALRM, &sighandler);
+	setitimer (ITIMER_REAL, &it, NULL);
+
+	hog (ULONG_MAX);
+	for (i = 0; i < HIST; ++i) v[i] = ULONG_MAX - hog (ULONG_MAX);
+	for (i = 0; i < HIST; ++i) tmp += v[i];
+	tmp /= HIST;
+	n = tmp - (tmp / 3.0);
+
+	sigemptyset (&set);
+	sigaddset (&set, SIGALRM);
+
+	for (;;) {
+		hog (n);
+		sigwait (&set, &i);
+	}
+	return 0;
+	}
+
+
+參考
+---
+
+- https://lore.kernel.org/r/loom.20070212T063225-663@post.gmane.org
+- Documentation/filesystems/proc.rst (1.8)
+
+
+謝謝
+---
+
+Con Kolivas, Pavel Machek
+
diff --git a/Documentation/translations/zh_TW/admin-guide/index.rst b/Documentation/translations/zh_TW/admin-guide/index.rst
new file mode 100644
index 000000000000..293c20245783
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/index.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../admin-guide/index`
+:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+
+Linux 內核用戶和管理員指南
+==========================
+
+下面是一組隨時間添加到內核中的面向用戶的文檔的集合。到目前爲止，還沒有一個
+整體的順序或組織 - 這些材料不是一個單一的，連貫的文件！幸運的話，情況會隨著
+時間的推移而迅速改善。
+
+這個初始部分包含總體信息，包括描述內核的README， 關於內核參數的文檔等。
+
+.. toctree::
+   :maxdepth: 1
+
+   README
+
+Todolist:
+
+   kernel-parameters
+   devices
+   sysctl/index
+
+本節介紹CPU漏洞及其緩解措施。
+
+Todolist:
+
+   hw-vuln/index
+
+下面的一組文檔，針對的是試圖跟蹤問題和bug的用戶。
+
+.. toctree::
+   :maxdepth: 1
+
+   reporting-issues
+   security-bugs
+   bug-hunting
+   bug-bisect
+   tainted-kernels
+   init
+
+Todolist:
+
+   reporting-bugs
+   ramoops
+   dynamic-debug-howto
+   kdump/index
+   perf/index
+
+這是應用程式開發人員感興趣的章節的開始。可以在這裡找到涵蓋內核ABI各個
+方面的文檔。
+
+Todolist:
+
+   sysfs-rules
+
+本手冊的其餘部分包括各種指南，介紹如何根據您的喜好配置內核的特定行爲。
+
+
+.. toctree::
+   :maxdepth: 1
+
+   clearing-warn-once
+   cpu-load
+   unicode
+
+Todolist:
+
+   acpi/index
+   aoe/index
+   auxdisplay/index
+   bcache
+   binderfs
+   binfmt-misc
+   blockdev/index
+   bootconfig
+   braille-console
+   btmrvl
+   cgroup-v1/index
+   cgroup-v2
+   cifs/index
+   cputopology
+   dell_rbu
+   device-mapper/index
+   edid
+   efi-stub
+   ext4
+   nfs/index
+   gpio/index
+   highuid
+   hw_random
+   initrd
+   iostats
+   java
+   jfs
+   kernel-per-CPU-kthreads
+   laptops/index
+   lcd-panel-cgram
+   ldm
+   lockup-watchdogs
+   LSM/index
+   md
+   media/index
+   mm/index
+   module-signing
+   mono
+   namespaces/index
+   numastat
+   parport
+   perf-security
+   pm/index
+   pnp
+   rapidio
+   ras
+   rtc
+   serial-console
+   svga
+   sysrq
+   thunderbolt
+   ufs
+   vga-softcursor
+   video-output
+   xfs
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/translations/zh_TW/admin-guide/init.rst b/Documentation/translations/zh_TW/admin-guide/init.rst
new file mode 100644
index 000000000000..32cdf134948f
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/init.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../admin-guide/init`
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+解釋「No working init found.」啓動掛起消息
+==========================================
+
+:作者:
+
+ Andreas Mohr <andi at lisas period de>
+
+ Cristian Souza <cristianmsbr at gmail period com>
+
+本文檔提供了加載初始化二進位（init binary）失敗的一些高層級原因（大致按執行
+順序列出）。
+
+1) **無法掛載根文件系統Unable to mount root FS** ：請設置「debug」內核參數（在
+   引導加載程序bootloader配置文件或CONFIG_CMDLINE）以獲取更詳細的內核消息。
+
+2) **初始化二進位不存在於根文件系統上init binary doesn't exist on rootfs** ：
+   確保您的根文件系統類型正確（並且 ``root=`` 內核參數指向正確的分區）；擁有
+   所需的驅動程序，例如SCSI或USB等存儲硬體；文件系統（ext3、jffs2等）是內建的
+   （或者作爲模塊由initrd預加載）。
+
+3) **控制台設備損壞Broken console device** ： ``console= setup`` 中可能存在
+   衝突 --> 初始控制台不可用（initial console unavailable）。例如，由於串行
+   IRQ問題（如缺少基於中斷的配置）導致的某些串行控制台不可靠。嘗試使用不同的
+   ``console= device`` 或像 ``netconsole=`` 。
+
+4) **二進位存在但依賴項不可用Binary exists but dependencies not available** ：
+   例如初始化二進位的必需庫依賴項，像 ``/lib/ld-linux.so.2`` 丟失或損壞。使用
+   ``readelf -d <INIT>|grep NEEDED`` 找出需要哪些庫。
+
+5) **無法加載二進位Binary cannot be loaded** ：請確保二進位的體系結構與您的
+   硬體匹配。例如i386不匹配x86_64，或者嘗試在ARM硬體上加載x86。如果您嘗試在
+   此處加載非二進位文件（shell腳本？），您應該確保腳本在其工作頭（shebang
+   header）行 ``#!/...`` 中指定能正常工作的解釋器（包括其庫依賴項）。在處理
+   腳本之前，最好先測試一個簡單的非腳本二進位文件，比如 ``/bin/sh`` ，並確認
+   它能成功執行。要了解更多信息，請將代碼添加到 ``init/main.c`` 以顯示
+   kernel_execve()的返回值。
+
+當您發現新的失敗原因時，請擴展本解釋（畢竟加載初始化二進位是一個 **關鍵** 且
+艱難的過渡步驟，需要儘可能無痛地進行），然後向LKML提交一個補丁。
+
+待辦事項：
+
+- 通過一個可以存儲 ``kernel_execve()`` 結果值的結構體數組實現各種
+  ``run_init_process()`` 調用，並在失敗時通過疊代 **所有** 結果來記錄一切
+  （非常重要的可用性修復）。
+- 試著使實現本身在一般情況下更有幫助，例如在受影響的地方提供額外的錯誤消息。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
new file mode 100644
index 000000000000..27638e199f13
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
@@ -0,0 +1,1337 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+..
+   If you want to distribute this text under CC-BY-4.0 only, please use 'The
+   Linux kernel developers' for author attribution and link this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/reporting-issues.rst
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+
+報告問題
++++++++++
+
+
+簡明指南（亦即 太長不看）
+==========================
+
+您面臨的是否爲同系列穩定版或長期支持內核的普通內核的回歸？是否仍然受支持？
+請搜索 `LKML內核郵件列表 <https://lore.kernel.org/lkml/>`_ 和
+`Linux穩定版郵件列表 <https://lore.kernel.org/stable/>`_ 存檔中匹配的報告並
+加入討論。如果找不到匹配的報告，請安裝該系列的最新版本。如果它仍然出現問題，
+報告給穩定版郵件列表（stable@vger.kernel.org）。
+
+在所有其他情況下，請儘可能猜測是哪個內核部分導致了問題。查看MAINTAINERS文件，
+了解開發人員希望如何得知問題，大多數情況下，報告問題都是通過電子郵件和抄送
+相關郵件列表進行的。檢查報告目的地的存檔中是否已有匹配的報告；也請搜索
+`LKML <https://lore.kernel.org/lkml/>`_ 和網絡。如果找不到可加入的討論，請
+安裝 `最新的主線內核 <https://kernel.org/>`_ 。如果仍存在問題，請發送報告。
+
+問題已經解決了，但是您希望看到它在一個仍然支持的穩定版或長期支持系列中得到
+解決？請安裝其最新版本。如果它出現了問題，那麼在主線中搜索修復它的更改，並
+檢查是否正在回傳（backporting）或者已放棄；如果兩者都沒有，那麼可詢問處理
+更改的人員。
+
+**通用提醒** ：當安裝和測試上述內核時，請確保它是普通的（即：沒有補丁，也沒
+有使用附加模塊）。還要確保它是在一個正常的環境中構建和運行，並且在問題發生
+之前沒有被汙染（tainted）。
+
+在編寫報告時，要涵蓋與問題相關的所有信息，如使用的內核和發行版。在碰見回歸時，
+嘗試給出引入它的更改的提交ID，二分可以找到它。如果您同時面臨Linux內核的多個
+問題，請分別報告每個問題。
+
+一旦報告發出，請回答任何出現的問題，並儘可能地提供幫助。這包括通過不時重新
+測試新版本並發送狀態更新來推動進展。
+
+
+如何向內核維護人員報告問題的逐步指南
+=====================================
+
+上面的簡明指南概述了如何向Linux內核開發人員報告問題。對於已經熟悉向自由和開
+源軟體（FLOSS）項目報告問題的人來說，這可能是他們所需要的全部內容。對於其他
+人，本部分更爲詳細，並一步一步地描述。爲了便於閱讀，它仍然儘量簡潔，並省略
+了許多細節；這些在逐步指南後的參考章節中進行了描述，該章節更詳細地解釋了每
+個步驟。
+
+注意：本節涉及的方面比簡明指南多，順序也稍有不同。這符合你的利益，以確保您
+儘早意識到看起來像Linux內核毛病的問題可能實際上是由其他原因引起的。這些步驟
+可以確保你最終不會覺得在這一過程中投入的時間是浪費：
+
+ * 您是否面臨硬體或軟體供應商提供的Linux內核的問題？那麼基本上您最好停止閱讀
+   本文檔，轉而向您的供應商報告問題，除非您願意自己安裝最新的Linux版本。尋找
+   和解決問題往往需要後者。
+
+ * 使用您喜愛的網絡搜尋引擎對現有報告進行粗略搜索；此外，請檢查
+   `Linux內核郵件列表（LKML） <https://lore.kernel.org/lkml/>`_ 的存檔。如果
+   找到匹配的報告，請加入討論而不是發送新報告。
+
+ * 看看你正在處理的問題是否爲回歸問題、安全問題或非常嚴重的問題：這些都是需
+   要在接下來的一些步驟中特別處理的「高優先級問題」。
+
+ * 確保不是內核環境導致了您面臨的問題。
+
+ * 創建一個新的備份，並將系統修復和恢復工具放在手邊。
+
+ * 確保您的系統不會通過動態構建額外的內核模塊來增強其內核，像DKMS這樣的解決
+   方案可能在您不知情的情況下就在本地進行了這樣的工作。
+
+ * 當問題發生時，檢查您的內核是否被「汙染」，因爲使內核設置這個標誌的事件可能
+   會導致您面臨的問題。
+
+ * 粗略地寫下如何重現這個問題。如果您同時處理多個問題，請爲每個問題單獨寫注
+   釋，並確保它們在新啓動的系統上獨立出現。這是必要的，因爲每個問題都需要分
+   別報告給內核開發人員，除非它們嚴重糾纏在一起。
+
+ * 如果您正面臨穩定版或長期支持版本線的回歸（例如從5.10.4更新到5.10.5時出現
+   故障），請查看後文「報告穩定版和長期支持內核線的回歸」小節。
+
+ * 定位可能引起問題的驅動程序或內核子系統。找出其開發人員期望的報告的方式和
+   位置。注意：大多數情況下不會是 bugzilla.kernel.org，因爲問題通常需要通
+   過郵件發送給維護人員和公共郵件列表。
+
+ * 在缺陷追蹤器或問題相關郵件列表的存檔中徹底搜索可能與您的問題匹配的報告。
+   如果你發現了一些相關討論，請加入討論而不是發送新的報告。
+
+在完成這些準備之後，你將進入主要部分：
+
+ * 除非您已經在運行最新的「主線」Linux內核，否則最好在報告流程前安裝它。在某些
+   情況下，使用最新的「穩定版」Linux進行測試和報告也是可以接受的替代方案；在
+   合併窗口期間，這實際上可能是最好的方法，但在開發階段最好還是暫停幾天。無論
+   你選擇什麼版本，最好使用「普通」構建。忽略這些建議會大大增加您的報告被拒絕
+   或忽略的風險。
+
+ * 確保您剛剛安裝的內核在運行時不會「汙染」自己。
+
+ * 在您剛剛安裝的內核中復現這個問題。如果它沒有出現，請查看下方只發生在
+   穩定版和長期支持內核的問題的說明。
+
+ * 優化你的筆記：試著找到並寫出最直接的復現問題的方法。確保最終結果包含所有
+   重要的細節，同時讓第一次聽說的人容易閱讀和理解。如果您在此過程中學到了一
+   些東西，請考慮再次搜索關於該問題的現有報告。
+
+ * 如果失敗涉及「panic」、「Oops」、「warning」或「BUG」，請考慮解碼內核日誌以查找觸
+   發錯誤的代碼行。
+
+ * 如果您的問題是回歸問題，請儘可能縮小引入問題時的範圍。
+
+ * 通過詳細描述問題來開始編寫報告。記得包括以下條目：您爲復現而安裝的最新內
+   核版本、使用的Linux發行版以及關於如何復現該問題的說明。如果可能，將內核
+   構建配置（.config）和 ``dmesg`` 的輸出放在網上的某個地方，並連結到它。包
+   含或上傳所有其他可能相關的信息，如Oops的輸出/截圖或來自 ``lspci`` 的輸出
+   。一旦你寫完了這個主要部分，請在上方插入一個正常長度的段落快速概述問題和
+   影響。再在此之上添加一個簡單描述問題的句子，以得到人們的閱讀。現在給出一
+   個更短的描述性標題或主題。然後就可以像MAINTAINERS文件告訴你的那樣發送或
+   提交報告了，除非你在處理一個「高優先級問題」：它們需要按照下面「高優先級問
+   題的特殊處理」所述特別關照。
+
+ * 等待別人的反應，繼續推進事情，直到你能夠接受這樣或那樣的結果。因此，請公
+   開和及時地回應任何詢問。測試提出的修復。積極地測試：至少重新測試每個新主
+   線版本的首個候選版本（RC），並報告你的結果。如果出現拖延，就友好地提醒一
+   下。如果你沒有得到任何幫助或者未能滿意，請試著自己幫助自己。
+
+
+報告穩定版和長期支持內核線的回歸
+----------------------------------
+
+如果您發現了穩定版或長期支持內核版本線中的回歸問題並按上述流程跳到這裡，那麼
+請閱讀本小節。即例如您在從5.10.4更新到5.10.5時出現了問題（從5.9.15到5.10.5則
+不是）。開發人員希望儘快修復此類回歸，因此有一個簡化流程來報告它們：
+
+ * 檢查內核開發人員是否仍然維護你關心的Linux內核版本線：去 `kernel.org 的首頁
+   <https://kernel.org/>`_ ，確保此特定版本線的最新版沒有「[EOL]」標記。
+
+ * 檢查 `Linux穩定版郵件列表 <https://lore.kernel.org/stable/>`_ 中的現有報告。
+
+ * 從特定的版本線安裝最新版本作爲純淨內核。確保這個內核沒有被汙染，並且仍然
+   存在問題，因爲問題可能已經在那裡被修復了。如果您第一次發現供應商內核的問題，
+   請檢查已知最新版本的普通構建是否可以正常運行。
+
+ * 向Linux穩定版郵件列表發送一個簡短的問題報告(stable@vger.kernel.org)。大致
+   描述問題，並解釋如何復現。講清楚首個出現問題的版本和最後一個工作正常的版本。
+   然後等待進一步的指示。
+
+下面的參考章節部分詳細解釋了這些步驟中的每一步。
+
+
+報告只發生在較舊內核版本線的問題
+----------------------------------
+
+若您嘗試了上述的最新主線內核，但未能在那裡復現問題，那麼本小節適用於您；以下
+流程有助於使問題在仍然支持的穩定版或長期支持版本線，或者定期基於最新穩定版或
+長期支持內核的供應商內核中得到修復。如果是這種情況，請執行以下步驟：
+
+ * 請做好準備，接下來的幾個步驟可能無法在舊版本中解決問題：修復可能太大或太
+   冒險，無法移植到那裡。
+
+ * 執行前節「報告穩定版和長期支持內核線的回歸」中的前三個步驟。
+
+ * 在Linux內核版本控制系統中搜索修復主線問題的更改，因爲它的提交消息可能會
+   告訴你修復是否已經計劃好了支持。如果你沒有找到，搜索適當的郵件列表，尋找
+   討論此類問題或同行評議可能修復的帖子；然後檢查討論是否認爲修復不適合支持。
+   如果支持根本不被考慮，加入最新的討論，詢問是否有可能。
+
+ * 前面的步驟之一應該會給出一個解決方案。如果仍未能成功，請向可能引起問題的
+   子系統的維護人員詢問建議；抄送特定子系統的郵件列表以及穩定版郵件列表
+
+下面的參考章節部分詳細解釋了這些步驟中的每一步。
+
+
+參考章節：向內核維護者報告問題
+===============================
+
+上面的詳細指南簡要地列出了所有主要步驟，這對大多數人來說應該足夠了。但有時，
+即使是有經驗的用戶也可能想知道如何實際執行這些步驟之一。這就是本節的目的，
+因爲它將提供關於上述每個步驟的更多細節。請將此作爲參考文檔：可以從頭到尾
+閱讀它。但它主要是爲了瀏覽和查找如何實際執行這些步驟的詳細信息。
+
+在深入挖掘細節之前，我想先給你一些一般性建議：
+
+ * Linux內核開發人員很清楚這個過程很複雜，比其他的FLOSS項目要求更多。我們很
+   希望讓它更簡單。但這需要在不同的地方以及一些基礎設施上付諸努力，這些基礎
+   設施需要持續的維護；尚未有人站出來做這些工作，所以目前情況就是這樣。
+
+ * 與某些供應商簽訂的保證或支持合同並不能使您有權要求上游Linux內核社區的開
+   發人員進行修復：這樣的合同完全在Linux內核、其開發社區和本文檔的範圍之外。
+   這就是爲什麼在這種情況下，你不能要求任何契約保證，即使開發人員處理的問
+   題對供應商有效。如果您想主張您的權利，使用供應商的支持渠道代替。當這樣做
+   的時候，你可能想提出你希望看到這個問題在上游Linux內核中修復；可以這是確
+   保最終修復將被納入所有Linux發行版的唯一方法來鼓勵他們。
+
+ * 如果您從未向FLOSS項目報告過任何問題，那麼您應該考慮閱讀 `如何有效地報告
+   缺陷 <https://www.chiark.greenend.org.uk/~sgtatham/bugs.html>`_ ， `如何
+   以明智的方式提問 <http://www.catb.org/esr/faqs/smart-questions.html>`_ ，
+   和 `如何提出好問題 <https://jvns.ca/blog/good-questions/>`_ 。
+
+解決這些問題之後，可以在下面找到如何正確地向Linux內核報告問題的詳細信息。
+
+
+確保您使用的是上游Linux內核
+----------------------------
+
+   *您是否面臨硬體或軟體供應商提供的Linux內核的問題？那麼基本上您最好停止閱
+   讀本文檔，轉而向您的供應商報告問題，除非您願意自己安裝最新的Linux版本。
+   尋找和解決問題往往需要後者。*
+
+與大多數程式設計師一樣，Linux內核開發人員不喜歡花時間處理他們維護的原始碼中根本
+不會發生的問題的報告。這只會浪費每個人的時間，尤其是你的時間。不幸的是，當
+涉及到內核時，這樣的情況很容易發生，並且常常導致雙方氣餒。這是因爲幾乎所有預
+裝在設備（台式機、筆記本電腦、智慧型手機、路由器等）上的Linux內核，以及大多數
+由Linux發行商提供的內核，都與由kernel.org發行的官方Linux內核相距甚遠：從Linux
+開發的角度來看，這些供應商提供的內核通常是古老的或者經過了大量修改，通常兩點
+兼具。
+
+大多數供應商內核都不適合用來向Linux內核開發人員報告問題：您在其中遇到的問題
+可能已經由Linux內核開發人員在數月或數年前修復；此外，供應商的修改和增強可能
+會導致您面臨的問題，即使它們看起來很小或者完全不相關。這就是爲什麼您應該向
+供應商報告這些內核的問題。它的開發者應該查看報告，如果它是一個上游問題，直接
+於上游修復或將報告轉發到那裡。在實踐中，這有時行不通。因此，您可能需要考慮
+通過自己安裝最新的Linux內核內核來繞過供應商。如果如果您選擇此方法，那麼本指
+南後面的步驟將解釋如何在排除了其他可能導致您的問題的原因後執行此操作。
+
+注意前段使用的詞語是「大多數」，因爲有時候開發人員實際上願意處理供應商內核出現
+的問題報告。他們是否這麼做很大程度上取決於開發人員和相關問題。如果發行版只
+根據最近的Linux版本對內核進行了較小修改，那麼機會就比較大；例如對於Debian
+GNU/Linux Sid或Fedora Rawhide所提供的主線內核。一些開發人員還將接受基於最新
+穩定內核的發行版內核問題報告，只要它改動不大；例如Arch Linux、常規Fedora版本
+和openSUSE Turboweed。但是請記住，您最好使用主線Linux，並避免在此流程中使用
+穩定版內核，如「安裝一個新的內核進行測試」一節中所詳述。
+
+當然，您可以忽略所有這些建議，並向上游Linux開發人員報告舊的或經過大量修改的
+供應商內核的問題。但是注意，這樣的報告經常被拒絕或忽視，所以自行小心考慮一下。
+不過這還是比根本不報告問題要好：有時候這樣的報告會直接或間接地幫助解決之後的
+問題。
+
+
+搜索現有報告（第一部分）
+-------------------------
+
+    *使用您喜愛的網絡搜尋引擎對現有報告進行粗略搜索；此外，請檢查Linux內核
+    郵件列表（LKML）的存檔。如果找到匹配的報告，請加入討論而不是發送新報告。*
+
+報告一個別人已經提出的問題，對每個人來說都是浪費時間，尤其是作爲報告人的你。
+所以徹底檢查是否有人已經報告了這個問題，這對你自己是有利的。在流程中的這一步，
+可以只執行一個粗略的搜索：一旦您知道您的問題需要報告到哪裡，稍後的步驟將告訴
+您如何詳細搜索。儘管如此，不要倉促完成這一步，它可以節省您的時間和減少麻煩。
+
+只需先用你最喜歡的搜尋引擎在網際網路上搜索。然後再搜索Linux內核郵件列表（LKML）
+存檔。
+
+如果搜索結果實在太多，可以考慮讓你的搜尋引擎將搜索時間範圍限制在過去的一個
+月或一年。而且無論你在哪裡搜索，一定要用恰當的搜索關鍵詞；也要變化幾次關鍵
+詞。同時，試著從別人的角度看問題：這將幫助你想出其他的關鍵詞。另外，一定不
+要同時使用過多的關鍵詞。記住搜索時要同時嘗試包含和不包含內核驅動程序的名稱
+或受影響的硬體組件的名稱等信息。但其確切的品牌名稱（比如說「華碩紅魔 Radeon
+RX 5700 XT Gaming OC」）往往幫助不大，因爲它太具體了。相反，嘗試搜索術語，如
+型號（Radeon 5700 或 Radeon 5000）和核心代號（「Navi」或「Navi10」），以及包含
+和不包含其製造商（「AMD」）。
+
+如果你發現了關於你的問題的現有報告，請加入討論，因爲你可能會提供有價值的額
+外信息。這一點很重要，即使是在修復程序已經準備好或處於最後階段，因爲開發人
+員可能會尋找能夠提供額外信息或測試建議修復程序的人。跳到「發布報告後的責任」
+一節，了解有關如何正確參與的細節。
+
+注意，搜索 `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ 網站可能
+也是一個好主意，因爲這可能會提供有價值的見解或找到匹配的報告。如果您發現後者，
+請記住：大多數子系統都希望在不同的位置報告，如下面「你需要將問題報告到何處」
+一節中所述。因此本應處理這個問題的開發人員甚至可能不知道bugzilla的工單。所以
+請檢查工單中的問題是否已經按照本文檔所述得到報告，如果沒有，請考慮這樣做。
+
+高優先級的問題？
+-----------------
+
+    *看看你正在處理的問題是否是回歸問題、安全問題或非常嚴重的問題：這些都是
+    需要在接下來的一些步驟中特別處理的「高優先級問題」。*
+
+Linus Torvalds和主要的Linux內核開發人員希望看到一些問題儘快得到解決，因此在
+報告過程中有一些「高優先級問題」的處理略有不同。有三種情況符合條件:回歸、安全
+問題和非常嚴重的問題。
+
+如果在舊版本的Linux內核中工作的東西不能在新版本的Linux內核中工作，或者某種
+程度上在新版本的Linux內核中工作得更差，那麼你就需要處理「回歸」。因此，當一個
+在Linux 5.7中表現良好的WiFi驅動程序在5.8中表現不佳或根本不能工作時，這是一
+種回歸。如果應用程式在新的內核中出現不穩定的現象，這也是一種回歸，這可能是
+由於內核和用戶空間之間的接口（如procfs和sysfs）發生不兼容的更改造成的。顯著
+的性能降低或功耗增加也可以稱爲回歸。但是請記住:新內核需要使用與舊內核相似的
+配置來構建（參見下面如何實現這一點）。這是因爲內核開發人員在實現新特性時有
+時無法避免不兼容性；但是爲了避免回歸，這些特性必須在構建配置期間顯式地啓用。
+
+什麼是安全問題留給您自己判斷。在繼續之前，請考慮閱讀
+「Documentation/translations/zh_TW/admin-guide/security-bugs.rst」，
+因爲它提供了如何最恰當地處理安全問題的額外細節。
+
+當發生了完全無法接受的糟糕事情時，此問題就是一個「非常嚴重的問題」。例如，
+Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核突然顯示錯誤消息
+（「kernel panic」）並停止工作，或者根本沒有任何停止信息時，您也在處理一個嚴重
+的問題。注意：不要混淆「panic」（內核停止自身的致命錯誤）和「Oops」（可恢復錯誤），
+因爲顯示後者之後內核仍然在運行。
+
+
+確保環境健康
+--------------
+
+    *確保不是內核所處環境導致了你所面臨的問題。*
+
+看起來很像內核問題的問題有時是由構建或運行時環境引起的。很難完全排除這種問
+題，但你應該儘量減少這種問題：
+
+ * 構建內核時，請使用經過驗證的工具，因爲編譯器或二進位文件中的錯誤可能會導
+   致內核出現錯誤行爲。
+
+ * 確保您的計算機組件在其設計規範內運行；這對處理器、內存和主板尤爲重要。因
+   此，當面臨潛在的內核問題時，停止低電壓或超頻。
+
+ * 儘量確保不是硬體故障導致了你的問題。例如，內存損壞會導致大量的問題，這些
+   問題會表現爲看起來像內核問題。
+
+ * 如果你正在處理一個文件系統問題，你可能需要用 ``fsck`` 檢查一下文件系統，
+   因爲它可能會以某種方式被損壞，從而導致無法預期的內核行爲。
+
+ * 在處理回歸問題時，要確保沒有在更新內核的同時發生了其他變化。例如，這個問
+   題可能是由同時更新的其他軟體引起的。也有可能是在你第一次重啓進入新內核時，
+   某個硬體巧合地壞了。更新系統 BIOS 或改變 BIOS 設置中的某些內容也會導致
+   一些看起來很像內核回歸的問題。
+
+
+爲緊急情況做好準備
+-------------------
+
+    *創建一個全新的備份，並將系統修復和還原工具放在手邊*
+
+我得提醒您，您正在和計算機打交道，計算機有時會出現意想不到的事情，尤其是當
+您折騰其作業系統的內核等關鍵部件時。而這就是你在這個過程中要做的事情。因此，
+一定要創建一個全新的備份；還要確保你手頭有修復或重裝作業系統的所有工具，
+以及恢復備份所需的一切。
+
+
+確保你的內核不會被增強
+------------------------
+
+    *確保您的系統不會通過動態構建額外的內核模塊來增強其內核，像DKMS這樣的解
+    決方案可能在您不知情的情況下就在本地進行了這樣的工作。*
+
+如果內核以任何方式得到增強，那麼問題報告被忽略或拒絕的風險就會急劇增加。這就
+是爲什麼您應該刪除或禁用像akmods和DKMS這樣的機制：這些機制會自動構建額外內核
+模塊，例如當您安裝新的Linux內核或第一次引導它時。也要記得同時刪除他們可能安裝
+的任何模塊。然後重新啓動再繼續。
+
+注意，你可能不知道你的系統正在使用這些解決方案之一：當你安裝 Nvidia 專有圖
+形驅動程序、VirtualBox 或其他需要 Linux 內核以外的模塊支持的軟體時，它們通
+常會靜默設置。這就是爲什麼你可能需要卸載這些軟體的軟體包，以擺脫任何第三方
+內核模塊。
+
+
+檢測「汙染」標誌
+----------------
+
+    *當問題發生時，檢查您的內核是否被「汙染」，因爲使內核設置這個標誌的事件可
+    能會導致您面臨的問題。*
+
+當某些可能會導致看起來完全不相關的後續錯誤的事情發生時，內核會用「汙染
+（taint）」標誌標記自己。如果您的內核受到汙染，那麼您面臨的可能是這樣的錯誤。
+因此在投入更多時間到這個過程中之前，儘早排除此情況可能對你有好處。這是這個
+步驟出現在這裡的唯一原因，因爲這個過程稍後會告訴您安裝最新的主線內核；然後
+您將需要再次檢查汙染標誌，因爲當它出問題的時候內核報告會關注它。
+
+在正在運行的系統上檢查內核是否汙染非常容易：如果 ``cat /proc/sys/kernel/tainted``
+返回「0」，那麼內核沒有被汙染，一切正常。在某些情況下無法檢查該文件；這就是
+爲什麼當內核報告內部問題（「kernel bug」）、可恢復錯誤（「kernel Oops」）或停止
+操作前不可恢復的錯誤（「kernel panic」）時，它也會提到汙染狀態。當其中一個錯
+誤發生時，查看列印的錯誤消息的頂部，搜索以「CPU:」開頭的行。如果發現問題時內
+核未被汙染，那麼它應該以「Not infected」結束；如果你看到「Tainted:」且後跟一些
+空格和字母，那就被汙染了。
+
+如果你的內核被汙染了，請閱讀「Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst」
+以找出原因。設法消除汙染因素。通常是由以下三種因素之一引起的：
+
+ 1. 發生了一個可恢復的錯誤（「kernel Oops」），內核汙染了自己，因爲內核知道在
+    此之後它可能會出現奇怪的行爲錯亂。在這種情況下，檢查您的內核或系統日誌，
+    並尋找以下列文字開頭的部分::
+
+       Oops: 0000 [#1] SMP
+
+    如方括號中的「#1」所示，這是自啓動以來的第一次Oops。每個Oops和此後發生的
+    任何其他問題都可能是首個Oops的後續問題，即使這兩個問題看起來完全不相關。
+    通過消除首個Oops的原因並在之後復現該問題，可以排除這種情況。有時僅僅
+    重新啓動就足夠了，有時更改配置後重新啓動可以消除Oops。但是在這個流程中
+    不要花費太多時間在這一點上，因爲引起Oops的原因可能已經在您稍後將按流程
+    安裝的新Linux內核版本中修復了。
+
+ 2. 您的系統使用的軟體安裝了自己的內核模塊，例如Nvidia的專有圖形驅動程序或
+    VirtualBox。當內核從外部源（即使它們是開源的）加載此類模塊時，它會汙染
+    自己：它們有時會在不相關的內核區域導致錯誤，從而可能導致您面臨的問題。
+    因此，當您想要向Linux內核開發人員報告問題時，您必須阻止這些模塊加載。
+    大多數情況下最簡單的方法是：臨時卸載這些軟體，包括它們可能已經安裝的任
+    何模塊。之後重新啓動。
+
+ 3. 當內核加載駐留在Linux內核原始碼staging樹中的模塊時，它也會汙染自身。這
+    是一個特殊的區域，代碼（主要是驅動程序）還沒有達到正常Linux內核的質量
+    標準。當您報告此種模塊的問題時，內核受到汙染顯然是沒有問題的；只需確保
+    問題模塊是造成汙染的唯一原因。如果問題發生在一個不相關的區域，重新啓動
+    並通過指定 ``foo.blacklist=1`` 作爲內核參數臨時阻止該模塊被加載（用有
+    問題的模塊名替換「foo」）。
+
+
+記錄如何重現問題
+------------------
+
+    *粗略地寫下如何重現這個問題。如果您同時處理多個問題，請爲每個問題單獨寫
+    注釋，並確保它們在新啓動的系統上獨立出現。這是必要的，因爲每個問題都需
+    要分別報告給內核開發人員，除非它們嚴重糾纏在一起。*
+
+如果你同時處理多個問題，必須分別報告每個問題，因爲它們可能由不同的開發人員
+處理。在一份報告中描述多種問題，也會讓其他人難以將其分開。因此只有在問題嚴
+重糾纏的情況下，才能將問題合併在一份報告中。
+
+此外，在報告過程中，你必須測試該問題是否發生在其他內核版本上。因此，如果您
+知道如何在一個新啓動的系統上快速重現問題，將使您的工作更加輕鬆。
+
+注意：報告只發生過一次的問題往往是沒有結果的，因爲它們可能是由於宇宙輻射導
+致的位翻轉。所以你應該嘗試通過重現問題來排除這種情況，然後再繼續。如果你有
+足夠的經驗來區分由於硬體故障引起的一次性錯誤和難以重現的罕見內核問題，可以
+忽略這個建議。
+
+
+穩定版或長期支持內核的回歸？
+-----------------------------
+
+    *如果您正面臨穩定版或長期支持版本線的回歸（例如從5.10.4更新到5.10.5時出現
+    故障），請查看後文「報告穩定版和長期支持內核線的回歸」小節。*
+
+穩定版和長期支持內核版本線中的回歸是Linux開發人員非常希望解決的問題，這樣的
+問題甚至比主線開發分支中的回歸更不應出現，因爲它們會很快影響到很多人。開發人員
+希望儘快了解此類問題，因此有一個簡化流程來報告這些問題。注意，使用更新內核版
+本線的回歸（比如從5.9.15切換到5.10.5時出現故障）不符合條件。
+
+
+你需要將問題報告到何處
+------------------------
+
+    *定位可能引起問題的驅動程序或內核子系統。找出其開發人員期望的報告的方式
+    和位置。注意：大多數情況下不會是bugzilla.kernel.org，因爲問題通常需要通
+    過郵件發送給維護人員和公共郵件列表。*
+
+將報告發送給合適的人是至關重要的，因爲Linux內核是一個大項目，大多數開發人員
+只熟悉其中的一小部分。例如，相當多的程式設計師只關心一個驅動程序，比如一個WiFi
+晶片驅動程序；它的開發人員可能對疏遠的或不相關的「子系統」（如TCP堆棧、
+PCIe/PCI子系統、內存管理或文件系統）的內部知識了解很少或完全不了解。
+
+問題在於：Linux內核缺少一個，可以簡單地將問題歸檔並讓需要了解它的開發人員了
+解它的，中心化缺陷跟蹤器。這就是爲什麼你必須找到正確的途徑來自己報告問題。
+您可以在腳本的幫助下做到這一點（見下文），但它主要針對的是內核開發人員和專
+家。對於其他人來說，MAINTAINERS（維護人員）文件是更好的選擇。
+
+如何閱讀MAINTAINERS維護者文件
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+爲了說明如何使用 :ref:`MAINTAINERS <maintainers>` 文件，讓我們假設您的筆記
+本電腦中的WiFi在更新內核後突然出現了錯誤行爲。這種情況下可能是WiFi驅動的問
+題。顯然，它也可能由於驅動基於的某些代碼，但除非你懷疑有這樣的東西會附著在
+驅動程序上。如果真的是其他的問題，驅動程序的開發人員會讓合適的人參與進來。
+
+遺憾的是，沒有通用且簡單的辦法來檢查哪個代碼驅動了特定硬體組件。
+
+在WiFi驅動出現問題的情況下，你可能想查看 ``lspci -k`` 的輸出，因爲它列出了
+PCI/PCIe總線上的設備和驅動它的內核模塊::
+
+       [user@something ~]$ lspci -k
+       [...]
+       3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
+         Subsystem: Bigfoot Networks, Inc. Device 1535
+         Kernel driver in use: ath10k_pci
+         Kernel modules: ath10k_pci
+       [...]
+
+但如果你的WiFi晶片通過USB或其他內部總線連接，這種方法就行不通了。在這種情況
+下，您可能需要檢查您的WiFi管理器或 ``ip link`` 的輸出。尋找有問題的網絡接口
+的名稱，它可能類似於「wlp58s0」。此名稱可以用來找到驅動它的模塊::
+
+       [user@something ~]$ realpath --relative-to=/sys/module//sys/class/net/wlp58s0/device/driver/module
+       ath10k_pci
+
+如果這些技巧不能進一步幫助您，請嘗試在網上搜索如何縮小相關驅動程序或子系統
+的範圍。如果你不確定是哪一個：試著猜一下，即使你猜得不好，也會有人會幫助你
+的。
+
+一旦您知道了相應的驅動程序或子系統，您就希望在MAINTAINERS文件中搜索它。如果
+是「ath10k_pci」，您不會找到任何東西，因爲名稱太具體了。有時你需要在網上尋找
+幫助；但在此之前，請嘗試使用一個稍短或修改過的名稱來搜索MAINTAINERS文件，因
+爲這樣你可能會發現類似這樣的東西::
+
+       QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
+       Mail:          A. Some Human <shuman@example.com>
+       Mailing list:  ath10k@lists.infradead.org
+       Status:        Supported
+       Web-page:      https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
+       SCM:           git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+       Files:         drivers/net/wireless/ath/ath10k/
+
+注意：如果您閱讀在Linux原始碼樹的根目錄中找到的原始維護者文件，則行描述將是
+縮寫。例如，「Mail:（郵件）」將是「M:」，「Mailing list:（郵件列表）」將是「L」，
+「Status:（狀態）」將是「S:」。此文件頂部有一段解釋了這些和其他縮寫。
+
+首先查看「Status」狀態行。理想情況下，它應該得到「Supported（支持）」或
+「Maintained（維護）」。如果狀態爲「Obsolete（過時的）」，那麼你在使用一些過時的
+方法，需要轉換到新的解決方案上。有時候，只有在感到有動力時，才會有人爲代碼
+提供「Odd Fixes」。如果碰見「Orphan」，你就完全不走運了，因爲再也沒有人關心代碼
+了，只剩下這些選項:準備好與問題共存，自己修復它，或者找一個願意修復它的程式設計師。
+
+檢查狀態後，尋找以「bug:」開頭的一行：它將告訴你在哪裡可以找到子系統特定的缺
+陷跟蹤器來提交你的問題。上面的例子沒有此行。大多數部分都是這樣，因爲 Linux
+內核的開發完全是由郵件驅動的。很少有子系統使用缺陷跟蹤器，且其中只有一部分
+依賴於 bugzilla.kernel.org。
+
+在這種以及其他很多情況下，你必須尋找以「Mail:」開頭的行。這些行提到了特定代碼
+的維護者的名字和電子郵件地址。也可以查找以「Mailing list:」開頭的行，它告訴你
+開發代碼的公共郵件列表。你的報告之後需要通過郵件發到這些地址。另外，對於所有
+通過電子郵件發送的問題報告，一定要抄送 Linux Kernel Mailing List（LKML）
+<linux-kernel@vger.kernel.org>。在以後通過郵件發送問題報告時，不要遺漏任何
+一個郵件列表!維護者都是大忙人，可能會把一些工作留給子系統特定列表上的其他開
+發者；而 LKML 很重要，因爲需要一個可以找到所有問題報告的地方。
+
+
+藉助腳本找到維護者
+~~~~~~~~~~~~~~~~~~~~
+
+對於手頭有Linux源碼的人來說，有第二個可以找到合適的報告地點的選擇：腳本
+「scripts/get_maintainer.pl」，它嘗試找到所有要聯繫的人。它會查詢MAINTAINERS
+文件，並需要用相關原始碼的路徑來調用。對於編譯成模塊的驅動程序，經常可以用
+這樣的命令找到::
+
+       $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
+       drivers/net/wireless/ath/ath10k/ath10k_pci.ko
+
+將其中的部分內容傳遞給腳本::
+
+       $ ./scripts/get_maintainer.pl -f drivers/net/wireless/ath/ath10k*
+       Some Human <shuman@example.com> (supporter:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+       Another S. Human <asomehuman@example.com> (maintainer:NETWORKING DRIVERS)
+       ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+       linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
+       netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
+       linux-kernel@vger.kernel.org (open list)
+
+不要把你的報告發給所有的人。發送給維護者，腳本稱之爲「supporter:」；另外抄送
+代碼最相關的郵件列表，以及 Linux 內核郵件列表（LKML）。在此例中，你需要將報
+告發送給 「Some Human <shuman@example.com>」 ，並抄送
+「ath10k@lists.infradead.org」和「linux-kernel@vger.kernel.org」。
+
+注意：如果你用 git 克隆了 Linux 原始碼，你可能需要用--git 再次調用
+get_maintainer.pl。腳本會查看提交歷史，以找到最近哪些人參與了相關代碼的編寫，
+因爲他們可能會提供幫助。但要小心使用這些結果，因爲它很容易讓你誤入歧途。
+例如，這種情況常常會發生在很少被修改的地方（比如老舊的或未維護的驅動程序）：
+有時這樣的代碼會在樹級清理期間被根本不關心此驅動程序的開發者修改。
+
+
+搜索現有報告（第二部分）
+--------------------------
+
+    *在缺陷追蹤器或問題相關郵件列表的存檔中徹底搜索可能與您的問題匹配的報告。
+    如果找到匹配的報告，請加入討論而不是發送新報告。*
+
+如前所述：報告一個別人已經提出的問題，對每個人來說都是浪費時間，尤其是作爲報告
+人的你。這就是爲什麼你應該再次搜索現有的報告。現在你已經知道問題需要報告到哪裡。
+如果是郵件列表，那麼一般在 `lore.kernel.org <https://lore.kernel.org/>`_ 可以
+找到相應存檔。
+
+但有些列表運行在其他地方。例如前面步驟中當例子的ath10k WiFi驅動程序就是這種
+情況。但是你通常可以在網上很容易地找到這些列表的檔案。例如搜索「archive
+ath10k@lists.infradead.org」，將引導您到ath10k郵件列表的信息頁，該頁面頂部連結
+到其 `列表存檔 <https://lists.infradead.org/pipermail/ath10k/>`_ 。遺憾的是，
+這個列表和其他一些列表缺乏搜索其存檔的功能。在這種情況下可以使用常規的網際網路
+搜尋引擎，並添加類似「site:lists.infadead.org/pipermail/ath10k/」這
+樣的搜索條件，這會把結果限制在該連結中的檔案。
+
+也請進一步搜索網絡、LKML和bugzilla.kernel.org網站。
+
+有關如何搜索以及在找到匹配報告時如何操作的詳細信息，請參閱上面的「搜索現有報告
+（第一部分）」。
+
+不要急著完成報告過程的這一步：花30到60分鐘甚至更多的時間可以爲你和其他人節省 /
+減少相當多的時間和麻煩。
+
+
+安裝一個新的內核進行測試
+--------------------------
+
+    *除非您已經在運行最新的「主線」Linux內核，否則最好在報告流程前安裝它。在
+    某些情況下，使用最新的「穩定版」Linux進行測試和報告也是可以接受的替代方案；
+    在合併窗口期間，這實際上可能是最好的方法，但在開發階段最好還是暫停幾天。
+    無論你選擇什麼版本，最好使用「普通」構建。忽略這些建議會大大增加您的報告
+    被拒絕或忽略的風險。*
+
+正如第一步的詳細解釋中所提到的：與大多數程式設計師一樣，與大多數程式設計師一樣，Linux
+內核開發人員不喜歡花時間處理他們維護的原始碼中根本不會發生的問題的報告。這隻
+會浪費每個人的時間，尤其是你的時間。這就是爲什麼在報告問題之前，您必須先確認
+問題仍然存在於最新的上游代碼中，這符合每個人的利益。您可以忽略此建議，但如前
+所述：這樣做會極大地增加問題報告被拒絕或被忽略的風險。
+
+內核「最新上游」的範圍通常指：
+
+ * 安裝一個主線內核；最新的穩定版內核也可以是一個選擇，但大多數時候都最好避免。
+   長期支持內核（有時稱爲「LTS內核」）不適合此流程。下一小節將更詳細地解釋所有
+   這些。
+
+ * 下一小節描述獲取和安裝這樣一個內核的方法。它還指出了使用預編譯內核是可以的，
+   但普通的內核更好，這意味著：它是直接使用從 `kernel.org <https://kernel.org/>`_
+   獲得的Linux原始碼構建並且沒有任何方式修改或增強。
+
+
+選擇適合測試的版本
+~~~~~~~~~~~~~~~~~~~~
+
+前往 `kernel.org <https://kernel.org/>`_ 來決定使用哪個版本。忽略那個寫著
+「Latest release最新版本」的巨大黃色按鈕，往下看有一個表格。在表格的頂部，你會
+看到一行以「mainline」開頭的字樣，大多數情況下它會指向一個版本號類似「5.8-rc2」
+的預發布版本。如果是這樣的話，你將需要使用這個主線內核進行測試。不要讓「rc」
+嚇到你，這些「開發版內核」實際上非常可靠——而且你已經按照上面的指示做了備份，
+不是嗎？
+
+大概每九到十周，「mainline」可能會給你指出一個版本號類似「5.7」的正式版本。如果
+碰見這種情況，請考慮暫停報告過程，直到下一個版本的第一個預發布（5.8-rc1）出
+現在 `kernel.org <https://kernel.org/>`_ 上。這是因爲 Linux 的開發周期正在
+兩周的「合併窗口」內。大部分的改動和所有干擾性的改動都會在這段時間內被合併到
+下一個版本中。在此期間使用主線是比較危險的。內核開發者通常也很忙，可能沒有
+多餘的時間來處理問題報告。這也是很有可能在合併窗口中應用了許多修改來修復你
+所面臨的問題；這就是爲什麼你很快就得用一個新的內核版本重新測試，就像下面「發
+布報告後的責任」一節中所述的那樣。
+
+這就是爲什麼要等到合併窗口結束後才去做。但是如果你處理的是一些不應該等待的
+東西，則無需這樣做。在這種情況下，可以考慮通過 git 獲取最新的主線內核（見下
+文），或者使用 kernel.org 上提供的最新穩定版本。如果 mainline 因爲某些原因
+不無法正常工作，那麼使用它也是可以接受的。總的來說：用它來重現問題也比完全
+不報告問題要好。
+
+最好避免在合併窗口外使用最新的穩定版內核，因爲所有修復都必須首先應用於主線。
+這就是爲什麼檢查最新的主線內核是如此重要：你希望看到在舊版本線修復的任何問題
+需要先在主線修復，然後才能得到回傳，這可能需要幾天或幾周。另一個原因是：您
+希望的修復對於回傳來說可能太難或太冒險；因此再次報告問題不太可能改變任何事情。
+
+這些方面也部分表明了爲什麼長期支持內核（有時稱爲「LTS內核」）不適合報告流程：
+它們與當前代碼的距離太遠。因此，先去測試主線，然後再按流程走：如果主線沒有
+出現問題，流程將指導您如何在舊版本線中修復它。
+
+如何獲得新的 Linux 內核
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+你可以使用預編譯或自編譯的內核進行測試；如果你選擇後者，可以使用 git 獲取源
+代碼，或者下載其 tar 存檔包。
+
+**使用預編譯的內核** ：這往往是最快速、最簡單、最安全的方法——尤其是在你不熟
+悉 Linux 內核的情況下。問題是：發行商或附加存儲庫提供的大多數版本都是從修改
+過的Linux原始碼構建的。因此它們不是普通的，通常不適合於測試和問題報告：這些
+更改可能會導致您面臨的問題或以某種方式影響問題。
+
+但是如果您使用的是流行的Linux發行版，那麼您就很幸運了：對於大部分的發行版，
+您可以在網上找到包含最新主線或穩定版本Linux內核包的存儲庫。使用這些是完全可
+以的，只要從存儲庫的描述中確認它們是普通的或者至少接近普通。此外，請確保軟體
+包包含kernel.org上提供的最新版本內核。如果這些軟體包的時間超過一周，那麼它們
+可能就不合適了，因爲新的主線和穩定版內核通常至少每周發布一次。
+
+請注意，您以後可能需要手動構建自己的內核：有時這是調試或測試修復程序所必需的，
+如後文所述。還要注意，預編譯的內核可能缺少在出現panic、Oops、warning或BUG時
+解碼內核列印的消息所需的調試符號；如果您計劃解碼這些消息，最好自己編譯內核
+（有關詳細信息，請參閱本小節結尾和「解碼失敗信息」小節）。
+
+**使用git** ：熟悉 git 的開發者和有經驗的 Linux 用戶通常最好直接從
+`kernel.org 上的官方開發倉庫
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
+中獲取最新的 Linux 內核原始碼。這些很可能比最新的主線預發布版本更新一些。不
+用擔心：它們和正式的預發布版本一樣可靠，除非內核的開發周期目前正處於合併窗
+口中。不過即便如此，它們也是相當可靠的。
+
+**常規方法** ：不熟悉 git 的人通常最好從 `kernel.org <https://kernel.org/>`_
+下載源碼的tar 存檔包。
+
+如何實際構建一個內核並不在這裡描述，因爲許多網站已經解釋了必要的步驟。如果
+你是新手，可以考慮按照那些建議使用 ``make localmodconfig`` 來做，它將嘗試獲
+取你當前內核的配置，然後根據你的系統進行一些調整。這樣做並不能使編譯出來的
+內核更好，但可以更快地編譯。
+
+注意：如果您正在處理來自內核的pannc、Oops、warning或BUG，請在配置內核時嘗試
+啓用 CONFIG_KALLSYMS 選項。此外，還可以啓用 CONFIG_DEBUG_KERNEL 和
+CONFIG_DEBUG_INFO；後者是相關選項，但只有啓用前者才能開啓。請注意，
+CONFIG_DEBUG_INFO 會需要更多儲存空間來構建內核。但這是值得的，因爲這些選項將
+允許您稍後精確定位觸發問題的確切代碼行。下面的「解碼失敗信息」一節對此進行了更
+詳細的解釋。
+
+但請記住：始終記錄遇到的問題，以防難以重現。發送未解碼的報告總比不報告要好。
+
+
+檢查「汙染」標誌
+----------------
+
+    *確保您剛剛安裝的內核在運行時不會「汙染」自己。*
+
+正如上面已經詳細介紹過的：當發生一些可能會導致一些看起來完全不相關的後續錯
+誤的事情時，內核會設置一個「汙染」標誌。這就是爲什麼你需要檢查你剛剛安裝的內
+核是否有設置此標誌。如果有的話，幾乎在任何情況下你都需要在報告問題之前先消
+除它。詳細的操作方法請看上面的章節。
+
+
+用新內核重現問題
+------------------
+
+    *在您剛剛安裝的內核中復現這個問題。如果它沒有出現，請查看下方只發生在
+    穩定版和長期支持內核的問題的說明。*
+
+檢查這個問題是否發生在你剛剛安裝的新 Linux 內核版本上。如果新內核已經修復了，
+可以考慮使用此版本線，放棄報告問題。但是請記住，只要它沒有在 `kernel.org
+<https://kernel.org/>`_ 的穩定版和長期版（以及由這些版本衍生出來的廠商內核）
+中得到修復，其他用戶可能仍然會受到它的困擾。如果你喜歡使用其中的一個，或
+者只是想幫助它們的用戶，請前往下面的「報告只發生在較舊內核版本線的問題」一節。
+
+
+優化復現問題的描述
+--------------------
+
+    *優化你的筆記：試著找到並寫出最直接的復現問題的方法。確保最終結果包含所
+    有重要的細節，同時讓第一次聽說的人容易閱讀和理解。如果您在此過程中學到
+    了一些東西，請考慮再次搜索關於該問題的現有報告。*
+
+過於複雜的報告會讓別人很難理解。因此請儘量找到一個可以直接描述、易於以書面
+形式理解的再現方法。包含所有重要的細節，但同時也要儘量保持簡短。
+
+在這在前面的步驟中，你很可能已經了解了一些關於你所面臨的問題的點。利用這些
+知識，再次搜索可以轉而加入的現有報告。
+
+
+解碼失敗信息
+-------------
+
+    *如果失敗涉及「panic」、「Oops」、「warning」或「BUG」，請考慮解碼內核日誌以查找
+    觸發錯誤的代碼行。*
+
+當內核檢測到內部問題時，它會記錄一些有關已執行代碼的信息。這使得在原始碼中精
+確定位觸發問題的行並顯示如何調用它成爲可能。但只有在配置內核時啓用了
+CONFIG_DEBUG_INFO 和 CONFIG_KALLSYMS選項時，這種方法才起效。如果已啓用此選項，
+請考慮解碼內核日誌中的信息。這將使我們更容易理解是什麼導致了「panic」、「Oops」、
+「warning」或「BUG」，從而增加了有人提供修復的機率。
+
+解碼可以通過Linux原始碼樹中的腳本來完成。如果您運行的內核是之前自己編譯的，
+這樣這樣調用它::
+
+	[user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
+	/usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/kernels/5.10.10-4.1.x86_64/
+
+如果您運行的是打包好的普通內核，則可能需要安裝帶有調試符號的相應包。然後按以下
+方式調用腳本（如果發行版未打包，則可能需要從Linux原始碼獲取）::
+
+	[user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh \
+	/usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/kernels/5.10.10-4.1.x86_64/
+
+腳本將解碼如下的日誌行，這些日誌行顯示內核在發生錯誤時正在執行的代碼的地址::
+
+	[   68.387301] RIP: 0010:test_module_init+0x5/0xffa [test_module]
+
+解碼之後，這些行將變成這樣::
+
+	[   68.387301] RIP: 0010:test_module_init (/home/username/linux-5.10.5/test-module/test-module.c:16) test_module
+
+在本例中，執行的代碼是從文件「~/linux-5.10.5/test-module/test-module.c」構建的，
+錯誤出現在第16行的指令中。
+
+該腳本也會如此解碼以「Call trace」開頭的部分中提到的地址，該部分顯示出現問題的
+函數的路徑。此外，腳本還會顯示內核正在執行的代碼部分的彙編輸出。
+
+注意，如果你沒法做到這一點，只需跳過這一步，並在報告中說明原因。如果你幸運的
+話，可能無需解碼。如果需要的話，也許有人會幫你做這件事情。還要注意，這只是解
+碼內核堆棧跟蹤的幾種方法之一。有時需要採取不同的步驟來檢索相關的詳細信息。
+別擔心，如果您碰到的情況需要這樣做，開發人員會告訴您該怎麼做。
+
+
+對回歸的特別關照
+-----------------
+
+    *如果您的問題是回歸問題，請儘可能縮小引入問題時的範圍。*
+
+Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這就是爲什麼他
+認爲回歸是不可接受的，並希望看到它們被迅速修復。這就是爲什麼引入了回歸的改
+動導致的問題若無法通過其他方式快速解決，通常會被迅速撤銷。因此，報告回歸有
+點像「王炸」，會迅速得到修復。但要做到這一點，需要知道導致回歸的變化。通常情
+況下，要由報告者來追查罪魁禍首，因爲維護者往往沒有時間或手頭設置不便來自行
+重現它。
+
+有一個叫做「二分」的過程可以來尋找變化，這在
+「Documentation/translations/zh_TW/admin-guide/bug-bisect.rst」文檔中進行了詳細
+的描述，這個過程通常需要你構建十到二十個內核鏡像，每次都嘗試在構建下一個鏡像
+之前重現問題。是的，這需要花費一些時間，但不用擔心，它比大多數人想像的要快得多。
+多虧了「binary search二進位搜索」，這將引導你在原始碼管理系統中找到導致回歸的提交。
+一旦你找到它，就在網上搜索其主題、提交ID和縮短的提交ID（提交ID的前12個字符）。
+如果有的話，這將引導您找到關於它的現有報告。
+
+需要注意的是，二分法需要一點竅門，不是每個人都懂得訣竅，也需要相當多的努力，
+不是每個人都願意投入。儘管如此，還是強烈建議自己進行一次二分。如果你真的
+不能或者不想走這條路，至少要找出是哪個主線內核引入的回歸。比如說從 5.5.15
+切換到 5.8.4 的時候出現了一些問題，那麼至少可以嘗試一下相近的所有的主線版本
+（5.6、5.7 和 5.8）來檢查它是什麼時候出現的。除非你想在一個穩定版或長期支持
+內核中找到一個回歸，否則要避免測試那些編號有三段的版本（5.6.12、5.7.8），因
+爲那會使結果難以解釋，可能會讓你的測試變得無用。一旦你找到了引入回歸的主要
+版本，就可以放心地繼續報告了。但請記住：在不知道罪魁禍首的情況下，開發人員
+是否能夠提供幫助取決於手頭的問題。有時他們可能會從報告中確認是什麼出現了問
+題，並能修復它；有時他們可能無法提供幫助，除非你進行二分。
+
+當處理回歸問題時，請確保你所面臨的問題真的是由內核引起的，而不是由其他東西
+引起的，如上文所述。
+
+在整個過程中，請記住：只有當舊內核和新內核的配置相似時，問題才算回歸。最好
+的方法是：把配置文件（``.config``）從舊的工作內核直接複製到你嘗試的每個新內
+核版本。之後運行 ``make oldnoconfig`` 來調整它以適應新版本的需要，而不啓用
+任何新的功能，因爲那些功能也可能導致回歸。
+
+
+撰寫並發送報告
+---------------
+
+    *通過詳細描述問題來開始編寫報告。記得包括以下條目：您爲復現而安裝的最新
+    內核版本、使用的Linux發行版以及關於如何復現該問題的說明。如果可能，將內
+    核構建配置（.config）和 ``dmesg`` 的輸出放在網上的某個地方，並連結到它。
+    包含或上傳所有其他可能相關的信息，如Oops的輸出/截圖或來自 ``lspci``
+    的輸出。一旦你寫完了這個主要部分，請在上方插入一個正常長度的段落快速概
+    述問題和影響。再在此之上添加一個簡單描述問題的句子，以得到人們的閱讀。
+    現在給出一個更短的描述性標題或主題。然後就可以像MAINTAINERS文件告訴你的
+    那樣發送或提交報告了，除非你在處理一個「高優先級問題」：它們需要按照下面
+    「高優先級問題的特殊處理」所述特別關照。*
+
+現在你已經準備好了一切，是時候寫你的報告了。上文前言中連結的三篇文檔對如何
+寫報告做了部分解釋。這就是爲什麼本文將只提到一些基本的內容以及 Linux 內核特
+有的東西。
+
+有一點是符合這兩類的：你的報告中最關鍵的部分是標題/主題、第一句話和第一段。
+開發者經常會收到許多郵件。因此，他們往往只是花幾秒鐘的時間瀏覽一下郵件，然
+後再決定繼續下一封或仔細查看。因此，你報告的開頭越好，有人研究並幫助你的機
+會就越大。這就是爲什麼你應該暫時忽略他們，先寫出詳細的報告。;-)
+
+每份報告都應提及的事項
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+詳細描述你的問題是如何發生在你安裝的新純淨內核上的。試著包含你之前寫的和優
+化過的分步說明，概述你和其他人如何重現這個問題；在極少數無法重現的情況下，
+儘量描述你做了什麼來觸發它。
+
+還應包括其他人爲了解該問題及其環境而可能需要的所有相關信息。實際需要的東西
+在很大程度上取決於具體問題，但有些事項你總是應該包括在內：
+
+ * ``cat /proc/version`` 的輸出，其中包含 Linux 內核版本號和構建時的編譯器。
+
+ * 機器正在運行的 Linux 發行版（ ``hostnamectl | grep 「Operating System「`` ）
+
+ * CPU 和作業系統的架構（ ``uname -mi`` ）
+
+ * 如果您正在處理回歸，並進行了二分，請提及導致回歸的變更的主題和提交ID。
+
+許多情況下，讓讀你報告的人多了解兩件事也是明智之舉：
+
+ * 用於構建 Linux 內核的配置（「.config」文件）
+
+ * 內核的信息，你從 ``dmesg`` 得到的信息寫到一個文件里。確保它以像「Linux
+   version 5.8-1 (foobar@example.com) (gcc (GCC) 10.2.1, GNU ld version
+   2.34) #1 SMP Mon Aug 3 14:54:37 UTC 2020」這樣的行開始，如果沒有，那麼第
+   一次啓動階段的重要信息已經被丟棄了。在這種情況下，可以考慮使用
+   ``journalctl -b 0 -k`` ；或者你也可以重啓，重現這個問題，然後調用
+   ``dmesg`` 。
+
+這兩個文件很大，所以直接把它們放到你的報告中是個壞主意。如果你是在缺陷跟蹤
+器中提交問題，那麼將它們附加到工單中。如果你通過郵件報告問題，不要用附件附
+上它們，因爲那會使郵件變得太大，可以按下列之一做：
+
+ * 將文件上傳到某個公開的地方（你的網站，公共文件粘貼服務，在
+   `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ 上創建的工單……），
+   並在你的報告中放上連結。理想情況下請使用允許這些文件保存很多年的地方，因
+   爲它們可能在很多年後對別人有用；例如 5 年或 10 年後，一個開發者正在修改
+   一些代碼，而這些代碼正是爲了修復你的問題。
+
+ * 把文件放在一邊，然後說明你會在他人回復時再單獨發送。只要記得報告發出去後，
+   真正做到這一點就可以了。;-)
+
+提供這些東西可能是明智的
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+根據問題的不同，你可能需要提供更多的背景數據。這裡有一些關於提供什麼比較好
+的建議：
+
+ * 如果你處理的是內核的「warning」、「OOPS」或「panic」，請包含它。如果你不能複製
+   粘貼它，試著用netconsole網絡終端遠程跟蹤或者至少拍一張屏幕的照片。
+
+ * 如果問題可能與你的電腦硬體有關，請說明你使用的是什麼系統。例如，如果你的
+   顯卡有問題，請提及它的製造商，顯卡的型號，以及使用的晶片。如果是筆記本電
+   腦，請提及它的型號名稱，但儘量確保意義明確。例如「戴爾 XPS 13」就不很明確，
+   因爲它可能是 2012 年的那款，那款除了看起來和現在銷售的沒有什麼不同之外，
+   兩者沒有任何共同之處。因此，在這種情況下，要加上準確的型號，例如 2019
+   年內推出的 XPS 13 型號爲「9380」或「7390」。像「聯想 Thinkpad T590」這樣的名字
+   也有些含糊不清：這款筆記本有帶獨立顯卡和不帶的子型號，所以要儘量找到準確
+   的型號名稱或註明主要部件。
+
+ * 說明正在使用的相關軟體。如果你在加載模塊時遇到了問題，你要說明正在使用的
+   kmod、systemd 和 udev 的版本。如果其中一個 DRM 驅動出現問題，你要說明
+   libdrm 和 Mesa 的版本；還要說明你的 Wayland 合成器或 X-Server 及其驅動。
+   如果你有文件系統問題，請註明相應的文件系統實用程序的版本（e2fsprogs,
+   btrfs-progs, xfsprogs……）。
+
+ * 從內核中收集可能有用的額外信息。例如， ``lspci -nn`` 的輸出可以幫助別人
+   識別你使用的硬體。如果你的硬體有問題，你甚至可以給出 ``sudo lspci -vvv``
+   的結果，因爲它提供了組件是如何配置的信息。對於一些問題，可能最好包含
+   ``/proc/cpuinfo`` ， ``/proc/ioports`` ， ``/proc/iomem`` ，
+   ``/proc/modules`` 或 ``/proc/scsi/scsi`` 等文件的內容。一些子系統還提
+   供了收集相關信息的工具。 ``alsa-info.sh`` `就是這樣一個工具，它是音頻/聲
+   音子系統開發者提供的  <https://www.alsa-project.org/wiki/AlsaInfo>`_ 。
+
+這些例子應該會給你一些知識點，讓你知道附上什麼數據可能是明智的，但你自己也
+要想一想，哪些數據對別人會有幫助。不要太擔心忘記一些東西，因爲開發人員會要
+求提供他們需要的額外細節。但從一開始就把所有重要的東西都提供出來，會增加別
+人仔細查看的機會。
+
+
+重要部分：報告的開頭
+~~~~~~~~~~~~~~~~~~~~~~
+
+現在你已經準備好了報告的詳細部分，讓我們進入最重要的部分：開頭幾句。現在到
+報告的最前面，在你剛才寫的部分之前加上類似「The detailed description:」（詳細
+描述）這樣的內容，並在最前面插入兩個新行。現在寫一個正常長度的段落，大致概
+述這個問題。去掉所有枯燥的細節，把重點放在讀者需要知道的關鍵部分，以讓人了
+解這是怎麼回事；如果你認爲這個缺陷影響了很多用戶，就提一下這點來吸引大家關
+注。
+
+做好這一點後，在頂部再插入兩行，寫一句話的摘要，快速解釋報告的內容。之後你
+要更加抽象，爲報告寫一個更短的主題/標題。
+
+現在你已經寫好了這部分，請花點時間來優化它，因爲它是你的報告中最重要的部分：
+很多人會先讀這部分，然後才會決定是否值得花時間閱讀其他部分。
+
+現在就像 :ref:`MAINTAINERS <maintainers>` 維護者文件告訴你的那樣發送或提交
+報告，除非它是前面概述的那些「高優先級問題」之一：在這種情況下，請先閱讀下一
+小節，然後再發送報告。
+
+高優先級問題的特殊處理
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+高優先級問題的報告需要特殊處理。
+
+**非常嚴重的缺陷** ：確保在主題或工單標題以及第一段中明顯標出 severeness
+（非常嚴重的）。
+
+**回歸** ：如果問題是一個回歸，請在郵件的主題或缺陷跟蹤器的標題中添加
+[REGRESSION]。如果您沒有進行二分，請至少註明您測試的最新主線版本（比如 5.7）
+和出現問題的最新版本（比如 5.8）。如果您成功地進行了二分，請註明導致回歸
+的提交ID和主題。也請添加該變更的作者到你的報告中；如果您需要將您的缺陷提交
+到缺陷跟蹤器中，請將報告以私人郵件的形式轉發給他，並註明報告提交地點。
+
+**安全問題** ：對於這種問題，你將必須評估：如果細節被公開披露，是否會對其他
+用戶產生短期風險。如果不會，只需按照所述繼續報告問題。如果有此風險，你需要
+稍微調整一下報告流程。
+
+ * 如果 MAINTAINERS 文件指示您通過郵件報告問題，請不要抄送任何公共郵件列表。
+
+ * 如果你應該在缺陷跟蹤器中提交問題，請確保將工單標記爲「私有」或「安全問題」。
+   如果缺陷跟蹤器沒有提供保持報告私密性的方法，那就別想了，把你的報告以私人
+   郵件的形式發送給維護者吧。
+
+在這兩種情況下，都一定要將報告發到 MAINTAINERS 文件中「安全聯絡」部分列出的
+地址。理想的情況是在發送報告的時候直接抄送他們。如果您在缺陷跟蹤器中提交了
+報告，請將報告的文本轉發到這些地址；但請在報告的頂部加上注釋，表明您提交了
+報告，並附上工單連結。
+
+更多信息請參見「Documentation/translations/zh_TW/admin-guide/security-bugs.rst」。
+
+
+發布報告後的責任
+------------------
+
+    *等待別人的反應，繼續推進事情，直到你能夠接受這樣或那樣的結果。因此，請
+    公開和及時地回應任何詢問。測試提出的修復。積極地測試：至少重新測試每個
+    新主線版本的首個候選版本（RC），並報告你的結果。如果出現拖延，就友好地
+    提醒一下。如果你沒有得到任何幫助或者未能滿意，請試著自己幫助自己。*
+
+如果你的報告非常優秀，而且你真的很幸運，那麼某個開發者可能會立即發現導致問
+題的原因；然後他們可能會寫一個補丁來修復、測試它，並直接發送給主線集成，同
+時標記它以便以後回溯到需要它的穩定版和長期支持內核。那麼你需要做的就是回復
+一句「Thank you very much」（非常感謝），然後在發布後換上修復好的版本。
+
+但這種理想狀況很少發生。這就是爲什麼你把報告拿出來之後工作才開始。你要做的
+事情要視情況而定，但通常會是下面列出的事情。但在深入研究細節之前，這裡有幾
+件重要的事情，你需要記住這部分的過程。
+
+
+關於進一步互動的一般建議
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**總是公開回復** ：當你在缺陷跟蹤器中提交問題時，一定要在那裡回復，不要私下
+聯繫任何開發者。對於郵件報告，在回復您收到的任何郵件時，總是使用「全部回復」
+功能。這包括帶有任何你可能想要添加到你的報告中的額外數據的郵件：進入郵件應
+用程序「已發送」文件夾，並在郵件上使用「全部回復」來回復報告。這種方法可以確保
+公共郵件列表和其他所有參與者都能及時了解情況；它還能保持郵件線程的完整性，
+這對於郵件列表將所有相關郵件歸爲一類是非常重要的。
+
+只有兩種情況不適合在缺陷跟蹤器或「全部回復」中發表評論：
+
+ * 有人讓你私下發東西。
+
+ * 你被告知要發送一些東西，但注意到其中包含需要保密的敏感信息。在這種情況下，
+   可以私下發送給要求發送的開發者。但要在工單或郵件中註明你是這麼做的，這
+   樣其他人就知道你尊重了這個要求。
+
+**在請求解釋或幫助之前先研究一下** ：在這部分過程中，有人可能會告訴你用尚未
+掌握的技能做一些事情。例如你可能會被要求使用一些你從未聽說過的測試工具；或
+者你可能會被要求在 Linux 內核原始碼上應用一個補丁來測試它是否有幫助。在某些
+情況下，發個回復詢問如何做就可以了。但在走這條路之前，儘量通過在網際網路上搜
+索自行找到答案；或者考慮在其他地方詢問建議。比如詢問朋友，或者到你平時常去
+的聊天室或論壇發帖諮詢。
+
+**要有耐心** ：如果你真的很幸運，你可能會在幾個小時內收到對你的報告的答覆。
+但大多數情況下會花費更多的時間，因爲維護者分散在全球各地，因此可能在不同的
+時區——在那裡他們已經享受著遠離鍵盤的夜晚。
+
+一般來說，內核開發者需要一到五個工作日來回復報告。有時會花費更長的時間，因
+爲他們可能正忙於合併窗口、其他工作、參加開發者會議，或者只是在享受一個漫長
+的暑假。
+
+「高優先級的問題」（見上面的解釋）例外：維護者應該儘快解決這些問題；這就是爲
+什麼你應該最多等待一個星期（如果是緊急的事情，則只需兩天），然後再發送友好
+的提醒。
+
+有時維護者可能沒有及時回復；有時候可能會出現分歧，例如一個問題是否符合回歸
+的條件。在這種情況下，在郵件列表上提出你的顧慮，並請求其他人公開或私下回復
+如何繼續推進。如果失敗了，可能應該讓更高級別的維護者介入。如果是 WiFi 驅動，
+那就是無線維護者；如果沒有更高級別的維護者，或者其他一切努力都失敗了，那
+這可能是一種罕見的、可以讓 Linus Torvalds 參與進來的情況。
+
+**主動測試** ：每當一個新的主線內核版本的第一個預發布版本（rc1）發布的時候，
+去檢查一下這個問題是否得到了解決，或者是否有什麼重要的變化。在工單中或在
+回復報告的郵件中提及結果（確保所有參與討論的人都被抄送）。這將表明你的承諾
+和你願意幫忙。如果問題持續存在，它也會提醒開發者確保他們不會忘記它。其他一
+些不定期的重新測試（例如用rc3、rc5 和最終版本）也是一個好主意，但只有在相關
+的東西發生變化或者你正在寫什麼東西的時候才報告你的結果。
+
+這些些常規的事情就不說了，我們來談談報告後如何幫助解決問題的細節。
+
+查詢和測試請求
+~~~~~~~~~~~~~~~
+
+如果你的報告得到了回復則需履行以下責任：
+
+**檢查與你打交道的人** ：大多數情況下，會是維護者或特定代碼區域的開發人員對
+你的報告做出回應。但由於問題通常是公開報告的，所以回復的可能是任何人——包括
+那些想要幫忙的人，但最後可能會用他們的問題或請求引導你完全偏離軌道。這很少
+發生，但這是快速上網搜搜看你正在與誰互動是明智之舉的許多原因之一。通過這樣
+做，你也可以知道你的報告是否被正確的人聽到，因爲如果討論沒有導致滿意的問題
+解決方案而淡出，之後可能需要提醒維護者（見下文）。
+
+**查詢數據** ：通常你會被要求測試一些東西或提供更多細節。儘快提供所要求的信
+息，因爲你已經得到了可能會幫助你的人的注意，你等待的時間越長就有越可能失去
+關注；如果你不在數個工作日內提供信息，甚至可能出現這種結果。
+
+**測試請求** ：當你被要求測試一個診斷補丁或可能的修復時，也要儘量及時測試。
+但要做得恰當，一定不要急於求成：混淆事情很容易發生，這會給所有人帶來許多困
+惑。例如一個常見的錯誤是以爲應用了一個帶修復的建議補丁，但事實上並沒有。即
+使是有經驗的測試人員也會偶爾發生這樣的事情，但當有修復的內核和沒有修復的內
+核表現得一樣時，他們大多時候會注意到。
+
+當沒有任何實質性進展時該怎麼辦
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+有些報告不會得到負有相關責任的 Linux 內核開發者的任何反應；或者圍繞這個問題
+的討論有所發展，但漸漸淡出，沒有任何實質內容產出。
+
+在這種情況下，要等兩個星期（最好是三個星期）後再發出友好的提醒：也許當你的
+報告到達時，維護者剛剛離開鍵盤一段時間，或者有更重要的事情要處理。在寫提醒
+信的時候，要善意地問一下，是否還需要你這邊提供什麼來讓事情推進下去。如果報
+告是通過郵件發出來的，那就在郵件的第一行回覆你的初始郵件（見上文），其中包
+括下方的原始報告的完整引用：這是少數幾種情況下，這樣的「TOFU」（Text Over,
+Fullquote Under文字在上，完整引用在下）是正確的做法，因爲這樣所有的收件人都
+會以適當的順序立即讓細節到手頭上來。
+
+在提醒之後，再等三周的回覆。如果你仍然沒有得到適當的反饋，你首先應該重新考
+慮你的方法。你是否可能嘗試接觸了錯誤的人？是不是報告也許令人反感或者太混亂，
+以至於人們決定完全遠離它？排除這些因素的最好方法是：把報告給一兩個熟悉
+FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於如何繼續推進的建議。
+這可能意味著：準備一份更好的報告，讓這些人在你發出去之前對它進行審查。這樣
+的方法完全可以；只需說明這是關於這個問題的第二份改進的報告，並附上第一份報
+告的連結。
+
+如果報告是恰當的，你可以發送第二封提醒信；在其中詢問爲什麼報告沒有得到任何
+回復。第二封提醒郵件的好時機是在新 Linux 內核版本的首個預發布版本（'rc1'）
+發布後不久，因爲無論如何你都應該在那個時候重新測試並提供狀態更新（見上文）。
+
+如果第二次提醒的結果又在一周內沒有任何反應，可以嘗試聯繫上級維護者詢問意見：
+即使再忙的維護者在這時候也至少應該發過某種確認。
+
+記住要做好失望的準備：理想狀況下維護者最好對每一個問題報告做出回應，但他們
+只有義務解決之前列出的「高優先級問題」。所以，如果你得到的回覆是「謝謝你的報告，
+我目前有更重要的問題要處理，在可預見的未來沒有時間去研究這個問題」，那請不
+要太沮喪。
+
+也有可能在缺陷跟蹤器或列表中進行了一些討論之後，什麼都沒有發生，提醒也無助
+於激勵大家進行修復。這種情況可能是毀滅性的，但在 Linux 內核開發中確實會發生。
+這些和其他得不到幫助的原因在本文結尾處的「爲什麼有些問題在被報告後沒有得到
+任何回應或者仍然沒有修復」中進行了解釋。
+
+如果你沒有得到任何幫助或問題最終沒有得到解決，不要沮喪：Linux 內核是 FLOSS，
+因此你仍然可以自己幫助自己。例如，你可以試著找到其他受影響的人，和他們一
+起合作來解決這個問題。這樣的團隊可以一起準備一份新的報告，提到團隊有多少人，
+爲什麼你們認爲這是應該得到解決的事情。也許你們還可以一起縮小確切原因或引
+入回歸的變化，這往往會使修復更容易。而且如果運氣好的話，團隊中可能會有懂點
+編程的人，也許能寫出一個修複方案。
+
+
+
+「報告穩定版和長期支持內核線的回歸」的參考
+------------------------------------------
+
+本小節提供了在穩定版和長期支持內核線中面對回歸時需要執行的步驟的詳細信息。
+
+確保特定版本線仍然受支持
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *檢查內核開發人員是否仍然維護你關心的Linux內核版本線：去 kernel.org 的
+    首頁，確保此特定版本線的最新版沒有「[EOL]」標記。*
+
+大多數內核版本線只支持三個月左右，因爲延長維護時間會帶來相當多的工作。因此，
+每年只會選擇一個版本來支持至少兩年（通常是六年）。這就是爲什麼你需要檢查
+內核開發者是否還支持你關心的版本線。
+
+注意，如果 `kernel.org <https://kernel.org/>`_ 在首頁上列出了兩個「穩定」版本，
+你應該考慮切換到較新的版本，而忘掉較舊的版本：對它的支持可能很快就會結束。
+然後，它將被標記爲「生命周期結束」（EOL）。達到這個程度的版本線仍然會在
+`kernel.org <https://kernel.org/>`_ 首頁上被顯示一兩周，但不適合用於測試和
+報告。
+
+搜索穩定版郵件列表
+~~~~~~~~~~~~~~~~~~~
+
+    *檢查Linux穩定版郵件列表中的現有報告。*
+
+也許你所面臨的問題已經被發現，並且已經或即將被修復。因此，請在 `Linux 穩定
+版郵件列表的檔案 <https://lore.kernel.org/stable/>`_ 中搜索類似問題的報告。
+如果你找到任何匹配的問題，可以考慮加入討論，除非修復工作已經完成並計劃很快
+得到應用。
+
+用最新版本復現問題
+~~~~~~~~~~~~~~~~~~~
+
+    *從特定的版本線安裝最新版本作爲純淨內核。確保這個內核沒有被汙染，並且仍
+    然存在問題，因爲問題可能已經在那裡被修復了。*
+
+在投入更多時間到這個過程中之前，你要檢查這個問題是否在你關注的版本線的最新
+版本中已經得到了修復。這個內核需要是純淨的，在問題發生之前不應該被汙染，正
+如上面已經在測試主線的過程中詳細介紹過的一樣。
+
+您是否是第一次注意到供應商內核的回歸？供應商的更改可能會發生變化。你需要重新
+檢查排除來這個問題。當您從5.10.4-vendor.42更新到5.10.5-vendor.43時，記錄損壞
+的信息。然後在測試了前一段中所述的最新5.10版本之後，檢查Linux 5.10.4的普通版本
+是否也可以正常工作。如果問題在那裡出現，那就不符合上游回歸的條件，您需要切換
+回主逐步指南來報告問題。
+
+報告回歸
+~~~~~~~~~~
+
+    *向Linux穩定版郵件列表發送一個簡短的問題報告(stable@vger.kernel.org)。
+    大致描述問題，並解釋如何復現。講清楚首個出現問題的版本和最後一個工作正常
+    的版本。然後等待進一步的指示。*
+
+當報告在穩定版或長期支持內核線內發生的回歸（例如在從5.10.4更新到5.10.5時），
+一份簡短的報告足以快速報告問題。因此只需要粗略的描述。
+
+但是請注意，如果您能夠指明引入問題的確切版本，這將對開發人員有很大幫助。因此
+如果有時間的話，請嘗試使用普通內核找到該版本。讓我們假設發行版發布Linux內核
+5.10.5到5.10.8的更新時發生了故障。那麼按照上面的指示，去檢查該版本線中的最新
+內核，比如5.10.9。如果問題出現，請嘗試普通5.10.5，以確保供應商應用的補丁不會
+干擾。如果問題沒有出現，那麼嘗試5.10.7，然後直到5.10.8或5.10.6（取決於結果）
+找到第一個引入問題的版本。在報告中寫明這一點，並指出5.10.9仍然存在故障。
+
+前一段基本粗略地概述了「二分」方法。一旦報告出來，您可能會被要求做一個正確的
+報告，因爲它允許精確地定位導致問題的確切更改（然後很容易被恢復以快速修復問題）。
+因此如果時間允許，考慮立即進行適當的二分。有關如何詳細信息，請參閱「對回歸的
+特別關照」部分和文檔「Documentation/translations/zh_TW/admin-guide/bug-bisect.rst」。
+
+
+「報告僅在舊內核版本線中發生的問題」的參考
+------------------------------------------
+
+本節詳細介紹了如果無法用主線內核重現問題，但希望在舊版本線（又稱穩定版內核和
+長期支持內核）中修復問題時需要採取的步驟。
+
+有些修復太複雜
+~~~~~~~~~~~~~~~
+
+    *請做好準備，接下來的幾個步驟可能無法在舊版本中解決問題：修復可能太大或
+    太冒險，無法移植到那裡。*
+
+即使是微小的、看似明顯的代碼變化，有時也會帶來新的、完全意想不到的問題。穩
+定版和長期支持內核的維護者非常清楚這一點，因此他們只對這些內核進行符合
+「Documentation/translations/zh_TW/process/stable-kernel-rules.rst」中所列出的
+規則的修改。
+
+複雜或有風險的修改不符合條件，因此只能應用於主線。其他的修復很容易被回溯到
+最新的穩定版和長期支持內核，但是風險太大，無法集成到舊版內核中。所以要注意
+你所希望的修復可能是那些不會被回溯到你所關心的版本線的修復之一。在這種情況
+下，你將別無選擇，要麼忍受這個問題，要麼切換到一個較新的 Linux 版本，除非你
+想自己把修復補丁應用到你的內核中。
+
+通用準備
+~~~~~~~~~~
+
+    *執行上面「報告僅在舊內核版本線中發生的問題」一節中的前三個步驟。*
+
+您需要執行本指南另一節中已經描述的幾個步驟。這些步驟將讓您：
+
+ * 檢查內核開發人員是否仍然維護您關心的Linux內核版本行。
+
+ * 在Linux穩定郵件列表中搜索退出的報告。
+
+ * 檢查最新版本。
+
+
+檢查代碼歷史和搜索現有的討論
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *在Linux內核版本控制系統中搜索修復主線問題的更改，因爲它的提交消息可能
+    會告訴你修復是否已經計劃好了支持。如果你沒有找到，搜索適當的郵件列表，
+    尋找討論此類問題或同行評議可能修復的帖子；然後檢查討論是否認爲修復不適
+    合支持。如果支持根本不被考慮，加入最新的討論，詢問是否有可能。*
+
+在許多情況下，你所處理的問題會發生在主線上，但已在主線上得到了解決。修正它
+的提交也需要被回溯才能解決這個問題。這就是爲什麼你要搜索它或任何相關討論。
+
+ * 首先嘗試在存放 Linux 內核原始碼的 Git 倉庫中找到修復。你可以通過
+   `kernel.org 上的網頁
+   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
+   或 `GitHub 上的鏡像 <https://github.com/torvalds/linux>`_ 來實現；如果你
+   有一個本地克隆，你也可以在命令行用 ``git log --grep=<pattern>`` 來搜索。
+
+   如果你找到了修復，請查看提交消息的尾部是否包含了類似這樣的「穩定版標籤」：
+
+          Cc: <stable@vger.kernel.org> # 5.4+
+
+   像上面這行，開發者標記了安全修復可以回傳到 5.4 及以後的版本。大多數情況
+   下，它會在兩周內被應用到那裡，但有時需要更長的時間。
+
+ * 如果提交沒有告訴你任何東西，或者你找不到修復，請再找找關於這個問題的討論。
+   用你最喜歡的搜尋引擎搜索網絡，以及 `Linux kernel developers mailing
+   list 內核開發者郵件列表 <https://lore.kernel.org/lkml/>`_ 的檔案。也可以
+   閱讀上面的 `定位導致問題的內核區域` 一節，然後按照說明找到導致問題的子系
+   統：它的缺陷跟蹤器或郵件列表存檔中可能有你要找的答案。
+
+ * 如果你看到了一個計劃的修復，請按上所述在版本控制系統中搜索它，因爲提交可
+   能會告訴你是否可以進行回溯。
+
+   * 檢查討論中是否有任何跡象表明，該修復程序可能風險太大，無法回溯到你關心
+     的版本線。如果是這樣的話，你必須忍受這個問題，或者切換到應用了修復的內
+     核版本線。
+
+   * 如果修復的問題未包含穩定版標籤，並且沒有討論過回溯問題，請加入討論：如
+     果合適的話，請提及你所面對的問題的版本，以及你希望看到它被修復。
+
+
+請求建議
+~~~~~~~~~
+
+    *前面的步驟之一應該會給出一個解決方案。如果仍未能成功，請向可能引起問題
+    的子系統的維護人員詢問建議；抄送特定子系統的郵件列表以及穩定版郵件列表。*
+
+如果前面的三個步驟都沒有讓你更接近解決方案，那麼只剩下一個選擇：請求建議。
+在你發給可能是問題根源的子系統的維護者的郵件中這樣做；抄送子系統的郵件列表
+以及穩定版郵件列表（stable@vger.kernel.org）。
+
+
+爲什麼有些問題在報告後沒有任何回應或仍未解決？
+===============================================
+
+當向 Linux 開發者報告問題時，要注意只有「高優先級的問題」（回歸、安全問題、嚴
+重問題）才一定會得到解決。如果維護者或其他人都失敗了，Linus Torvalds 他自己
+會確保這一點。他們和其他內核開發者也會解決很多其他問題。但是要知道，有時他
+們也會不能或不願幫忙；有時甚至沒有人發報告給他們。
+
+最好的解釋就是那些內核開發者常常是在業餘時間爲 Linux 內核做出貢獻。內核中的
+不少驅動程序都是由這樣的程式設計師編寫的，往往只是因爲他們想讓自己的硬體可以在
+自己喜歡的作業系統上使用。
+
+這些程式設計師大多數時候會很樂意修復別人報告的問題。但是沒有人可以強迫他們這樣
+做，因爲他們是自願貢獻的。
+
+還有一些情況下，這些開發者真的很想解決一個問題，但卻不能解決：有時他們缺乏
+硬體編程文檔來解決問題。這種情況往往由於公開的文檔太簡陋，或者驅動程序是通
+過逆向工程編寫的。
+
+業餘開發者遲早也會不再關心某驅動。也許他們的測試硬體壞了，被更高級的玩意取
+代了，或者是太老了以至於只能在計算機博物館裡找到。有時開發者根本就不關心他
+們的代碼和 Linux 了，因爲在他們的生活中一些不同的東西變得更重要了。在某些情
+況下，沒有人願意接手維護者的工作——也沒有人可以被強迫，因爲對 Linux 內核的貢
+獻是自願的。然而被遺棄的驅動程序仍然存在於內核中：它們對人們仍然有用，刪除
+它們可能導致回歸。
+
+對於那些爲 Linux 內核工作而獲得報酬的開發者來說，情況並沒有什麼不同。這些人
+現在貢獻了大部分的變更。但是他們的僱主遲早也會停止關注他們的代碼或者讓程序
+員專注於其他事情。例如，硬體廠商主要通過銷售新硬體來賺錢；因此，他們中的不
+少人並沒有投入太多時間和精力來維護他們多年前就停止銷售的東西的 Linux 內核驅
+動。企業級 Linux 發行商往往持續維護的時間比較長，但在新版本中往往會把對老舊
+和稀有硬體的支持放在一邊，以限制範圍。一旦公司拋棄了一些代碼，往往由業餘貢
+獻者接手，但正如上面提到的：他們遲早也會放下代碼。
+
+優先級是一些問題沒有被修復的另一個原因，因爲維護者相當多的時候是被迫設置這
+些優先級的，因爲在 Linux 上工作的時間是有限的。對於業餘時間或者僱主給予他們
+的開發人員用於上游內核維護工作的時間也是如此。有時維護人員也會被報告淹沒，
+即使一個驅動程序幾乎完美地工作。爲了不被完全纏住，程式設計師可能別無選擇，只能
+對問題報告進行優先級排序而拒絕其中的一些報告。
+
+不過這些都不用太過擔心，很多驅動都有積極的維護者，他們對儘可能多的解決問題
+相當感興趣。
+
+
+結束語
+=======
+
+與其他免費/自由&開源軟體（Free/Libre & Open Source Software，FLOSS）相比，
+向 Linux 內核開發者報告問題是很難的：這個文檔的長度和複雜性以及字裡行間的內
+涵都說明了這一點。但目前就是這樣了。這篇文字的主要作者希望通過記錄現狀來爲
+以後改善這種狀況打下一些基礎。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
new file mode 100644
index 000000000000..eed260ef0c37
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../admin-guide/security-bugs`
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+安全缺陷
+=========
+
+Linux內核開發人員非常重視安全性。因此我們想知道何時發現了安全漏洞，以便儘快
+修復和披露。請向Linux內核安全團隊報告安全漏洞。
+
+聯絡
+-----
+
+可以通過電子郵件<security@kernel.org>聯繫Linux內核安全團隊。這是一個安全人員
+的私有列表，他們將幫助驗證錯誤報告並開發和發布修復程序。如果您已經有了一個
+修復，請將其包含在您的報告中，這樣可以大大加快進程。安全團隊可能會從區域維護
+人員那裡獲得額外的幫助，以理解和修復安全漏洞。
+
+與任何缺陷一樣，提供的信息越多，診斷和修復就越容易。如果您不清楚哪些信息有用，
+請查看「Documentation/translations/zh_TW/admin-guide/reporting-issues.rst」中
+概述的步驟。任何利用漏洞的攻擊代碼都非常有用，未經報告者同意不會對外發布，除
+非已經公開。
+
+請儘可能發送無附件的純文本電子郵件。如果所有的細節都藏在附件里，那麼就很難對
+一個複雜的問題進行上下文引用的討論。把它想像成一個
+:doc:`常規的補丁提交 <../process/submitting-patches>` （即使你還沒有補丁）：
+描述問題和影響，列出復現步驟，然後給出一個建議的解決方案，所有這些都是純文本的。
+
+披露和限制信息
+---------------
+
+安全列表不是公開渠道。爲此，請參見下面的協作。
+
+一旦開發出了健壯的補丁，發布過程就開始了。對公開的缺陷的修復會立即發布。
+
+儘管我們傾向於在未公開缺陷的修復可用時即發布補丁，但應報告者或受影響方的請求，
+這可能會被推遲到發布過程開始後的7日內，如果根據缺陷的嚴重性需要更多的時間，
+則可額外延長到14天。推遲發布修復的唯一有效原因是爲了適應QA的邏輯和需要發布
+協調的大規模部署。
+
+雖然可能與受信任的個人共享受限信息以開發修復，但未經報告者許可，此類信息不會
+與修復程序一起發布或發布在任何其他披露渠道上。這包括但不限於原始錯誤報告和
+後續討論（如有）、漏洞、CVE信息或報告者的身份。
+
+換句話說，我們唯一感興趣的是修復缺陷。提交給安全列表的所有其他資料以及對報告
+的任何後續討論，即使在解除限制之後，也將永久保密。
+
+協調
+------
+
+對敏感缺陷（例如那些可能導致權限提升的缺陷）的修復可能需要與私有郵件列表
+<linux-distros@vs.openwall.org>進行協調，以便分發供應商做好準備，在公開披露
+上游補丁時發布一個已修復的內核。發行版將需要一些時間來測試建議的補丁，通常
+會要求至少幾天的限制，而供應商更新發布更傾向於周二至周四。若合適，安全團隊
+可以協助這種協調，或者報告者可以從一開始就包括linux發行版。在這種情況下，請
+記住在電子郵件主題行前面加上「[vs]」，如linux發行版wiki中所述：
+<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>。
+
+CVE分配
+--------
+
+安全團隊通常不分配CVE，我們也不需要它們來進行報告或修復，因爲這會使過程不必
+要的複雜化，並可能耽誤缺陷處理。如果報告者希望在公開披露之前分配一個CVE編號，
+他們需要聯繫上述的私有linux-distros列表。當在提供補丁之前已有這樣的CVE編號時，
+如報告者願意，最好在提交消息中提及它。
+
+保密協議
+---------
+
+Linux內核安全團隊不是一個正式的機構實體，因此無法簽訂任何保密協議。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
new file mode 100644
index 000000000000..d7b3c4276417
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
@@ -0,0 +1,161 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../admin-guide/tainted-kernels`
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+受汙染的內核
+-------------
+
+當發生一些在稍後調查問題時可能相關的事件時，內核會將自己標記爲「受汙染
+（tainted）」的。不用太過擔心，大多數情況下運行受汙染的內核沒有問題；這些信息
+主要在有人想調查某個問題時才有意義的，因爲問題的真正原因可能是導致內核受汙染
+的事件。這就是爲什麼來自受汙染內核的缺陷報告常常被開發人員忽略，因此請嘗試用
+未受汙染的內核重現問題。
+
+請注意，即使在您消除導致汙染的原因（亦即卸載專有內核模塊）之後，內核仍將保持
+汙染狀態，以表示內核仍然不可信。這也是爲什麼內核在注意到內部問題（「kernel
+bug」）、可恢復錯誤（「kernel oops」）或不可恢復錯誤（「kernel panic」）時會列印
+受汙染狀態，並將有關此的調試信息寫入日誌 ``dmesg`` 輸出。也可以通過
+``/proc/`` 中的文件在運行時檢查受汙染的狀態。
+
+
+BUG、Oops或Panics消息中的汙染標誌
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+在頂部以「CPU:」開頭的一行中可以找到受汙染的狀態；內核是否受到汙染和原因會顯示
+在進程ID（「PID:」）和觸發事件命令的縮寫名稱（「Comm:」）之後::
+
+	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
+	Oops: 0002 [#1] SMP PTI
+	CPU: 0 PID: 4424 Comm: insmod Tainted: P        W  O      4.20.0-0.rc6.fc30 #1
+	Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
+	RIP: 0010:my_oops_init+0x13/0x1000 [kpanic]
+	[...]
+
+如果內核在事件發生時沒有被汙染，您將在那裡看到「Not-tainted:」；如果被汙染，那
+麼它將是「Tainted:」以及字母或空格。在上面的例子中，它看起來是這樣的::
+
+	Tainted: P        W  O
+
+下表解釋了這些字符的含義。在本例中，由於加載了專有模塊（ ``P`` ），出現了
+警告（ ``W`` ），並且加載了外部構建的模塊（ ``O`` ），所以內核早些時候受到
+了汙染。要解碼其他字符，請使用下表。
+
+
+解碼運行時的汙染狀態
+~~~~~~~~~~~~~~~~~~~~~
+
+在運行時，您可以通過讀取 ``cat /proc/sys/kernel/tainted`` 來查詢受汙染狀態。
+如果返回 ``0`` ，則內核沒有受到汙染；任何其他數字都表示受到汙染的原因。解碼
+這個數字的最簡單方法是使用腳本  ``tools/debugging/kernel-chktaint`` ，您的
+發行版可能會將其作爲名爲 ``linux-tools`` 或 ``kernel-tools`` 的包的一部分提
+供；如果沒有，您可以從
+`git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_
+網站下載此腳本並用 ``sh kernel-chktaint`` 執行，它會在上面引用的日誌中有類似
+語句的機器上列印這樣的內容::
+
+	Kernel is Tainted for following reasons:
+	 * Proprietary module was loaded (#0)
+	 * Kernel issued warning (#9)
+	 * Externally-built ('out-of-tree') module was loaded  (#12)
+	See Documentation/admin-guide/tainted-kernels.rst in the Linux kernel or
+	 https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html for
+	 a more details explanation of the various taint flags.
+	Raw taint value as int/string: 4609/'P        W  O     '
+
+你也可以試著自己解碼這個數字。如果內核被汙染的原因只有一個，那麼這很簡單，
+在本例中您可以通過下表找到數字。如果你需要解碼有多個原因的數字，因爲它是一
+個位域（bitfield），其中每個位表示一個特定類型的汙染的存在或不存在，最好讓
+前面提到的腳本來處理。但是如果您需要快速看一下，可以使用這個shell命令來檢查
+設置了哪些位::
+
+	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
+
+汙染狀態代碼表
+~~~~~~~~~~~~~~~
+
+===  =====  ======  ========================================================
+ 位  日誌     數字  內核被汙染的原因
+===  =====  ======  ========================================================
+  0   G/P        1  已加載專用模塊
+  1   _/F        2  模塊被強制加載
+  2   _/S        4  內核運行在不合規範的系統上
+  3   _/R        8  模塊被強制卸載
+  4   _/M       16  處理器報告了機器檢測異常（MCE）
+  5   _/B       32  引用了錯誤的頁或某些意外的頁標誌
+  6   _/U       64  用戶空間應用程式請求的汙染
+  7   _/D      128  內核最近死機了，即曾出現OOPS或BUG
+  8   _/A      256  ACPI表被用戶覆蓋
+  9   _/W      512  內核發出警告
+ 10   _/C     1024  已加載staging驅動程序
+ 11   _/I     2048  已應用平台固件缺陷的解決方案
+ 12   _/O     4096  已加載外部構建（「樹外」）模塊
+ 13   _/E     8192  已加載未簽名的模塊
+ 14   _/L    16384  發生軟鎖定
+ 15   _/K    32768  內核已實時打補丁
+ 16   _/X    65536  備用汙染，爲發行版定義並使用
+ 17   _/T   131072  內核是用結構隨機化插件構建的
+===  =====  ======  ========================================================
+
+註：字符 ``_`` 表示空白，以便於閱讀表。
+
+汙染的更詳細解釋
+~~~~~~~~~~~~~~~~~
+
+ 0)  ``G`` 加載的所有模塊都有GPL或兼容許可證， ``P`` 加載了任何專有模塊。
+     沒有MODULE_LICENSE（模塊許可證）或MODULE_LICENSE未被insmod認可爲GPL
+     兼容的模塊被認爲是專有的。
+
+
+ 1)  ``F`` 任何模塊被 ``insmod -f`` 強制加載， ``' '`` 所有模塊正常加載。
+
+ 2)  ``S`` 內核運行在不合規範的處理器或系統上：硬體已運行在不受支持的配置中，
+     因此無法保證正確執行。內核將被汙染，例如：
+
+     - 在x86上：PAE是通過intel CPU（如Pentium M）上的forcepae強制執行的，這些
+       CPU不報告PAE，但可能有功能實現，SMP內核在非官方支持的SMP Athlon CPU上
+       運行，MSR被暴露到用戶空間中。
+     - 在arm上：在某些CPU（如Keystone 2）上運行的內核，沒有啓用某些內核特性。
+     - 在arm64上：CPU之間存在不匹配的硬體特性，引導加載程序以不同的模式引導CPU。
+     - 某些驅動程序正在被用在不受支持的體系結構上（例如x86_64以外的其他系統
+       上的scsi/snic，非x86/x86_64/itanium上的scsi/ips，已經損壞了arm64上
+       irqchip/irq-gic的固件設置…）。
+
+ 3)  ``R`` 模塊被 ``rmmod -f`` 強制卸載， ``' '`` 所有模塊都正常卸載。
+
+ 4)  ``M`` 任何處理器報告了機器檢測異常， ``' '`` 未發生機器檢測異常。
+
+ 5)  ``B`` 頁面釋放函數發現錯誤的頁面引用或某些意外的頁面標誌。這表示硬體問題
+     或內核錯誤；日誌中應該有其他信息指示發生此汙染的原因。
+
+ 6)  ``U`` 用戶或用戶應用程式特意請求設置受汙染標誌，否則應爲 ``' '`` 。
+
+ 7)  ``D`` 內核最近死機了，即出現了OOPS或BUG。
+
+ 8)  ``A`` ACPI表被重寫。
+
+ 9)  ``W`` 內核之前已發出過警告（儘管有些警告可能會設置更具體的汙染標誌）。
+
+ 10) ``C`` 已加載staging驅動程序。
+
+ 11) ``I`` 內核正在處理平台固件（BIOS或類似軟體）中的嚴重錯誤。
+
+ 12) ``O`` 已加載外部構建（「樹外」）模塊。
+
+ 13) ``E`` 在支持模塊簽名的內核中加載了未簽名的模塊。
+
+ 14) ``L`` 系統上先前發生過軟鎖定。
+
+ 15) ``K`` 內核已經實時打了補丁。
+
+ 16) ``X`` 備用汙染，由Linux發行版定義和使用。
+
+ 17) ``T`` 內核構建時使用了randstruct插件，它可以有意生成非常不尋常的內核結構
+     布局（甚至是性能病態的布局），這在調試時非常有用。於構建時設置。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/unicode.rst b/Documentation/translations/zh_TW/admin-guide/unicode.rst
new file mode 100644
index 000000000000..720875be5ef8
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/unicode.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/unicode.rst
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+ 胡皓文 Hu Haowen <src.res@email.cn>
+
+Unicode（統一碼）支持
+======================
+
+	（英文版）上次更新：2005-01-17，版本號 1.4
+
+此文檔由H. Peter Anvin <unicode@lanana.org>管理，是Linux註冊名稱與編號管理局
+（Linux Assigned Names And Numbers Authority，LANANA）項目的一部分。
+現行版本請見：
+
+	http://www.lanana.org/docs/unicode/admin-guide/unicode.rst
+
+簡介
+-----
+
+Linux內核代碼已被重寫以使用Unicode來將字符映射到字體。下載一個Unicode到字體
+（Unicode-to-font）表，八位字符集與UTF-8模式都將改用此字體來顯示。
+
+這微妙地改變了八位字符表的語義。現在的四個字符表是：
+
+=============== =============================== ================
+映射代號        映射名稱                        Escape代碼 (G0)
+=============== =============================== ================
+LAT1_MAP        Latin-1 (ISO 8859-1)            ESC ( B
+GRAF_MAP        DEC VT100 pseudographics        ESC ( 0
+IBMPC_MAP       IBM code page 437               ESC ( U
+USER_MAP        User defined                    ESC ( K
+=============== =============================== ================
+
+特別是 ESC ( U 不再是「直通字體」，因爲字體可能與IBM字符集完全不同。
+例如，即使加載了一個Latin-1字體，也允許使用塊圖形（block graphics）。
+
+請注意，儘管這些代碼與ISO 2022類似，但這些代碼及其用途都與ISO 2022不匹配；
+Linux有兩個八位代碼（G0和G1），而ISO 2022有四個七位代碼（G0-G3）。
+
+根據Unicode標準/ISO 10646，U+F000到U+F8FF被保留用於作業系統範圍內的分配
+（Unicode標準將其稱爲「團體區域（Corporate Zone）」，因爲這對於Linux是不準確
+的，所以我們稱之爲「Linux區域」）。選擇U+F000作爲起點，因爲它允許直接映射
+區域以2的大倍數開始（以防需要1024或2048個字符的字體）。這就留下U+E000到
+U+EFFF作爲最終用戶區。
+
+[v1.2]：Unicodes範圍從U+F000到U+F7FF已經被硬編碼爲直接映射到加載的字體，
+繞過了翻譯表。用戶定義的映射現在默認爲U+F000到U+F0FF，模擬前述行爲。實際上，
+此範圍可能較短；例如，vgacon只能處理256字符（U+F000..U+F0FF）或512字符
+（U+F000..U+F1FF）字體。
+
+Linux 區域中定義的實際字符
+---------------------------
+
+此外，還定義了Unicode 1.1.4中不存在的以下字符；這些字符由DEC VT圖形映射使用。
+[v1.2]此用法已過時，不應再使用；請參見下文。
+
+====== ======================================
+U+F800 DEC VT GRAPHICS HORIZONTAL LINE SCAN 1
+U+F801 DEC VT GRAPHICS HORIZONTAL LINE SCAN 3
+U+F803 DEC VT GRAPHICS HORIZONTAL LINE SCAN 7
+U+F804 DEC VT GRAPHICS HORIZONTAL LINE SCAN 9
+====== ======================================
+
+DEC VT220使用6x10字符矩陣，這些字符在DEC VT圖形字符集中形成一個平滑的過渡。
+我省略了掃描5行，因爲它也被用作塊圖形字符，因此被編碼爲U+2500 FORMS LIGHT
+HORIZONTAL。
+
+[v1.3]：這些字符已正式添加到Unicode 3.2.0中；它們在U+23BA、U+23BB、U+23BC、
+U+23BD處添加。Linux現在使用新值。
+
+[v1.2]：添加了以下字符來表示常見的鍵盤符號，這些符號不太可能被添加到Unicode
+中，因爲它們非常討厭地取決於特定供應商。當然，這是糟糕設計的一個好例子。
+
+====== ======================================
+U+F810 KEYBOARD SYMBOL FLYING FLAG
+U+F811 KEYBOARD SYMBOL PULLDOWN MENU
+U+F812 KEYBOARD SYMBOL OPEN APPLE
+U+F813 KEYBOARD SYMBOL SOLID APPLE
+====== ======================================
+
+克林貢（Klingon）語支持
+------------------------
+
+1996年，Linux是世界上第一個添加對人工語言克林貢支持的作業系統，克林貢是由
+Marc Okrand爲《星際迷航》電視連續劇創造的。這種編碼後來被徵募Unicode註冊表
+（ConScript Unicode Registry，CSUR）採用，並建議（但最終被拒絕）納入Unicode
+平面一。不過，它仍然是Linux區域中的Linux/CSUR私有分配。
+
+這種編碼已經得到克林貢語言研究所（Klingon Language Institute）的認可。
+有關更多信息，請聯繫他們：
+
+	http://www.kli.org/
+
+由於Linux CZ開頭部分的字符大多是dingbats/symbols/forms類型，而且這是一種
+語言，因此根據標準Unicode慣例，我將它放置在16單元的邊界上。
+
+.. note::
+
+  這個範圍現在由徵募Unicode註冊表正式管理。規範性引用文件爲：
+
+	https://www.evertype.com/standards/csur/klingon.html
+
+克林貢語有一個26個字符的字母表，一個10位數的位置數字書寫系統，從左到右
+，從上到下書寫。
+
+克林貢字母的幾種字形已經被提出。但是由於這組符號看起來始終是一致的，只有實際
+的形狀不同，因此按照標準Unicode慣例，這些差異被認爲是字體變體。
+
+======	=======================================================
+U+F8D0	KLINGON LETTER A
+U+F8D1	KLINGON LETTER B
+U+F8D2	KLINGON LETTER CH
+U+F8D3	KLINGON LETTER D
+U+F8D4	KLINGON LETTER E
+U+F8D5	KLINGON LETTER GH
+U+F8D6	KLINGON LETTER H
+U+F8D7	KLINGON LETTER I
+U+F8D8	KLINGON LETTER J
+U+F8D9	KLINGON LETTER L
+U+F8DA	KLINGON LETTER M
+U+F8DB	KLINGON LETTER N
+U+F8DC	KLINGON LETTER NG
+U+F8DD	KLINGON LETTER O
+U+F8DE	KLINGON LETTER P
+U+F8DF	KLINGON LETTER Q
+	- Written <q> in standard Okrand Latin transliteration
+U+F8E0	KLINGON LETTER QH
+	- Written <Q> in standard Okrand Latin transliteration
+U+F8E1	KLINGON LETTER R
+U+F8E2	KLINGON LETTER S
+U+F8E3	KLINGON LETTER T
+U+F8E4	KLINGON LETTER TLH
+U+F8E5	KLINGON LETTER U
+U+F8E6	KLINGON LETTER V
+U+F8E7	KLINGON LETTER W
+U+F8E8	KLINGON LETTER Y
+U+F8E9	KLINGON LETTER GLOTTAL STOP
+
+U+F8F0	KLINGON DIGIT ZERO
+U+F8F1	KLINGON DIGIT ONE
+U+F8F2	KLINGON DIGIT TWO
+U+F8F3	KLINGON DIGIT THREE
+U+F8F4	KLINGON DIGIT FOUR
+U+F8F5	KLINGON DIGIT FIVE
+U+F8F6	KLINGON DIGIT SIX
+U+F8F7	KLINGON DIGIT SEVEN
+U+F8F8	KLINGON DIGIT EIGHT
+U+F8F9	KLINGON DIGIT NINE
+
+U+F8FD	KLINGON COMMA
+U+F8FE	KLINGON FULL STOP
+U+F8FF	KLINGON SYMBOL FOR EMPIRE
+======	=======================================================
+
+其他虛構和人工字母
+-------------------
+
+自從分配了克林貢Linux Unicode塊之後，John Cowan <jcowan@reutershealth.com>
+和 Michael Everson <everson@evertype.com> 建立了一個虛構和人工字母的註冊表。
+徵募Unicode註冊表請訪問：
+
+	https://www.evertype.com/standards/csur/
+
+所使用的範圍位於最終用戶區域的低端，因此無法進行規範化分配，但建議希望對虛構
+字母進行編碼的人員使用這些代碼，以實現互操作性。對於克林貢語，CSUR採用了Linux
+編碼。CSUR的人正在推動將Tengwar和Cirth添加到Unicode平面一；將克林貢添加到
+Unicode平面一被拒絕，因此上述編碼仍然是官方的。
+
diff --git a/Documentation/translations/zh_TW/disclaimer-zh_TW.rst b/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
new file mode 100644
index 000000000000..f4cf87d03dc5
--- /dev/null
+++ b/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
@@ -0,0 +1,11 @@
+:orphan:
+
+.. warning::
+     此文件的目的是爲讓中文讀者更容易閱讀和理解，而不是作爲一個分支。因此，
+     如果您對此文件有任何意見或改動，請先嘗試更新原始英文文件。如果要更改或
+     修正某處翻譯文件，請將意見或補丁發送給維護者（聯繫方式見下）。
+
+.. note::
+     如果您發現本文檔與原始文件有任何不同或者有翻譯問題，請聯繫該文件的譯者，
+     或者發送電子郵件給胡皓文以獲取幫助：<src.res@email.cn>。
+
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
new file mode 100644
index 000000000000..e3c076dd75a5
--- /dev/null
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -0,0 +1,651 @@
+Chinese translated version of Documentation/admin-guide/gpio
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Grant Likely <grant.likely@secretlab.ca>
+		Linus Walleij <linus.walleij@linaro.org>
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/admin-guide/gpio 的繁體中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
+者翻譯存在問題，請聯繫繁體中文版維護者。
+
+英文版維護者： Grant Likely <grant.likely@secretlab.ca>
+		Linus Walleij <linus.walleij@linaro.org>
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+
+以下爲正文
+---------------------------------------------------------------------
+GPIO 接口
+
+本文檔提供了一個在Linux下訪問GPIO的公約概述。
+
+這些函數以 gpio_* 作爲前綴。其他的函數不允許使用這樣的前綴或相關的
+__gpio_* 前綴。
+
+
+什麼是GPIO?
+==========
+"通用輸入/輸出口"(GPIO)是一個靈活的由軟體控制的數位訊號。他們可
+由多種晶片提供,且對於從事嵌入式和定製硬體的 Linux 開發者來說是
+比較熟悉。每個GPIO 都代表一個連接到特定引腳或球柵陣列(BGA)封裝中
+「球珠」的一個位。電路板原理圖顯示了 GPIO 與外部硬體的連接關係。
+驅動可以編寫成通用代碼，以使板級啓動代碼可傳遞引腳配置數據給驅動。
+
+片上系統 (SOC) 處理器對 GPIO 有很大的依賴。在某些情況下,每個
+非專用引腳都可配置爲 GPIO,且大多數晶片都最少有一些 GPIO。
+可編程邏輯器件(類似 FPGA) 可以方便地提供 GPIO。像電源管理和
+音頻編解碼器這樣的多功能晶片經常留有一些這樣的引腳來幫助那些引腳
+匱乏的 SOC。同時還有通過 I2C 或 SPI 串行總線連接的「GPIO擴展器」
+晶片。大多數 PC 的南橋有一些擁有 GPIO 能力的引腳 (只有BIOS
+固件才知道如何使用他們)。
+
+GPIO 的實際功能因系統而異。通常用法有:
+
+  - 輸出值可寫 (高電平=1，低電平=0)。一些晶片也有如何驅動這些值的選項,
+    例如只允許輸出一個值、支持「線與」及其他取值類似的模式(值得注意的是
+    「開漏」信號)
+
+  - 輸入值可讀(1、0)。一些晶片支持引腳在配置爲「輸出」時回讀，這對於類似
+    「線與」的情況(以支持雙向信號)是非常有用的。GPIO 控制器可能有輸入
+    去毛刺/消抖邏輯,這有時需要軟體控制。
+
+  - 輸入通常可作爲 IRQ 信號,一般是沿觸發,但有時是電平觸發。這樣的 IRQ
+    可能配置爲系統喚醒事件,以將系統從低功耗狀態下喚醒。
+
+  - 通常一個 GPIO 根據不同產品電路板的需求,可以配置爲輸入或輸出,也有僅
+    支持單向的。
+
+  - 大部分 GPIO 可以在持有自旋鎖時訪問,但是通常由串行總線擴展的 GPIO
+    不允許持有自旋鎖。但某些系統也支持這種類型。
+
+對於給定的電路板,每個 GPIO 都用於某個特定的目的,如監控 MMC/SD 卡的
+插入/移除、檢測卡的防寫狀態、驅動 LED、配置收發器、模擬串行總線、
+復位硬體看門狗、感知開關狀態等等。
+
+
+GPIO 公約
+=========
+注意,這個叫做「公約」，因爲這不是強制性的，不遵循這個公約是無傷大雅的，
+因爲此時可移植性並不重要。GPIO 常用於板級特定的電路邏輯,甚至可能
+隨著電路板的版本而改變，且不可能在不同走線的電路板上使用。僅有在少數
+功能上才具有可移植性，其他功能是平台特定。這也是由於「膠合」的邏輯造成的。
+
+此外，這不需要任何的執行框架，只是一個接口。某個平台可能通過一個簡單地
+訪問晶片寄存器的內聯函數來實現它，其他平台可能通過委託一系列不同的GPIO
+控制器的抽象函數來實現它。(有一些可選的代碼能支持這種策略的實現,本文檔
+後面會介紹，但作爲 GPIO 接口的客戶端驅動程序必須與它的實現無關。)
+
+也就是說,如果在他們的平台上支持這個公約，驅動應儘可能的使用它。同時，平台
+必須在 Kconfig 中選擇 ARCH_REQUIRE_GPIOLIB 或者 ARCH_WANT_OPTIONAL_GPIOLIB
+選項。那些調用標準 GPIO 函數的驅動應該在 Kconfig 入口中聲明依賴GENERIC_GPIO。
+當驅動包含文件:
+
+	#include <linux/gpio.h>
+
+則 GPIO 函數是可用,無論是「真實代碼」還是經優化過的語句。如果你遵守
+這個公約，當你的代碼完成後，對其他的開發者來說會更容易看懂和維護。
+
+注意，這些操作包含所用平台的 I/O 屏障代碼，驅動無須顯式地調用他們。
+
+
+標識 GPIO
+---------
+GPIO 是通過無符號整型來標識的,範圍是 0 到 MAX_INT。保留「負」數
+用於其他目的,例如標識信號「在這個板子上不可用」或指示錯誤。未接觸底層
+硬體的代碼會忽略這些整數。
+
+平台會定義這些整數的用法,且通常使用 #define 來定義 GPIO，這樣
+板級特定的啓動代碼可以直接關聯相應的原理圖。相對來說，驅動應該僅使用
+啓動代碼傳遞過來的 GPIO 編號，使用 platform_data 保存板級特定
+引腳配置數據 (同時還有其他須要的板級特定數據)，避免可能出現的問題。
+
+例如一個平台使用編號 32-159 來標識 GPIO,而在另一個平台使用編號0-63
+標識一組 GPIO 控制器,64-79標識另一類 GPIO 控制器,且在一個含有
+FPGA 的特定板子上使用 80-95。編號不一定要連續,那些平台中，也可以
+使用編號2000-2063來標識一個 I2C 接口的 GPIO 擴展器中的 GPIO。
+
+如果你要初始化一個帶有無效 GPIO 編號的結構體,可以使用一些負編碼
+(如"-EINVAL")，那將使其永遠不會是有效。來測試這樣一個結構體中的編號
+是否關聯一個 GPIO，你可使用以下斷言:
+
+	int gpio_is_valid(int number);
+
+如果編號不存在，則請求和釋放 GPIO 的函數將拒絕執行相關操作(見下文)。
+其他編號也可能被拒絕,比如一個編號可能存在，但暫時在給定的電路上不可用。
+
+一個平台是否支持多個 GPIO 控制器爲平台特定的實現問題，就像是否可以
+在 GPIO 編號空間中有「空洞」和是否可以在運行時添加新的控制器一樣。
+這些問題會影響其他事情，包括相鄰的 GPIO 編號是否存在等。
+
+使用 GPIO
+---------
+對於一個 GPIO，系統應該做的第一件事情就是通過 gpio_request()
+函數分配它，見下文。
+
+接下來是設置I/O方向，這通常是在板級啓動代碼中爲所使用的 GPIO 設置
+platform_device 時完成。
+
+	/* 設置爲輸入或輸出, 返回 0 或負的錯誤代碼 */
+	int gpio_direction_input(unsigned gpio);
+	int gpio_direction_output(unsigned gpio, int value);
+
+返回值爲零代表成功，否則返回一個負的錯誤代碼。這個返回值需要檢查，因爲
+get/set(獲取/設置)函數調用沒法返回錯誤,且有可能是配置錯誤。通常，
+你應該在進程上下文中調用這些函數。然而,對於自旋鎖安全的 GPIO，在板子
+啓動的早期、進程啓動前使用他們也是可以的。
+
+對於作爲輸出的 GPIO，爲其提供初始輸出值，對於避免在系統啓動期間出現
+信號毛刺是很有幫助的。
+
+爲了與傳統的 GPIO 接口兼容, 在設置一個 GPIO 方向時，如果它還未被申請，
+則隱含了申請那個 GPIO 的操作(見下文)。這種兼容性正在從可選的 gpiolib
+框架中移除。
+
+如果這個 GPIO 編碼不存在，或者特定的 GPIO 不能用於那種模式，則方向
+設置可能失敗。依賴啓動固件來正確地設置方向通常是一個壞主意，因爲它可能
+除了啓動Linux，並沒有做更多的驗證工作。(同理, 板子的啓動代碼可能需要
+將這個復用的引腳設置爲 GPIO，並正確地配置上拉/下拉電阻。)
+
+
+訪問自旋鎖安全的 GPIO
+-------------------
+大多數 GPIO 控制器可以通過內存讀/寫指令來訪問。這些指令不會休眠,可以
+安全地在硬(非線程)中斷例程和類似的上下文中完成。
+
+對於那些用 gpio_cansleep()測試總是返回失敗的 GPIO(見下文)，使用
+以下的函數訪問:
+
+	/* GPIO 輸入:返回零或非零 */
+	int gpio_get_value(unsigned gpio);
+
+	/* GPIO 輸出 */
+	void gpio_set_value(unsigned gpio, int value);
+
+GPIO值是布爾值，零表示低電平，非零表示高電平。當讀取一個輸出引腳的值時，
+返回值應該是引腳上的值。這個值不總是和輸出值相符，因爲存在開漏輸出信號和
+輸出延遲問題。
+
+以上的 get/set 函數無錯誤返回值，因爲之前 gpio_direction_*()應已檢查過
+其是否爲「無效GPIO」。此外，還需要注意的是並不是所有平台都可以從輸出引腳
+中讀取數據，對於不能讀取的引腳應總返回零。另外，對那些在原子上下文中無法
+安全訪問的 GPIO (譯者註：因爲訪問可能導致休眠)使用這些函數是不合適的
+(見下文)。
+
+在 GPIO 編號(還有輸出、值)爲常數的情況下,鼓勵通過平台特定的實現來優化
+這兩個函數來訪問 GPIO 值。這種情況(讀寫一個硬體寄存器)下只需要幾條指令
+是很正常的,且無須自旋鎖。這種優化函數比起那些在子程序上花費許多指令的
+函數可以使得模擬接口(譯者注:例如 GPIO 模擬 I2C、1-wire 或 SPI)的
+應用(在空間和時間上都)更具效率。
+
+
+訪問可能休眠的 GPIO
+-----------------
+某些 GPIO 控制器必須通過基於總線(如 I2C 或 SPI)的消息訪問。讀或寫這些
+GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其反饋。期間需要
+休眠，這不能在 IRQ 例程(中斷上下文)中執行。
+
+支持此類 GPIO 的平台通過以下函數返回非零值來區分出這種 GPIO。(此函數需要
+一個之前通過 gpio_request 分配到的有效 GPIO 編號):
+
+	int gpio_cansleep(unsigned gpio);
+
+爲了訪問這種 GPIO,內核定義了一套不同的函數:
+
+	/* GPIO 輸入:返回零或非零 ,可能會休眠 */
+	int gpio_get_value_cansleep(unsigned gpio);
+
+	/* GPIO 輸出,可能會休眠 */
+	void gpio_set_value_cansleep(unsigned gpio, int value);
+
+
+訪問這樣的 GPIO 需要一個允許休眠的上下文，例如線程 IRQ 處理例程，並用以上的
+訪問函數替換那些沒有 cansleep()後綴的自旋鎖安全訪問函數。
+
+除了這些訪問函數可能休眠，且它們操作的 GPIO 不能在硬體 IRQ 處理例程中訪問的
+事實，這些處理例程實際上和自旋鎖安全的函數是一樣的。
+
+** 除此之外 ** 調用設置和配置此類 GPIO 的函數也必須在允許休眠的上下文中，
+因爲它們可能也需要訪問 GPIO 控制器晶片: (這些設置函數通常在板級啓動代碼或者
+驅動探測/斷開代碼中，所以這是一個容易滿足的約束條件。)
+
+	gpio_direction_input()
+	gpio_direction_output()
+	gpio_request()
+
+## 	gpio_request_one()
+##	gpio_request_array()
+## 	gpio_free_array()
+
+	gpio_free()
+	gpio_set_debounce()
+
+
+
+聲明和釋放 GPIO
+----------------------------
+爲了有助於捕獲系統配置錯誤,定義了兩個函數。
+
+	/* 申請 GPIO, 返回 0 或負的錯誤代碼.
+	 * 非空標籤可能有助於診斷.
+	 */
+	int gpio_request(unsigned gpio, const char *label);
+
+	/* 釋放之前聲明的 GPIO */
+	void gpio_free(unsigned gpio);
+
+將無效的 GPIO 編碼傳遞給 gpio_request()會導致失敗，申請一個已使用這個
+函數聲明過的 GPIO 也會失敗。gpio_request()的返回值必須檢查。你應該在
+進程上下文中調用這些函數。然而,對於自旋鎖安全的 GPIO,在板子啓動的早期、
+進入進程之前是可以申請的。
+
+這個函數完成兩個基本的目標。一是標識那些實際上已作爲 GPIO 使用的信號線，
+這樣便於更好地診斷;系統可能需要服務幾百個可用的 GPIO，但是對於任何一個
+給定的電路板通常只有一些被使用。另一個目的是捕獲衝突，查明錯誤:如兩個或
+更多驅動錯誤地認爲他們已經獨占了某個信號線,或是錯誤地認爲移除一個管理著
+某個已激活信號的驅動是安全的。也就是說，申請 GPIO 的作用類似一種鎖機制。
+
+某些平台可能也使用 GPIO 作爲電源管理激活信號(例如通過關閉未使用晶片區和
+簡單地關閉未使用時鐘)。
+
+對於 GPIO 使用 pinctrl 子系統已知的引腳，子系統應該被告知其使用情況；
+一個 gpiolib 驅動的 .request()操作應調用 pinctrl_gpio_request()，
+而 gpiolib 驅動的 .free()操作應調用 pinctrl_gpio_free()。pinctrl
+子系統允許 pinctrl_gpio_request()在某個引腳或引腳組以復用形式「屬於」
+一個設備時都成功返回。
+
+任何須將 GPIO 信號導向適當引腳的引腳復用硬體的編程應該發生在 GPIO
+驅動的 .direction_input()或 .direction_output()函數中，以及
+任何輸出 GPIO 值的設置之後。這樣可使從引腳特殊功能到 GPIO 的轉換
+不會在引腳產生毛刺波形。有時當用一個 GPIO 實現其信號驅動一個非 GPIO
+硬體模塊的解決方案時，就需要這種機制。
+
+某些平台允許部分或所有 GPIO 信號使用不同的引腳。類似的，GPIO 或引腳的
+其他方面也需要配置，如上拉/下拉。平台軟體應該在對這些 GPIO 調用
+gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映射表，
+使得 GPIO 的用戶無須關注這些細節。
+
+還有一個值得注意的是在釋放 GPIO 前，你必須停止使用它。
+
+
+注意:申請一個 GPIO 並沒有以任何方式配置它，只不過標識那個 GPIO 處於使用
+狀態。必須有另外的代碼來處理引腳配置(如控制 GPIO 使用的引腳、上拉/下拉)。
+考慮到大多數情況下聲明 GPIO 之後就會立即配置它們,所以定義了以下三個輔助函數:
+
+	/* 申請一個 GPIO 信號, 同時通過特定的'flags'初始化配置,
+	 * 其他和 gpio_request()的參數和返回值相同
+	 *
+	 */
+	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
+
+	/* 在單個函數中申請多個 GPIO
+	 */
+	int gpio_request_array(struct gpio *array, size_t num);
+
+	/* 在單個函數中釋放多個 GPIO
+	 */
+	void gpio_free_array(struct gpio *array, size_t num);
+
+這裡 'flags' 當前定義可指定以下屬性:
+
+	* GPIOF_DIR_IN		- 配置方向爲輸入
+	* GPIOF_DIR_OUT		- 配置方向爲輸出
+
+	* GPIOF_INIT_LOW	- 在作爲輸出時,初始值爲低電平
+	* GPIOF_INIT_HIGH	- 在作爲輸出時,初始值爲高電平
+	* GPIOF_OPEN_DRAIN	- gpio引腳爲開漏信號
+	* GPIOF_OPEN_SOURCE	- gpio引腳爲源極開路信號
+
+	* GPIOF_EXPORT_DIR_FIXED	- 將 gpio 導出到 sysfs，並保持方向
+	* GPIOF_EXPORT_DIR_CHANGEABLE	- 同樣是導出, 但允許改變方向
+
+因爲 GPIOF_INIT_* 僅有在配置爲輸出的時候才存在,所以有效的組合爲:
+
+	* GPIOF_IN		- 配置爲輸入
+	* GPIOF_OUT_INIT_LOW	- 配置爲輸出,並初始化爲低電平
+	* GPIOF_OUT_INIT_HIGH	- 配置爲輸出,並初始化爲高電平
+
+當設置 flag 爲 GPIOF_OPEN_DRAIN 時，則假設引腳是開漏信號。這樣的引腳
+將不會在輸出模式下置1。這樣的引腳需要連接上拉電阻。通過使能這個標誌，gpio庫
+將會在被要求輸出模式下置1時將引腳變爲輸入狀態來使引腳置高。引腳在輸出模式下
+通過置0使其輸出低電平。
+
+當設置 flag 爲 GPIOF_OPEN_SOURCE 時，則假設引腳爲源極開路信號。這樣的引腳
+將不會在輸出模式下置0。這樣的引腳需要連接下拉電阻。通過使能這個標誌，gpio庫
+將會在被要求輸出模式下置0時將引腳變爲輸入狀態來使引腳置低。引腳在輸出模式下
+通過置1使其輸出高電平。
+
+將來這些標誌可能擴展到支持更多的屬性。
+
+更進一步,爲了更簡單地聲明/釋放多個 GPIO,'struct gpio'被引進來封裝所有
+這三個領域:
+
+	struct gpio {
+		unsigned	gpio;
+		unsigned long	flags;
+		const char	*label;
+	};
+
+一個典型的用例:
+
+	static struct gpio leds_gpios[] = {
+		{ 32, GPIOF_OUT_INIT_HIGH, "Power LED" }, /* 默認開啓 */
+		{ 33, GPIOF_OUT_INIT_LOW,  "Green LED" }, /* 默認關閉 */
+		{ 34, GPIOF_OUT_INIT_LOW,  "Red LED"   }, /* 默認關閉 */
+		{ 35, GPIOF_OUT_INIT_LOW,  "Blue LED"  }, /* 默認關閉 */
+		{ ... },
+	};
+
+	err = gpio_request_one(31, GPIOF_IN, "Reset Button");
+	if (err)
+		...
+
+	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
+	if (err)
+		...
+
+	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
+
+
+GPIO 映射到 IRQ
+--------------------
+GPIO 編號是無符號整數;IRQ 編號也是。這些構成了兩個邏輯上不同的命名空間
+(GPIO 0 不一定使用 IRQ 0)。你可以通過以下函數在它們之間實現映射:
+
+	/* 映射 GPIO 編號到 IRQ 編號 */
+	int gpio_to_irq(unsigned gpio);
+
+	/* 映射 IRQ 編號到 GPIO 編號 (儘量避免使用) */
+	int irq_to_gpio(unsigned irq);
+
+它們的返回值爲對應命名空間的相關編號，或是負的錯誤代碼(如果無法映射)。
+(例如,某些 GPIO 無法做爲 IRQ 使用。)以下的編號錯誤是未經檢測的:使用一個
+未通過 gpio_direction_input()配置爲輸入的 GPIO 編號，或者使用一個
+並非來源於gpio_to_irq()的 IRQ 編號。
+
+這兩個映射函數可能會在信號編號的加減計算過程上花些時間。它們不可休眠。
+
+gpio_to_irq()返回的非錯誤值可以傳遞給 request_irq()或者 free_irq()。
+它們通常通過板級特定的初始化代碼存放到平台設備的 IRQ 資源中。注意:IRQ
+觸發選項是 IRQ 接口的一部分，如 IRQF_TRIGGER_FALLING，系統喚醒能力
+也是如此。
+
+irq_to_gpio()返回的非錯誤值大多數通常可以被 gpio_get_value()所使用，
+比如在 IRQ 是沿觸發時初始化或更新驅動狀態。注意某些平台不支持反映射,所以
+你應該儘量避免使用它。
+
+
+模擬開漏信號
+----------------------------
+有時在只有低電平信號作爲實際驅動結果(譯者注:多個輸出連接於一點，邏輯電平
+結果爲所有輸出的邏輯與)的時候,共享的信號線需要使用「開漏」信號。(該術語
+適用於 CMOS 管；而 TTL 用「集電極開路」。)一個上拉電阻使信號爲高電平。這
+有時被稱爲「線與」。實際上，從負邏輯(低電平爲真)的角度來看，這是一個「線或」。
+
+一個開漏信號的常見例子是共享的低電平使能 IRQ 信號線。此外,有時雙向數據總線
+信號也使用漏極開路信號。
+
+某些 GPIO 控制器直接支持開漏輸出，還有許多不支持。當你需要開漏信號，但
+硬體又不直接支持的時候，一個常用的方法是用任何即可作輸入也可作輸出的 GPIO
+引腳來模擬:
+
+ LOW:	gpio_direction_output(gpio, 0) ... 這代碼驅動信號並覆蓋
+	上拉配置。
+
+ HIGH:	gpio_direction_input(gpio) ... 這代碼關閉輸出,所以上拉電阻
+	(或其他的一些器件)控制了信號。
+
+如果你將信號線「驅動」爲高電平，但是 gpio_get_value(gpio)報告了一個
+低電平(在適當的上升時間後)，你就可以知道是其他的一些組件將共享信號線拉低了。
+這不一定是錯誤的。一個常見的例子就是 I2C 時鐘的延長：一個需要較慢時鐘的
+從設備延遲 SCK 的上升沿，而 I2C 主設備相應地調整其信號傳輸速率。
+
+
+這些公約忽略了什麼?
+================
+這些公約忽略的最大一件事就是引腳復用，因爲這屬於高度晶片特定的屬性且
+沒有可移植性。某個平台可能不需要明確的復用信息；有的對於任意給定的引腳
+可能只有兩個功能選項；有的可能每個引腳有八個功能選項；有的可能可以將
+幾個引腳中的任何一個作爲給定的 GPIO。(是的，這些例子都來自於當前運行
+Linux 的系統。)
+
+在某些系統中,與引腳復用相關的是配置和使能集成的上、下拉模式。並不是所有
+平台都支持這種模式,或者不會以相同的方式來支持這種模式；且任何給定的電路板
+可能使用外置的上拉(或下拉)電阻,這時晶片上的就不應該使用。(當一個電路需要
+5kOhm 的拉動電阻,晶片上的 100 kOhm 電阻就不能做到。)同樣的，驅動能力
+(2 mA vs 20 mA)和電壓(1.8V vs 3.3V)是平台特定問題,就像模型一樣在
+可配置引腳和 GPIO 之間(沒)有一一對應的關係。
+
+還有其他一些系統特定的機制沒有在這裡指出，例如上述的輸入去毛刺和線與輸出
+選項。硬體可能支持批量讀或寫 GPIO，但是那一般是配置相關的：對於處於同一
+塊區(bank)的GPIO。(GPIO 通常以 16 或 32 個組成一個區塊，一個給定的
+片上系統一般有幾個這樣的區塊。)某些系統可以通過輸出 GPIO 觸發 IRQ，
+或者從並非以 GPIO 管理的引腳取值。這些機制的相關代碼沒有必要具有可移植性。
+
+當前，動態定義 GPIO 並不是標準的，例如作爲配置一個帶有某些 GPIO 擴展器的
+附加電路板的副作用。
+
+GPIO 實現者的框架 (可選)
+=====================
+前面提到了，有一個可選的實現框架，讓平台使用相同的編程接口，更加簡單地支持
+不同種類的 GPIO 控制器。這個框架稱爲"gpiolib"。
+
+作爲一個輔助調試功能，如果 debugfs 可用，就會有一個 /sys/kernel/debug/gpio
+文件。通過這個框架，它可以列出所有註冊的控制器,以及當前正在使用中的 GPIO
+的狀態。
+
+
+控制器驅動: gpio_chip
+-------------------
+在框架中每個 GPIO 控制器都包裝爲一個 "struct gpio_chip"，他包含了
+該類型的每個控制器的常用信息:
+
+ - 設置 GPIO 方向的方法
+ - 用於訪問 GPIO 值的方法
+ - 告知調用其方法是否可能休眠的標誌
+ - 可選的 debugfs 信息導出方法 (顯示類似上拉配置一樣的額外狀態)
+ - 診斷標籤
+
+也包含了來自 device.platform_data 的每個實例的數據：它第一個 GPIO 的
+編號和它可用的 GPIO 的數量。
+
+實現 gpio_chip 的代碼應支持多控制器實例，這可能使用驅動模型。那些代碼要
+配置每個 gpio_chip，並發起gpiochip_add()。卸載一個 GPIO 控制器很少見，
+但在必要的時候可以使用 gpiochip_remove()。
+
+大部分 gpio_chip 是一個實例特定結構體的一部分，而並不將 GPIO 接口單獨
+暴露出來,比如編址、電源管理等。類似編解碼器這樣的晶片會有複雜的非 GPIO
+狀態。
+
+任何一個 debugfs 信息導出方法通常應該忽略還未申請作爲 GPIO 的信號線。
+他們可以使用 gpiochip_is_requested()測試，當這個 GPIO 已經申請過了
+就返回相關的標籤，否則返回 NULL。
+
+
+平台支持
+-------
+爲了支持這個框架，一個平台的 Kconfig 文件將會 "select"(選擇)
+ARCH_REQUIRE_GPIOLIB 或 ARCH_WANT_OPTIONAL_GPIOLIB，並讓它的
+<asm/gpio.h> 包含 <asm-generic/gpio.h>，同時定義三個方法:
+gpio_get_value()、gpio_set_value()和 gpio_cansleep()。
+
+它也應提供一個 ARCH_NR_GPIOS 的定義值，這樣可以更好地反映該平台 GPIO
+的實際數量,節省靜態表的空間。(這個定義值應該包含片上系統內建 GPIO 和
+GPIO 擴展器中的數據。)
+
+ARCH_REQUIRE_GPIOLIB 意味著 gpiolib 核心在這個構架中將總是編譯進內核。
+
+ARCH_WANT_OPTIONAL_GPIOLIB 意味著 gpiolib 核心默認關閉,且用戶可以
+使能它,並將其編譯進內核(可選)。
+
+如果這些選項都沒被選擇,該平台就不通過 GPIO-lib 支持 GPIO,且代碼不可以
+被用戶使能。
+
+以下這些方法的實現可以直接使用框架代碼,並總是通過 gpio_chip 調度:
+
+  #define gpio_get_value	__gpio_get_value
+  #define gpio_set_value	__gpio_set_value
+  #define gpio_cansleep		__gpio_cansleep
+
+這些定義可以用更理想的實現方法替代，那就是使用經過邏輯優化的內聯函數來訪問
+基於特定片上系統的 GPIO。例如,若引用的 GPIO (寄存器位偏移)是常量「12」，
+讀取或設置它可能只需少則兩或三個指令，且不會休眠。當這樣的優化無法實現時，
+那些函數必須使用框架提供的代碼，那就至少要幾十條指令才可以實現。對於用 GPIO
+模擬的 I/O 接口, 如此精簡指令是很有意義的。
+
+對於片上系統，平台特定代碼爲片上 GPIO 每個區(bank)定義並註冊 gpio_chip
+實例。那些 GPIO 應該根據晶片廠商的文檔進行編碼/標籤,並直接和電路板原理圖
+對應。他們應該開始於零並終止於平台特定的限制。這些 GPIO(代碼)通常從
+arch_initcall()或者更早的地方集成進平台初始化代碼，使這些 GPIO 總是可用，
+且他們通常可以作爲 IRQ 使用。
+
+板級支持
+-------
+對於外部 GPIO 控制器(例如 I2C 或 SPI 擴展器、專用晶片、多功能器件、FPGA
+或 CPLD)，大多數常用板級特定代碼都可以註冊控制器設備，並保證他們的驅動知道
+gpiochip_add()所使用的 GPIO 編號。他們的起始編號通常跟在平台特定的 GPIO
+編號之後。
+
+例如板級啓動代碼應該創建結構體指明晶片公開的 GPIO 範圍，並使用 platform_data
+將其傳遞給每個 GPIO 擴展器晶片。然後晶片驅動中的 probe()例程可以將這個
+數據傳遞給 gpiochip_add()。
+
+初始化順序很重要。例如，如果一個設備依賴基於 I2C 的(擴展)GPIO，那麼它的
+probe()例程就應該在那個 GPIO 有效以後才可以被調用。這意味著設備應該在
+GPIO 可以工作之後才可被註冊。解決這類依賴的的一種方法是讓這種 gpio_chip
+控制器向板級特定代碼提供 setup()和 teardown()回調函數。一旦所有必須的
+資源可用之後，這些板級特定的回調函數將會註冊設備，並可以在這些 GPIO 控制器
+設備變成無效時移除它們。
+
+
+用戶空間的 Sysfs 接口(可選)
+========================
+使用「gpiolib」實現框架的平台可以選擇配置一個 GPIO 的 sysfs 用戶接口。
+這不同於 debugfs 接口，因爲它提供的是對 GPIO方向和值的控制，而不只顯示
+一個GPIO 的狀態摘要。此外,它可以出現在沒有調試支持的產品級系統中。
+
+例如，通過適當的系統硬體文檔，用戶空間可以知道 GIOP #23 控制 Flash
+存儲器的防寫(用於保護其中 Bootloader 分區)。產品的系統升級可能需要
+臨時解除這個保護：首先導入一個 GPIO，改變其輸出狀態，然後在重新使能防寫
+前升級代碼。通常情況下,GPIO #23 是不會被觸及的，並且內核也不需要知道他。
+
+根據適當的硬體文檔，某些系統的用戶空間 GPIO 可以用於確定系統配置數據，
+這些數據是標準內核不知道的。在某些任務中，簡單的用戶空間 GPIO 驅動可能是
+系統真正需要的。
+
+注意：標準內核驅動中已經存在通用的「LED 和按鍵」GPIO 任務，分別是:
+"leds-gpio" 和 "gpio_keys"。請使用這些來替代直接訪問 GPIO，因爲集成在
+內核框架中的這類驅動比你在用戶空間的代碼更好。
+
+
+Sysfs 中的路徑
+--------------
+在/sys/class/gpio 中有 3 類入口:
+
+   -	用於在用戶空間控制 GPIO 的控制接口;
+
+   -	GPIOs 本身;以及
+
+   -	GPIO 控制器 ("gpio_chip" 實例)。
+
+除了這些標準的文件,還包含「device」符號連結。
+
+控制接口是只寫的:
+
+    /sys/class/gpio/
+
+    	"export" ... 用戶空間可以通過寫其編號到這個文件，要求內核導出
+		一個 GPIO 的控制到用戶空間。
+
+		例如: 如果內核代碼沒有申請 GPIO #19,"echo 19 > export"
+		將會爲 GPIO #19 創建一個 "gpio19" 節點。
+
+    	"unexport" ... 導出到用戶空間的逆操作。
+
+		例如: "echo 19 > unexport" 將會移除使用"export"文件導出的
+		"gpio19" 節點。
+
+GPIO 信號的路徑類似 /sys/class/gpio/gpio42/ (對於 GPIO #42 來說)，
+並有如下的讀/寫屬性:
+
+    /sys/class/gpio/gpioN/
+
+	"direction" ... 讀取得到 "in" 或 "out"。這個值通常運行寫入。
+		寫入"out" 時,其引腳的默認輸出爲低電平。爲了確保無故障運行，
+		"low" 或 "high" 的電平值應該寫入 GPIO 的配置，作爲初始輸出值。
+
+		注意:如果內核不支持改變 GPIO 的方向，或者在導出時內核代碼沒有
+		明確允許用戶空間可以重新配置 GPIO 方向，那麼這個屬性將不存在。
+
+	"value" ... 讀取得到 0 (低電平) 或 1 (高電平)。如果 GPIO 配置爲
+		輸出,這個值允許寫操作。任何非零值都以高電平看待。
+
+		如果引腳可以配置爲中斷信號，且如果已經配置了產生中斷的模式
+		（見"edge"的描述），你可以對這個文件使用輪詢操作(poll(2))，
+		且輪詢操作會在任何中斷觸發時返回。如果你使用輪詢操作(poll(2))，
+		請在 events 中設置 POLLPRI 和 POLLERR。如果你使用輪詢操作
+		(select(2))，請在 exceptfds 設置你期望的文件描述符。在
+		輪詢操作(poll(2))返回之後，既可以通過 lseek(2)操作讀取
+		sysfs 文件的開始部分，也可以關閉這個文件並重新打開它來讀取數據。
+
+	"edge" ... 讀取得到「none」、「rising」、「falling」或者「both」。
+		將這些字符串寫入這個文件可以選擇沿觸發模式，會使得輪詢操作
+		(select(2))在"value"文件中返回。
+
+		這個文件僅有在這個引腳可以配置爲可產生中斷輸入引腳時，才存在。
+
+	"active_low" ... 讀取得到 0 (假) 或 1 (真)。寫入任何非零值可以
+		翻轉這個屬性的(讀寫)值。已存在或之後通過"edge"屬性設置了"rising"
+		和 "falling" 沿觸發模式的輪詢操作(poll(2))將會遵循這個設置。
+
+GPIO 控制器的路徑類似 /sys/class/gpio/gpiochip42/ (對於從#42 GPIO
+開始實現控制的控制器),並有著以下只讀屬性:
+
+    /sys/class/gpio/gpiochipN/
+
+    	"base" ... 與以上的 N 相同,代表此晶片管理的第一個 GPIO 的編號
+
+    	"label" ... 用於診斷 (並不總是只有唯一值)
+
+    	"ngpio" ... 此控制器所管理的 GPIO 數量(而 GPIO 編號從 N 到
+    		N + ngpio - 1)
+
+大多數情況下,電路板的文檔應當標明每個 GPIO 的使用目的。但是那些編號並不總是
+固定的,例如在擴展卡上的 GPIO會根據所使用的主板或所在堆疊架構中其他的板子而
+有所不同。在這種情況下,你可能需要使用 gpiochip 節點(儘可能地結合電路圖)來
+確定給定信號所用的 GPIO 編號。
+
+
+從內核代碼中導出
+-------------
+內核代碼可以明確地管理那些已通過 gpio_request()申請的 GPIO 的導出:
+
+	/* 導出 GPIO 到用戶空間 */
+	int gpio_export(unsigned gpio, bool direction_may_change);
+
+	/* gpio_export()的逆操作 */
+	void gpio_unexport();
+
+	/* 創建一個 sysfs 連接到已導出的 GPIO 節點 */
+	int gpio_export_link(struct device *dev, const char *name,
+		unsigned gpio)
+
+在一個內核驅動申請一個 GPIO 之後，它可以通過 gpio_export()使其在 sysfs
+接口中可見。該驅動可以控制信號方向是否可修改。這有助於防止用戶空間代碼無意間
+破壞重要的系統狀態。
+
+這個明確的導出有助於(通過使某些實驗更容易來)調試，也可以提供一個始終存在的接口，
+與文檔配合作爲板級支持包的一部分。
+
+在 GPIO 被導出之後，gpio_export_link()允許在 sysfs 文件系統的任何地方
+創建一個到這個 GPIO sysfs 節點的符號連結。這樣驅動就可以通過一個描述性的
+名字，在 sysfs 中他們所擁有的設備下提供一個(到這個 GPIO sysfs 節點的)接口。
+
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
new file mode 100644
index 000000000000..cab58e428825
--- /dev/null
+++ b/Documentation/translations/zh_TW/index.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. raw:: latex
+
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+	\kerneldocCJKon
+
+.. _linux_doc_zh_tw:
+
+繁體中文翻譯
+============
+
+
+.. note::
+   內核文檔繁體中文版的翻譯工作正在進行中。如果您願意並且有時間參與這項工
+   作，歡迎提交補丁給胡皓文 <src.res@email.cn>。
+
+許可證文檔
+----------
+
+下面的文檔介紹了Linux內核原始碼的許可證（GPLv2）、如何在原始碼樹中正確標記
+單個文件的許可證、以及指向完整許可證文本的連結。
+
+TODOList:
+
+* Documentation/translations/zh_TW/process/license-rules.rst
+
+用戶文檔
+--------
+
+下面的手冊是爲內核用戶編寫的——即那些試圖讓它在給定系統上以最佳方式工作的
+用戶。
+
+.. toctree::
+   :maxdepth: 2
+
+   admin-guide/index
+
+TODOList:
+
+* kbuild/index
+
+固件相關文檔
+------------
+
+下列文檔描述了內核需要的平台固件相關信息。
+
+TODOList:
+
+* firmware-guide/index
+* devicetree/index
+
+應用程式開發人員文檔
+--------------------
+
+用戶空間API手冊涵蓋了描述應用程式開發人員可見內核接口方面的文檔。
+
+TODOlist:
+
+* userspace-api/index
+
+內核開發簡介
+------------
+
+這些手冊包含有關如何開發內核的整體信息。內核社區非常龐大，一年下來有數千名
+開發人員做出貢獻。與任何大型社區一樣，知道如何完成任務將使得更改合併的過程
+變得更加容易。
+
+TODOList:
+
+* process/index
+* dev-tools/index
+* doc-guide/index
+* kernel-hacking/index
+* trace/index
+* maintainer/index
+* fault-injection/index
+* livepatch/index
+* rust/index
+
+內核API文檔
+-----------
+
+以下手冊從內核開發人員的角度詳細介紹了特定的內核子系統是如何工作的。這裡的
+大部分信息都是直接從內核原始碼獲取的，並根據需要添加補充材料（或者至少是在
+我們設法添加的時候——可能不是所有的都是有需要的）。
+
+TODOList:
+
+* driver-api/index
+* core-api/index
+* locking/index
+* accounting/index
+* block/index
+* cdrom/index
+* cpu-freq/index
+* ide/index
+* fb/index
+* fpga/index
+* hid/index
+* i2c/index
+* iio/index
+* isdn/index
+* infiniband/index
+* leds/index
+* netlabel/index
+* networking/index
+* pcmcia/index
+* power/index
+* target/index
+* timers/index
+* spi/index
+* w1/index
+* watchdog/index
+* virt/index
+* input/index
+* hwmon/index
+* gpu/index
+* security/index
+* sound/index
+* crypto/index
+* filesystems/index
+* vm/index
+* bpf/index
+* usb/index
+* PCI/index
+* scsi/index
+* misc-devices/index
+* scheduler/index
+* mhi/index
+
+體系結構無關文檔
+----------------
+
+TODOList:
+
+* asm-annotations
+
+特定體系結構文檔
+----------------
+
+TODOList:
+
+* arch
+
+其他文檔
+--------
+
+有幾份未排序的文檔似乎不適合放在文檔的其他部分，或者可能需要進行一些調整和/或
+轉換爲reStructureText格式，也有可能太舊。
+
+TODOList:
+
+* staging/index
+* watch_queue
+
+目錄和表格
+----------
+
+* :ref:`genindex`
+
diff --git a/Documentation/translations/zh_TW/io_ordering.txt b/Documentation/translations/zh_TW/io_ordering.txt
new file mode 100644
index 000000000000..1e99206c8421
--- /dev/null
+++ b/Documentation/translations/zh_TW/io_ordering.txt
@@ -0,0 +1,68 @@
+Chinese translated version of Documentation/driver-api/io_ordering.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/driver-api/io_ordering.rst 的繁體中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
+者翻譯存在問題，請聯繫繁體中文版維護者。
+
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+
+
+以下爲正文
+---------------------------------------------------------------------
+
+在某些平台上，所謂的內存映射I/O是弱順序。在這些平台上，驅動開發者有責任
+保證I/O內存映射地址的寫操作按程序圖意的順序達到設備。通常讀取一個「安全」
+設備寄存器或橋寄存器，觸發IO晶片清刷未處理的寫操作到達設備後才處理讀操作，
+而達到保證目的。驅動程序通常在spinlock保護的臨界區退出之前使用這種技術。
+這也可以保證後面的寫操作只在前面的寫操作之後到達設備（這非常類似於內存
+屏障操作，mb()，不過僅適用於I/O）。
+
+假設一個設備驅動程的具體例子：
+
+        ...
+CPU A:  spin_lock_irqsave(&dev_lock, flags)
+CPU A:  val = readl(my_status);
+CPU A:  ...
+CPU A:  writel(newval, ring_ptr);
+CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+        ...
+CPU B:  spin_lock_irqsave(&dev_lock, flags)
+CPU B:  val = readl(my_status);
+CPU B:  ...
+CPU B:  writel(newval2, ring_ptr);
+CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
+        ...
+
+上述例子中，設備可能會先接收到newval2的值，然後接收到newval的值，問題就
+發生了。不過很容易通過下面方法來修復：
+
+        ...
+CPU A:  spin_lock_irqsave(&dev_lock, flags)
+CPU A:  val = readl(my_status);
+CPU A:  ...
+CPU A:  writel(newval, ring_ptr);
+CPU A:  (void)readl(safe_register); /* 配置寄存器？*/
+CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+        ...
+CPU B:  spin_lock_irqsave(&dev_lock, flags)
+CPU B:  val = readl(my_status);
+CPU B:  ...
+CPU B:  writel(newval2, ring_ptr);
+CPU B:  (void)readl(safe_register); /* 配置寄存器？*/
+CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
+
+在解決方案中，讀取safe_register寄存器，觸發IO晶片清刷未處理的寫操作，
+再處理後面的讀操作，防止引發數據不一致問題。
+
diff --git a/Documentation/translations/zh_TW/oops-tracing.txt b/Documentation/translations/zh_TW/oops-tracing.txt
new file mode 100644
index 000000000000..be8e59f2abaf
--- /dev/null
+++ b/Documentation/translations/zh_TW/oops-tracing.txt
@@ -0,0 +1,212 @@
+Chinese translated version of Documentation/admin-guide/bug-hunting.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Traditional Chinese maintainer:  Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/admin-guide/bug-hunting.rst 的繁體中文版翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
+者翻譯存在問題，請聯繫繁體中文版維護者。
+
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+
+以下爲正文
+---------------------------------------------------------------------
+
+注意： ksymoops 在2.6中是沒有用的。 請以原有格式使用Oops(來自dmesg，等等)。
+忽略任何這樣那樣關於「解碼Oops」或者「通過ksymoops運行」的文檔。 如果你貼出運行過
+ksymoops的來自2.6的Oops，人們只會讓你重貼一次。
+
+快速總結
+-------------
+
+發現Oops並發送給看似相關的內核領域的維護者。別太擔心對不上號。如果你不確定就發給
+和你所做的事情相關的代碼的負責人。 如果可重現試著描述怎樣重構。 那甚至比oops更有
+價值。
+
+如果你對於發送給誰一無所知， 發給linux-kernel@vger.kernel.org。感謝你幫助Linux
+儘可能地穩定。
+
+Oops在哪裡?
+----------------------
+
+通常Oops文本由klogd從內核緩衝區里讀取並傳給syslogd，由syslogd寫到syslog文件中，
+典型地是/var/log/messages(依賴於/etc/syslog.conf)。有時klogd崩潰了,這種情況下你
+能夠運行dmesg > file來從內核緩衝區中讀取數據並保存下來。 否則你可以
+cat /proc/kmsg > file， 然而你必須介入中止傳輸， kmsg是一個「永不結束的文件」。如
+果機器崩潰壞到你不能輸入命令或者磁碟不可用那麼你有三種選擇:-
+
+（1） 手抄屏幕上的文本待機器重啓後再輸入計算機。 麻煩但如果沒有針對崩潰的準備，
+這是僅有的選擇。 另外，你可以用數位相機把屏幕拍下來-不太好，但比沒有強。 如果信
+息滾動到了終端的上面，你會發現以高分辯率啓動（比如，vga=791）會讓你讀到更多的文
+本。（注意：這需要vesafb，所以對『早期』的oops沒有幫助）
+
+（2）用串口終端啓動（請參看Documentation/admin-guide/serial-console.rst），運行一個null
+modem到另一台機器並用你喜歡的通訊工具獲取輸出。Minicom工作地很好。
+
+（3）使用Kdump（請參看Documentation/admin-guide/kdump/kdump.rst），
+使用在Documentation/admin-guide/kdump/gdbmacros.txt中定義的dmesg gdb宏，從舊的內存中提取內核
+環形緩衝區。
+
+完整信息
+----------------
+
+注意：以下來自於Linus的郵件適用於2.4內核。 我因爲歷史原因保留了它，並且因爲其中
+一些信息仍然適用。 特別注意的是，請忽略任何ksymoops的引用。
+
+From: Linus Torvalds <torvalds@osdl.org>
+
+怎樣跟蹤Oops.. [原發到linux-kernel的一封郵件]
+
+主要的竅門是有五年和這些煩人的oops消息打交道的經驗;-)
+
+實際上，你有辦法使它更簡單。我有兩個不同的方法：
+
+	gdb /usr/src/linux/vmlinux
+	gdb> disassemble <offending_function>
+
+那是發現問題的簡單辦法，至少如果bug報告做的好的情況下（象這個一樣-運行ksymoops
+得到oops發生的函數及函數內的偏移）。
+
+哦，如果報告發生的內核以相同的編譯器和相似的配置編譯它會有幫助的。
+
+另一件要做的事是反彙編bug報告的「Code」部分：ksymoops也會用正確的工具來做這件事，
+但如果沒有那些工具你可以寫一個傻程序：
+
+	char str[] = "\xXX\xXX\xXX...";
+	main(){}
+
+並用gcc -g編譯它然後執行「disassemble str」（XX部分是由Oops報告的值-你可以僅剪切
+粘貼並用「\x」替換空格-我就是這麼做的，因爲我懶得寫程序自動做這一切）。
+
+另外，你可以用scripts/decodecode這個shell腳本。它的使用方法是：
+decodecode < oops.txt
+
+「Code」之後的十六進位字節可能（在某些架構上）有一些當前指令之前的指令字節以及
+當前和之後的指令字節
+
+Code: f9 0f 8d f9 00 00 00 8d 42 0c e8 dd 26 11 c7 a1 60 ea 2b f9 8b 50 08 a1
+64 ea 2b f9 8d 34 82 8b 1e 85 db 74 6d 8b 15 60 ea 2b f9 <8b> 43 04 39 42 54
+7e 04 40 89 42 54 8b 43 04 3b 05 00 f6 52 c0
+
+最後，如果你想知道代碼來自哪裡，你可以：
+
+	cd /usr/src/linux
+	make fs/buffer.s 	# 或任何產生BUG的文件
+
+然後你會比gdb反彙編更清楚的知道發生了什麼。
+
+現在，問題是把你所擁有的所有數據結合起來：C源碼（關於它應該怎樣的一般知識），
+彙編代碼及其反彙編得到的代碼（另外還有從「oops」消息得到的寄存器狀態-對了解毀壞的
+指針有用，而且當你有了彙編代碼你也能拿其它的寄存器和任何它們對應的C表達式做匹配
+）。
+
+實際上，你僅需看看哪裡不匹配（這個例子是「Code」反彙編和編譯器生成的代碼不匹配）。
+然後你須要找出爲什麼不匹配。通常很簡單-你看到代碼使用了空指針然後你看代碼想知道
+空指針是怎麼出現的，還有檢查它是否合法..
+
+現在，如果明白這是一項耗時的工作而且需要一丁點兒的專心，沒錯。這就是我爲什麼大多
+只是忽略那些沒有符號表信息的崩潰報告的原因：簡單的說太難查找了（我有一些
+程序用於在內核代碼段中搜索特定的模式，而且有時我也已經能找出那些崩潰的地方，但是
+僅僅是找出正確的序列也確實需要相當紮實的內核知識）
+
+_有時_會發生這種情況，我僅看到崩潰中的反彙編代碼序列， 然後我馬上就明白問題出在
+哪裡。這時我才意識到自己幹這個工作已經太長時間了;-)
+
+		Linus
+
+
+---------------------------------------------------------------------------
+關於Oops跟蹤的註解：
+
+爲了幫助Linus和其它內核開發者，klogd納入了大量的支持來處理保護錯誤。爲了擁有對
+地址解析的完整支持至少應該使用1.3-pl3的sysklogd包。
+
+當保護錯誤發生時，klogd守護進程自動把內核日誌信息中的重要地址翻譯成它們相應的符
+號。
+
+klogd執行兩種類型的地址解析。首先是靜態翻譯其次是動態翻譯。靜態翻譯和ksymoops
+一樣使用System.map文件。爲了做靜態翻譯klogd守護進程必須在初始化時能找到system
+map文件。關於klogd怎樣搜索map文件請參看klogd手冊頁。
+
+動態地址翻譯在使用內核可裝載模塊時很重要。 因爲內核模塊的內存是從內核動態內存池
+里分配的，所以不管是模塊開始位置還是模塊中函數和符號的位置都不是固定的。
+
+內核支持允許程序決定裝載哪些模塊和它們在內存中位置的系統調用。使用這些系統調用
+klogd守護進程生成一張符號表用於調試發生在可裝載模塊中的保護錯誤。
+
+至少klogd會提供產生保護錯誤的模塊名。還可有額外的符號信息供可裝載模塊開發者選擇
+以從模塊中輸出符號信息。
+
+因爲內核模塊環境可能是動態的，所以必須有一種機制當模塊環境發生改變時來通知klogd
+守護進程。 有一些可用的命令行選項允許klogd向當前執行中的守護進程發送信號，告知符
+號信息應該被刷新了。 更多信息請參看klogd手冊頁。
+
+sysklogd發布時包含一個補丁修改了modules-2.0.0包，無論何時一個模塊裝載或者卸載都
+會自動向klogd發送信號。打上這個補丁提供了必要的對調試發生於內核可裝載模塊的保護
+錯誤的無縫支持。
+
+以下是被klogd處理過的發生在可裝載模塊中的一個保護錯誤例子：
+---------------------------------------------------------------------------
+Aug 29 09:51:01 blizard kernel: Unable to handle kernel paging request at virtual address f15e97cc
+Aug 29 09:51:01 blizard kernel: current->tss.cr3 = 0062d000, %cr3 = 0062d000
+Aug 29 09:51:01 blizard kernel: *pde = 00000000
+Aug 29 09:51:01 blizard kernel: Oops: 0002
+Aug 29 09:51:01 blizard kernel: CPU:    0
+Aug 29 09:51:01 blizard kernel: EIP:    0010:[oops:_oops+16/3868]
+Aug 29 09:51:01 blizard kernel: EFLAGS: 00010212
+Aug 29 09:51:01 blizard kernel: eax: 315e97cc   ebx: 003a6f80   ecx: 001be77b   edx: 00237c0c
+Aug 29 09:51:01 blizard kernel: esi: 00000000   edi: bffffdb3   ebp: 00589f90   esp: 00589f8c
+Aug 29 09:51:01 blizard kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
+Aug 29 09:51:01 blizard kernel: Process oops_test (pid: 3374, process nr: 21, stackpage=00589000)
+Aug 29 09:51:01 blizard kernel: Stack: 315e97cc 00589f98 0100b0b4 bffffed4 0012e38e 00240c64 003a6f80 00000001
+Aug 29 09:51:01 blizard kernel:        00000000 00237810 bfffff00 0010a7fa 00000003 00000001 00000000 bfffff00
+Aug 29 09:51:01 blizard kernel:        bffffdb3 bffffed4 ffffffda 0000002b 0007002b 0000002b 0000002b 00000036
+Aug 29 09:51:01 blizard kernel: Call Trace: [oops:_oops_ioctl+48/80] [_sys_ioctl+254/272] [_system_call+82/128]
+Aug 29 09:51:01 blizard kernel: Code: c7 00 05 00 00 00 eb 08 90 90 90 90 90 90 90 90 89 ec 5d c3
+---------------------------------------------------------------------------
+
+Dr. G.W. Wettstein           Oncology Research Div. Computing Facility
+Roger Maris Cancer Center    INTERNET: greg@wind.rmcc.com
+820 4th St. N.
+Fargo, ND  58122
+Phone: 701-234-7556
+
+
+---------------------------------------------------------------------------
+受汙染的內核
+
+一些oops報告在程序記數器之後包含字符串'Tainted: '。這表明內核已經被一些東西給汙
+染了。 該字符串之後緊跟著一系列的位置敏感的字符，每個代表一個特定的汙染值。
+
+  1：'G'如果所有裝載的模塊都有GPL或相容的許可證，'P'如果裝載了任何的專有模塊。
+沒有模塊MODULE_LICENSE或者帶有insmod認爲是與GPL不相容的的MODULE_LICENSE的模塊被
+認定是專有的。
+
+  2：'F'如果有任何通過「insmod -f」被強制裝載的模塊，' '如果所有模塊都被正常裝載。
+
+  3：'S'如果oops發生在SMP內核中，運行於沒有證明安全運行多處理器的硬體。 當前這種
+情況僅限於幾種不支持SMP的速龍處理器。
+
+  4：'R'如果模塊通過「insmod -f」被強制裝載，' '如果所有模塊都被正常裝載。
+
+  5：'M'如果任何處理器報告了機器檢查異常，' '如果沒有發生機器檢查異常。
+
+  6：'B'如果頁釋放函數發現了一個錯誤的頁引用或者一些非預期的頁標誌。
+
+  7：'U'如果用戶或者用戶應用程式特別請求設置汙染標誌，否則' '。
+
+  8：'D'如果內核剛剛死掉，比如有OOPS或者BUG。
+
+使用'Tainted: '字符串的主要原因是要告訴內核調試者，這是否是一個乾淨的內核亦或發
+生了任何的不正常的事。汙染是永久的：即使出錯的模塊已經被卸載了，汙染值仍然存在，
+以表明內核不再值得信任。
+
diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/translations/zh_TW/sparse.txt
new file mode 100644
index 000000000000..c9acb2c926cb
--- /dev/null
+++ b/Documentation/translations/zh_TW/sparse.txt
@@ -0,0 +1,91 @@
+﻿Chinese translated version of Documentation/dev-tools/sparse.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/dev-tools/sparse.rst 的繁體中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
+者翻譯存在問題，請聯繫繁體中文版維護者。
+
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+
+以下爲正文
+---------------------------------------------------------------------
+
+Copyright 2004 Linus Torvalds
+Copyright 2004 Pavel Machek <pavel@ucw.cz>
+Copyright 2006 Bob Copeland <me@bobcopeland.com>
+
+使用 sparse 工具做類型檢查
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+"__bitwise" 是一種類型屬性，所以你應該這樣使用它：
+
+        typedef int __bitwise pm_request_t;
+
+        enum pm_request {
+                PM_SUSPEND = (__force pm_request_t) 1,
+                PM_RESUME = (__force pm_request_t) 2
+        };
+
+這樣會使 PM_SUSPEND 和 PM_RESUME 成爲位方式(bitwise)整數（使用"__force"
+是因爲 sparse 會抱怨改變位方式的類型轉換，但是這裡我們確實需要強制進行轉
+換）。而且因爲所有枚舉值都使用了相同的類型，這裡的"enum pm_request"也將
+會使用那個類型做爲底層實現。
+
+而且使用 gcc 編譯的時候，所有的 __bitwise/__force 都會消失，最後在 gcc
+看來它們只不過是普通的整數。
+
+坦白來說，你並不需要使用枚舉類型。上面那些實際都可以濃縮成一個特殊的"int
+__bitwise"類型。
+
+所以更簡單的辦法只要這樣做：
+
+	typedef int __bitwise pm_request_t;
+
+	#define PM_SUSPEND ((__force pm_request_t) 1)
+	#define PM_RESUME ((__force pm_request_t) 2)
+
+現在你就有了嚴格的類型檢查所需要的所有基礎架構。
+
+一個小提醒：常數整數"0"是特殊的。你可以直接把常數零當作位方式整數使用而
+不用擔心 sparse 會抱怨。這是因爲"bitwise"（恰如其名）是用來確保不同位方
+式類型不會被弄混（小尾模式，大尾模式，cpu尾模式，或者其他），對他們來說
+常數"0"確實是特殊的。
+
+獲取 sparse 工具
+~~~~~~~~~~~~~~~~
+
+你可以從 Sparse 的主頁獲取最新的發布版本：
+
+	http://www.kernel.org/pub/linux/kernel/people/josh/sparse/
+
+或者，你也可以使用 git 克隆最新的 sparse 開發版本：
+
+	git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
+
+一旦你下載了源碼，只要以普通用戶身份運行：
+
+	make
+	make install
+
+它將會被自動安裝到你的 ~/bin 目錄下。
+
+使用 sparse 工具
+~~~~~~~~~~~~~~~~
+
+用"make C=1"命令來編譯內核，會對所有重新編譯的 C 文件使用 sparse 工具。
+或者使用"make C=2"命令，無論文件是否被重新編譯都會對其使用 sparse 工具。
+如果你已經編譯了內核，用後一種方式可以很快地檢查整個源碼樹。
+
+make 的可選變量 CHECKFLAGS 可以用來向 sparse 工具傳遞參數。編譯系統會自
+動向 sparse 工具傳遞 -Wbitwise 參數。
+
-- 
2.25.1

