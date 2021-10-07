Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1697E424E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhJGIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbhJGIHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:07:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F045C061746;
        Thu,  7 Oct 2021 01:05:07 -0700 (PDT)
Received: from ip4d14bdef.dynamic.kabel-deutschland.de ([77.20.189.239] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mYOOk-0004cv-8V; Thu, 07 Oct 2021 10:05:02 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hu Haowen <src.res@email.cn>, Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v1 1/2] docs: use the lore redirector everywhere
Date:   Thu,  7 Oct 2021 10:05:00 +0200
Message-Id: <5bb55bac6ba10fafab19bf2b21572dd0e2f8cea2.1633593385.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633593385.git.linux@leemhuis.info>
References: <cover.1633593385.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1633593908;1a9e2f95;
X-HE-SMSGID: 1mYOOk-0004cv-8V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change all links from using the lkml redirector to the lore redirector,
as the kernel.org admin recently indicated: we shouldn't be using
lkml.kernel.org anymore because the domain can create confusion, as it
indicates it is only valid for messages sent to the LKML; the convention
has been to use https://lore.kernel.org/r/msgid for this reason.

In this process also change three links from using http to https.

Link: https://lore.kernel.org/r/20211006170025.qw3glxvocczfuhar@meerkat.local
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Hu Haowen <src.res@email.cn>
CC: Alex Shi <alexs@kernel.org>
CC: Federico Vaga <federico.vaga@vaga.pv.it>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/asm-annotations.rst                             | 2 +-
 Documentation/kbuild/Kconfig.recursion-issue-02               | 2 +-
 Documentation/maintainer/pull-requests.rst                    | 2 +-
 Documentation/networking/msg_zerocopy.rst                     | 2 +-
 Documentation/process/maintainer-tip.rst                      | 4 ++--
 Documentation/process/submitting-patches.rst                  | 4 ++--
 .../translations/it_IT/process/submitting-patches.rst         | 4 ++--
 Documentation/translations/zh_CN/maintainer/pull-requests.rst | 2 +-
 .../translations/zh_CN/process/submitting-patches.rst         | 4 ++--
 .../translations/zh_TW/process/submitting-patches.rst         | 4 ++--
 Documentation/x86/entry_64.rst                                | 2 +-
 Documentation/x86/orc-unwinder.rst                            | 4 ++--
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 76424e0431f4..f4bf0f6395fb 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -64,7 +64,7 @@ macros, it was decided that brand new macros should be introduced instead::
     of importing all the crappy, historic, essentially randomly chosen
     debug symbol macro names from the binutils and older kernels?
 
-.. _discussion: https://lkml.kernel.org/r/20170217104757.28588-1-jslaby@suse.cz
+.. _discussion: https://lore.kernel.org/r/20170217104757.28588-1-jslaby@suse.cz
 
 Macros Description
 ------------------
diff --git a/Documentation/kbuild/Kconfig.recursion-issue-02 b/Documentation/kbuild/Kconfig.recursion-issue-02
index 0034eb494d11..09dcb92d9b43 100644
--- a/Documentation/kbuild/Kconfig.recursion-issue-02
+++ b/Documentation/kbuild/Kconfig.recursion-issue-02
@@ -42,7 +42,7 @@
 # "select FW_LOADER" [0], in the end the simple alternative solution to this
 # problem consisted on matching semantics with newly introduced features.
 #
-# [0] https://lkml.kernel.org/r/1432241149-8762-1-git-send-email-mcgrof@do-not-panic.com
+# [0] https://lore.kernel.org/r/1432241149-8762-1-git-send-email-mcgrof@do-not-panic.com
 
 mainmenu "Simple example to demo cumulative kconfig recursive dependency implication"
 
diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/maintainer/pull-requests.rst
index 1a2f99b67d25..e072de60ccb0 100644
--- a/Documentation/maintainer/pull-requests.rst
+++ b/Documentation/maintainer/pull-requests.rst
@@ -15,7 +15,7 @@ please direct abuse to Tobin C. Harding <me@tobin.cc>.
 
 Original email thread::
 
