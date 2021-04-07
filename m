Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8B3566A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhDGIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240769AbhDGIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4D04613E1;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783663;
        bh=PFoiUzrc4UDoKpKV5SVR6YKUlweDG13ENnan5BvdTW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWz7/FzZrsJNAGckZ8937l7y+tGenxlGLTbeiF0zz06miPvxH6erw1MWgpoWgJT+i
         gInxy/twE7rvKE1mpx5pJ2nq7i5fZ0gaBKW+C2AQnPuydV0ersHjgDdfmDwuucuBjM
         v6lHPXo2PKVV2O9cst7tgCSG0PB0sRPxPrUnCAMUVLwPVaNsVE+JmKaL8o4Z/Yv6yK
         uTTrhJkUnnPL+LFsVy7cE4IM5jDf40K/Z7Cx1OYz/DtjN3U4PK7I/DVS1GTHhDlUIF
         SDvUd/gthE5qlYDOqZIskV2hsU0+rijXo7nVeFeD/R8oR3GRvO2jC8HF2iKZBHI3KN
         dbx/ntAW5Odzg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2q-UI; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Jonathan Corbet" <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/19] docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
Date:   Wed,  7 Apr 2021 10:20:57 +0200
Message-Id: <87442e7f284d063b6e552080b4ed7ca891c4895c.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

transaltions -> translations

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
2.30.2

