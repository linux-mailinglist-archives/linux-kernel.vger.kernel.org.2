Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55817356DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbhDGNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhDGNqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:46:52 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA1361382;
        Wed,  7 Apr 2021 13:46:43 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU8W1-0065Ei-5i; Wed, 07 Apr 2021 14:46:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, Gavin Shan <gshan@redhat.com>
Cc:     shan.gavin@gmail.com, linux-kernel@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH v2 0/3] KVM: arm64: Minor page fault handler improvement
Date:   Wed,  7 Apr 2021 14:46:38 +0100
Message-Id: <161780318317.1871386.15067995969870728434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316041126.81860-1-gshan@redhat.com>
References: <20210316041126.81860-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, gshan@redhat.com, shan.gavin@gmail.com, linux-kernel@vger.kernel.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 12:11:23 +0800, Gavin Shan wrote:
> The series includes several minior improvements to stage-2 page fault
> handler: PATCH[1/2] are cleaning up the code. PATCH[3] don't retrieve
> the memory slot again in the page fault handler to save a bit CPU cycles.
> 
> Changelog
> =========
> v2:
>    * Rebased to 5.12.rc3 and include r-bs from Keqian  (Gavin)
>    * Drop patch to fix IPA limit boundary issue        (Keqian)
>    * Comments on why we use __gfn_to_pfn_memslot()     (Keqian)
> 
> [...]

Applied to kvm-arm64/memslot-fixes, thanks!

[1/3] KVM: arm64: Hide kvm_mmu_wp_memory_region()
      commit: eab62148478d339a37c7a6b37d34182ccf5056ad
[2/3] KVM: arm64: Use find_vma_intersection()
      commit: c728fd4ce75e9c342ea96facc5a2fe5ddb976a67
[3/3] KVM: arm64: Don't retrieve memory slot again in page fault handler
      commit: 10ba2d17d2972926c60e01dace6d7a3f8d968c4f

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


