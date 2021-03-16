Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DD33CC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhCPEMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhCPELk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615867899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r+17IQWtv/wBkvaPEi3N+nCMeCCp+098AbtNh4M0c3Y=;
        b=HD0Ei2pK6iKNTNJYwjwZ+EbUEepCnX3T2yqD8TNmH+xnwvn25xyVfEIfnmncvp8GGozHll
        smJtI8AoJiQ8cGINe1moPLy1r4hDlY9ZJcdiQy8n8fmXGNoHSsDccYzh0xqPLtqaNmZL9g
        ZTp+tbLJoft828DFA15kMBMYKTlQNWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-FGuNs7kmNfimLMJbDYVnPA-1; Tue, 16 Mar 2021 00:11:34 -0400
X-MC-Unique: FGuNs7kmNfimLMJbDYVnPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E210107ACCA;
        Tue, 16 Mar 2021 04:11:33 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E15F5B4A8;
        Tue, 16 Mar 2021 04:11:29 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        zhukeqian1@huawei.com, shan.gavin@gmail.com
Subject: [PATCH v2 0/3] KVM: arm64: Minor page fault handler improvement
Date:   Tue, 16 Mar 2021 12:11:23 +0800
Message-Id: <20210316041126.81860-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series includes several minior improvements to stage-2 page fault
handler: PATCH[1/2] are cleaning up the code. PATCH[3] don't retrieve
the memory slot again in the page fault handler to save a bit CPU cycles.

Changelog
=========
v2:
   * Rebased to 5.12.rc3 and include r-bs from Keqian  (Gavin)
   * Drop patch to fix IPA limit boundary issue        (Keqian)
   * Comments on why we use __gfn_to_pfn_memslot()     (Keqian)

Gavin Shan (3):
  KVM: arm64: Hide kvm_mmu_wp_memory_region()
  KVM: arm64: Use find_vma_intersection()
  KVM: arm64: Don't retrieve memory slot again in page fault handler

 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/mmu.c              | 21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.23.0

