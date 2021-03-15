Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645AA33AA59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCOETo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhCOETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615781940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aKj/5CA1P2uSnEV3uJxCfOdpLBFnK+/ZnKmjfmOEBg0=;
        b=NEhcUoPRqopm807R5vKYJehGAJgVo1wxFbSwvwpxJiiUX9DuAK28ck/2taUxDjShGjs27+
        F2rBBW+10kNtn/I7OzYnN68vcw91GJ29OvvVBZnrCM42p8GXOKuayIr+CfkulMd1gBAPQp
        pyWKZrUbY+53dYluhcUEnE9BWdc7DYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-iehVtjabMYu8qajrojFgkA-1; Mon, 15 Mar 2021 00:18:58 -0400
X-MC-Unique: iehVtjabMYu8qajrojFgkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8FB801817;
        Mon, 15 Mar 2021 04:18:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 441C7437F;
        Mon, 15 Mar 2021 04:18:54 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, shan.gavin@gmail.com
Subject: [PATCH 0/4] KVM: arm64: Minor page fault handler improvement
Date:   Mon, 15 Mar 2021 12:18:40 +0800
Message-Id: <20210315041844.64915-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series includes several minior improvements to stage-2 page fault
handler: PATCH[1/2] are cleaning up the code. PATCH[3] fixes the address
range check on adding new memory slot. PATCH[4] don't retrieve the memory
slot again in the page fault handler to save a bit CPU cycles.

Gavin Shan (4):
  KVM: arm64: Hide kvm_mmu_wp_memory_region()
  KVM: arm64: Use find_vma_intersection()
  KVM: arm64: Fix address check for memory slot
  KVM: arm64: Don't retrieve memory slot again in page fault handler

 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/mmu.c              | 19 +++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.23.0

