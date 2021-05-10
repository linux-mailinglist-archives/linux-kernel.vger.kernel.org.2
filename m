Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39217378243
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhEJKdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231822AbhEJKaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC3D76191C;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=z9PrVdVXAHvCaRn+C1s2vWYKe0TVKExCVwxvWswapsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msPW4EIcjQKYLlClKbhfMCeBqk2XriApF00XoMZFnSiB6Z7yGFGDA7NQmrbNTDXnT
         fqv4mQDpkzdbcLmKkN30pCdvr72FY2gDV5IwoXbFMQQidp2bVilosmURccyvPmycoN
         1LXdnb0vFUUAfnp/tmZowzECULrF6qPqkyA75jdK09rIQz/Y81n7ph3wOgh3pEewcN
         loBlHx7ORo+c/qSuN6uPMbAPvBbYuFfOxIqHluGp981/esW6+kBBiDjKuQXkjrwIQO
         hxvYQHoT6ZWWrBg4Cg+4WwcjeJYkAo1K6YvLUxW7AjoeOvw01GcxWarFaaf2G/zHuL
         RMIr1rKVl1HOA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UPk-Ck; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 22/53] docs: block: data-integrity.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:34 +0200
Message-Id: <ddc1ab317831fe660f74ee9a6a5728e794ae636a.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+feff ('﻿'): ZERO WIDTH NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/block/data-integrity.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/data-integrity.rst b/Documentation/block/data-integrity.rst
index 4f2452a95c43..07a97aa26668 100644
--- a/Documentation/block/data-integrity.rst
+++ b/Documentation/block/data-integrity.rst
@@ -1,4 +1,4 @@
-﻿==============
+==============
 Data Integrity
 ==============
 
-- 
2.30.2

