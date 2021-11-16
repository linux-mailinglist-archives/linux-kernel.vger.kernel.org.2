Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B814531DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhKPMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:13:58 -0500
Received: from smtpbgjp3.qq.com ([54.92.39.34]:59578 "EHLO smtpbgjp3.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236110AbhKPMNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:13:22 -0500
X-Greylist: delayed 22776 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 07:13:21 EST
X-QQ-mid: bizesmtp44t1637064619tdp2m1u1
Received: from localhost.localdomain (unknown [111.207.172.18])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 16 Nov 2021 20:10:17 +0800 (CST)
X-QQ-SSF: 01400000002000B0G000000A0000000
X-QQ-FEAT: ZHWZeLXy+8efjliGw0J+4h7EXHazGPJhLJdP0zD7SRYbHqFNdnR+KsiPtHZ1u
        vn4Lc1JGQCWs/DxCgDcig2ZphH0ZPagX0oKa+8n/wb2qaUNOKpN3qTTapASlUIm76QDrzcw
        Bh08Dizapl+dYMe0iODWpOWqtdNFsuP9s84lQrFi/XSc2mr3yXZMeB94D9BvrouNSP3VnQP
        /CwPWeqJsuCtH8RU/2lEYeSr/I/R7881AZklr86zY4EngdyKHjKYREioU/tz/gvutFUxPh3
        YdnjN/pFaNYOyCicDQbtW8mD+j8ziIfVpqW188w4H9JXG516vmwRuDem+UvKe+mQu76Zmrj
        b2GywDTk/XtnXKAts6C5ZtR2GH9gIHW7LC82k1q
X-QQ-GoodBg: 1
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] KVM: Fix the warning by the min()
Date:   Tue, 16 Nov 2021 20:10:14 +0800
Message-Id: <20211116121014.1675-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
virt/kvm/kvm_main.c:4995:10-11: WARNING opportunity for min()
virt/kvm/kvm_main.c:4924:10-11: WARNING opportunity for min()

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 virt/kvm/kvm_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d31724500501..bd646c64722d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4910,7 +4910,6 @@ int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 {
 	struct kvm_io_bus *bus;
 	struct kvm_io_range range;
-	int r;
 
 	range = (struct kvm_io_range) {
 		.addr = addr,
@@ -4920,8 +4919,8 @@ int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 	bus = srcu_dereference(vcpu->kvm->buses[bus_idx], &vcpu->kvm->srcu);
 	if (!bus)
 		return -ENOMEM;
-	r = __kvm_io_bus_write(vcpu, bus, &range, val);
-	return r < 0 ? r : 0;
+
+	return min(__kvm_io_bus_write(vcpu, bus, &range, val), 0);
 }
 EXPORT_SYMBOL_GPL(kvm_io_bus_write);
 
@@ -4981,7 +4980,6 @@ int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 {
 	struct kvm_io_bus *bus;
 	struct kvm_io_range range;
-	int r;
 
 	range = (struct kvm_io_range) {
 		.addr = addr,
@@ -4991,8 +4989,8 @@ int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 	bus = srcu_dereference(vcpu->kvm->buses[bus_idx], &vcpu->kvm->srcu);
 	if (!bus)
 		return -ENOMEM;
-	r = __kvm_io_bus_read(vcpu, bus, &range, val);
-	return r < 0 ? r : 0;
+
+	return min(__kvm_io_bus_read(vcpu, bus, &range, val), 0);
 }
 
 /* Caller must hold slots_lock. */
-- 
2.20.1



