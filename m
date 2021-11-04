Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B527F4459A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhKDSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhKDSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:25:24 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC07C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:22:46 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x14-20020a63cc0e000000b002a5bc462947so4292988pgf.20
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5ix4/3NpnVGjtiMtY7OPBLAYG6TIPSiTGBCQ4cLZqp0=;
        b=efWWhQWTrD5lfJC4fSRT0cLT0sAac7iqEb9IXZ6vVJiMcyEIBaNnjQ04vuYm4vbmvk
         1ptu9qeRA+VUCg1goFVigN0sZu6EH0fo5gPgBuqKPXxcMTi23kQUe0Ngx22BBU3nvYQ+
         JZfPJnyaRESPD+5QHom4VxF+dN8bEmkGqFqi3N9l56lwB44BIFQsV4rAW5q3eYHZ4ai4
         0y2fYZN/TtH6U9ncfKnF611slYrT5jYu1bz0S+NyvRftIbGXT0DlcisyQyyUEJuDXkNu
         w1e7wZ0HLhr6jYxo8ZzBZcBatLtUXrbgSSRwFu0dhOj3Div55Q/aHTuXnkIlqi+2ZFBz
         bkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5ix4/3NpnVGjtiMtY7OPBLAYG6TIPSiTGBCQ4cLZqp0=;
        b=2ssiUIK8kWhiJU8WDutT/2xsya7pGB758VOZC6NVkOZFda/I7jE0XMxvbrSuK/t9IR
         X8+4O5YMirxywTg//noyAiUwgZjO3Pcfv4ltF1xX6mqNVnSBvyR9iXOhXUi+UGe+RZtR
         BaBaFdo3WvSPXspwQ6T8Fa0rQWiZmtzIx5qZzXLjrYnNJSOfo/JsvXAzSPXHX5fp7+4u
         4ELznLNkuQ5cJKmbn/GKCMOEhVZ8BX5QCmwB0g01x1N9YWbRBFUuksqzUZ5N2D/SjMNN
         eW5tELXHOEvAc/q/3G4jrAcm49bU4VjLskljrJeaOPZkiYinMt843zcXztd5Oo4KwtfC
         o1Mg==
X-Gm-Message-State: AOAM530x5j/E9toYKmFJx6hCigTnLfQ3q25+gEm3aOqLZRKfbriUVc/q
        kQi9W9LTzICxrv/gK9SWKAJMmAoymIY=
X-Google-Smtp-Source: ABdhPJxHMao3OUVZBSwT5hghVMfiyWgl2YnDvna/Q9hXIxJsNdv9txrkHMPTbKI67MTFbmwTyJWfIg9OW98=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c3:: with SMTP id
 v3mr154267pjd.0.1636050165321; Thu, 04 Nov 2021 11:22:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 18:22:38 +0000
In-Reply-To: <20211104182239.1302956-1-seanjc@google.com>
Message-Id: <20211104182239.1302956-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211104182239.1302956-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 1/2] x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if
 Hyper-V setup fails
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for a valid hv_vp_index array prior to derefencing hv_vp_index when
setting Hyper-V's TSC change callback.  If Hyper-V setup failed in
hyperv_init(), the kernel will still report that it's running under
Hyper-V, but will have silently disabled nearly all functionality.

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc2+ #75
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:set_hv_tscchange_cb+0x15/0xa0
  Code: <8b> 04 82 8b 15 12 17 85 01 48 c1 e0 20 48 0d ee 00 01 00 f6 c6 08
  ...
  Call Trace:
   kvm_arch_init+0x17c/0x280
   kvm_init+0x31/0x330
   vmx_init+0xba/0x13a
   do_one_initcall+0x41/0x1c0
   kernel_init_freeable+0x1f2/0x23b
   kernel_init+0x16/0x120
   ret_from_fork+0x22/0x30

Fixes: 93286261de1b ("x86/hyperv: Reenlightenment notifications support")
Cc: stable@vger.kernel.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/hyperv/hv_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 24f4a06ac46a..7d252a58fbe4 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -177,6 +177,9 @@ void set_hv_tscchange_cb(void (*cb)(void))
 		return;
 	}
 
+	if (!hv_vp_index)
+		return;
+
 	hv_reenlightenment_cb = cb;
 
 	/* Make sure callback is registered before we write to MSRs */
-- 
2.34.0.rc0.344.g81b53c2807-goog

