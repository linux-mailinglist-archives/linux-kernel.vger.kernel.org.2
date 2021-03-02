Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB332A7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579231AbhCBQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:46:28 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:55621 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448437AbhCBOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:20:33 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 122EIQx0008022;
        Tue, 2 Mar 2021 23:18:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 122EIQx0008022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614694707;
        bh=VCeA0PWI/KpvDWvDmIzbSqbL1uVVr9co70j2lM2jmC8=;
        h=From:To:Cc:Subject:Date:From;
        b=2TgU0n6i5FG+/Le+H7wIGKG9bZa6FOgZTGlzNxsGYO4V3doLohIjNvS12Bcuynxqz
         WKprLEeCZfy4Jom5ag79Rftz4r+VdJfq5MF141p8nZXZtvlaUmD8rdMD1lmyrnq6WD
         aUXtVvT7mtZAaxts8uPFceW/UW3ZM5jyTQue++x5ukJQtFTlx76k2rRoSvUXjAgCnm
         LGXjIj9UC2Xfb703qF1pY9cDh9bj5iUu1T30k0rhVVNHx87ArudNIAt+QQFHNhtV0o
         o27NRFmzoQnyjYZ1klry7h7XWvU5YSOj0i8Da8NGtge5rqET3+2iYvM5pNahCimIrw
         3pJ/taQhorlnA==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] docs: Remove make headers_check from checklist in translations
Date:   Tue,  2 Mar 2021 23:18:22 +0900
Message-Id: <20210302141822.504773-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1a63f9cce7b7 ("docs: Remove make headers_check from checklist")
fixed only the English version.

Let's fix the translated variants too.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .../it_IT/process/submit-checklist.rst             | 14 ++++++--------
 Documentation/translations/ja_JP/SubmitChecklist   |  8 +++-----
 .../zh_CN/process/submit-checklist.rst             | 14 ++++++--------
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 614fc17d9086..62ba471921b6 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -95,31 +95,29 @@ sottomissione delle patch, in particolare
     informazioni.  Le patch che modificano le interfacce utente dovrebbero
     essere inviate in copia anche a linux-api@vger.kernel.org.
 
-20) Verifica che il kernel passi con successo ``make headers_check``
-
-21) La patch è stata verificata con l'iniezione di fallimenti in slab e
+20) La patch è stata verificata con l'iniezione di fallimenti in slab e
     nell'allocazione di pagine.  Vedere ``Documentation/fault-injection/``.
 
     Se il nuovo codice è corposo, potrebbe essere opportuno aggiungere
     l'iniezione di fallimenti specifici per il sottosistema.
 
-22) Il nuovo codice è stato compilato con ``gcc -W`` (usate
+21) Il nuovo codice è stato compilato con ``gcc -W`` (usate
     ``make KCFLAGS=-W``).  Questo genererà molti avvisi, ma è ottimo
     per scovare bachi come  "warning: comparison between signed and unsigned".
 
-23) La patch è stata verificata dopo essere stata inclusa nella serie di patch
+22) La patch è stata verificata dopo essere stata inclusa nella serie di patch
     -mm; questo al fine di assicurarsi che continui a funzionare assieme a
     tutte le altre patch in coda e i vari cambiamenti nei sottosistemi VM, VFS
     e altri.
 
-24) Tutte le barriere di sincronizzazione {per esempio, ``barrier()``,
+23) Tutte le barriere di sincronizzazione {per esempio, ``barrier()``,
     ``rmb()``, ``wmb()``} devono essere accompagnate da un commento nei
     sorgenti che ne spieghi la logica: cosa fanno e perché.
 
-25) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
+24) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
     ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
 
