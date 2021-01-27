Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F499306075
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhA0QCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343662AbhA0QAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0571A207C4;
        Wed, 27 Jan 2021 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611763170;
        bh=sl0hajfkhycjjiqx2nFrmHKZ+VEN4o7Qoa1LysfxnZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPLTPALFgAql3/s75W0Pvj4/dDb+nEIVaNcUe1Iq9gitf+CIf4XnEPJr2IRsIdh5L
         d0tCnXWITl5BPgPvwKKg0cKzInggd0EsOLpQIaXHRDsSn/cjYLCG1b2LHtPB1KPwD2
         pFVbVci383OzO8jPrcRvrEmb9+RHOsne9As6KUafW2NLWu3xyuukOqtK4cieuch+ya
         aRM8GzJasxwZMw+xs5s/fplBrXhsKp7YcRiUcYO7vo4eEFXeP4o+cL3pke0LRAsa66
         UwgEBTPooziAlry7rmvbZivvjQRzWYdxbdEr7ucFVctVQUgFtdU/TwnXwYTxHay2nE
         fuHSj1RjSfmzQ==
From:   Will Deacon <will@kernel.org>
To:     jmorris@namei.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        matthias.bgg@gmail.com, james.morse@arm.com, selindag@gmail.com,
        mark.rutland@arm.com, Pavel Tatashin <pasha.tatashin@soleen.com>,
        rfontana@redhat.com, sashal@kernel.org, steve.capper@arm.com,
        tyhicks@linux.microsoft.com, kexec@lists.infradead.org,
        ebiederm@xmission.com, vladimir.murzin@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-mm@kvack.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: (subset) [PATCH v10 00/18] arm64: MMU enabled kexec relocation
Date:   Wed, 27 Jan 2021 15:59:22 +0000
Message-Id: <161176207403.2744652.12806246618808213171.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 14:19:05 -0500, Pavel Tatashin wrote:
> Changelog:
> v10:
> 	- Addressed a lot of comments form James Morse and from  Marc Zyngier
> 	- Added review-by's
> 	- Synchronized with mainline
> 
> [...]

Applied the first 12 patches to arm64 (for-next/kexec), thanks!

[01/18] arm64: kexec: make dtb_mem always enabled
        https://git.kernel.org/arm64/c/117cda9a7847
[02/18] arm64: hibernate: variable pudp is used instead of pd4dp
        https://git.kernel.org/arm64/c/41f67d40a31d
[03/18] arm64: hibernate: move page handling function to new trans_pgd.c
        https://git.kernel.org/arm64/c/072e3d96a79a
[04/18] arm64: trans_pgd: make trans_pgd_map_page generic
        https://git.kernel.org/arm64/c/50f53fb72181
[05/18] arm64: trans_pgd: pass allocator trans_pgd_create_copy
        https://git.kernel.org/arm64/c/89d1410f4af5
[06/18] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
        https://git.kernel.org/arm64/c/5de59884ac0e
[07/18] arm64: mm: Always update TCR_EL1 from __cpu_set_tcr_t0sz()
        https://git.kernel.org/arm64/c/1401bef703a4
[08/18] arm64: trans_pgd: hibernate: idmap the single page that holds the copy page routines
        https://git.kernel.org/arm64/c/7018d467ff2d
[09/18] arm64: kexec: move relocation function setup
        https://git.kernel.org/arm64/c/4c3c31230c91
[10/18] arm64: kexec: call kexec_image_info only once
        https://git.kernel.org/arm64/c/77a43be11648
[11/18] arm64: kexec: arm64_relocate_new_kernel clean-ups and optimizations
        https://git.kernel.org/arm64/c/dbd82fee0f25
[12/18] arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
        https://git.kernel.org/arm64/c/a360190e8a42

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
