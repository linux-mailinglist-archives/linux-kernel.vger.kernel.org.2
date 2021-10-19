Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C024330AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhJSIHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234694AbhJSIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AA8E6137D;
        Tue, 19 Oct 2021 08:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630673;
        bh=uSYnEW1MU4+2trpILgPQ0bvo1YVZrQYVHHdygicuNUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSKdJKx3N49OxAfjUHyOL9Fg8HNDjvfgKjj5sxGiNEgSGBifWLF1ZxODKKHS7DKF1
         6J2ft9woB0JWpnPYqnnMs6V2lzo48KWc7Jw4ynyUseLpcJvveON75grlBidKnUv4ei
         Ca9QEwnzhly6TP/Odp+FnTu9TQjlP09fN/2vvgUYvvyIig+KPbgzYs9H6ALW+G0sQ+
         Fk7VjofmF5RDOwhVV30bHQZeOYWDLzsTrPfY8zwn7w6H/BUVw7UU0fbs/mJ//RH3ZU
         usEkr4ckFXOGpb8FttcompSIhCuwxApy5TJm9KOipOb1G5bHPQkRNn8Zn2O0rFMKU4
         nPF70C7w+PrXw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJa-88; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/23] docs: translations: zh_CN: memory-hotplug.rst: fix a typo
Date:   Tue, 19 Oct 2021 09:04:15 +0100
Message-Id: <b22b772c23f531708a9bc025d56c0312a53bd6c9.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_hotplug.rst -> memory-hotplug.rst

Fixes: 620127548a69 ("docs/zh_CN: add core api memory_hotplug translation")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 Documentation/translations/zh_CN/core-api/memory-hotplug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
index 9a204eb196f2..9b2841fb9a5f 100644
--- a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
+++ b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/core-api/memory_hotplug.rst
+:Original: Documentation/core-api/memory-hotplug.rst
 
 :翻译:
 
-- 
2.31.1