-	http://lkml.kernel.org/r/20171114110500.GA21175@kroah.com
+	https://lore.kernel.org/r/20171114110500.GA21175@kroah.com
 
 
 Create Branch
diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
index ace56204dd03..15920db8d35d 100644
--- a/Documentation/networking/msg_zerocopy.rst
+++ b/Documentation/networking/msg_zerocopy.rst
@@ -50,7 +50,7 @@ the excellent reporting over at LWN.net or read the original code.
 
   patchset
     [PATCH net-next v4 0/9] socket sendmsg MSG_ZEROCOPY
-    https://lkml.kernel.org/netdev/20170803202945.70750-1-willemdebruijn.kernel@gmail.com
+    https://lore.kernel.org/netdev/20170803202945.70750-1-willemdebruijn.kernel@gmail.com
 
 
 Interface
diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 2b495c8bcb5b..c74f4a81588b 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -371,9 +371,9 @@ following tag ordering scheme:
  - Link: ``https://link/to/information``
 
    For referring to an email on LKML or other kernel mailing lists,
-   please use the lkml.kernel.org redirector URL::
+   please use the lore.kernel.org redirector URL::
 
-     https://lkml.kernel.org/r/email-message@id
+     https://lore.kernel.org/r/email-message@id
 
    The kernel.org redirector is considered a stable URL, unlike other email
    archives.
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 21125d299ce6..b0f31aa82fcd 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -98,7 +98,7 @@ its behaviour.
 
 If the patch fixes a logged bug entry, refer to that bug entry by
 number and URL.  If the patch follows from a mailing list discussion,
-give a URL to the mailing list archive; use the https://lkml.kernel.org/
+give a URL to the mailing list archive; use the https://lore.kernel.org/
 redirector with a ``Message-Id``, to ensure that the links cannot become
 stale.
 
@@ -750,7 +750,7 @@ the bug report.  However, for a multi-patch series, it is generally
 best to avoid using In-Reply-To: to link to older versions of the
 series.  This way multiple versions of the patch don't become an
 unmanageable forest of references in email clients.  If a link is
-helpful, you can use the https://lkml.kernel.org/ redirector (e.g., in
+helpful, you can use the https://lore.kernel.org/ redirector (e.g., in
 the cover email text) to link to an earlier version of the patch series.
 
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 458d9d24b9c0..c2fb712a1377 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -107,7 +107,7 @@ comportamento.
 Se la patch corregge un baco conosciuto, fare riferimento a quel baco inserendo
 il suo numero o il suo URL.  Se la patch è la conseguenza di una discussione
 su una lista di discussione, allora fornite l'URL all'archivio di quella
-discussione;  usate i collegamenti a https://lkml.kernel.org/ con il
+discussione;  usate i collegamenti a https://lore.kernel.org/ con il
 ``Message-Id``, in questo modo vi assicurerete che il collegamento non diventi
 invalido nel tempo.
 
@@ -772,7 +772,7 @@ che lo riportava.  Tuttavia, per serie di patch multiple è generalmente
 sconsigliato l'uso di In-Reply-To: per collegare precedenti versioni.
 In questo modo versioni multiple di una patch non diventeranno un'ingestibile
 giungla di riferimenti all'interno dei programmi di posta.  Se un collegamento
