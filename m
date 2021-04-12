Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8935D2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbhDLWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbhDLWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:21:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:20:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n13so14114225ybp.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CWYLK1Nq956lXK6/CZyqJrTCFyW3FBgUwDisoyLnoZE=;
        b=JAJOXTeFhWLgvXICg+LDvObGR5FL/FNB/jnOfdao44BEDtwrf2fTtD5Z/B54TyJuvX
         f1m6IQUxQ2aKUsN94lnQWCqu0sUeG96gXdlcegV5bn/XXC3dw3nDZfING2MtRD75cZ3w
         qYyHV/nZZ03WqXdRKUz6oVzcUTiXUdZck/6yTI+lOjFyA00EjBqJqZSY4p5I8IxXTRnU
         45PFjbzpcYriIeK1vtUmjM0IR6Rl2fGlxE4tJGMzBCLeyTQZldelPq1wlsGTwXtlLl8w
         Yc6sEDtkNLqS+krwgsLIh3nByT9Vv94t8B64o/uyFxDIA2+o2QRMV1rHA/NbJH8WY/7E
         MlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CWYLK1Nq956lXK6/CZyqJrTCFyW3FBgUwDisoyLnoZE=;
        b=nT+fF9CwkLw5jPNSkp8k1Jnl4Achk8RyR/1i2npI7qh7GOhgpRk8xKnCejTuHVc4uR
         KyCgr1EMdn6ZfWxZO1hKgnh9Ep/ccl3gtc1/vwxwC++HepLxKm59sYbOQCaAqlntVIyY
         c76car2pEGCGTFXypDoCBfi7LnGhH3yd7krnHlpL7/nV8duoBaU740p9LIFXa+/g8arX
         wXopq9M+l9ALbK1bBlnAWQNGnkk9NnLQv5FU8Llm3v8xoAKLN8Vo7MBBRqGsVUPlnhDf
         1igbwnEBu5Fqttfjf8EXUC5vSeAPNhMnSIq/6n662clK+f5AqGkPcuTrZiD89AcL30P3
         YJlQ==
X-Gm-Message-State: AOAM533saOoAav7qyUkgLzAX/snmIqQxKsQtOryqECqrC5f5N9QSYgta
        OxaJQ8bMnv+HTrfYX/Mao2bg65Ly8/Y=
X-Google-Smtp-Source: ABdhPJwIxmb+XLWgx2RW89d77jd3AkTM4I4lGPEqIzhsdt9VwOq9Ll4tWQyfrDSEqTTpMdlUCP0VUNzutpU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f031:9c1c:56c7:c3bf])
 (user=seanjc job=sendgmr) by 2002:a25:cc3:: with SMTP id 186mr40287194ybm.178.1618266056256;
 Mon, 12 Apr 2021 15:20:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 12 Apr 2021 15:20:48 -0700
In-Reply-To: <20210412222050.876100-1-seanjc@google.com>
Message-Id: <20210412222050.876100-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210412222050.876100-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 1/3] KVM: Destroy I/O bus devices on unregister failure
 _after_ sync'ing SRCU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If allocating a new instance of an I/O bus fails when unregistering a
device, wait to destroy the device until after all readers are guaranteed
to see the new null bus.  Destroying devices before the bus is nullified
could lead to use-after-free since readers expect the devices on their
reference of the bus to remain valid.

Fixes: f65886606c2d ("KVM: fix memory leak in kvm_io_bus_unregister_dev()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 383df23514b9..d6e2b570e430 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4511,7 +4511,13 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 		new_bus->dev_count--;
 		memcpy(new_bus->range + i, bus->range + i + 1,
 				flex_array_size(new_bus, range, new_bus->dev_count - i));
-	} else {
+	}
+
+	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
+	synchronize_srcu_expedited(&kvm->srcu);
+
+	/* Destroy the old bus _after_ installing the (null) bus. */
+	if (!new_bus) {
 		pr_err("kvm: failed to shrink bus, removing it completely\n");
 		for (j = 0; j < bus->dev_count; j++) {
 			if (j == i)
@@ -4520,8 +4526,6 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 		}
 	}
 
-	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
-	synchronize_srcu_expedited(&kvm->srcu);
 	kfree(bus);
 	return;
 }
-- 
2.31.1.295.g9ea45b61b8-goog

