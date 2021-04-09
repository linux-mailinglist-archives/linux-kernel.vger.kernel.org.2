Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46F9359F37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhDIMsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233777AbhDIMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A53161106;
        Fri,  9 Apr 2021 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617972481;
        bh=Tj7z1zW72+qtHkoeI0ngIMPv3VOSrEkM37aHTlYijTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSc0TOB5iDQfrFZgdgZ2E3XeIICVG5Yc17Ydmmy21a0RasA6TdLWnI4W9tNUv4Pzb
         B0c+TEc5zFY2pCeAguU6tsTkzbor0xRVTPjGrO1vF5aEqEd3OrrYd5H6YIZDpE7UZB
         aOF9RVVxptcYSSnKk98BI4fvYnMzKrTV7sgNXdmTGfJ1YfdOKlez/28ceKRHfjFMtt
         Ncw4ML6PpxP6jKCyhKKDOreupuUOpEei7gG1Tw9EXpNhk9ejGDsN/TUrVxCqNfVNDj
         wJd6q20GMpwbHJaDAjNjWRKHj0gDi0HRSbsRy9ONpku1Fm9Mtljg03QaQacxPeUWrH
         cC66t5NcwefLg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lUqYE-001SLs-DP; Fri, 09 Apr 2021 14:47:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
Date:   Fri,  9 Apr 2021 14:47:51 +0200
Message-Id: <febb930dc6c8679e9da9e451aa82d9243cf97b9e.1617972339.git.mchehab+huawei@kernel.org>
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
2.30.2