-è utile, potete usare https://lkml.kernel.org/ per ottenere i collegamenti
+è utile, potete usare https://lore.kernel.org/ per ottenere i collegamenti
 ad una versione precedente di una serie di patch (per esempio, potete usarlo
 per l'email introduttiva alla serie).
 
diff --git a/Documentation/translations/zh_CN/maintainer/pull-requests.rst b/Documentation/translations/zh_CN/maintainer/pull-requests.rst
index f46d6f3f2498..ce9725f4674c 100644
--- a/Documentation/translations/zh_CN/maintainer/pull-requests.rst
+++ b/Documentation/translations/zh_CN/maintainer/pull-requests.rst
@@ -21,7 +21,7 @@ Harding <me@tobin.cc>。
 
 原始邮件线程::
 
-	http://lkml.kernel.org/r/20171114110500.GA21175@kroah.com
+	https://lore.kernel.org/r/20171114110500.GA21175@kroah.com
 
 
 创建分支
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 3296b8f7bedf..3f1683cd4727 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -133,7 +133,7 @@ xyzzy do frotz”或“[I]changed xyzzy to do frotz”，就好像你在命令
 
 如果修补程序修复了一个记录的bug条目，请按编号和URL引用该bug条目。如果补丁来
 自邮件列表讨论，请给出邮件列表存档的URL；使用带有 ``Message-ID`` 的
-https://lkml.kernel.org/ 重定向，以确保链接不会过时。
+https://lore.kernel.org/ 重定向，以确保链接不会过时。
 
 但是，在没有外部资源的情况下，尽量让你的解释可理解。除了提供邮件列表存档或
 bug的URL之外，还要总结需要提交补丁的相关讨论要点。
@@ -599,7 +599,7 @@ e-mail 标题中的“一句话概述”扼要的描述 e-mail 中的补丁。
 将补丁与以前的相关讨论关联起来，例如，将bug修复程序链接到电子邮件和bug报告。
 但是，对于多补丁系列，最好避免在回复时使用链接到该系列的旧版本。这样，
 补丁的多个版本就不会成为电子邮件客户端中无法管理的引用序列。如果链接有用，
-可以使用 https://lkml.kernel.org/ 重定向器（例如，在封面电子邮件文本中）
+可以使用 https://lore.kernel.org/ 重定向器（例如，在封面电子邮件文本中）
 链接到补丁系列的早期版本。
 
 16) 发送git pull请求
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index cdf0b52e4a98..37eccf9e2746 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -136,7 +136,7 @@ xyzzy do frotz」或「[我]changed xyzzy to do frotz」，就好像你在命令
 
 如果修補程序修復了一個記錄的bug條目，請按編號和URL引用該bug條目。如果補丁來
 自郵件列表討論，請給出郵件列表存檔的URL；使用帶有 ``Message-ID`` 的
-https://lkml.kernel.org/ 重定向，以確保連結不會過時。
+https://lore.kernel.org/ 重定向，以確保連結不會過時。
 
 但是，在沒有外部資源的情況下，儘量讓你的解釋可理解。除了提供郵件列表存檔或
 bug的URL之外，還要總結需要提交補丁的相關討論要點。
@@ -602,7 +602,7 @@ e-mail 標題中的「一句話概述」扼要的描述 e-mail 中的補丁。
 將補丁與以前的相關討論關聯起來，例如，將bug修復程序連結到電子郵件和bug報告。
 但是，對於多補丁系列，最好避免在回復時使用連結到該系列的舊版本。這樣，
 補丁的多個版本就不會成爲電子郵件客戶端中無法管理的引用序列。如果連結有用，
-可以使用 https://lkml.kernel.org/ 重定向器（例如，在封面電子郵件文本中）
+可以使用 https://lore.kernel.org/ 重定向器（例如，在封面電子郵件文本中）
 連結到補丁系列的早期版本。
 
 16) 發送git pull請求
diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index a48b3f6ebbe8..e433e08f7018 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -8,7 +8,7 @@ This file documents some of the kernel entries in
 arch/x86/entry/entry_64.S.  A lot of this explanation is adapted from
 an email from Ingo Molnar:
 
-http://lkml.kernel.org/r/<20110529191055.GC9835%40elte.hu>
+https://lore.kernel.org/r/20110529191055.GC9835%40elte.hu
 
 The x86 architecture has quite a few different ways to jump into
 kernel code.  Most of these entry points are registered in
diff --git a/Documentation/x86/orc-unwinder.rst b/Documentation/x86/orc-unwinder.rst
index d811576c1f3e..9a66a88be765 100644
--- a/Documentation/x86/orc-unwinder.rst
+++ b/Documentation/x86/orc-unwinder.rst
@@ -177,6 +177,6 @@ brutal, unyielding efficiency.
 ORC stands for Oops Rewind Capability.
 
 
-.. [1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
-.. [2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
+.. [1] https://lore.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
+.. [2] https://lore.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
 .. [3] http://dustin.wikidot.com/half-orcs-and-orcs
-- 
2.31.1

