Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE437509B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhEFIQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:16:13 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:19512 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhEFIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:16:11 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 16285C20158;
        Thu,  6 May 2021 16:15:12 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] docs/zh_CN: fix reference file and update translations
Date:   Thu,  6 May 2021 16:14:01 +0800
Message-Id: <20210506081414.14004-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh4eHVZDT0IeQkIfGEhOQxhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06Mww4ND8TPEIsAhMuGTgM
        KTAKFE9VSlVKTUlLSUNDQkpJTUhOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFIT0xPNwY+
X-HM-Tid: 0a7940bebb63d976kuws16285c20158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit da514157c4f06 ("docs: make reporting-bugs.rst obsolete"),
reporting-bugs.rst was deleted and replaced by reporting-issues.rst.

In commit cf6d6fc279360 ("docs: process/howto.rst: make sections on
bug reporting match practice"), related sections were adjusted.

Fix the reference file and update some translations.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 .../translations/zh_CN/process/howto.rst         | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index ee3dee476d57..930ebc215fad 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -275,14 +275,8 @@ Linux-next 集成测试树
 报告bug
 -------
 
-bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。我们鼓励用
-户在这个工具中报告找到的所有bug。如何使用内核bugzilla的细节请访问：
-
-	http://test.kernel.org/bugzilla/faq.html
-
-内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
-文件里有一个很好的模板。它指导用户如何报告可能的内核bug以及需要提供哪些信息
-来帮助内核开发者们找到问题的根源。
+内核源码主目录中的 'Documentation/admin-guide/reporting-issues.rst' 文件介绍了
+如何报告可能的内核bug，以及需要提供哪些信息来帮助内核开发者们找到问题的根源。
 
 
 利用bug报告
@@ -293,7 +287,11 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 者感受到你的存在。修改bug是赢得其他开发者赞誉的最好办法，因为并不是很多
 人都喜欢浪费时间去修改别人报告的bug。
 
-要尝试修改已知的bug，请访问 http://bugzilla.kernel.org 网址。
+要尝试修复已知的bug，请找到你感兴趣的子系统，查看报告该子系统bug的
+MAINTAINERS文件，通常它是一个邮件列表，很少有bug追踪信息。在这个
+文件搜索获取最新的报告，并在你认为合适的地方提供帮助。你可能还需要查看
+https://bugzilla.kernel.org 以获取bug报告，只有少数一些内核子系统积极地
+通过它进行报告或追踪，但是整个内核的bug都被归档在那里。
 
 
 邮件列表
-- 
2.25.1

