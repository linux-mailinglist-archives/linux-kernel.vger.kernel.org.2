Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135373B5B92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhF1Jtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232596AbhF1Jtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624873625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQwFhKapZL6UsA+VsV+BKckM/z9GTyx8c9rV/2Kbgfo=;
        b=N0crKTlc34b1Q3zCxXTfzgPzQleoZaM0U1og4Gz2VQ0d+aPPOxOxRuYtqwzT+d7ovWkcoD
        P2vl1KrTXATk5DFiY7NKOqmkcFWjLkyKc3Twbr85DHF6KsTTHHgoYoC07z9sZpBVdefacw
        bHzu/YFyi6ZiHMgq2FX2P6LFyc75w9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-oLWlBJfeOIelmJKO9uCBpA-1; Mon, 28 Jun 2021 05:47:03 -0400
X-MC-Unique: oLWlBJfeOIelmJKO9uCBpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AC67100C611;
        Mon, 28 Jun 2021 09:47:01 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-121.rdu2.redhat.com [10.10.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D09160C5F;
        Mon, 28 Jun 2021 09:46:58 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/4] trace/osnoise: Fix return value on osnoise_init_hotplug_support
Date:   Mon, 28 Jun 2021 11:45:49 +0200
Message-Id: <c7fc67f1a117cc88bab2e508c898634872795341.1624872608.git.bristot@redhat.com>
In-Reply-To: <cover.1624872608.git.bristot@redhat.com>
References: <cover.1624872608.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported:

  >> kernel/trace/trace_osnoise.c:1584:2: error: void function
  'osnoise_init_hotplug_support' should not return a
  value [-Wreturn-type]
           return 0;

When !CONFIG_HOTPLUG_CPU.

Fix it problem by removing the return value.

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 4cd9e66e8513..03d41cb2219f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1583,7 +1583,7 @@ static void osnoise_init_hotplug_support(void)
 #else /* CONFIG_HOTPLUG_CPU */
 static void osnoise_init_hotplug_support(void)
 {
-	return 0;
+	return;
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-- 
2.31.1

