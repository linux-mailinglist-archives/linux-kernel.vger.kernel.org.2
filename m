Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F422544D36B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhKKIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhKKIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB007C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h62-20020a25a544000000b005c5d9b06e57so8324554ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M+Jt1U9rGRY7ueu8QhTKXbEp5FJrT9ahXVfXgntcGxQ=;
        b=J8ogrbRUUO4ZorfroqqiBYvx689f70PfbMFO72jaekSQZfHDv3bOBvoFOdPgEUFJat
         MVkmFnV3TDQ5R3kwACQrp+/b8w/QdmlhHyLAWAWOrrzCa300CYgbWArYVn82IXGSpPUC
         EbfhX+na6FYQrXvKdyMXtq3Cs75Xcq+VUQ9OAIPiG6SuqlwY0vyqcIqBAVhTGWIFM/sg
         GscKD4qqJIFVS5bdxRtOk9S1+U3B6YyS63VSeK9zGfBd2MMuE99PIbL4rrPO4FqUEMQ+
         dMvlb4UCPHxK+tRWEYTc7IzP/wTuUfecJtiMsrs3mGr9rieElFqIeqcgwbHhJ6tFgXzZ
         Dq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M+Jt1U9rGRY7ueu8QhTKXbEp5FJrT9ahXVfXgntcGxQ=;
        b=yC6Zd+o2fIIUWbY4+chjalegr8kwDaU4rvvRVUfjG50aytnQdLlokXBVsWZH9BifP1
         GusuoskczF2gunxg0koPrllNtuusrYCshio3HRXPvw8AQCYGjM63LZmfRAi4pu06zYyX
         IG6V+afmglrLejndCdsTIBGAovP3F6Ld3/TGtYSa450AmI9LswB8oCiLBZrdYRBxa7m8
         jayuj+FxDPC343RotFfsGQFVrrGTzTlgsdftTYyJpgCct1N2QauafCS3sNTFlu4+mSeS
         DSqSkxE3Pp1mSL1JdKDZIrzYR2pE2Je9kfWxo4NnGR7EAMnt6+XkesFFJvCVnIIU7TM9
         SR0Q==
X-Gm-Message-State: AOAM531ka0MPs1KknSUxmUm8ZvvS3pzUzXcCKW+gSsTc5Xo3PPHF0UZH
        nQsuUov/LOS6aRIA4PU5g4RiqH9cp3qT/0ZfE8kp6zE7wDkm/PlzLPD22Eo9TY9OLTMsQpGJaE8
        AuCHE0LVWGpwTw8Z5F9V2ywhS9/SMh9BYgdBXaFrqkR2sEbFPS0KyQ1vYV022LPEJZWmTHnln
X-Google-Smtp-Source: ABdhPJzI1VHp1SrMP2jQNi73maN2kfXnp+Nye6lMuQjUT6pR557G78CAQjJugV5hRc+9XbwXVJ1Ly5/mH2QX
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:46:: with SMTP id 67mr6796709yba.380.1636620677931;
 Thu, 11 Nov 2021 00:51:17 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:04 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-3-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 02/13] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cpu feature for AMD Fam19h Branch Sampling feature as bit
31 of EBX on CPUID leaf function 0x80000008.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..e71443f93f04 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_BRS		(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.34.0.rc0.344.g81b53c2807-goog

