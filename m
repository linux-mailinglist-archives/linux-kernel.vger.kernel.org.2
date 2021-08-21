Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD653F39EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhHUJl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:41:58 -0400
Received: from [43.250.32.171] ([43.250.32.171]:5961 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S233401AbhHUJly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=ynFxv685X4HtqxJFOvTATZaFPsvthr/jrFuJN
        5Kmzsw=; b=i+F/EzekHQm0iJA0pOr389c6eMcAqTcJdQKmviWHMPvzUZroQM1oR
        /x12WRM/VVa3GNrk6N6ucNZQgeSBAlgpo7HDj+MMHm88VOTj4dS2Z4dtRxDifXvH
        aFRs4sxLdS6tQ8LH8Tl6yw+dOoq/rXXS8bv9QhQ/x7z83sTlzQ7+2E=
Received: from localhost.localdomain (unknown [113.251.14.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgD3BAQxyiBh6xE3AA--.56302S2;
        Sat, 21 Aug 2021 17:41:05 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/3] docs/zh_TW: add translations for zh_TW/arm64
Date:   Sat, 21 Aug 2021 17:40:57 +0800
Message-Id: <20210821094059.64300-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgD3BAQxyiBh6xE3AA--.56302S2
X-Coremail-Antispam: 1UD129KBjvAXoWfKFWkKryrAFWftF17trWDArb_yoW7XFWfAo
        ZF93y5Cr4kAF15X3W8Gw47Jry8WrsrCFs7Xr4UKwn0g34jkF4rJ3W8Xw15WrySvr45GFWf
        Ja43Jw4fC3WUJw1kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5-7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
        IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vE
        x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr4
        1l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUnLS
        dPUUUUU==
X-Originating-IP: [113.251.14.129]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new translations for zh_TW/arm64 and link them to index.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../translations/zh_TW/arm64/amu.rst          | 104 ++++++++
 .../translations/zh_TW/arm64/booting.txt      | 251 ++++++++++++++++++
 .../translations/zh_TW/arm64/elf_hwcaps.rst   | 244 +++++++++++++++++
 .../translations/zh_TW/arm64/hugetlbpage.rst  |  49 ++++
 .../translations/zh_TW/arm64/index.rst        |  23 ++
 .../zh_TW/arm64/legacy_instructions.txt       |  77 ++++++
 .../translations/zh_TW/arm64/memory.txt       | 119 +++++++++
 .../translations/zh_TW/arm64/perf.rst         |  88 ++++++
 .../zh_TW/arm64/silicon-errata.txt            |  79 ++++++
 .../zh_TW/arm64/tagged-pointers.txt           |  57 ++++
 Documentation/translations/zh_TW/index.rst    |   5 +
 11 files changed, 1096 insertions(+)
 create mode 100644 Documentation/translations/zh_TW/arm64/amu.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/booting.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/hugetlbpage.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/index.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/legacy_instructions.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/memory.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/perf.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/silicon-errata.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/tagged-pointers.txt

diff --git a/Documentation/translations/zh_TW/arm64/amu.rst b/Documentation/translations/zh_TW/arm64/amu.rst
new file mode 100644
index 000000000000..ffdc466e0f62
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/amu.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/arm64/amu.rst <amu_index>`
+
+Translator: Bailu Lin <bailu.lin@vivo.com>
+            Hu Haowen <src.res@email.cn>
+
+==================================
+AArch64 Linux 中擴展的活動監控單元
+==================================
+
+作者: Ionela Voinescu <ionela.voinescu@arm.com>
+
+日期: 2019-09-10
+
+本文檔簡要描述了 AArch64 Linux 支持的活動監控單元的規範。
+
+
+架構總述
+--------
+
+活動監控是 ARMv8.4 CPU 架構引入的一個可選擴展特性。
+
+活動監控單元(在每個 CPU 中實現)爲系統管理提供了性能計數器。既可以通
+過系統寄存器的方式訪問計數器，同時也支持外部內存映射的方式訪問計數器。
+
+AMUv1 架構實現了一個由4個固定的64位事件計數器組成的計數器組。
+
+  - CPU 周期計數器：同 CPU 的頻率增長
+  - 常量計數器：同固定的系統時鐘頻率增長
+  - 淘汰指令計數器: 同每次架構指令執行增長
+  - 內存停頓周期計數器：計算由在時鐘域內的最後一級緩存中未命中而引起
+    的指令調度停頓周期數
+
+當處於 WFI 或者 WFE 狀態時，計數器不會增長。
+
+AMU 架構提供了一個高達16位的事件計數器空間，未來新的 AMU 版本中可能
+用它來實現新增的事件計數器。
+
+另外，AMUv1 實現了一個多達16個64位輔助事件計數器的計數器組。
+
+冷復位時所有的計數器會清零。
+
+
+基本支持
+--------
+
+內核可以安全地運行在支持 AMU 和不支持 AMU 的 CPU 組合中。
+因此，當配置 CONFIG_ARM64_AMU_EXTN 後我們無條件使能後續
+(secondary or hotplugged) CPU 檢測和使用這個特性。
+
+當在 CPU 上檢測到該特性時，我們會標記爲特性可用但是不能保證計數器的功能，
+僅表明有擴展屬性。
+
+固件(代碼運行在高異常級別，例如 arm-tf )需支持以下功能：
+
+ - 提供低異常級別(EL2 和 EL1)訪問 AMU 寄存器的能力。
+ - 使能計數器。如果未使能，它的值應爲 0。
+ - 在從電源關閉狀態啓動 CPU 前或後保存或者恢復計數器。
+
+當使用使能了該特性的內核啓動但固件損壞時，訪問計數器寄存器可能會遭遇
+panic 或者死鎖。即使未發現這些症狀，計數器寄存器返回的數據結果並不一
+定能反映真實情況。通常，計數器會返回 0，表明他們未被使能。
+
+如果固件沒有提供適當的支持最好關閉 CONFIG_ARM64_AMU_EXTN。
+值得注意的是，出於安全原因，不要繞過 AMUSERRENR_EL0 設置而捕獲從
+EL0(用戶空間) 訪問 EL1(內核空間)。 因此，固件應該確保訪問 AMU寄存器
+不會困在 EL2或EL3。
+
+AMUv1 的固定計數器可以通過如下系統寄存器訪問：
+
+ - SYS_AMEVCNTR0_CORE_EL0
+ - SYS_AMEVCNTR0_CONST_EL0
+ - SYS_AMEVCNTR0_INST_RET_EL0
+ - SYS_AMEVCNTR0_MEM_STALL_EL0
+
+特定輔助計數器可以通過 SYS_AMEVCNTR1_EL0(n) 訪問，其中n介於0到15。
+
+詳細信息定義在目錄：arch/arm64/include/asm/sysreg.h。
+
+
+用戶空間訪問
+------------
+
+由於以下原因，當前禁止從用戶空間訪問 AMU 的寄存器：
+
+  - 安全因數：可能會暴露處於安全模式執行的代碼信息。
+  - 意願：AMU 是用於系統管理的。
+
+同樣，該功能對用戶空間不可見。
+
+
+虛擬化
+------
+
+由於以下原因，當前禁止從 KVM 客戶端的用戶空間(EL0)和內核空間(EL1)
+訪問 AMU 的寄存器：
+
+  - 安全因數：可能會暴露給其他客戶端或主機端執行的代碼信息。
+
+任何試圖訪問 AMU 寄存器的行爲都會觸發一個註冊在客戶端的未定義異常。
+
diff --git a/Documentation/translations/zh_TW/arm64/booting.txt b/Documentation/translations/zh_TW/arm64/booting.txt
new file mode 100644
index 000000000000..b9439dd54012
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/booting.txt
@@ -0,0 +1,251 @@
+SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/arm64/booting.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+M:	Will Deacon <will.deacon@arm.com>
+zh_CN:	Fu Wei <wefu@redhat.com>
+zh_TW:	Hu Haowen <src.res@email.cn>
+C:	55f058e7574c3615dea4615573a19bdb258696c6
+---------------------------------------------------------------------
+Documentation/arm64/booting.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+
+英文版維護者： Will Deacon <will.deacon@arm.com>
+中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+本文翻譯提交時的 Git 檢出點爲： 55f058e7574c3615dea4615573a19bdb258696c6
+
+以下爲正文
+---------------------------------------------------------------------
+			啓動 AArch64 Linux
+			==================
+
+作者: Will Deacon <will.deacon@arm.com>
+日期: 2012 年 09 月 07 日
+
+本文檔基於 Russell King 的 ARM 啓動文檔，且適用於所有公開發布的
+AArch64 Linux 內核代碼。
+
+AArch64 異常模型由多個異常級（EL0 - EL3）組成，對於 EL0 和 EL1 異常級
+有對應的安全和非安全模式。EL2 是系統管理級，且僅存在於非安全模式下。
+EL3 是最高特權級，且僅存在於安全模式下。
+
+基於本文檔的目的，我們將簡單地使用『引導裝載程序』（『boot loader』）
+這個術語來定義在將控制權交給 Linux 內核前 CPU 上執行的所有軟體。
+這可能包含安全監控和系統管理代碼，或者它可能只是一些用於準備最小啓動
+環境的指令。
+
+基本上，引導裝載程序（至少）應實現以下操作：
+
+1、設置和初始化 RAM
+2、設置設備樹數據
+3、解壓內核映像
+4、調用內核映像
+
+
+1、設置和初始化 RAM
+-----------------
+
+必要性: 強制
+
+引導裝載程序應該找到並初始化系統中所有內核用於保持系統變量數據的 RAM。
+這個操作的執行方式因設備而異。（它可能使用內部算法來自動定位和計算所有
+RAM，或可能使用對這個設備已知的 RAM 信息，還可能是引導裝載程序設計者
+想到的任何合適的方法。）
+
+
+2、設置設備樹數據
+---------------
+
+必要性: 強制
+
+設備樹數據塊（dtb）必須 8 字節對齊，且大小不能超過 2MB。由於設備樹
+數據塊將在使能緩存的情況下以 2MB 粒度被映射，故其不能被置於必須以特定
+屬性映射的2M區域內。
+
+註： v4.2 之前的版本同時要求設備樹數據塊被置於從內核映像以下
+text_offset 字節處算起第一個 512MB 內。
+
+3、解壓內核映像
+-------------
+
+必要性: 可選
+
+AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內核映像文件
+（比如 Image.gz），則需要通過引導裝載程序（使用 gzip 等）來進行解壓。
+若引導裝載程序沒有實現這個功能，就要使用非壓縮內核映像文件。
+
+
+4、調用內核映像
+-------------
+
+必要性: 強制
+
+已解壓的內核映像包含一個 64 字節的頭，內容如下：
+
+  u32 code0;			/* 可執行代碼 */
+  u32 code1;			/* 可執行代碼 */
+  u64 text_offset;		/* 映像裝載偏移，小端模式 */
+  u64 image_size;		/* 映像實際大小, 小端模式 */
+  u64 flags;			/* 內核旗標, 小端模式 *
+  u64 res2	= 0;		/* 保留 */
+  u64 res3	= 0;		/* 保留 */
+  u64 res4	= 0;		/* 保留 */
+  u32 magic	= 0x644d5241;	/* 魔數, 小端, "ARM\x64" */
+  u32 res5;			/* 保留 （用於 PE COFF 偏移） */
+
+
+映像頭注釋：
+
+- 自 v3.17 起，除非另有說明，所有域都是小端模式。
+
+- code0/code1 負責跳轉到 stext.
+
+- 當通過 EFI 啓動時， 最初 code0/code1 被跳過。
+  res5 是到 PE 文件頭的偏移，而 PE 文件頭含有 EFI 的啓動入口點
+  （efi_stub_entry）。當 stub 代碼完成了它的使命，它會跳轉到 code0
+  繼續正常的啓動流程。
+
+- v3.17 之前，未明確指定 text_offset 的字節序。此時，image_size 爲零，
+  且 text_offset 依照內核字節序爲 0x80000。
+  當 image_size 非零，text_offset 爲小端模式且是有效值，應被引導加載
+  程序使用。當 image_size 爲零，text_offset 可假定爲 0x80000。
+
+- flags 域 (v3.17 引入) 爲 64 位小端模式，其編碼如下：
+  位 0: 	內核字節序。 1 表示大端模式，0 表示小端模式。
+  位 1-2:	內核頁大小。
+			0 - 未指定。
+			1 - 4K
+			2 - 16K
+			3 - 64K
+  位 3:		內核物理位置
+			0 - 2MB 對齊基址應儘量靠近內存起始處，因爲
+			    其基址以下的內存無法通過線性映射訪問
+			1 - 2MB 對齊基址可以在物理內存的任意位置
+  位 4-63:	保留。
+
+- 當 image_size 爲零時，引導裝載程序應試圖在內核映像末尾之後儘可能
+  多地保留空閒內存供內核直接使用。對內存空間的需求量因所選定的內核
+  特性而異, 並無實際限制。
+
+內核映像必須被放置在任意一個可用系統內存 2MB 對齊基址的 text_offset
+字節處，並從該處被調用。2MB 對齊基址和內核映像起始地址之間的區域對於
+內核來說沒有特殊意義，且可能被用於其他目的。
+從映像起始地址算起，最少必須準備 image_size 字節的空閒內存供內核使用。
+註： v4.6 之前的版本無法使用內核映像物理偏移以下的內存，所以當時建議
+將映像儘量放置在靠近系統內存起始的地方。
+
+任何提供給內核的內存（甚至在映像起始地址之前），若未從內核中標記爲保留
+(如在設備樹（dtb）的 memreserve 區域），都將被認爲對內核是可用。
+
+在跳轉入內核前，必須符合以下狀態：
+
+- 停止所有 DMA 設備，這樣內存數據就不會因爲虛假網絡包或磁碟數據而
+  被破壞。這可能可以節省你許多的調試時間。
+
+- 主 CPU 通用寄存器設置
+  x0 = 系統 RAM 中設備樹數據塊（dtb）的物理地址。
+  x1 = 0 (保留，將來可能使用)
+  x2 = 0 (保留，將來可能使用)
+  x3 = 0 (保留，將來可能使用)
+
+- CPU 模式
+  所有形式的中斷必須在 PSTATE.DAIF 中被屏蔽（Debug、SError、IRQ
+  和 FIQ）。
+  CPU 必須處於 EL2（推薦，可訪問虛擬化擴展）或非安全 EL1 模式下。
+
+- 高速緩存、MMU
+  MMU 必須關閉。
+  指令緩存開啓或關閉皆可。
+  已載入的內核映像的相應內存區必須被清理，以達到緩存一致性點（PoC）。
+  當存在系統緩存或其他使能緩存的一致性主控器時，通常需使用虛擬地址
+  維護其緩存，而非 set/way 操作。
+  遵從通過虛擬地址操作維護構架緩存的系統緩存必須被配置，並可以被使能。
+  而不通過虛擬地址操作維護構架緩存的系統緩存（不推薦），必須被配置且
+  禁用。
+
+  *譯者註：對於 PoC 以及緩存相關內容，請參考 ARMv8 構架參考手冊
+   ARM DDI 0487A
+
+- 架構計時器
+  CNTFRQ 必須設定爲計時器的頻率，且 CNTVOFF 必須設定爲對所有 CPU
+  都一致的值。如果在 EL1 模式下進入內核，則 CNTHCTL_EL2 中的
+  EL1PCTEN (bit 0) 必須置位。
+
+- 一致性
+  通過內核啓動的所有 CPU 在內核入口地址上必須處於相同的一致性域中。
+  這可能要根據具體實現來定義初始化過程，以使能每個CPU上對維護操作的
+  接收。
+
+- 系統寄存器
+  在進入內核映像的異常級中，所有構架中可寫的系統寄存器必須通過軟體
+  在一個更高的異常級別下初始化，以防止在 未知 狀態下運行。
+
+  對於擁有 GICv3 中斷控制器並以 v3 模式運行的系統：
+  - 如果 EL3 存在：
+    ICC_SRE_EL3.Enable (位 3) 必須初始化爲 0b1。
+    ICC_SRE_EL3.SRE (位 0) 必須初始化爲 0b1。
+  - 若內核運行在 EL1：
+    ICC_SRE_EL2.Enable (位 3) 必須初始化爲 0b1。
+    ICC_SRE_EL2.SRE (位 0) 必須初始化爲 0b1。
+  - 設備樹（DT）或 ACPI 表必須描述一個 GICv3 中斷控制器。
+
+  對於擁有 GICv3 中斷控制器並以兼容（v2）模式運行的系統：
+  - 如果 EL3 存在：
+    ICC_SRE_EL3.SRE (位 0) 必須初始化爲 0b0。
+  - 若內核運行在 EL1：
+    ICC_SRE_EL2.SRE (位 0) 必須初始化爲 0b0。
+  - 設備樹（DT）或 ACPI 表必須描述一個 GICv2 中斷控制器。
+
+以上對於 CPU 模式、高速緩存、MMU、架構計時器、一致性、系統寄存器的
+必要條件描述適用於所有 CPU。所有 CPU 必須在同一異常級別跳入內核。
+
+引導裝載程序必須在每個 CPU 處於以下狀態時跳入內核入口：
+
+- 主 CPU 必須直接跳入內核映像的第一條指令。通過此 CPU 傳遞的設備樹
+  數據塊必須在每個 CPU 節點中包含一個 『enable-method』 屬性，所
+  支持的 enable-method 請見下文。
+
+  引導裝載程序必須生成這些設備樹屬性，並在跳入內核入口之前將其插入
+  數據塊。
+
+- enable-method 爲 「spin-table」 的 CPU 必須在它們的 CPU
+  節點中包含一個 『cpu-release-addr』 屬性。這個屬性標識了一個
+  64 位自然對齊且初始化爲零的內存位置。
+
+  這些 CPU 必須在內存保留區（通過設備樹中的 /memreserve/ 域傳遞
+  給內核）中自旋於內核之外，輪詢它們的 cpu-release-addr 位置（必須
+  包含在保留區中）。可通過插入 wfe 指令來降低忙循環開銷，而主 CPU 將
+  發出 sev 指令。當對 cpu-release-addr 所指位置的讀取操作返回非零值
+  時，CPU 必須跳入此值所指向的地址。此值爲一個單獨的 64 位小端值，
+  因此 CPU 須在跳轉前將所讀取的值轉換爲其本身的端模式。
+
+- enable-method 爲 「psci」 的 CPU 保持在內核外（比如，在
+  memory 節點中描述爲內核空間的內存區外，或在通過設備樹 /memreserve/
+  域中描述爲內核保留區的空間中）。內核將會發起在 ARM 文檔（編號
+  ARM DEN 0022A：用於 ARM 上的電源狀態協調接口系統軟體）中描述的
+  CPU_ON 調用來將 CPU 帶入內核。
+
+  *譯者注: ARM DEN 0022A 已更新到 ARM DEN 0022C。
+
+  設備樹必須包含一個 『psci』 節點，請參考以下文檔：
+  Documentation/devicetree/bindings/arm/psci.yaml
+
+
+- 輔助 CPU 通用寄存器設置
+  x0 = 0 (保留，將來可能使用)
+  x1 = 0 (保留，將來可能使用)
+  x2 = 0 (保留，將來可能使用)
+  x3 = 0 (保留，將來可能使用)
+
diff --git a/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst b/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
new file mode 100644
index 000000000000..3eb1c623ce31
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
@@ -0,0 +1,244 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
+
+Translator: Bailu Lin <bailu.lin@vivo.com>
+            Hu Haowen <src.res@email.cn>
+
+================
+ARM64 ELF hwcaps
+================
+
+這篇文檔描述了 arm64 ELF hwcaps 的用法和語義。
+
+
+1. 簡介
+-------
+
+有些硬體或軟體功能僅在某些 CPU 實現上和/或在具體某個內核配置上可用，但
+對於處於 EL0 的用戶空間代碼沒有可用的架構發現機制。內核通過在輔助向量表
+公開一組稱爲 hwcaps 的標誌而把這些功能暴露給用戶空間。
+
+用戶空間軟體可以通過獲取輔助向量的 AT_HWCAP 或 AT_HWCAP2 條目來測試功能，
+並測試是否設置了相關標誌，例如::
+
+	bool floating_point_is_present(void)
+	{
+		unsigned long hwcaps = getauxval(AT_HWCAP);
+		if (hwcaps & HWCAP_FP)
+			return true;
+
+		return false;
+	}
+
+如果軟體依賴於 hwcap 描述的功能，在嘗試使用該功能前則應檢查相關的 hwcap
+標誌以驗證該功能是否存在。
+
+不能通過其他方式探查這些功能。當一個功能不可用時，嘗試使用它可能導致不可
+預測的行爲，並且無法保證能確切的知道該功能不可用，例如 SIGILL。
+
+
+2. Hwcaps 的說明
+----------------
+
+大多數 hwcaps 旨在說明通過架構 ID 寄存器(處於 EL0 的用戶空間代碼無法訪問)
+描述的功能的存在。這些 hwcap 通過 ID 寄存器欄位定義，並且應根據 ARM 體系
+結構參考手冊（ARM ARM）中定義的欄位來解釋說明。
+
+這些 hwcaps 以下面的形式描述::
+
+    idreg.field == val 表示有某個功能。
+
+當 idreg.field 中有 val 時，hwcaps 表示 ARM ARM 定義的功能是有效的，但是
+並不是說要完全和 val 相等，也不是說 idreg.field 描述的其他功能就是缺失的。
+
+其他 hwcaps 可能表明無法僅由 ID 寄存器描述的功能的存在。這些 hwcaps 可能
+沒有被 ID 寄存器描述，需要參考其他文檔。
+
+
+3. AT_HWCAP 中揭示的 hwcaps
+---------------------------
+
+HWCAP_FP
+    ID_AA64PFR0_EL1.FP == 0b0000 表示有此功能。
+
+HWCAP_ASIMD
+    ID_AA64PFR0_EL1.AdvSIMD == 0b0000 表示有此功能。
+
+HWCAP_EVTSTRM
+    通用計時器頻率配置爲大約100KHz以生成事件。
+
+HWCAP_AES
+    ID_AA64ISAR0_EL1.AES == 0b0001 表示有此功能。
+
+HWCAP_PMULL
+    ID_AA64ISAR0_EL1.AES == 0b0010 表示有此功能。
+
+HWCAP_SHA1
+    ID_AA64ISAR0_EL1.SHA1 == 0b0001 表示有此功能。
+
+HWCAP_SHA2
+    ID_AA64ISAR0_EL1.SHA2 == 0b0001 表示有此功能。
+
+HWCAP_CRC32
+    ID_AA64ISAR0_EL1.CRC32 == 0b0001 表示有此功能。
+
+HWCAP_ATOMICS
+    ID_AA64ISAR0_EL1.Atomic == 0b0010 表示有此功能。
+
+HWCAP_FPHP
+    ID_AA64PFR0_EL1.FP == 0b0001 表示有此功能。
+
+HWCAP_ASIMDHP
+    ID_AA64PFR0_EL1.AdvSIMD == 0b0001 表示有此功能。
+
+HWCAP_CPUID
+    根據 Documentation/arm64/cpu-feature-registers.rst 描述，EL0 可以訪問
+    某些 ID 寄存器。
+
+    這些 ID 寄存器可能表示功能的可用性。
+
+HWCAP_ASIMDRDM
+    ID_AA64ISAR0_EL1.RDM == 0b0001 表示有此功能。
+
+HWCAP_JSCVT
+    ID_AA64ISAR1_EL1.JSCVT == 0b0001 表示有此功能。
+
+HWCAP_FCMA
+    ID_AA64ISAR1_EL1.FCMA == 0b0001 表示有此功能。
+
+HWCAP_LRCPC
+    ID_AA64ISAR1_EL1.LRCPC == 0b0001 表示有此功能。
+
+HWCAP_DCPOP
+    ID_AA64ISAR1_EL1.DPB == 0b0001 表示有此功能。
+
+HWCAP_SHA3
+    ID_AA64ISAR0_EL1.SHA3 == 0b0001 表示有此功能。
+
+HWCAP_SM3
+    ID_AA64ISAR0_EL1.SM3 == 0b0001 表示有此功能。
+
+HWCAP_SM4
+    ID_AA64ISAR0_EL1.SM4 == 0b0001 表示有此功能。
+
+HWCAP_ASIMDDP
+    ID_AA64ISAR0_EL1.DP == 0b0001 表示有此功能。
+
+HWCAP_SHA512
+    ID_AA64ISAR0_EL1.SHA2 == 0b0010 表示有此功能。
+
+HWCAP_SVE
+    ID_AA64PFR0_EL1.SVE == 0b0001 表示有此功能。
+
+HWCAP_ASIMDFHM
+    ID_AA64ISAR0_EL1.FHM == 0b0001 表示有此功能。
+
+HWCAP_DIT
+    ID_AA64PFR0_EL1.DIT == 0b0001 表示有此功能。
+
+HWCAP_USCAT
+    ID_AA64MMFR2_EL1.AT == 0b0001 表示有此功能。
+
+HWCAP_ILRCPC
+    ID_AA64ISAR1_EL1.LRCPC == 0b0010 表示有此功能。
+
+HWCAP_FLAGM
+    ID_AA64ISAR0_EL1.TS == 0b0001 表示有此功能。
+
+HWCAP_SSBS
+    ID_AA64PFR1_EL1.SSBS == 0b0010 表示有此功能。
+
+HWCAP_SB
+    ID_AA64ISAR1_EL1.SB == 0b0001 表示有此功能。
+
+HWCAP_PACA
+    如 Documentation/arm64/pointer-authentication.rst 所描述，
+    ID_AA64ISAR1_EL1.APA == 0b0001 或 ID_AA64ISAR1_EL1.API == 0b0001
+    表示有此功能。
+
+HWCAP_PACG
+    如 Documentation/arm64/pointer-authentication.rst 所描述，
+    ID_AA64ISAR1_EL1.GPA == 0b0001 或 ID_AA64ISAR1_EL1.GPI == 0b0001
+    表示有此功能。
+
+HWCAP2_DCPODP
+
+    ID_AA64ISAR1_EL1.DPB == 0b0010 表示有此功能。
+
+HWCAP2_SVE2
+
+    ID_AA64ZFR0_EL1.SVEVer == 0b0001 表示有此功能。
+
+HWCAP2_SVEAES
+
+    ID_AA64ZFR0_EL1.AES == 0b0001 表示有此功能。
+
+HWCAP2_SVEPMULL
+
+    ID_AA64ZFR0_EL1.AES == 0b0010 表示有此功能。
+
+HWCAP2_SVEBITPERM
+
+    ID_AA64ZFR0_EL1.BitPerm == 0b0001 表示有此功能。
+
+HWCAP2_SVESHA3
+
+    ID_AA64ZFR0_EL1.SHA3 == 0b0001 表示有此功能。
+
+HWCAP2_SVESM4
+
+    ID_AA64ZFR0_EL1.SM4 == 0b0001 表示有此功能。
+
+HWCAP2_FLAGM2
+
+    ID_AA64ISAR0_EL1.TS == 0b0010 表示有此功能。
+
+HWCAP2_FRINT
+
+    ID_AA64ISAR1_EL1.FRINTTS == 0b0001 表示有此功能。
+
+HWCAP2_SVEI8MM
+
+    ID_AA64ZFR0_EL1.I8MM == 0b0001 表示有此功能。
+
+HWCAP2_SVEF32MM
+
+    ID_AA64ZFR0_EL1.F32MM == 0b0001 表示有此功能。
+
+HWCAP2_SVEF64MM
+
+    ID_AA64ZFR0_EL1.F64MM == 0b0001 表示有此功能。
+
+HWCAP2_SVEBF16
+
+    ID_AA64ZFR0_EL1.BF16 == 0b0001 表示有此功能。
+
+HWCAP2_I8MM
+
+    ID_AA64ISAR1_EL1.I8MM == 0b0001 表示有此功能。
+
+HWCAP2_BF16
+
+    ID_AA64ISAR1_EL1.BF16 == 0b0001 表示有此功能。
+
+HWCAP2_DGH
+
+    ID_AA64ISAR1_EL1.DGH == 0b0001 表示有此功能。
+
+HWCAP2_RNG
+
+    ID_AA64ISAR0_EL1.RNDR == 0b0001 表示有此功能。
+
+HWCAP2_BTI
+
+    ID_AA64PFR0_EL1.BT == 0b0001 表示有此功能。
+
+
+4. 未使用的 AT_HWCAP 位
+-----------------------
+
+爲了與用戶空間交互，內核保證 AT_HWCAP 的第62、63位將始終返回0。
+
diff --git a/Documentation/translations/zh_TW/arm64/hugetlbpage.rst b/Documentation/translations/zh_TW/arm64/hugetlbpage.rst
new file mode 100644
index 000000000000..846b500dae97
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/hugetlbpage.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/arm64/hugetlbpage.rst <hugetlbpage_index>`
+
+Translator: Bailu Lin <bailu.lin@vivo.com>
+            Hu Haowen <src.res@email.cn>
+
+=====================
+ARM64中的 HugeTLBpage
+=====================
+
+大頁依靠有效利用 TLBs 來提高地址翻譯的性能。這取決於以下
+兩點 -
+
+  - 大頁的大小
+  - TLBs 支持的條目大小
+
+ARM64 接口支持2種大頁方式。
+
+1) pud/pmd 級別的塊映射
+-----------------------
+
+這是常規大頁，他們的 pmd 或 pud 頁面表條目指向一個內存塊。
+不管 TLB 中支持的條目大小如何，塊映射可以減少翻譯大頁地址
+所需遍歷的頁表深度。
+
+2) 使用連續位
+-------------
+
+架構中轉換頁表條目(D4.5.3, ARM DDI 0487C.a)中提供一個連續
+位告訴 MMU 這個條目是一個連續條目集的一員，它可以被緩存在單
+個 TLB 條目中。
+
+在 Linux 中連續位用來增加 pmd 和 pte(最後一級)級別映射的大
+小。受支持的連續頁表條目數量因頁面大小和頁表級別而異。
+
+
+支持以下大頁尺寸配置 -
+
+  ====== ========   ====    ========    ===
+  -      CONT PTE    PMD    CONT PMD    PUD
+  ====== ========   ====    ========    ===
+  4K:         64K     2M         32M     1G
+  16K:         2M    32M          1G
+  64K:         2M   512M         16G
+  ====== ========   ====    ========    ===
+
diff --git a/Documentation/translations/zh_TW/arm64/index.rst b/Documentation/translations/zh_TW/arm64/index.rst
new file mode 100644
index 000000000000..2322783f3881
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/index.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/arm64/index.rst <arm64_index>`
+:Translator: Bailu Lin <bailu.lin@vivo.com>
+             Hu Haowen <src.res@email.cn>
+
+.. _tw_arm64_index:
+
+
+==========
+ARM64 架構
+==========
+
+.. toctree::
+    :maxdepth: 2
+
+    amu
+    hugetlbpage
+    perf
+    elf_hwcaps
+
diff --git a/Documentation/translations/zh_TW/arm64/legacy_instructions.txt b/Documentation/translations/zh_TW/arm64/legacy_instructions.txt
new file mode 100644
index 000000000000..6d4454f77b9e
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/legacy_instructions.txt
@@ -0,0 +1,77 @@
+SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/arm64/legacy_instructions.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Punit Agrawal <punit.agrawal@arm.com>
+            Suzuki K. Poulose <suzuki.poulose@arm.com>
+Chinese maintainer: Fu Wei <wefu@redhat.com>
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/arm64/legacy_instructions.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+
+本文翻譯提交時的 Git 檢出點爲： bc465aa9d045feb0e13b4a8f32cc33c1943f62d6
+
+英文版維護者： Punit Agrawal <punit.agrawal@arm.com>
+            Suzuki K. Poulose <suzuki.poulose@arm.com>
+中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
+繁體中文版校譯者：胡皓文  Hu Haowen <src.res@email.cn>
+
+以下爲正文
+---------------------------------------------------------------------
+Linux 內核在 arm64 上的移植提供了一個基礎框架，以支持構架中正在被淘汰或已廢棄指令的模擬執行。
+這個基礎框架的代碼使用未定義指令鉤子（hooks）來支持模擬。如果指令存在，它也允許在硬體中啓用該指令。
+
+模擬模式可通過寫 sysctl 節點（/proc/sys/abi）來控制。
+不同的執行方式及 sysctl 節點的相應值，解釋如下：
+
+* Undef（未定義）
+  值： 0
+  產生未定義指令終止異常。它是那些構架中已廢棄的指令，如 SWP，的默認處理方式。
+
+* Emulate（模擬）
+  值： 1
+  使用軟體模擬方式。爲解決軟體遷移問題，這種模擬指令模式的使用是被跟蹤的，並會發出速率限制警告。
+  它是那些構架中正在被淘汰的指令，如 CP15 barriers（隔離指令），的默認處理方式。
+
+* Hardware Execution（硬體執行）
+  值： 2
+  雖然標記爲正在被淘汰，但一些實現可能提供硬體執行這些指令的使能/禁用操作。
+  使用硬體執行一般會有更好的性能，但將無法收集運行時對正被淘汰指令的使用統計數據。
+
+默認執行模式依賴於指令在構架中狀態。正在被淘汰的指令應該以模擬（Emulate）作爲默認模式，
+而已廢棄的指令必須默認使用未定義（Undef）模式
+
+注意：指令模擬可能無法應對所有情況。更多詳情請參考單獨的指令注釋。
+
+受支持的遺留指令
+-------------
+* SWP{B}
+節點: /proc/sys/abi/swp
+狀態: 已廢棄
+默認執行方式: Undef (0)
+
+* CP15 Barriers
+節點: /proc/sys/abi/cp15_barrier
+狀態: 正被淘汰，不推薦使用
+默認執行方式: Emulate (1)
+
+* SETEND
+節點: /proc/sys/abi/setend
+狀態: 正被淘汰，不推薦使用
+默認執行方式: Emulate (1)*
+註：爲了使能這個特性，系統中的所有 CPU 必須在 EL0 支持混合字節序。
+如果一個新的 CPU （不支持混合字節序） 在使能這個特性後被熱插入系統，
+在應用中可能會出現不可預期的結果。
+
diff --git a/Documentation/translations/zh_TW/arm64/memory.txt b/Documentation/translations/zh_TW/arm64/memory.txt
new file mode 100644
index 000000000000..99c2b78b5674
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/memory.txt
@@ -0,0 +1,119 @@
+SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/arm64/memory.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Catalin Marinas <catalin.marinas@arm.com>
+Chinese maintainer: Fu Wei <wefu@redhat.com>
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/arm64/memory.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+
+本文翻譯提交時的 Git 檢出點爲： bc465aa9d045feb0e13b4a8f32cc33c1943f62d6
+
+英文版維護者： Catalin Marinas <catalin.marinas@arm.com>
+中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+
+以下爲正文
+---------------------------------------------------------------------
+		     Linux 在 AArch64 中的內存布局
+		     ===========================
+
+作者: Catalin Marinas <catalin.marinas@arm.com>
+
+本文檔描述 AArch64 Linux 內核所使用的虛擬內存布局。此構架可以實現
+頁大小爲 4KB 的 4 級轉換表和頁大小爲 64KB 的 3 級轉換表。
+
+AArch64 Linux 使用 3 級或 4 級轉換表，其頁大小配置爲 4KB，對於用戶和內核
+分別都有 39-bit (512GB) 或 48-bit (256TB) 的虛擬地址空間。
+對於頁大小爲 64KB的配置，僅使用 2 級轉換表，有 42-bit (4TB) 的虛擬地址空間，但內存布局相同。
+
+用戶地址空間的 63:48 位爲 0，而內核地址空間的相應位爲 1。TTBRx 的
+選擇由虛擬地址的 63 位給出。swapper_pg_dir 僅包含內核（全局）映射，
+而用戶 pgd 僅包含用戶（非全局）映射。swapper_pg_dir 地址被寫入
+TTBR1 中，且從不寫入 TTBR0。
+
+
+AArch64 Linux 在頁大小爲 4KB，並使用 3 級轉換表時的內存布局：
+
+起始地址			結束地址			大小		用途
+-----------------------------------------------------------------------
+0000000000000000	0000007fffffffff	 512GB		用戶空間
+ffffff8000000000	ffffffffffffffff	 512GB		內核空間
+
+
+AArch64 Linux 在頁大小爲 4KB，並使用 4 級轉換表時的內存布局：
+
+起始地址			結束地址			大小		用途
+-----------------------------------------------------------------------
+0000000000000000	0000ffffffffffff	 256TB		用戶空間
+ffff000000000000	ffffffffffffffff	 256TB		內核空間
+
+
+AArch64 Linux 在頁大小爲 64KB，並使用 2 級轉換表時的內存布局：
+
+起始地址			結束地址			大小		用途
+-----------------------------------------------------------------------
+0000000000000000	000003ffffffffff	   4TB		用戶空間
+fffffc0000000000	ffffffffffffffff	   4TB		內核空間
+
+
+AArch64 Linux 在頁大小爲 64KB，並使用 3 級轉換表時的內存布局：
+
+起始地址			結束地址			大小		用途
+-----------------------------------------------------------------------
+0000000000000000	0000ffffffffffff	 256TB		用戶空間
+ffff000000000000	ffffffffffffffff	 256TB		內核空間
+
+
+更詳細的內核虛擬內存布局，請參閱內核啓動信息。
+
+
+4KB 頁大小的轉換表查找：
+
++--------+--------+--------+--------+--------+--------+--------+--------+
+|63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
++--------+--------+--------+--------+--------+--------+--------+--------+
+ |                 |         |         |         |         |
+ |                 |         |         |         |         v
+ |                 |         |         |         |   [11:0]  頁內偏移
+ |                 |         |         |         +-> [20:12] L3 索引
+ |                 |         |         +-----------> [29:21] L2 索引
+ |                 |         +---------------------> [38:30] L1 索引
+ |                 +-------------------------------> [47:39] L0 索引
+ +-------------------------------------------------> [63] TTBR0/1
+
+
+64KB 頁大小的轉換表查找：
+
++--------+--------+--------+--------+--------+--------+--------+--------+
+|63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
++--------+--------+--------+--------+--------+--------+--------+--------+
+ |                 |    |               |              |
+ |                 |    |               |              v
+ |                 |    |               |            [15:0]  頁內偏移
+ |                 |    |               +----------> [28:16] L3 索引
+ |                 |    +--------------------------> [41:29] L2 索引
+ |                 +-------------------------------> [47:42] L1 索引
+ +-------------------------------------------------> [63] TTBR0/1
+
+
+當使用 KVM 時, 管理程序（hypervisor）在 EL2 中通過相對內核虛擬地址的
+一個固定偏移來映射內核頁（內核虛擬地址的高 24 位設爲零）:
+
+起始地址			結束地址			大小		用途
+-----------------------------------------------------------------------
+0000004000000000	0000007fffffffff	 256GB		在 HYP 中映射的內核對象
+
diff --git a/Documentation/translations/zh_TW/arm64/perf.rst b/Documentation/translations/zh_TW/arm64/perf.rst
new file mode 100644
index 000000000000..f1ffd55dfe50
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/perf.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/arm64/perf.rst <perf_index>`
+
+Translator: Bailu Lin <bailu.lin@vivo.com>
+            Hu Haowen <src.res@email.cn>
+
+=============
+Perf 事件屬性
+=============
+
+:作者: Andrew Murray <andrew.murray@arm.com>
+:日期: 2019-03-06
+
+exclude_user
+------------
+
+該屬性排除用戶空間。
+
+用戶空間始終運行在 EL0，因此該屬性將排除 EL0。
+
+
+exclude_kernel
+--------------
+
+該屬性排除內核空間。
+
+打開 VHE 時內核運行在 EL2，不打開 VHE 時內核運行在 EL1。客戶機
+內核總是運行在 EL1。
+
+對於宿主機，該屬性排除 EL1 和 VHE 上的 EL2。
+
+對於客戶機，該屬性排除 EL1。請注意客戶機從來不會運行在 EL2。
+
+
+exclude_hv
+----------
+
+該屬性排除虛擬機監控器。
+
+對於 VHE 宿主機該屬性將被忽略，此時我們認爲宿主機內核是虛擬機監
+控器。
+
+對於 non-VHE 宿主機該屬性將排除 EL2，因爲虛擬機監控器運行在 EL2
+的任何代碼主要用於客戶機和宿主機的切換。
+
+對於客戶機該屬性無效。請注意客戶機從來不會運行在 EL2。
+
+
+exclude_host / exclude_guest
+----------------------------
+
+這些屬性分別排除了 KVM 宿主機和客戶機。
+
+KVM 宿主機可能運行在 EL0（用戶空間），EL1（non-VHE 內核）和
+EL2（VHE 內核 或 non-VHE 虛擬機監控器）。
+
+KVM 客戶機可能運行在 EL0（用戶空間）和 EL1（內核）。
+
+由於宿主機和客戶機之間重疊的異常級別，我們不能僅僅依靠 PMU 的硬體異
+常過濾機制-因此我們必須啓用/禁用對於客戶機進入和退出的計數。而這在
+VHE 和 non-VHE 系統上表現不同。
+
+對於 non-VHE 系統的 exclude_host 屬性排除 EL2 - 在進入和退出客戶
+機時，我們會根據 exclude_host 和 exclude_guest 屬性在適當的情況下
+禁用/啓用該事件。
+
+對於 VHE 系統的 exclude_guest 屬性排除 EL1，而對其中的 exclude_host
+屬性同時排除 EL0，EL2。在進入和退出客戶機時，我們會適當地根據
+exclude_host 和 exclude_guest 屬性包括/排除 EL0。
+
+以上聲明也適用於在 not-VHE 客戶機使用這些屬性時，但是請注意客戶機從
+來不會運行在 EL2。
+
+
+準確性
+------
+
+在 non-VHE 宿主機上，我們在 EL2 進入/退出宿主機/客戶機的切換時啓用/
+關閉計數器 -但是在啓用/禁用計數器和進入/退出客戶機之間存在一段延時。
+對於 exclude_host， 我們可以通過過濾 EL2 消除在客戶機進入/退出邊界
+上用於計數客戶機事件的宿主機事件計數器。但是當使用 !exclude_hv 時，
+在客戶機進入/退出有一個小的停電窗口無法捕獲到宿主機的事件。
+
+在 VHE 系統沒有停電窗口。
+
diff --git a/Documentation/translations/zh_TW/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arm64/silicon-errata.txt
new file mode 100644
index 000000000000..bf2077197504
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/silicon-errata.txt
@@ -0,0 +1,79 @@
+SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/arm64/silicon-errata.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+M:	Will Deacon <will.deacon@arm.com>
+zh_CN:	Fu Wei <wefu@redhat.com>
+zh_TW:	Hu Haowen <src.res@email.cn>
+C:	1926e54f115725a9248d0c4c65c22acaf94de4c4
+---------------------------------------------------------------------
+Documentation/arm64/silicon-errata.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+
+英文版維護者： Will Deacon <will.deacon@arm.com>
+中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+本文翻譯提交時的 Git 檢出點爲： 1926e54f115725a9248d0c4c65c22acaf94de4c4
+
+以下爲正文
+---------------------------------------------------------------------
+                晶片勘誤和軟體補救措施
+                ==================
+
+作者: Will Deacon <will.deacon@arm.com>
+日期: 2015年11月27日
+
+一個不幸的現實：硬體經常帶有一些所謂的「瑕疵（errata）」，導致其在
+某些特定情況下會違背構架定義的行爲。就基於 ARM 的硬體而言，這些瑕疵
+大體可分爲以下幾類：
+
+  A 類：無可行補救措施的嚴重缺陷。
+  B 類：有可接受的補救措施的重大或嚴重缺陷。
+  C 類：在正常操作中不會顯現的小瑕疵。
+
+更多資訊，請在 infocenter.arm.com （需註冊）中查閱「軟體開發者勘誤
+筆記」（「Software Developers Errata Notice」）文檔。
+
+對於 Linux 而言，B 類缺陷可能需要作業系統的某些特別處理。例如，避免
+一個特殊的代碼序列，或是以一種特定的方式配置處理器。在某種不太常見的
+情況下，爲將 A 類缺陷當作 C 類處理，可能需要用類似的手段。這些手段被
+統稱爲「軟體補救措施」，且僅在少數情況需要（例如，那些需要一個運行在
+非安全異常級的補救措施 *並且* 能被 Linux 觸發的情況）。
+
+對於尚在討論中的可能對未受瑕疵影響的系統產生干擾的軟體補救措施，有一個
+相應的內核配置（Kconfig）選項被加在 「內核特性（Kernel Features）」->
+「基於可選方法框架的 ARM 瑕疵補救措施（ARM errata workarounds via
+the alternatives framework）"。這些選項被默認開啓，若探測到受影響的CPU，
+補丁將在運行時被使用。至於對系統運行影響較小的補救措施，內核配置選項
+並不存在，且代碼以某種規避瑕疵的方式被構造（帶注釋爲宜）。
+
+這種做法對於在任意內核原始碼樹中準確地判斷出哪個瑕疵已被軟體方法所補救
+稍微有點麻煩，所以在 Linux 內核中此文件作爲軟體補救措施的註冊表，
+並將在新的軟體補救措施被提交和向後移植（backported）到穩定內核時被更新。
+
+| 實現者         | 受影響的組件    | 勘誤編號        | 內核配置                |
++----------------+-----------------+-----------------+-------------------------+
+| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319    |
+| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319    |
+| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069    |
+| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472    |
+| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719    |
+| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419    |
+| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
+| ARM            | Cortex-A57      | #852523         | N/A                     |
+| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
+|                |                 |                 |                         |
+| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
+| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
+
diff --git a/Documentation/translations/zh_TW/arm64/tagged-pointers.txt b/Documentation/translations/zh_TW/arm64/tagged-pointers.txt
new file mode 100644
index 000000000000..87f88628401a
--- /dev/null
+++ b/Documentation/translations/zh_TW/arm64/tagged-pointers.txt
@@ -0,0 +1,57 @@
+SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/arm64/tagged-pointers.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Will Deacon <will.deacon@arm.com>
+Chinese maintainer: Fu Wei <wefu@redhat.com>
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+---------------------------------------------------------------------
+Documentation/arm64/tagged-pointers.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+
+英文版維護者： Will Deacon <will.deacon@arm.com>
+中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
+中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+
+以下爲正文
+---------------------------------------------------------------------
+		Linux 在 AArch64 中帶標記的虛擬地址
+		=================================
+
+作者: Will Deacon <will.deacon@arm.com>
+日期: 2013 年 06 月 12 日
+
+本文檔簡述了在 AArch64 地址轉換系統中提供的帶標記的虛擬地址及其在
+AArch64 Linux 中的潛在用途。
+
+內核提供的地址轉換表配置使通過 TTBR0 完成的虛擬地址轉換（即用戶空間
+映射），其虛擬地址的最高 8 位（63:56）會被轉換硬體所忽略。這種機制
+讓這些位可供應用程式自由使用，其注意事項如下：
+
+	(1) 內核要求所有傳遞到 EL1 的用戶空間地址帶有 0x00 標記。
+	    這意味著任何攜帶用戶空間虛擬地址的系統調用（syscall）
+	    參數 *必須* 在陷入內核前使它們的最高字節被清零。
+
+	(2) 非零標記在傳遞信號時不被保存。這意味著在應用程式中利用了
+	    標記的信號處理函數無法依賴 siginfo_t 的用戶空間虛擬
+	    地址所攜帶的包含其內部域信息的標記。此規則的一個例外是
+	    當信號是在調試觀察點的異常處理程序中產生的，此時標記的
+	    信息將被保存。
+
+	(3) 當使用帶標記的指針時需特別留心，因爲僅對兩個虛擬地址
+	    的高字節，C 編譯器很可能無法判斷它們是不同的。
+
+此構架會阻止對帶標記的 PC 指針的利用，因此在異常返回時，其高字節
+將被設置成一個爲 「55」 的擴展符。
+
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index 76981b2111f6..5bfc6759ec5e 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -135,6 +135,11 @@ TODOList:
 體系結構無關文檔
 ----------------
 
+.. toctree::
+   :maxdepth: 2
+
+   arm64/index
+
 TODOList:
 
 * asm-annotations
-- 
2.25.1

