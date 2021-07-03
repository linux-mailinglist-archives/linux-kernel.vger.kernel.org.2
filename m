Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D83BA99F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhGCRBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 13:01:49 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:33708 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229499AbhGCRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 13:01:48 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2021 13:01:47 EDT
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 5083425762D;
        Sun,  4 Jul 2021 00:49:24 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id dWAa3b8PfRJC; Sun,  4 Jul 2021 00:49:07 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Sun,  4 Jul 2021 00:49:07 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.160.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id 8C71D201AAFF2;
        Sun,  4 Jul 2021 00:49:06 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     =?UTF-8?q?=E5=BC=A0=E4=B9=90=20Zhang=20Le?= <r0bertz@gentoo.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Remove the Microsoft rhetoric
Date:   Sun,  4 Jul 2021 00:48:34 +0800
Message-Id: <20210703164834.460447-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Chinese translation on par with original English coding-style.rst
Related commit b7592e5b82db19b72a34b471f3296ad3f651c8b9

Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
---
This is more of a crude first attempt to begin getting accustomed to
mailing list conventions of open-source communities.
While efforts have been made to conform to the patch submission
conventions, there is still inevitably certain omissions.
Any corrections and suggestions would be greatly appreciated! :)

 Documentation/translations/zh_CN/process/coding-style.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index b8c484a84d10..638d714bec83 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -268,8 +268,7 @@ C 程序员不使用类似 ThisVariableIsATemporaryCounter 这样华丽的名字
 ``count_active_users()`` 或者类似的名字，你不应该叫它 ``cntuser()`` 。
 
 在函数名中包含函数类型 (所谓的匈牙利命名法) 是脑子出了问题——编译器知道那些类
-型而且能够检查那些类型，这样做只能把程序员弄糊涂了。难怪微软总是制造出有问题
-的程序。
+型而且能够检查那些类型，这样做只能把程序员弄糊涂了。
 
 本地变量名应该简短，而且能够表达相关的含义。如果你有一些随机的整数型的循环计
 数器，它应该被称为 ``i`` 。叫它 ``loop_counter`` 并无益处，如果它没有被误解的
-- 
2.32.0

