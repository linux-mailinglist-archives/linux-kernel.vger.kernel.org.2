Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3903B35D2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhDLWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbhDLWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:21:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:21:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 10so14017146ybu.18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ESswuqujHLR9RwIvnBx5XZH5Vn+MJ5i3MkDtDukO9o0=;
        b=D1tTFUeCdmwluFUVTzpGwF3ju7lYDhrtdS9PuO6ZgTVDdac6bd3h6POmsudUhkQ09r
         eX+aoQ0wza9Jf/Pn0Qb/hFavoSCKVNrq4aaMzxcLGdzslfWx7cTII/CCjZTQEbztPi8o
         qPG9pePkOtNftszj1a3Jb1eTu++jck2aBPxIK0Yi8q5Zj9VXSKOd9ICfJSQ/1BOvycRW
         OFPRE7Mrwf0PrU5bTE3FjsCPN7UpcZmtvnzRraAgf+vjEanLqGBDlMdlPsTouuJ8T4Bc
         qngB/tersKAYsRm6t35MX9LJ21hhzAGHqjLVM5pFzdUA9sO8J5bOF8QFYg54izbwh1Wf
         9l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ESswuqujHLR9RwIvnBx5XZH5Vn+MJ5i3MkDtDukO9o0=;
        b=B1EJQKp186V21LTPm+2fiDiUExDVMWFk5CBRrYWDTk0IwRRphbCnNHzy1PIEfdOQ6V
         l3mYB0UGKI/4LdjryJ7Yxr8b+oQ5Qd7IDGzCdzeB+6gZdNKNf3yQz3aYfMkqCvGwO2TT
         xgRmZGXoXeya7jeo1/EPiIhhWCsH7g0Zd5cydPwEY3eC0PrGZYAuRjr+IQIYz3cUSj3y
         iaAYfp12OtLq/Rl4A8WHeLE2CTDNAe3n5sCAg4ElAcNiJVtpWLvf5RQQx/pPUrUBZr4u
         qkof0ywA9jxfVK+0XFJ223BlHg2h4ChG3JaSmXCuoY8PNSX7Bx4pyyz9Yb6uQdhFbBpG
         V7zA==
X-Gm-Message-State: AOAM532bszpSqxJ/zyKgW+a3NfahgJNM7VC5eh9zYTbP99KejqGtTpWo
        c+9Xy2IabFEEW4CXfd9T6iJWjVMnTEI=
X-Google-Smtp-Source: ABdhPJy/vKp9lF3Y26AoMcKefOoc3C9FcpTbnn6rqDLQhJGEO8gZT+3DXRr2wOaM7WtseZ7zIBoiBj9XETU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f031:9c1c:56c7:c3bf])
 (user=seanjc job=sendgmr) by 2002:a25:4154:: with SMTP id o81mr12685872yba.69.1618266060926;
 Mon, 12 Apr 2021 15:21:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 12 Apr 2021 15:20:50 -0700
In-Reply-To: <20210412222050.876100-1-seanjc@google.com>
Message-Id: <20210412222050.876100-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210412222050.876100-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 3/3] KVM: Add proper lockdep assertion in I/O bus unregister
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert a comment above kvm_io_bus_unregister_dev() into an actual
lockdep assertion, and opportunistically add curly braces to a multi-line
for-loop.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ab1fa6f92c82..ccc2ef1dbdda 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4485,21 +4485,23 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	return 0;
 }
 
-/* Caller must hold slots_lock. */
 int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 			      struct kvm_io_device *dev)
 {
 	int i, j;
 	struct kvm_io_bus *new_bus, *bus;
 
+	lockdep_assert_held(&kvm->slots_lock);
+
 	bus = kvm_get_bus(kvm, bus_idx);
 	if (!bus)
 		return 0;
 
-	for (i = 0; i < bus->dev_count; i++)
+	for (i = 0; i < bus->dev_count; i++) {
 		if (bus->range[i].dev == dev) {
 			break;
 		}
+	}
 
 	if (i == bus->dev_count)
 		return 0;
-- 
2.31.1.295.g9ea45b61b8-goog

