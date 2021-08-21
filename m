Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE26B3F39F1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhHUJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:42:06 -0400
Received: from [43.250.32.171] ([43.250.32.171]:5979 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S233730AbhHUJl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=r4rOGx3F7ZK7lTFT1G2RhlLC6o5BCZdA4R8Dw
        NoQmVI=; b=bsPnANKftv7FE/iRTonpeHPp5AkvuDxgbM2kFEbGWTNcuAY2yJ7RW
        OB0msQzoE6vSaVWXOgmtbaFS+6/IskoWeKHpAUgpq9kweWfpuUl1QqD3yKvN9vEn
        a5MdYOuQKWhRMxBnAbGioT94D9p/slxINpeZ+YC2/AeTWrOQlp/tGU=
Received: from localhost.localdomain (unknown [113.251.14.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgD3BAQxyiBh6xE3AA--.56302S3;
        Sat, 21 Aug 2021 17:41:09 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/3] docs/zh_TW: add translations for zh_TW/cpu-freq
Date:   Sat, 21 Aug 2021 17:40:58 +0800
Message-Id: <20210821094059.64300-2-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210821094059.64300-1-src.res@email.cn>
References: <20210821094059.64300-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgD3BAQxyiBh6xE3AA--.56302S3
X-Coremail-Antispam: 1UD129KBjvAXoWftr1DJrW3Wr1DZrW5try8uFg_yoW5JFykZo
        WI9rWrC3WUGF15tFyDJw47JFWUJr42kF48AF47Gr1UWa4UAF1UJ3srJw15Cr13Zr45tF43
        J3WUKr13AF1xJr48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5-7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
        IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vE
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

Create new translations for zh_TW/cpu-freq and link them to index.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../translations/zh_TW/cpu-freq/core.rst      | 108 ++++++++
 .../zh_TW/cpu-freq/cpu-drivers.rst            | 256 ++++++++++++++++++
 .../zh_TW/cpu-freq/cpufreq-stats.rst          | 132 +++++++++
 .../translations/zh_TW/cpu-freq/index.rst     |  47 ++++
 Documentation/translations/zh_TW/index.rst    |   5 +-
 5 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/core.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/index.rst

diff --git a/Documentation/translations/zh_TW/cpu-freq/core.rst b/Documentation/translations/zh_TW/cpu-freq/core.rst
new file mode 100644
index 000000000000..3d890c2f2a61
--- /dev/null
+++ b/Documentation/translations/zh_TW/cpu-freq/core.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../cpu-freq/core`
+:Translator: Yanteng Si <siyanteng@loongson.cn>
+             Hu Haowen <src.res@email.cn>
+
+.. _tw_core.rst:
+
+
+====================================
+CPUFreq核心和CPUFreq通知器的通用說明
+====================================
+
+作者:
+	- Dominik Brodowski  <linux@brodo.de>
+	- David Kimdon <dwhedon@debian.org>
+	- Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+	- Viresh Kumar <viresh.kumar@linaro.org>
+
+.. 目錄:
+
+   1.  CPUFreq核心和接口
+   2.  CPUFreq通知器
+   3.  含有Operating Performance Point (OPP)的CPUFreq表的生成
+
+1. CPUFreq核心和接口
+======================
+
+cpufreq核心代碼位於drivers/cpufreq/cpufreq.c中。這些cpufreq代碼爲CPUFreq架構的驅
+動程序（那些操作硬體切換頻率的代碼）以及 "通知器 "提供了一個標準化的接口。
+這些是設備驅動程序或需要了解策略變化的其它內核部分（如 ACPI 熱量管理）或所有頻率更改（除
+計時代碼外），甚至需要強制確定速度限制的通知器（如 ARM 架構上的 LCD 驅動程序）。
+此外， 內核 "常數" loops_per_jiffy會根據頻率變化而更新。
+
+cpufreq策略的引用計數由 cpufreq_cpu_get 和 cpufreq_cpu_put 來完成，以確保 cpufreq 驅
+動程序被正確地註冊到核心中，並且驅動程序在 cpufreq_put_cpu 被調用之前不會被卸載。這也保證
+了每個CPU核的cpufreq 策略在使用期間不會被釋放。
+
+2. CPUFreq 通知器
+====================
+
+CPUFreq通知器符合標準的內核通知器接口。
+關於通知器的細節請參閱 linux/include/linux/notifier.h。
+
+這裡有兩個不同的CPUfreq通知器 - 策略通知器和轉換通知器。
+
+
+2.1 CPUFreq策略通知器
+----------------------------
+
+當創建或移除策略時，這些都會被通知。
+
+階段是在通知器的第二個參數中指定的。當第一次創建策略時，階段是CPUFREQ_CREATE_POLICY，當
+策略被移除時，階段是CPUFREQ_REMOVE_POLICY。
+
+第三個參數 ``void *pointer`` 指向一個結構體cpufreq_policy，其包括min，max(新策略的下限和
+上限（單位爲kHz）)這幾個值。
+
+
+2.2 CPUFreq轉換通知器
+--------------------------------
+
+當CPUfreq驅動切換CPU核心頻率時，策略中的每個在線CPU都會收到兩次通知，這些變化沒有任何外部干
+預。
+
+第二個參數指定階段 - CPUFREQ_PRECHANGE or CPUFREQ_POSTCHANGE.
+
+第三個參數是一個包含如下值的結構體cpufreq_freqs：
+
+=====	====================
+cpu	受影響cpu的編號
+old	舊頻率
+new	新頻率
+flags	cpufreq驅動的標誌
+=====	====================
+
+3. 含有Operating Performance Point (OPP)的CPUFreq表的生成
+==================================================================
+關於OPP的細節請參閱 Documentation/power/opp.rst
+
+dev_pm_opp_init_cpufreq_table -
+	這個功能提供了一個隨時可用的轉換程序，用來將OPP層關於可用頻率的內部信息翻譯成一種容易提供給
+	cpufreq的格式。
+
+	.. Warning::
+
+		不要在中斷上下文中使用此函數。
+
+	例如::
+
+	 soc_pm_init()
+	 {
+		/* Do things */
+		r = dev_pm_opp_init_cpufreq_table(dev, &freq_table);
+		if (!r)
+			policy->freq_table = freq_table;
+		/* Do other things */
+	 }
+
+	.. note::
+
+		該函數只有在CONFIG_PM_OPP之外還啓用了CONFIG_CPU_FREQ時才可用。
+
+dev_pm_opp_free_cpufreq_table
+	釋放dev_pm_opp_init_cpufreq_table分配的表。
+
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
new file mode 100644
index 000000000000..2bb8197cd320
--- /dev/null
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -0,0 +1,256 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../cpu-freq/cpu-drivers`
+:Translator: Yanteng Si <siyanteng@loongson.cn>
+             Hu Haowen <src.res@email.cn>
+
+.. _tw_cpu-drivers.rst:
+
+
+=======================================
+如何實現一個新的CPUFreq處理器驅動程序？
+=======================================
+
+作者:
+
+
+	- Dominik Brodowski  <linux@brodo.de>
+	- Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+	- Viresh Kumar <viresh.kumar@linaro.org>
+
+.. Contents
+
+   1.   怎麼做？
+   1.1  初始化
+   1.2  Per-CPU 初始化
+   1.3  驗證
+   1.4  target/target_index 或 setpolicy?
+   1.5  target/target_index
+   1.6  setpolicy
+   1.7  get_intermediate 與 target_intermediate
+   2.   頻率表助手
+
+
+
+1. 怎麼做？
+===========
+
+如此，你剛剛得到了一個全新的CPU/晶片組及其數據手冊，並希望爲這個CPU/晶片組添加cpufreq
+支持？很好，這裡有一些至關重要的提示：
+
+
+1.1 初始化
+----------
+
+首先，在__initcall_level_7 (module_init())或更靠後的函數中檢查這個內核是否
+運行在正確的CPU和正確的晶片組上。如果是，則使用cpufreq_register_driver()向
+CPUfreq核心層註冊一個cpufreq_driver結構體。
+
+結構體cpufreq_driver應該包含什麼成員?
+
+ .name - 驅動的名字。
+
+ .init - 一個指向per-policy初始化函數的指針。
+
+ .verify - 一個指向"verification"函數的指針。
+
+ .setpolicy 或 .fast_switch 或 .target 或 .target_index - 差異見
+ 下文。
+
+並且可選擇
+
+ .flags - cpufreq核的提示。
+
+ .driver_data - cpufreq驅動程序的特定數據。
+
+ .get_intermediate 和 target_intermediate - 用於在改變CPU頻率時切換到穩定
+ 的頻率。
+
+ .get - 返回CPU的當前頻率。
+
+ .bios_limit - 返回HW/BIOS對CPU的最大頻率限制值。
+
+ .exit - 一個指向per-policy清理函數的指針，該函數在cpu熱插拔過程的CPU_POST_DEAD
+ 階段被調用。
+
+ .suspend - 一個指向per-policy暫停函數的指針，該函數在關中斷且在該策略的調節器停止
+ 後被調用。
+
+ .resume - 一個指向per-policy恢復函數的指針，該函數在關中斷且在調節器再一次開始前被
+ 調用。
+
+ .ready - 一個指向per-policy準備函數的指針，該函數在策略完全初始化之後被調用。
+
+ .attr - 一個指向NULL結尾的"struct freq_attr"列表的指針，該函數允許導出值到
+ sysfs。
+
+ .boost_enabled - 如果設置，則啓用提升(boost)頻率。
+
+ .set_boost - 一個指向per-policy函數的指針，該函數用來開啓/關閉提升(boost)頻率功能。
+
+
+1.2 Per-CPU 初始化
+------------------
+
+每當一個新的CPU被註冊到設備模型中，或者在cpufreq驅動註冊自己之後，如果此CPU的cpufreq策
+略不存在，則會調用per-policy的初始化函數cpufreq_driver.init。請注意，.init()和.exit()程序
+只對策略調用一次，而不是對策略管理的每個CPU調用一次。它需要一個 ``struct cpufreq_policy
+*policy`` 作爲參數。現在該怎麼做呢？
+
+如果有必要，請在你的CPU上激活CPUfreq功能支持。
+
+然後，驅動程序必須填寫以下數值:
+
++-----------------------------------+--------------------------------------+
+|policy->cpuinfo.min_freq 和	   |					  |
+|policy->cpuinfo.max_freq	    | 該CPU支持的最低和最高頻率（kHz）     |
+|				    |                                      |
+|				    | 				           |
++-----------------------------------+--------------------------------------+
+|policy->cpuinfo.transition_latency |                                      |
+|				    | CPU在兩個頻率之間切換所需的時間，以  |
+|				    | 納秒爲單位（如適用，否則指定         |
+|				    | CPUFREQ_ETERNAL）                    |
++-----------------------------------+--------------------------------------+
+|policy->cur			    | 該CPU當前的工作頻率(如適用)          |
+|				    |                                      |
++-----------------------------------+--------------------------------------+
+|policy->min,			    |					   |
+|policy->max,			    |					   |
+|policy->policy and, if necessary,  |					   |
+|policy->governor		    | 必須包含該cpu的 「默認策略」。稍後   |
+|				    | 會用這些值調用                       |
+|				    | cpufreq_driver.verify and either     |
+|				    | cpufreq_driver.setpolicy or          |
+|				    | cpufreq_driver.target/target_index   |
+|				    | 		                           |
++-----------------------------------+--------------------------------------+
+|policy->cpus			    | 用與這個CPU一起做DVFS的(在線+離線)   |
+|				    | CPU(即與它共享時鐘/電壓軌)的掩碼更新 |
+|				    | 這個                                 |
+|				    |                                      |
++-----------------------------------+--------------------------------------+
+
+對於設置其中的一些值(cpuinfo.min[max]_freq, policy->min[max])，頻率表助手可能會有幫
+助。關於它們的更多信息，請參見第2節。
+
+
+1.3 驗證
+--------
+
+當用戶決定設置一個新的策略(由 「policy,governor,min,max組成」)時，必須對這個策略進行驗證，
+以便糾正不兼容的值。爲了驗證這些值，cpufreq_verify_within_limits(``struct cpufreq_policy
+*policy``, ``unsigned int min_freq``, ``unsigned int max_freq``)函數可能會有幫助。
+關於頻率表助手的詳細內容請參見第2節。
+
+您需要確保至少有一個有效頻率（或工作範圍）在 policy->min 和 policy->max 範圍內。如果有必
+要，先增加policy->max，只有在沒有辦法的情況下，才減少policy->min。
+
+
+1.4 target 或 target_index 或 setpolicy 或 fast_switch?
+-------------------------------------------------------
+
+大多數cpufreq驅動甚至大多數cpu頻率升降算法只允許將CPU頻率設置爲預定義的固定值。對於這些，你
+可以使用->target()，->target_index()或->fast_switch()回調。
+
+有些cpufreq功能的處理器可以自己在某些限制之間切換頻率。這些應使用->setpolicy()回調。
+
+
+1.5. target/target_index
+------------------------
+
+target_index調用有兩個參數：``struct cpufreq_policy * policy``和``unsigned int``
+索引(於列出的頻率表)。
+
+當調用這裡時，CPUfreq驅動必須設置新的頻率。實際頻率必須由freq_table[index].frequency決定。
+
+它應該總是在錯誤的情況下恢復到之前的頻率(即policy->restore_freq)，即使我們之前切換到中間頻率。
+
+已棄用
+----------
+目標調用有三個參數。``struct cpufreq_policy * policy``, unsigned int target_frequency,
+unsigned int relation.
+
+CPUfreq驅動在調用這裡時必須設置新的頻率。實際的頻率必須使用以下規則來確定。
+
+- 緊跟 "目標頻率"。
+- policy->min <= new_freq <= policy->max (這必須是有效的!!!)
+- 如果 relation==CPUFREQ_REL_L，嘗試選擇一個高於或等於 target_freq 的 new_freq。("L代表
+  最低，但不能低於")
+- 如果 relation==CPUFREQ_REL_H，嘗試選擇一個低於或等於 target_freq 的 new_freq。("H代表
+  最高，但不能高於")
+
+這裡，頻率表助手可能會幫助你--詳見第2節。
+
+1.6. fast_switch
+----------------
+
+這個函數用於從調度器的上下文進行頻率切換。並非所有的驅動都要實現它，因爲不允許在這個回調中睡眠。這
+個回調必須經過高度優化，以儘可能快地進行切換。
+
+這個函數有兩個參數： ``struct cpufreq_policy *policy`` 和 ``unsigned int target_frequency``。
+
+
+1.7 setpolicy
+-------------
+
+setpolicy調用只需要一個``struct cpufreq_policy * policy``作爲參數。需要將處理器內或晶片組內動態頻
+率切換的下限設置爲policy->min，上限設置爲policy->max，如果支持的話，當policy->policy爲
+CPUFREQ_POLICY_PERFORMANCE時選擇面向性能的設置，當CPUFREQ_POLICY_POWERSAVE時選擇面向省電的設置。
+也可以查看drivers/cpufreq/longrun.c中的參考實現。
+
+1.8 get_intermediate 和 target_intermediate
+--------------------------------------------
+
+僅適用於 target_index() 和 CPUFREQ_ASYNC_NOTIFICATION 未設置的驅動。
+
+get_intermediate應該返回一個平台想要切換到的穩定的中間頻率，target_intermediate()應該將CPU設置爲
+該頻率，然後再跳轉到'index'對應的頻率。核心會負責發送通知，驅動不必在target_intermediate()或
+target_index()中處理。
+
+在驅動程序不想因爲某個目標頻率切換到中間頻率的情況下，它們可以從get_intermediate()中返回'0'。在這種情況
+下，核心將直接調用->target_index()。
+
+注意：->target_index()應該在失敗的情況下恢復到policy->restore_freq，因爲core會爲此發送通知。
+
+
+2. 頻率表助手
+=============
+
+由於大多數cpufreq處理器只允許被設置爲幾個特定的頻率，因此，一個帶有一些函數的 「頻率表」可能會輔助處理器驅動
+程序的一些工作。這樣的 "頻率表" 由一個cpufreq_frequency_table條目構成的數組組成，"driver_data" 中包
+含了驅動程序的具體數值，"frequency" 中包含了相應的頻率，並設置了標誌。在表的最後，需要添加一個
+cpufreq_frequency_table條目，頻率設置爲CPUFREQ_TABLE_END。而如果想跳過表中的一個條目，則將頻率設置爲
+CPUFREQ_ENTRY_INVALID。這些條目不需要按照任何特定的順序排序，但如果它們是cpufreq 核心會對它們進行快速的DVFS，
+因爲搜索最佳匹配會更快。
+
+如果策略在其policy->freq_table欄位中包含一個有效的指針，cpufreq表就會被核心自動驗證。
+
+cpufreq_frequency_table_verify()保證至少有一個有效的頻率在policy->min和policy->max範圍內，並且所有其他
+標準都被滿足。這對->verify調用很有幫助。
+
+cpufreq_frequency_table_target()是對應於->target階段的頻率表助手。只要把數值傳遞給這個函數，這個函數就會返
+回包含CPU要設置的頻率的頻率表條目。
+
+以下宏可以作爲cpufreq_frequency_table的疊代器。
+
+cpufreq_for_each_entry(pos, table) - 遍歷頻率表的所有條目。
+
+cpufreq_for_each_valid_entry(pos, table) - 該函數遍歷所有條目，不包括CPUFREQ_ENTRY_INVALID頻率。
+使用參數 "pos"-一個``cpufreq_frequency_table * `` 作爲循環變量，使用參數 "table"-作爲你想疊代
+的``cpufreq_frequency_table * `` 。
+
+例如::
+
+	struct cpufreq_frequency_table *pos, *driver_freq_table;
+
+	cpufreq_for_each_entry(pos, driver_freq_table) {
+		/* Do something with pos */
+		pos->frequency = ...
+	}
+
+如果你需要在driver_freq_table中處理pos的位置，不要減去指針，因爲它的代價相當高。相反，使用宏
+cpufreq_for_each_entry_idx() 和 cpufreq_for_each_valid_entry_idx() 。
+
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
new file mode 100644
index 000000000000..d80bfed50e8c
--- /dev/null
+++ b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
@@ -0,0 +1,132 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../cpu-freq/cpufreq-stats`
+:Translator: Yanteng Si <siyanteng@loongson.cn>
+             Hu Haowen <src.res@email.cn>
+
+.. _tw_cpufreq-stats.rst:
+
+
+==========================================
+sysfs CPUFreq Stats的一般說明
+==========================================
+
+用戶信息
+
+
+作者: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+
+.. Contents
+
+   1. 簡介
+   2. 提供的統計數據(舉例說明)
+   3. 配置cpufreq-stats
+
+
+1. 簡介
+===============
+
+cpufreq-stats是一個爲每個CPU提供CPU頻率統計的驅動。
+這些統計數據在/sysfs中以一堆只讀接口的形式提供。這個接口（在配置好後）將出現在
+/sysfs（<sysfs root>/devices/system/cpu/cpuX/cpufreq/stats/）中cpufreq下的一個單
+獨的目錄中，提供給每個CPU。
+各種統計數據將在此目錄下形成只讀文件。
+
+此驅動是獨立於任何可能運行在你所用CPU上的特定cpufreq_driver而設計的。因此，它將與所有
+cpufreq_driver一起工作。
+
+
+2. 提供的統計數據(舉例說明)
+=====================================
+
+cpufreq stats提供了以下統計數據（在下面詳細解釋）。
+
+-  time_in_state
+-  total_trans
+-  trans_table
+
+所有的統計數據將從統計驅動被載入的時間（或統計被重置的時間）開始，到某一統計數據被讀取的時間爲止。
+顯然，統計驅動不會有任何關於統計驅動載入之前的頻率轉換信息。
+
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # ls -l
+    total 0
+    drwxr-xr-x  2 root root    0 May 14 16:06 .
+    drwxr-xr-x  3 root root    0 May 14 15:58 ..
+    --w-------  1 root root 4096 May 14 16:06 reset
+    -r--r--r--  1 root root 4096 May 14 16:06 time_in_state
+    -r--r--r--  1 root root 4096 May 14 16:06 total_trans
+    -r--r--r--  1 root root 4096 May 14 16:06 trans_table
+
+- **reset**
+
+只寫屬性，可用於重置統計計數器。這對於評估不同調節器下的系統行爲非常有用，且無需重啓。
+
+
+- **time_in_state**
+
+此項給出了這個CPU所支持的每個頻率所花費的時間。cat輸出的每一行都會有"<frequency>
+<time>"對，表示這個CPU在<frequency>上花費了<time>個usertime單位的時間。這裡的
+usertime單位是10mS（類似於/proc中輸出的其他時間）。
+
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat time_in_state
+    3600000 2089
+    3400000 136
+    3200000 34
+    3000000 67
+    2800000 172488
+
+
+- **total_trans**
+
+給出了這個CPU上頻率轉換的總次數。cat的輸出將有一個單一的計數，這就是頻率轉換的總數。
+
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat total_trans
+    20
+
+- **trans_table**
+
+這將提供所有CPU頻率轉換的細粒度信息。這裡的cat輸出是一個二維矩陣，其中一個條目<i, j>（第
+i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列遵循驅動最初提供給cpufreq
+核的頻率表的排序順序，因此可以排序（升序或降序）或不排序。 這裡的輸出也包含了每行每列的實際
+頻率值，以便更好地閱讀。
+
+如果轉換表大於PAGE_SIZE，讀取時將返回一個-EFBIG錯誤。
+
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
+    From  :    To
+	    :   3600000   3400000   3200000   3000000   2800000
+    3600000:         0         5         0         0         0
+    3400000:         4         0         2         0         0
+    3200000:         0         1         0         2         0
+    3000000:         0         0         1         0         3
+    2800000:         0         0         0         2         0
+
+3. 配置cpufreq-stats
+============================
+
+要在你的內核中配置cpufreq-stats::
+
+	Config Main Menu
+		Power management options (ACPI, APM)  --->
+			CPU Frequency scaling  --->
+				[*] CPU Frequency scaling
+				[*]   CPU frequency translation statistics
+
+
+"CPU Frequency scaling" (CONFIG_CPU_FREQ) 應該被啓用以配置cpufreq-stats。
+
+"CPU frequency translation statistics" (CONFIG_CPU_FREQ_STAT)提供了包括
+time_in_state、total_trans和trans_table的統計數據。
+
+一旦啓用了這個選項，並且你的CPU支持cpufrequency，你就可以在/sysfs中看到CPU頻率統計。
+
diff --git a/Documentation/translations/zh_TW/cpu-freq/index.rst b/Documentation/translations/zh_TW/cpu-freq/index.rst
new file mode 100644
index 000000000000..1a8e680f95ed
--- /dev/null
+++ b/Documentation/translations/zh_TW/cpu-freq/index.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../cpu-freq/index`
+:Translator: Yanteng Si <siyanteng@loongson.cn>
+             Hu Haowen <src.res@email.cn>
+
+.. _tw_index.rst:
+
+
+=======================================================
+Linux CPUFreq - Linux(TM)內核中的CPU頻率和電壓升降代碼
+=======================================================
+
+Author: Dominik Brodowski  <linux@brodo.de>
+
+      時鐘升降允許你在運行中改變CPU的時鐘速度。這是一個很好的節省電池電量的方法，因爲時
+      鐘速度越低，CPU消耗的電量越少。
+
+
+.. toctree::
+   :maxdepth: 1
+
+   core
+   cpu-drivers
+   cpufreq-stats
+
+郵件列表
+------------
+這裡有一個 CPU 頻率變化的 CVS 提交和通用列表，您可以在這裡報告bug、問題或提交補丁。要發
+布消息，請發送電子郵件到 linux-pm@vger.kernel.org。
+
+連結
+-----
+FTP檔案:
+* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
+
+如何訪問CVS倉庫:
+* http://cvs.arm.linux.org.uk/
+
+CPUFreq郵件列表:
+* http://vger.kernel.org/vger-lists.html#linux-pm
+
+SA-1100的時鐘和電壓標度:
+* http://www.lartmaker.nl/projects/scaling
+
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index 5bfc6759ec5e..aa6f4195f396 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -88,6 +88,10 @@ TODOList:
 大部分信息都是直接從內核原始碼獲取的，並根據需要添加補充材料（或者至少是在
 我們設法添加的時候——可能不是所有的都是有需要的）。
 
+.. toctree::
+   :maxdepth: 2
+   cpu-freq/index
+
 TODOList:
 
 * driver-api/index
@@ -96,7 +100,6 @@ TODOList:
 * accounting/index
 * block/index
 * cdrom/index
-* cpu-freq/index
 * ide/index
 * fb/index
 * fpga/index
-- 
2.25.1

