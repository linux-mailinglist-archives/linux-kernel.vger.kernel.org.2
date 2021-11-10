Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534E44C832
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhKJS7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 13:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234029AbhKJS5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 13:57:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 938FA61A03;
        Wed, 10 Nov 2021 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636570230;
        bh=NsbIr5bChjjcUDITu5+6wWc7IBaJx+yTotGfwq4f0Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU80CqhTtIdoTs4hEEF15pEK2rXVL/DdYdLIRVJSxAb7czhr7TtGq30YSGljGLOSZ
         AepfcrcimeMOQPs2KGKooLT+eGE+WGrBspSlraxs7UbD+pz8PBNogwPsYFTAbfAsq7
         dBvI0rE+rUwg6IAOA7BkWi5sAsbm4IAYXNhGth3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 02/26] Revert "x86/kvm: fix vcpu-id indexed array sizes"
Date:   Wed, 10 Nov 2021 19:44:01 +0100
Message-Id: <20211110182003.794713588@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110182003.700594531@linuxfoundation.org>
References: <20211110182003.700594531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit 1e254d0d86a0f2efd4190a89d5204b37c18c6381 upstream.

This reverts commit 76b4f357d0e7d8f6f0013c733e6cba1773c266d3.

The commit has the wrong reasoning, as KVM_MAX_VCPU_ID is not defining the
maximum allowed vcpu-id as its name suggests, but the number of vcpu-ids.
So revert this patch again.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20210913135745.13944-2-jgross@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/ioapic.c |    2 +-
 arch/x86/kvm/ioapic.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -96,7 +96,7 @@ static unsigned long ioapic_read_indirec
 static void rtc_irq_eoi_tracking_reset(struct kvm_ioapic *ioapic)
 {
 	ioapic->rtc_status.pending_eoi = 0;
-	bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID + 1);
+	bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID);
 }
 
 static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic);
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -39,13 +39,13 @@ struct kvm_vcpu;
 
 struct dest_map {
 	/* vcpu bitmap where IRQ has been sent */
-	DECLARE_BITMAP(map, KVM_MAX_VCPU_ID + 1);
+	DECLARE_BITMAP(map, KVM_MAX_VCPU_ID);
 
 	/*
 	 * Vector sent to a given vcpu, only valid when
 	 * the vcpu's bit in map is set
 	 */
-	u8 vectors[KVM_MAX_VCPU_ID + 1];
+	u8 vectors[KVM_MAX_VCPU_ID];
 };
 
 


