Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24273B5B90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhF1Jta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232586AbhF1Jt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624873623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1PSxNv11vEQ/dV/nSn7VQstGKHef8H9HEckMab64xc=;
        b=ArMfRGf+yEropZ2Yjv168AAoUBdQJGaYlQn2ZOgku58ySDh/yxiTgH72VxjWCpDnNBLsvF
        LWguHSvyPm+H5lpGyI5zgPYuiyRkahFp1s0g5WUXGqVfPhuqpJjulDeJG569viht/kMiug
        DU6XeKagPLtM7nnyP4hwibNVV8ZkQmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-MegPe-coP_C1WswHwCT9vQ-1; Mon, 28 Jun 2021 05:47:01 -0400
X-MC-Unique: MegPe-coP_C1WswHwCT9vQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDF341906804;
        Mon, 28 Jun 2021 09:46:58 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-121.rdu2.redhat.com [10.10.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 691CF60C9F;
        Mon, 28 Jun 2021 09:46:53 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/4] trace/osnoise: Make interval u64 on osnoise_main
Date:   Mon, 28 Jun 2021 11:45:48 +0200
Message-Id: <4ae1e7780563598563de079a3ef6d4d10b5f5546.1624872608.git.bristot@redhat.com>
In-Reply-To: <cover.1624872608.git.bristot@redhat.com>
References: <cover.1624872608.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported:

  >> kernel/trace/trace_osnoise.c:966:3: warning: comparison of distinct
     pointer types ('typeof ((interval)) *' (aka 'long long *') and
     'uint64_t *' (aka 'unsigned long long *'))
     [-Wcompare-distinct-pointer-types]
                   do_div(interval, USEC_PER_MSEC);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:228:28: note: expanded from macro 'do_div'
           (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
                  ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~

As interval cannot be negative because sample_period >= sample_runtime,
making interval u64 on osnoise_main() is enough to fix this problem.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e2401659b0e5..4cd9e66e8513 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1202,7 +1202,7 @@ static struct cpumask save_cpumask;
  */
 static int osnoise_main(void *data)
 {
-	s64 interval;
+	u64 interval;
 
 	while (!kthread_should_stop()) {
 
-- 
2.31.1

