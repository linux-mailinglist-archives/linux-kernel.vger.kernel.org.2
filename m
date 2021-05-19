Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33E3889C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbhESIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234833AbhESIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F3D76044F;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=2NMVrFwqHdsru0mdolyaaR9NXw7N3y0XVJQhv9TxciE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0v2aiemNxOehA7JgTGxFSbVFpF4YvNj99+FIvRy4Z76LRLDsNeiDHIqKge2TLRT4
         ikz45+TRSq7Lzi0JsV3VhuyxqnjARWU8ntE0uCSJMDyiAYvQLxJ7Xf4T+LEiP1e+Mx
         9m6IPlIEug96K3vfDKGur/dtdKizLbTrACFTkxZyqY8c3TzkVR04x1eZXM3QLLe5Cs
         iWmVrTryPGbg1361wurkgj1A9W0nrQ5Osc7EL9n+v4DkdpD+jBLoPaFoSEzR0Q9ufc
         f/K6VWJSfQmLhpwPBCfnjbOeZ9g1srWtZAgqW+kTcmFZrQws4ZuvVg9DbnqtarcPLb
         49SrwZZOcKnlg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gY6-EP; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
Date:   Wed, 19 May 2021 10:51:40 +0200
Message-Id: <40b3d5c983fb06d8a58d1f613c175a98e0631677.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

transaltions -> translations

Acked-by: Wu XiangCheng <bobwxc@email.cn>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/zh_CN/process/8.Conclusion.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
index 71c3e30efc6f..4707f0101964 100644
--- a/Documentation/translations/zh_CN/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
@@ -19,7 +19,7 @@
 :ref:`Documentation/translations/zh_CN/process/howto.rst <cn_process_howto>`
 文件是一个重要的起点；
 :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
-和 :ref:`Documentation/transaltions/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
+和 :ref:`Documentation/translations/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
 也是所有内核开发人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制
 记录的；“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档
 （尽管某些发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
-- 
2.31.1

