Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B33359F36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhDIMsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233781AbhDIMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6298A61177;
        Fri,  9 Apr 2021 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617972481;
        bh=lOVRhhI3sdxbepQz+6GNZ3ou0W529UWsSm4U1KahRac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSbAqQH87k5HCz6+NZAdIRBkRcfmWZb846RlLzPuK3hLqmuL1AVsh/yhDlcfVxm6q
         zUmQai+eK2Z1vbaO8cr8A1qfQyyh8o+cwjhTXHKZ6DFtpLY/lP6s1ZtMRaYp5u0kAA
         lyUWQ0EzDOuJjx75Gu+uTd7nThryZr9iINTJHNKI1S51/HHZhuAn+gJ2svhOZ/VceA
         mD32LwjGQ8ZFVzJ0owf0ZNQlT83+KrVQblzUPntFLbVGmdlnXHmbp0oj0sV2E8SfE3
         sKlB//4+G+NQOgVdKsugHDyaZehmcV2kPDSGW0sGj7LOTX9E8e20nmBtXaEHhnL6b1
         a3l7PYVpN/B3g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lUqYE-001SLq-C5; Fri, 09 Apr 2021 14:47:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] docs: replace transation references for reporting-bugs.rst
Date:   Fri,  9 Apr 2021 14:47:50 +0200
Message-Id: <3c7eb94992f7d85d75c8faf82c6a4690b2666951.1617972339.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617972339.git.mchehab+huawei@kernel.org>
References: <cover.1617972339.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset d2ce285378b0 ("docs: make reporting-issues.rst official and delete reporting-bugs.rst")
dropped reporting-bugs.rst, in favor of reporting-issues.rst, but
translations still need to be updated, in order to point to the
new file.

Fixes: d2ce285378b0 ("docs: make reporting-issues.rst official and delete reporting-bugs.rst")
Acked-by: Wu XiangCheng <bobwxc@email.cn>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/it_IT/process/howto.rst            | 2 +-
 Documentation/translations/ja_JP/howto.rst                    | 2 +-
 Documentation/translations/zh_CN/SecurityBugs                 | 2 +-
 .../translations/zh_CN/admin-guide/reporting-issues.rst       | 4 ++--
 Documentation/translations/zh_CN/process/howto.rst            | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 1db5a1082389..4962057f50fa 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -364,7 +364,7 @@ Per maggiori dettagli su come usare il bugzilla del kernel, guardare:
 
 	https://bugzilla.kernel.org/page.cgi?id=faq.html
 
-Il file admin-guide/reporting-bugs.rst nella cartella principale del kernel
+Il file admin-guide/reporting-issues.rst nella cartella principale del kernel
 fornisce un buon modello sul come segnalare un baco nel kernel, e spiega quali
 informazioni sono necessarie agli sviluppatori per poter aiutare il
 rintracciamento del problema.
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 73ebdab4ced7..3051ff787e69 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -367,7 +367,7 @@ kernel bugzilla を使うかの詳細は、以下を参照してください -
 	https://bugzilla.kernel.org/page.cgi?id=faq.html
 
 メインカーネルソースディレクトリにあるファイル
-admin-guide/reporting-bugs.rstはカーネルバグらしいものについてどうレポー
+admin-guide/reporting-issues.rstはカーネルバグらしいものについてどうレポー
 トするかの良いテンプレートであり、問題の追跡を助けるためにカーネル開発
 者にとってどんな情報が必要なのかの詳細が書かれています。
 
diff --git a/Documentation/translations/zh_CN/SecurityBugs b/Documentation/translations/zh_CN/SecurityBugs
index 2d0fffd122ce..980199d88eca 100644
--- a/Documentation/translations/zh_CN/SecurityBugs
+++ b/Documentation/translations/zh_CN/SecurityBugs
@@ -31,7 +31,7 @@ linux内核安全团队可以通过email<security@kernel.org>来联系。这是
 一组独立的安全工作人员，可以帮助改善漏洞报告并且公布和取消一个修复。安
 全团队有可能会从部分的维护者那里引进额外的帮助来了解并且修复安全漏洞。
 当遇到任何漏洞，所能提供的信息越多就越能诊断和修复。如果你不清楚什么
-是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
+是有帮助的信息，那就请重温一下admin-guide/reporting-issues.rst文件中的概述过程。任
 何攻击性的代码都是非常有用的，未经报告者的同意不会被取消，除非它已经
 被公布于众。
 
diff --git a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
index 2805c1a03cd5..72c8e2db88c0 100644
--- a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
+++ b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
@@ -19,7 +19,7 @@
 
 .. important::
 
-   本文档将取代“Documentation/admin-guide/reporting-bugs.rst”。主要的工作
+   本文档将取代“Documentation/admin-guide/reporting-issues.rst”。主要的工作
    已经完成，你可以自由地按照其指示来向Linux内核开发者报告问题。但请留意，
    下面的文字还需要一些润色和校审。现阶段它被合并到Linux内核源代码中，以使
    这个过程更容易，并增加文本的可见性。
@@ -726,7 +726,7 @@ tar 存档包。
 .. note::
 
    FIXME: 本节文字暂时是占位符，与目前
-   “Documentation/admin-guide/reporting-bugs.rst”中的旧文字非常相似。它和它
+   “Documentation/admin-guide/reporting-issues.rst”中的旧文字非常相似。它和它
    所引用的文档已经过时，因此需要重新审视。因此，请将此说明视为一个求助：如
    果你熟悉这个主题，请写几行适合这里的文字。或者只需向本文件的主要作者（见
    导言）大致概述一下当前的情况，因为他们也许能写出一些东西来。
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index ee3dee476d57..c87cd529d769 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -280,7 +280,7 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 
 	http://test.kernel.org/bugzilla/faq.html
 
-内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
+内核源码主目录中的:ref:`admin-guide/reporting-issues.rst <reportingbugs>`
 文件里有一个很好的模板。它指导用户如何报告可能的内核bug以及需要提供哪些信息
 来帮助内核开发者们找到问题的根源。
 
-- 
2.30.2