-26) Se il codice che avete modificato dipende o usa una qualsiasi interfaccia o
+25) Se il codice che avete modificato dipende o usa una qualsiasi interfaccia o
     funzionalità del kernel che è associata a uno dei seguenti simboli
     ``Kconfig``, allora verificate che il kernel compili con diverse
     configurazioni dove i simboli sono disabilitati e/o ``=m`` (se c'è la
diff --git a/Documentation/translations/ja_JP/SubmitChecklist b/Documentation/translations/ja_JP/SubmitChecklist
index b42220d3d46c..4429447b0965 100644
--- a/Documentation/translations/ja_JP/SubmitChecklist
+++ b/Documentation/translations/ja_JP/SubmitChecklist
@@ -88,20 +88,18 @@ Linux カーネルパッチ投稿者向けチェックリスト
 18: 新しいuserspaceインタフェースを作成した場合には、Documentation/ABI/ に
     Documentation/ABI/README を参考にして必ずドキュメントを追加してください。
 
-19: 'make headers_check'を実行して全く問題がないことを確認してください。
-
-20: 少なくともslabアロケーションとpageアロケーションに失敗した場合の
+19: 少なくともslabアロケーションとpageアロケーションに失敗した場合の
     挙動について、fault-injectionを利用して確認してください。
     Documentation/fault-injection/ を参照してください。
 
     追加したコードがかなりの量であったならば、サブシステム特有の
     fault-injectionを追加したほうが良いかもしれません。
 
-21: 新たに追加したコードは、`gcc -W'でコンパイルしてください。
+20: 新たに追加したコードは、`gcc -W'でコンパイルしてください。
     このオプションは大量の不要なメッセージを出力しますが、
     "warning: comparison between signed and unsigned" のようなメッセージは、
     バグを見つけるのに役に立ちます。
 
-22: 投稿したパッチが -mm パッチセットにマージされた後、全ての既存のパッチや
+21: 投稿したパッチが -mm パッチセットにマージされた後、全ての既存のパッチや
     VM, VFS およびその他のサブシステムに関する様々な変更と、現時点でも共存
     できることを確認するテストを行ってください。
diff --git a/Documentation/translations/zh_CN/process/submit-checklist.rst b/Documentation/translations/zh_CN/process/submit-checklist.rst
index 50386e0e42e7..a64858d321fc 100644
--- a/Documentation/translations/zh_CN/process/submit-checklist.rst
+++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
@@ -82,24 +82,22 @@ Linux内核补丁提交清单
     请参阅 ``Documentation/ABI/README`` 。更改用户空间接口的补丁应该抄送
     linux-api@vger.kernel.org。
 
-20) 检查是否全部通过 ``make headers_check`` 。
-
-21) 已通过至少注入slab和page分配失败进行检查。请参阅 ``Documentation/fault-injection/``
+20) 已通过至少注入slab和page分配失败进行检查。请参阅 ``Documentation/fault-injection/``
     如果新代码是实质性的，那么添加子系统特定的故障注入可能是合适的。
 
-22) 新添加的代码已经用 ``gcc -W`` 编译（使用 ``make EXTRA-CFLAGS=-W`` ）。这
+21) 新添加的代码已经用 ``gcc -W`` 编译（使用 ``make EXTRA-CFLAGS=-W`` ）。这
     将产生大量噪声，但对于查找诸如“警告：有符号和无符号之间的比较”之类的错误
     很有用。
 
-23) 在它被合并到-mm补丁集中之后进行测试，以确保它仍然与所有其他排队的补丁以
+22) 在它被合并到-mm补丁集中之后进行测试，以确保它仍然与所有其他排队的补丁以
     及VM、VFS和其他子系统中的各种更改一起工作。
 
-24) 所有内存屏障例如 ``barrier()``, ``rmb()``, ``wmb()`` 都需要源代码中的注
+23) 所有内存屏障例如 ``barrier()``, ``rmb()``, ``wmb()`` 都需要源代码中的注
     释来解释它们正在执行的操作及其原因的逻辑。
 
-25) 如果补丁添加了任何ioctl，那么也要更新 ``Documentation/userspace-api/ioctl/ioctl-number.rst``
+24) 如果补丁添加了任何ioctl，那么也要更新 ``Documentation/userspace-api/ioctl/ioctl-number.rst``
 
-26) 如果修改后的源代码依赖或使用与以下 ``Kconfig`` 符号相关的任何内核API或
+25) 如果修改后的源代码依赖或使用与以下 ``Kconfig`` 符号相关的任何内核API或
     功能，则在禁用相关 ``Kconfig`` 符号和/或 ``=m`` （如果该选项可用）的情况
     下测试以下多个构建[并非所有这些都同时存在，只是它们的各种/随机组合]：
 
-- 
2.27.0

