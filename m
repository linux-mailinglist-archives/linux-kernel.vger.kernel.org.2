Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057E6376F11
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhEHDJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:09:25 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:23168 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHDJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:09:24 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id A585CC200ED;
        Sat,  8 May 2021 11:08:21 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] docs/zh_CN: Remove obsolete translation file
Date:   Sat,  8 May 2021 11:07:33 +0800
Message-Id: <20210508030741.82655-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxhDSFZISBkeQkpJHU5PSUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZSkJCVUNKVU
        tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Fgw4LT8LSjkvGU1DAi4I
        MQIKCxpVSlVKTUlLT09ISEtJSUJPVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFPTk1DNwY+
X-HM-Tid: 0a7949f287c1d976kuwsa585cc200ed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This translation file was replaced by 
   Documentation/translations/zh_CN/admin-guide/security-bugs.rst
which was created in commit 2d153571003b ("docs/zh_CN: Add
zh_CN/admin-guide/security-bugs.rst").
This is a translation left over from history. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/translations/zh_CN/SecurityBugs | 50 -------------------
 1 file changed, 50 deletions(-)
 delete mode 100644 Documentation/translations/zh_CN/SecurityBugs

diff --git a/Documentation/translations/zh_CN/SecurityBugs b/Documentation/translations/zh_CN/SecurityBugs
deleted file mode 100644
index 2d0fffd122ce..000000000000
--- a/Documentation/translations/zh_CN/SecurityBugs
+++ /dev/null
@@ -1,50 +0,0 @@
-Chinese translated version of Documentation/admin-guide/security-bugs.rst
-
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
-
-Chinese maintainer: Harry Wei <harryxiyou@gmail.com>
----------------------------------------------------------------------
-Documentation/admin-guide/security-bugs.rst 的中文翻译
-
-如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
-交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
-
-中文版维护者： 贾威威 Harry Wei <harryxiyou@gmail.com>
-中文版翻译者： 贾威威 Harry Wei <harryxiyou@gmail.com>
-中文版校译者： 贾威威 Harry Wei <harryxiyou@gmail.com>
-
-
-以下为正文
----------------------------------------------------------------------
-Linux内核开发者认为安全非常重要。因此，我们想要知道当一个有关于
-安全的漏洞被发现的时候，并且它可能会被尽快的修复或者公开。请把这个安全
-漏洞报告给Linux内核安全团队。
-
-1) 联系
-
-linux内核安全团队可以通过email<security@kernel.org>来联系。这是
-一组独立的安全工作人员，可以帮助改善漏洞报告并且公布和取消一个修复。安
-全团队有可能会从部分的维护者那里引进额外的帮助来了解并且修复安全漏洞。
-当遇到任何漏洞，所能提供的信息越多就越能诊断和修复。如果你不清楚什么
-是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
-何攻击性的代码都是非常有用的，未经报告者的同意不会被取消，除非它已经
-被公布于众。
-
-2) 公开
-
-Linux内核安全团队的宗旨就是和漏洞提交者一起处理漏洞的解决方案直
-到公开。我们喜欢尽快地完全公开漏洞。当一个漏洞或者修复还没有被完全地理
-解，解决方案没有通过测试或者供应商协调，可以合理地延迟公开。然而，我们
-期望这些延迟尽可能的短些，是可数的几天，而不是几个星期或者几个月。公开
-日期是通过安全团队和漏洞提供者以及供应商洽谈后的结果。公开时间表是从很
-短（特殊的，它已经被公众所知道）到几个星期。作为一个基本的默认政策，我
-们所期望通知公众的日期是7天的安排。
-
-3) 保密协议
-
-Linux内核安全团队不是一个正式的团体，因此不能加入任何的保密协议。
-- 
2.20.1

