Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF93B5B93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhF1Jte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232596AbhF1Jtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624873627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCxxjPOMK626lwweSQwJ6p0VG+Oz3KmoKLw/q0UxjIE=;
        b=GbYk3hAUSw+ZWidNZCXOpEJvB1U+ifZAaiCQz68VgCf9bkJ3hDn9MZP5bKxd1OGyk/AWRT
        j27tt4Ra9rXGbxw7Y2NmmgUYM/4a5R1/LQovPEdAm9iZ1SwneS8lqaKE5L7Ca/S23i0hgN
        TzPfH2lIrBxEcu1k3c96E+M2D22U9rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-yHvpfYCHP3GWqwFZz7t2Dw-1; Mon, 28 Jun 2021 05:47:05 -0400
X-MC-Unique: yHvpfYCHP3GWqwFZz7t2Dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7731519067E3;
        Mon, 28 Jun 2021 09:47:04 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-121.rdu2.redhat.com [10.10.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE06E60C9F;
        Mon, 28 Jun 2021 09:47:01 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 4/4] Documentation: Fix a typo on trace/osnoise-tracer
Date:   Mon, 28 Jun 2021 11:45:50 +0200
Message-Id: <43e5160422a967218aa651c47f523e8d32d6a59e.1624872608.git.bristot@redhat.com>
In-Reply-To: <cover.1624872608.git.bristot@redhat.com>
References: <cover.1624872608.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/RUNTIME IN USE/RUNTIME IN US/

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 37a3c10fb216..b648cb9bf1f0 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -77,7 +77,7 @@ In addition to the regular trace fields (from TASK-PID to TIMESTAMP), the
 tracer prints a message at the end of each period for each CPU that is
 running an osnoise/ thread. The osnoise specific fields report:
 
- - The RUNTIME IN USE reports the amount of time in microseconds that
+ - The RUNTIME IN US reports the amount of time in microseconds that
    the osnoise thread kept looping reading the time.
  - The NOISE IN US reports the sum of noise in microseconds observed
    by the osnoise tracer during the associated runtime.
-- 
2.31.1

