Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3935041C70E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbhI2OpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245396AbhI2OpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632926607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k2mLc/radmqh34XgUWy+HwWaMs9PrqhstK/RW+oNKnc=;
        b=hs5mKGQpv5TsD2uWcnCEtb68+6p7Vb0iJ9soH+KInBz2DkiwXXGiMMyzmxEuTezF59IB7s
        NzKvcgmK4uk4xf/OgHdDbJSu345ctVu81KX5aeKfVjDP8zxP5CgeJu6HkPp6w2FifeeEcS
        FBC+Voqe8KEFsSQeEtOI9pB0ktv0XLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-yY6d50MPNzqq9ntTG_In9g-1; Wed, 29 Sep 2021 10:43:25 -0400
X-MC-Unique: yY6d50MPNzqq9ntTG_In9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7065518414A6;
        Wed, 29 Sep 2021 14:43:24 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B69319C59;
        Wed, 29 Sep 2021 14:43:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1] x86/Kconfig: select ARCH_SELECT_MEMORY_MODEL only if FLATMEM and SPARSEMEM are possible
Date:   Wed, 29 Sep 2021 16:43:21 +0200
Message-Id: <20210929144321.50411-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86-64 we really only support CONFIG_SPARSEMEM; there is nothing users
can select. So enable the memory model selection (via
CONFIG_ARCH_SELECT_MEMORY_MODEL) only if both, SPARSEMEM and FLATMEM are
possible, which isn't the case on x86-64.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22d274e..50f98dc02ad4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1611,7 +1611,7 @@ config ARCH_SPARSEMEM_DEFAULT
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
-	depends on ARCH_SPARSEMEM_ENABLE
+	depends on ARCH_SPARSEMEM_ENABLE && ARCH_FLATMEM_ENABLE
 
 config ARCH_MEMORY_PROBE
 	bool "Enable sysfs memory/probe interface"
-- 
2.31.1

