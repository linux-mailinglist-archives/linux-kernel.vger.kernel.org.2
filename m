Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE341CAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbhI2RXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344159AbhI2RXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E40260E08;
        Wed, 29 Sep 2021 17:21:45 +0000 (UTC)
Date:   Wed, 29 Sep 2021 18:21:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v17 00/15] arm64: MMU enabled kexec relocation
Message-ID: <YVSgplQLvPg1490d@arm.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:13:10PM -0400, Pasha Tatashin wrote:
> Pasha Tatashin (15):
>   arm64: kernel: add helper for booted at EL2 and not VHE
>   arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
>   arm64: hibernate: abstract ttrb0 setup function
>   arm64: kexec: flush image and lists during kexec load time
>   arm64: kexec: skip relocation code for inplace kexec
>   arm64: kexec: Use dcache ops macros instead of open-coding
>   arm64: kexec: pass kimage as the only argument to relocation function
>   arm64: kexec: configure EL2 vectors for kexec
>   arm64: kexec: relocate in EL1 mode
>   arm64: kexec: use ld script for relocation function
>   arm64: kexec: install a copy of the linear-map
>   arm64: kexec: keep MMU enabled during kexec relocation
>   arm64: kexec: remove the pre-kexec PoC maintenance
>   arm64: kexec: remove cpu-reset.h
>   arm64: trans_pgd: remove trans_pgd_map_page()

FWIW, I'm fine with this series. I think the only concern raised by
James and not addressed is the possibility of the failure of the memory
allocation for copying the page tables during kexec. If anyone will
complain in the future, we can look into adding a fallback mechanism to
do the relocation with the MMU off.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
