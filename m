Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F823F39F2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhHUJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:42:11 -0400
Received: from [43.250.32.171] ([43.250.32.171]:5987 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S233759AbhHUJl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=B09Z5MNWK2V7C7AYjHNKre6AZfb8hkHWxT03l
        pSGoJ0=; b=GjMyveYq0xOYlSu0ztzqBCEwU25UU2SoPYpw5L01QsAQ7OA3f54Gv
        4mS+NFpzbvYLzh1AIrYTX6tI9PNw70pqtYhwTQBj3rpBad9SvAEdRJXr4mxZmiMF
        jTr0/5fb0mPJoUgMNozIqNlQk862mchjPHqERgp/xCc45r7AvhxAvY=
Received: from localhost.localdomain (unknown [113.251.14.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgD3BAQxyiBh6xE3AA--.56302S4;
        Sat, 21 Aug 2021 17:41:15 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 3/3] docs/zh_TW: add translations for zh_TW/filesystems
Date:   Sat, 21 Aug 2021 17:40:59 +0800
Message-Id: <20210821094059.64300-3-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210821094059.64300-1-src.res@email.cn>
References: <20210821094059.64300-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgD3BAQxyiBh6xE3AA--.56302S4
X-Coremail-Antispam: 1UD129KBjvAXoWDWF45ur1kZFy7Zry8Kr43GFg_yoWrWr1kKo
        W2vrW5uw48AF1YqFWrKa1xJFWDCa13CFWDZr45Gr909r1jkF1rZw1UXw1fJwnxZrW5Ja13
        A34fXa13AF15Xa18n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5T7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
        IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vE
        x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr4
        1l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jH
        BTOUUUUU=
X-Originating-IP: [113.251.14.129]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new translations for zh_TW/filesystems and link them to index.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../zh_TW/filesystems/debugfs.rst             | 224 +++++++++++
 .../translations/zh_TW/filesystems/index.rst  |  31 ++
 .../translations/zh_TW/filesystems/sysfs.txt  | 377 ++++++++++++++++++
 .../translations/zh_TW/filesystems/tmpfs.rst  | 148 +++++++
 .../zh_TW/filesystems/virtiofs.rst            |  61 +++
 Documentation/translations/zh_TW/index.rst    |   3 +-
 6 files changed, 843 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_TW/filesystems/debugfs.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/index.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/sysfs.txt
 create mode 100644 Documentation/translations/zh_TW/filesystems/tmpfs.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/virtiofs.rst

diff --git a/Documentation/translations/zh_TW/filesystems/debugfs.rst b/Documentation/translations/zh_TW/filesystems/debugfs.rst
new file mode 100644
index 000000000000..270dd94fddf1
--- /dev/null
+++ b/Documentation/translations/zh_TW/filesystems/debugfs.rst
@@ -0,0 +1,224 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :doc:`../../../filesystems/debugfs`
+
+=======
+Debugfs
+=======
+
+譯者
+::
+
+	中文版維護者：羅楚成 Chucheng Luo <luochucheng@vivo.com>
+	中文版翻譯者：羅楚成 Chucheng Luo <luochucheng@vivo.com>
+	中文版校譯者: 羅楚成 Chucheng Luo <luochucheng@vivo.com>
+	繁體中文版校譯者: 胡皓文 Hu Haowen <src.res@email.cn>
+
+
+
+版權所有2020 羅楚成 <luochucheng@vivo.com>
+版權所有2021 胡皓文 Hu Haowen <src.res@email.cn>
+
+
+Debugfs是內核開發人員在用戶空間獲取信息的簡單方法。與/proc不同，proc只提供進程
+信息。也不像sysfs,具有嚴格的「每個文件一個值「的規則。debugfs根本沒有規則,開發
+人員可以在這裡放置他們想要的任何信息。debugfs文件系統也不能用作穩定的ABI接口。
+從理論上講，debugfs導出文件的時候沒有任何約束。但是[1]實際情況並不總是那麼
+簡單。即使是debugfs接口，也最好根據需要進行設計,並儘量保持接口不變。
+
+
+Debugfs通常使用以下命令安裝::
+
+    mount -t debugfs none /sys/kernel/debug
+
+（或等效的/etc/fstab行）。
+debugfs根目錄默認僅可由root用戶訪問。要更改對文件樹的訪問，請使用「 uid」，「 gid」
+和「 mode」掛載選項。請注意，debugfs API僅按照GPL協議導出到模塊。
+
+使用debugfs的代碼應包含<linux/debugfs.h>。然後，首先是創建至少一個目錄來保存
+一組debugfs文件::
+
+    struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
+
+如果成功，此調用將在指定的父目錄下創建一個名爲name的目錄。如果parent參數爲空，
+則會在debugfs根目錄中創建。創建目錄成功時，返回值是一個指向dentry結構體的指針。
+該dentry結構體的指針可用於在目錄中創建文件（以及最後將其清理乾淨）。ERR_PTR
+（-ERROR）返回值表明出錯。如果返回ERR_PTR（-ENODEV），則表明內核是在沒有debugfs
+支持的情況下構建的，並且下述函數都不會起作用。
+
+在debugfs目錄中創建文件的最通用方法是::
+
+    struct dentry *debugfs_create_file(const char *name, umode_t mode,
+				       struct dentry *parent, void *data,
+				       const struct file_operations *fops);
+
+在這裡，name是要創建的文件的名稱，mode描述了訪問文件應具有的權限，parent指向
+應該保存文件的目錄，data將存儲在產生的inode結構體的i_private欄位中，而fops是
+一組文件操作函數，這些函數中實現文件操作的具體行爲。至少，read（）和/或
+write（）操作應提供；其他可以根據需要包括在內。同樣的，返回值將是指向創建文件
+的dentry指針，錯誤時返回ERR_PTR（-ERROR），系統不支持debugfs時返回值爲ERR_PTR
+（-ENODEV）。創建一個初始大小的文件，可以使用以下函數代替::
+
+    struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
+				struct dentry *parent, void *data,
+				const struct file_operations *fops,
+				loff_t file_size);
+
+file_size是初始文件大小。其他參數跟函數debugfs_create_file的相同。
+
+在許多情況下，沒必要自己去創建一組文件操作;對於一些簡單的情況,debugfs代碼提供
+了許多幫助函數。包含單個整數值的文件可以使用以下任何一項創建::
+
+    void debugfs_create_u8(const char *name, umode_t mode,
+			   struct dentry *parent, u8 *value);
+    void debugfs_create_u16(const char *name, umode_t mode,
+			    struct dentry *parent, u16 *value);
+    struct dentry *debugfs_create_u32(const char *name, umode_t mode,
+				      struct dentry *parent, u32 *value);
+    void debugfs_create_u64(const char *name, umode_t mode,
+			    struct dentry *parent, u64 *value);
+
+這些文件支持讀取和寫入給定值。如果某個文件不支持寫入，只需根據需要設置mode
+參數位。這些文件中的值以十進位表示；如果需要使用十六進位，可以使用以下函數
+替代::
+
+    void debugfs_create_x8(const char *name, umode_t mode,
+			   struct dentry *parent, u8 *value);
+    void debugfs_create_x16(const char *name, umode_t mode,
+			    struct dentry *parent, u16 *value);
+    void debugfs_create_x32(const char *name, umode_t mode,
+			    struct dentry *parent, u32 *value);
+    void debugfs_create_x64(const char *name, umode_t mode,
+			    struct dentry *parent, u64 *value);
+
+這些功能只有在開發人員知道導出值的大小的時候才有用。某些數據類型在不同的架構上
+有不同的寬度，這樣會使情況變得有些複雜。在這種特殊情況下可以使用以下函數::
+
+    void debugfs_create_size_t(const char *name, umode_t mode,
+			       struct dentry *parent, size_t *value);
+
+不出所料，此函數將創建一個debugfs文件來表示類型爲size_t的變量。
+
+同樣地，也有導出無符號長整型變量的函數，分別以十進位和十六進位表示如下::
+
+    struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
+					struct dentry *parent,
+					unsigned long *value);
+    void debugfs_create_xul(const char *name, umode_t mode,
+			    struct dentry *parent, unsigned long *value);
+
+布爾值可以通過以下方式放置在debugfs中::
+
+    struct dentry *debugfs_create_bool(const char *name, umode_t mode,
+				       struct dentry *parent, bool *value);
+
+
+讀取結果文件將產生Y（對於非零值）或N，後跟換行符寫入的時候，它只接受大寫或小寫
+值或1或0。任何其他輸入將被忽略。
+
+同樣，atomic_t類型的值也可以放置在debugfs中::
+
+    void debugfs_create_atomic_t(const char *name, umode_t mode,
+				 struct dentry *parent, atomic_t *value)
+
+讀取此文件將獲得atomic_t值，寫入此文件將設置atomic_t值。
+
+另一個選擇是通過以下結構體和函數導出一個任意二進位數據塊::
+
+    struct debugfs_blob_wrapper {
+	void *data;
+	unsigned long size;
+    };
+
+    struct dentry *debugfs_create_blob(const char *name, umode_t mode,
+				       struct dentry *parent,
+				       struct debugfs_blob_wrapper *blob);
+
+讀取此文件將返回由指針指向debugfs_blob_wrapper結構體的數據。一些驅動使用「blobs」
+作爲一種返回幾行（靜態）格式化文本的簡單方法。這個函數可用於導出二進位信息，但
+似乎在主線中沒有任何代碼這樣做。請注意，使用debugfs_create_blob（）命令創建的
+所有文件是只讀的。
+
+如果您要轉儲一個寄存器塊（在開發過程中經常會這麼做，但是這樣的調試代碼很少上傳
+到主線中。Debugfs提供兩個函數：一個用於創建僅寄存器文件，另一個把一個寄存器塊
+插入一個順序文件中::
+
+    struct debugfs_reg32 {
+	char *name;
+	unsigned long offset;
+    };
+
+    struct debugfs_regset32 {
+	struct debugfs_reg32 *regs;
+	int nregs;
+	void __iomem *base;
+    };
+
+    struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
+				     struct dentry *parent,
+				     struct debugfs_regset32 *regset);
+
+    void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
+			 int nregs, void __iomem *base, char *prefix);
+
+「base」參數可能爲0，但您可能需要使用__stringify構建reg32數組，實際上有許多寄存器
+名稱（宏）是寄存器塊在基址上的字節偏移量。
+
+如果要在debugfs中轉儲u32數組，可以使用以下函數創建文件::
+
+     void debugfs_create_u32_array(const char *name, umode_t mode,
+			struct dentry *parent,
+			u32 *array, u32 elements);
+
+「array」參數提供數據，而「elements」參數爲數組中元素的數量。注意：數組創建後，數組
+大小無法更改。
+
+有一個函數來創建與設備相關的seq_file::
+
+   struct dentry *debugfs_create_devm_seqfile(struct device *dev,
+				const char *name,
+				struct dentry *parent,
+				int (*read_fn)(struct seq_file *s,
+					void *data));
+
+「dev」參數是與此debugfs文件相關的設備，並且「read_fn」是一個函數指針，這個函數在
+列印seq_file內容的時候被回調。
+
+還有一些其他的面向目錄的函數::
+
+    struct dentry *debugfs_rename(struct dentry *old_dir,
+		                  struct dentry *old_dentry,
+		                  struct dentry *new_dir,
+				  const char *new_name);
+
+    struct dentry *debugfs_create_symlink(const char *name,
+                                          struct dentry *parent,
+                                          const char *target);
+
+調用debugfs_rename()將爲現有的debugfs文件重命名，可能同時切換目錄。 new_name
+函數調用之前不能存在；返回值爲old_dentry，其中包含更新的信息。可以使用
+debugfs_create_symlink（）創建符號連結。
+
+所有debugfs用戶必須考慮的一件事是：
+
+debugfs不會自動清除在其中創建的任何目錄。如果一個模塊在不顯式刪除debugfs目錄的
+情況下卸載模塊，結果將會遺留很多野指針，從而導致系統不穩定。因此，所有debugfs
+用戶-至少是那些可以作爲模塊構建的用戶-必須做模塊卸載的時候準備刪除在此創建的
+所有文件和目錄。一份文件可以通過以下方式刪除::
+
+    void debugfs_remove(struct dentry *dentry);
+
+dentry值可以爲NULL或錯誤值，在這種情況下，不會有任何文件被刪除。
+
+很久以前，內核開發者使用debugfs時需要記錄他們創建的每個dentry指針，以便最後所有
+文件都可以被清理掉。但是，現在debugfs用戶能調用以下函數遞歸清除之前創建的文件::
+
+    void debugfs_remove_recursive(struct dentry *dentry);
+
+如果將對應頂層目錄的dentry傳遞給以上函數，則該目錄下的整個層次結構將會被刪除。
+
+注釋：
+[1] http://lwn.net/Articles/309298/
+
diff --git a/Documentation/translations/zh_TW/filesystems/index.rst b/Documentation/translations/zh_TW/filesystems/index.rst
new file mode 100644
index 000000000000..4e5dde0dca3c
--- /dev/null
+++ b/Documentation/translations/zh_TW/filesystems/index.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
+:Translator: Wang Wenhu <wenhu.wang@vivo.com>
+             Hu Haowen <src.res@email.cn>
+
+.. _tw_filesystems_index:
+
+========================
+Linux Kernel中的文件系統
+========================
+
+這份正在開發的手冊或許在未來某個輝煌的日子裡以易懂的形式將Linux虛擬\
+文件系統（VFS）層以及基於其上的各種文件系統如何工作呈現給大家。當前\
+可以看到下面的內容。
+
+文件系統
+========
+
+文件系統實現文檔。
+
+.. toctree::
+   :maxdepth: 2
+
+   virtiofs
+   debugfs
+   tmpfs
+
+
diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Documentation/translations/zh_TW/filesystems/sysfs.txt
new file mode 100644
index 000000000000..acd677f19d4f
--- /dev/null
+++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
@@ -0,0 +1,377 @@
+SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/filesystems/sysfs.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Patrick Mochel	<mochel@osdl.org>
+		Mike Murphy <mamurph@cs.clemson.edu>
+Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
+---------------------------------------------------------------------
+Documentation/filesystems/sysfs.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+英文版維護者： Patrick Mochel	<mochel@osdl.org>
+		Mike Murphy <mamurph@cs.clemson.edu>
+中文版維護者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
+中文版翻譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
+中文版校譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
+繁體中文版校譯者：胡皓文 Hu Haowen <src.res@email.cn>
+
+
+以下爲正文
+---------------------------------------------------------------------
+sysfs - 用於導出內核對象(kobject)的文件系統
+
+Patrick Mochel	<mochel@osdl.org>
+Mike Murphy <mamurph@cs.clemson.edu>
+
+修訂:    16 August 2011
+原始版本:   10 January 2003
+
+
+sysfs 簡介:
+~~~~~~~~~~
+
+sysfs 是一個最初基於 ramfs 且位於內存的文件系統。它提供導出內核
+數據結構及其屬性，以及它們之間的關聯到用戶空間的方法。
+
+sysfs 始終與 kobject 的底層結構緊密相關。請閱讀
+Documentation/core-api/kobject.rst 文檔以獲得更多關於 kobject 接口的
+信息。
+
+
+使用 sysfs
+~~~~~~~~~~~
+
+只要內核配置中定義了 CONFIG_SYSFS ，sysfs 總是被編譯進內核。你可
+通過以下命令掛載它:
+
+    mount -t sysfs sysfs /sys
+
+
+創建目錄
+~~~~~~~~
+
+任何 kobject 在系統中註冊，就會有一個目錄在 sysfs 中被創建。這個
+目錄是作爲該 kobject 的父對象所在目錄的子目錄創建的，以準確地傳遞
+內核的對象層次到用戶空間。sysfs 中的頂層目錄代表著內核對象層次的
+共同祖先；例如：某些對象屬於某個子系統。
+
+Sysfs 在與其目錄關聯的 kernfs_node 對象中內部保存一個指向實現
+目錄的 kobject 的指針。以前，這個 kobject 指針被 sysfs 直接用於
+kobject 文件打開和關閉的引用計數。而現在的 sysfs 實現中，kobject
+引用計數只能通過 sysfs_schedule_callback() 函數直接修改。
+
+
+屬性
+~~~~
+
+kobject 的屬性可在文件系統中以普通文件的形式導出。Sysfs 爲屬性定義
+了面向文件 I/O 操作的方法，以提供對內核屬性的讀寫。
+
+
+屬性應爲 ASCII 碼文本文件。以一個文件只存儲一個屬性值爲宜。但一個
+文件只包含一個屬性值可能影響效率，所以一個包含相同數據類型的屬性值
+數組也被廣泛地接受。
+
+混合類型、表達多行數據以及一些怪異的數據格式會遭到強烈反對。這樣做是
+很丟臉的,而且其代碼會在未通知作者的情況下被重寫。
+
+
+一個簡單的屬性結構定義如下:
+
+struct attribute {
+        char                    * name;
+        struct module		*owner;
+        umode_t                 mode;
+};
+
+
+int sysfs_create_file(struct kobject * kobj, const struct attribute * attr);
+void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr);
+
+
+一個單獨的屬性結構並不包含讀寫其屬性值的方法。子系統最好爲增刪特定
+對象類型的屬性定義自己的屬性結構體和封裝函數。
+
+例如:驅動程序模型定義的 device_attribute 結構體如下:
+
+struct device_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
+};
+
+int device_create_file(struct device *, const struct device_attribute *);
+void device_remove_file(struct device *, const struct device_attribute *);
+
+爲了定義設備屬性，同時定義了一下輔助宏:
+
+#define DEVICE_ATTR(_name, _mode, _show, _store) \
+struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
+
+例如:聲明
+
+static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo);
+
+等同於如下代碼：
+
+static struct device_attribute dev_attr_foo = {
+       .attr	= {
+		.name = "foo",
+		.mode = S_IWUSR | S_IRUGO,
+		.show = show_foo,
+		.store = store_foo,
+	},
+};
+
+
+子系統特有的回調函數
+~~~~~~~~~~~~~~~~~~~
+
+當一個子系統定義一個新的屬性類型時，必須實現一系列的 sysfs 操作，
+以幫助讀寫調用實現屬性所有者的顯示和儲存方法。
+
+struct sysfs_ops {
+        ssize_t (*show)(struct kobject *, struct attribute *, char *);
+        ssize_t (*store)(struct kobject *, struct attribute *, const char *, size_t);
+};
+
+[子系統應已經定義了一個 struct kobj_type 結構體作爲這個類型的
+描述符，並在此保存 sysfs_ops 的指針。更多的信息參見 kobject 的
+文檔]
+
+sysfs 會爲這個類型調用適當的方法。當一個文件被讀寫時，這個方法會
+將一般的kobject 和 attribute 結構體指針轉換爲適當的指針類型後
+調用相關聯的函數。
+
+
+示例:
+
+#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
+
+static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
+                             char *buf)
+{
+        struct device_attribute *dev_attr = to_dev_attr(attr);
+        struct device *dev = kobj_to_dev(kobj);
+        ssize_t ret = -EIO;
+
+        if (dev_attr->show)
+                ret = dev_attr->show(dev, dev_attr, buf);
+        if (ret >= (ssize_t)PAGE_SIZE) {
+                printk("dev_attr_show: %pS returned bad count\n",
+                                dev_attr->show);
+        }
+        return ret;
+}
+
+
+
+讀寫屬性數據
+~~~~~~~~~~~~
+
+在聲明屬性時，必須指定 show() 或 store() 方法，以實現屬性的
+讀或寫。這些方法的類型應該和以下的設備屬性定義一樣簡單。
+
+ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf);
+ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+                 const char *buf, size_t count);
+
+也就是說,他們應只以一個處理對象、一個屬性和一個緩衝指針作爲參數。
+
+sysfs 會分配一個大小爲 (PAGE_SIZE) 的緩衝區並傳遞給這個方法。
+Sysfs 將會爲每次讀寫操作調用一次這個方法。這使得這些方法在執行時
+會出現以下的行爲:
+
+- 在讀方面（read(2)），show() 方法應該填充整個緩衝區。回想屬性
+  應只導出了一個屬性值或是一個同類型屬性值的數組，所以這個代價將
+  不會不太高。
+
+  這使得用戶空間可以局部地讀和任意的向前搜索整個文件。如果用戶空間
+  向後搜索到零或使用『0』偏移執行一個pread(2)操作，show()方法將
+  再次被調用，以重新填充緩存。
+
+- 在寫方面（write(2)），sysfs 希望在第一次寫操作時得到整個緩衝區。
+  之後 Sysfs 傳遞整個緩衝區給 store() 方法。
+
+  當要寫 sysfs 文件時，用戶空間進程應首先讀取整個文件，修該想要
+  改變的值，然後回寫整個緩衝區。
+
+  在讀寫屬性值時，屬性方法的執行應操作相同的緩衝區。
+
+註記:
+
+- 寫操作導致的 show() 方法重載，會忽略當前文件位置。
+
+- 緩衝區應總是 PAGE_SIZE 大小。對於i386，這個值爲4096。
+
+- show() 方法應該返回寫入緩衝區的字節數，也就是 scnprintf()的
+  返回值。
+
+- show() 方法在將格式化返回值返回用戶空間的時候，禁止使用snprintf()。
+  如果可以保證不會發生緩衝區溢出，可以使用sprintf()，否則必須使用
+  scnprintf()。
+
+- store() 應返回緩衝區的已用字節數。如果整個緩存都已填滿，只需返回
+  count 參數。
+
+- show() 或 store() 可以返回錯誤值。當得到一個非法值，必須返回一個
+  錯誤值。
+
+- 一個傳遞給方法的對象將會通過 sysfs 調用對象內嵌的引用計數固定在
+  內存中。儘管如此，對象代表的物理實體(如設備)可能已不存在。如有必要，
+  應該實現一個檢測機制。
+
+一個簡單的(未經實驗證實的)設備屬性實現如下：
+
+static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+                         char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", dev->name);
+}
+
+static ssize_t store_name(struct device *dev, struct device_attribute *attr,
+                          const char *buf, size_t count)
+{
+        snprintf(dev->name, sizeof(dev->name), "%.*s",
+                 (int)min(count, sizeof(dev->name) - 1), buf);
+	return count;
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
+
+
+（注意：真正的實現不允許用戶空間設置設備名。）
+
+頂層目錄布局
+~~~~~~~~~~~~
+
+sysfs 目錄的安排顯示了內核數據結構之間的關係。
+
+頂層 sysfs 目錄如下:
+
+block/
+bus/
+class/
+dev/
+devices/
+firmware/
+net/
+fs/
+
+devices/ 包含了一個設備樹的文件系統表示。他直接映射了內部的內核
+設備樹，反映了設備的層次結構。
+
+bus/ 包含了內核中各種總線類型的平面目錄布局。每個總線目錄包含兩個
+子目錄:
+
+	devices/
+	drivers/
+
+devices/ 包含了系統中出現的每個設備的符號連結，他們指向 root/ 下的
+設備目錄。
+
+drivers/ 包含了每個已爲特定總線上的設備而掛載的驅動程序的目錄(這裡
+假定驅動沒有跨越多個總線類型)。
+
+fs/ 包含了一個爲文件系統設立的目錄。現在每個想要導出屬性的文件系統必須
+在 fs/ 下創建自己的層次結構(參見Documentation/filesystems/fuse.rst)。
+
+dev/ 包含兩個子目錄： char/ 和 block/。在這兩個子目錄中，有以
+<major>:<minor> 格式命名的符號連結。這些符號連結指向 sysfs 目錄
+中相應的設備。/sys/dev 提供一個通過一個 stat(2) 操作結果，查找
+設備 sysfs 接口快捷的方法。
+
+更多有關 driver-model 的特性信息可以在 Documentation/driver-api/driver-model/
+中找到。
+
+
+TODO: 完成這一節。
+
+
+當前接口
+~~~~~~~~
+
+以下的接口層普遍存在於當前的sysfs中:
+
+- 設備 (include/linux/device.h)
+----------------------------------
+結構體:
+
+struct device_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
+};
+
+聲明:
+
+DEVICE_ATTR(_name, _mode, _show, _store);
+
+增/刪屬性:
+
+int device_create_file(struct device *dev, const struct device_attribute * attr);
+void device_remove_file(struct device *dev, const struct device_attribute * attr);
+
+
+- 總線驅動程序 (include/linux/device.h)
+--------------------------------------
+結構體:
+
+struct bus_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct bus_type *, char * buf);
+        ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
+};
+
+聲明:
+
+BUS_ATTR(_name, _mode, _show, _store)
+
+增/刪屬性:
+
+int bus_create_file(struct bus_type *, struct bus_attribute *);
+void bus_remove_file(struct bus_type *, struct bus_attribute *);
+
+
+- 設備驅動程序 (include/linux/device.h)
+-----------------------------------------
+
+結構體:
+
+struct driver_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct device_driver *, char * buf);
+        ssize_t (*store)(struct device_driver *, const char * buf,
+                         size_t count);
+};
+
+聲明:
+
+DRIVER_ATTR(_name, _mode, _show, _store)
+
+增/刪屬性：
+
+int driver_create_file(struct device_driver *, const struct driver_attribute *);
+void driver_remove_file(struct device_driver *, const struct driver_attribute *);
+
+
+文檔
+~~~~
+
+sysfs 目錄結構以及其中包含的屬性定義了一個內核與用戶空間之間的 ABI。
+對於任何 ABI，其自身的穩定和適當的文檔是非常重要的。所有新的 sysfs
+屬性必須在 Documentation/ABI 中有文檔。詳見 Documentation/ABI/README。
+
diff --git a/Documentation/translations/zh_TW/filesystems/tmpfs.rst b/Documentation/translations/zh_TW/filesystems/tmpfs.rst
new file mode 100644
index 000000000000..8d753a34785b
--- /dev/null
+++ b/Documentation/translations/zh_TW/filesystems/tmpfs.rst
@@ -0,0 +1,148 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/filesystems/tmpfs.rst
+
+Translated by Wang Qing <wangqing@vivo.com>
+and Hu Haowen <src.res@email.cn>
+
+=====
+Tmpfs
+=====
+
+Tmpfs是一個將所有文件都保存在虛擬內存中的文件系統。
+
+tmpfs中的所有內容都是臨時的，也就是說沒有任何文件會在硬碟上創建。
+如果卸載tmpfs實例，所有保存在其中的文件都會丟失。
+
+tmpfs將所有文件保存在內核緩存中，隨著文件內容增長或縮小可以將不需要的
+頁面swap出去。它具有最大限制，可以通過「mount -o remount ...」調整。
+
+和ramfs（創建tmpfs的模板）相比，tmpfs包含交換和限制檢查。和tmpfs相似的另
+一個東西是RAM磁碟（/dev/ram*），可以在物理RAM中模擬固定大小的硬碟，並在
+此之上創建一個普通的文件系統。Ramdisks無法swap，因此無法調整它們的大小。
+
+由於tmpfs完全保存於頁面緩存和swap中，因此所有tmpfs頁面將在/proc/meminfo
+中顯示爲「Shmem」，而在free(1)中顯示爲「Shared」。請注意，這些計數還包括
+共享內存(shmem，請參閱ipcs(1))。獲得計數的最可靠方法是使用df(1)和du(1)。
+
+tmpfs具有以下用途：
+
+1) 內核總有一個無法看到的內部掛載，用於共享匿名映射和SYSV共享內存。
+
+   掛載不依賴於CONFIG_TMPFS。如果CONFIG_TMPFS未設置，tmpfs對用戶不可見。
+   但是內部機制始終存在。
+
+2) glibc 2.2及更高版本期望將tmpfs掛載在/dev/shm上以用於POSIX共享內存
+   (shm_open，shm_unlink)。添加內容到/etc/fstab應注意如下：
+
+	tmpfs	/dev/shm	tmpfs	defaults	0 0
+
+   使用時需要記住創建掛載tmpfs的目錄。
+
+   SYSV共享內存無需掛載，內部已默認支持。(在2.3內核版本中，必須掛載
+   tmpfs的前身(shm fs)才能使用SYSV共享內存)
+
+3) 很多人（包括我）都覺的在/tmp和/var/tmp上掛載非常方便，並具有較大的
+   swap分區。目前循環掛載tmpfs可以正常工作，所以大多數發布都應當可以
+   使用mkinitrd通過/tmp訪問/tmp。
+
+4) 也許還有更多我不知道的地方:-)
+
+
+tmpfs有三個用於調整大小的掛載選項：
+
+=========  ===========================================================
+size       tmpfs實例分配的字節數限制。默認值是不swap時物理RAM的一半。
+           如果tmpfs實例過大，機器將死鎖，因爲OOM處理將無法釋放該內存。
+nr_blocks  與size相同，但以PAGE_SIZE爲單位。
+nr_inodes  tmpfs實例的最大inode個數。默認值是物理內存頁數的一半，或者
+           (有高端內存的機器)低端內存RAM的頁數，二者以較低者為準。
+=========  ===========================================================
+
+這些參數接受後綴k，m或g表示千，兆和千兆字節，可以在remount時更改。
+size參數也接受後綴％用來限制tmpfs實例占用物理RAM的百分比：
+未指定size或nr_blocks時，默認值爲size=50％
+
+如果nr_blocks=0（或size=0），block個數將不受限制；如果nr_inodes=0，
+inode個數將不受限制。這樣掛載通常是不明智的，因爲它允許任何具有寫權限的
+用戶通過訪問tmpfs耗盡機器上的所有內存；但同時這樣做也會增強在多個CPU的
+場景下的訪問。
+
+tmpfs具有爲所有文件設置NUMA內存分配策略掛載選項(如果啓用了CONFIG_NUMA),
+可以通過「mount -o remount ...」調整
+
+======================== =========================
+mpol=default             採用進程分配策略
+                         (請參閱 set_mempolicy(2))
+mpol=prefer:Node         傾向從給定的節點分配
+mpol=bind:NodeList       只允許從指定的鍊表分配
+mpol=interleave          傾向於依次從每個節點分配
+mpol=interleave:NodeList 依次從每個節點分配
+mpol=local               優先本地節點分配內存
+======================== =========================
+
+NodeList格式是以逗號分隔的十進位數字表示大小和範圍，最大和最小範圍是用-
+分隔符的十進位數來表示。例如，mpol=bind0-3,5,7,9-15
+
+帶有有效NodeList的內存策略將按指定格式保存，在創建文件時使用。當任務在該
+文件系統上創建文件時，會使用到掛載時的內存策略NodeList選項，如果設置的話，
+由調用任務的cpuset[請參見Documentation/admin-guide/cgroup-v1/cpusets.rst]
+以及下面列出的可選標誌約束。如果NodeLists爲設置爲空集，則文件的內存策略將
+恢復爲「默認」策略。
+
+NUMA內存分配策略有可選標誌，可以用於模式結合。在掛載tmpfs時指定這些可選
+標誌可以在NodeList之前生效。
+Documentation/admin-guide/mm/numa_memory_policy.rst列出所有可用的內存
+分配策略模式標誌及其對內存策略。
+
+::
+
+	=static		相當於	MPOL_F_STATIC_NODES
+	=relative	相當於	MPOL_F_RELATIVE_NODES
+
+例如，mpol=bind=staticNodeList相當於MPOL_BIND|MPOL_F_STATIC_NODES的分配策略
+
+請注意，如果內核不支持NUMA，那麼使用mpol選項掛載tmpfs將會失敗；nodelist指定不
+在線的節點也會失敗。如果您的系統依賴於此，但內核會運行不帶NUMA功能(也許是安全
+revocery內核)，或者具有較少的節點在線，建議從自動模式中省略mpol選項掛載選項。
+可以在以後通過「mount -o remount,mpol=Policy:NodeList MountPoint」添加到掛載點。
+
+要指定初始根目錄，可以使用如下掛載選項：
+
+====	====================
+模式	權限用八進位數字表示
+uid	用戶ID
+gid	組ID
+====	====================
+
+這些選項對remount沒有任何影響。您可以通過chmod(1),chown(1)和chgrp(1)的更改
+已經掛載的參數。
+
+tmpfs具有選擇32位還是64位inode的掛載選項：
+
+=======   =============
+inode64   使用64位inode
+inode32   使用32位inode
+=======   =============
+
+在32位內核上，默認是inode32，掛載時指定inode64會被拒絕。
+在64位內核上，默認配置是CONFIG_TMPFS_INODE64。inode64避免了單個設備上可能有多個
+具有相同inode編號的文件；比如32位應用程式使用glibc如果長期訪問tmpfs，一旦達到33
+位inode編號，就有EOVERFLOW失敗的危險，無法打開大於2GiB的文件，並返回EINVAL。
+
+所以'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'將在
+/mytmpfs上掛載tmpfs實例，分配只能由root用戶訪問的10GB RAM/SWAP，可以有10240個
+inode的實例。
+
+
+:作者:
+   Christoph Rohland <cr@sap.com>, 1.12.01
+:更新:
+   Hugh Dickins, 4 June 2007
+:更新:
+   KOSAKI Motohiro, 16 Mar 2010
+:更新:
+   Chris Down, 13 July 2020
+
diff --git a/Documentation/translations/zh_TW/filesystems/virtiofs.rst b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
new file mode 100644
index 000000000000..2b05e84375dd
--- /dev/null
+++ b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: :ref:`Documentation/filesystems/virtiofs.rst <virtiofs_index>`
+
+譯者
+::
+
+	中文版維護者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+	中文版翻譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+	中文版校譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+	中文版校譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+	繁體中文版校譯者：胡皓文 Hu Haowen <src.res@email.cn>
+
+===========================================
+virtiofs: virtio-fs 主機<->客機共享文件系統
+===========================================
+
+- Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
+
+介紹
+====
+Linux的virtiofs文件系統實現了一個半虛擬化VIRTIO類型「virtio-fs」設備的驅動，通過該\
+類型設備實現客機<->主機文件系統共享。它允許客機掛載一個已經導出到主機的目錄。
+
+客機通常需要訪問主機或者遠程系統上的文件。使用場景包括：在新客機安裝時讓文件對其\
+可見；從主機上的根文件系統啓動；對無狀態或臨時客機提供持久存儲和在客機之間共享目錄。
+
+儘管在某些任務可能通過使用已有的網絡文件系統完成，但是卻需要非常難以自動化的配置\
+步驟，且將存儲網絡暴露給客機。而virtio-fs設備通過提供不經過網絡的文件系統訪問文件\
+的設計方式解決了這些問題。
+
+另外，virto-fs設備發揮了主客機共存的優點提高了性能，並且提供了網絡文件系統所不具備
+的一些語義功能。
+
+用法
+====
+以``myfs``標籤將文件系統掛載到``/mnt``:
+
+.. code-block:: sh
+
+  guest# mount -t virtiofs myfs /mnt
+
+請查閱 https://virtio-fs.gitlab.io/ 了解配置QEMU和virtiofsd守護程序的詳細信息。
+
+內幕
+====
+由於virtio-fs設備將FUSE協議用於文件系統請求，因此Linux的virtiofs文件系統與FUSE文\
+件系統客戶端緊密集成在一起。客機充當FUSE客戶端而主機充當FUSE伺服器，內核與用戶空\
+間之間的/dev/fuse接口由virtio-fs設備接口代替。
+
+FUSE請求被置於虛擬隊列中由主機處理。主機填充緩衝區中的響應部分，而客機處理請求的完成部分。
+
+將/dev/fuse映射到虛擬隊列需要解決/dev/fuse和虛擬隊列之間語義上的差異。每次讀取\
+/dev/fuse設備時，FUSE客戶端都可以選擇要傳輸的請求，從而可以使某些請求優先於其他\
+請求。虛擬隊列有其隊列語義，無法更改已入隊請求的順序。在虛擬隊列已滿的情況下尤
+其關鍵，因爲此時不可能加入高優先級的請求。爲了解決此差異，virtio-fs設備採用「hiprio」\
+（高優先級）虛擬隊列，專門用於有別於普通請求的高優先級請求。
+
+
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index aa6f4195f396..4f5a7277f4c2 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -90,7 +90,9 @@ TODOList:
 
 .. toctree::
    :maxdepth: 2
+
    cpu-freq/index
+   filesystems/index
 
 TODOList:
 
@@ -125,7 +127,6 @@ TODOList:
 * security/index
 * sound/index
 * crypto/index
-* filesystems/index
 * vm/index
 * bpf/index
 * usb/index
-- 
2.25.1

