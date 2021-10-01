Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8241EF0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353643AbhJAOD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354209AbhJAODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:03:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA7361278;
        Fri,  1 Oct 2021 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633096900;
        bh=7k8J4hVLhFBK3eMiMiK8hqRuB3P9jfD+acMH4FlpzHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQyJM5PE1v2PsPXtMgVXPRS69jwYq15GCSqJntv5wVEYDfl6Z+C1NIDAhFag6zmd1
         VCEyXmJrfivvtcv3FverqmQVlPja35LihszBynyo7jqqwynRoG6oIBH3f82V+BtRZA
         ny/rtimklWt138RI4HjweojYhA0pn+w+34FmvHX1fD/f/WiuwwdgU7Lu5rMIpn9UYS
         Y2eEBi7AnyZ3TRyeyg5YXZcb7VbXwqCDFJYKtPnL5KrCBUva64SXr9vHIYSGB+LsLh
         GBwkvYstWhDEVdKyiP0iFbR8XthYNxF2CkdOHvDtr54CDM87H+HErnyHmS4B18qOqw
         3+LlcLLbNRCzQ==
From:   Will Deacon <will@kernel.org>
To:     linux-mm@kvack.org, ebiederm@xmission.com, corbet@lwn.net,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        matthias.bgg@gmail.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, rfontana@redhat.com, maz@kernel.org,
        james.morse@arm.com, tglx@linutronix.de, selindag@gmail.com,
        linux-arm-kernel@lists.infradead.org, vladimir.murzin@arm.com,
        kernelfans@gmail.com, kexec@lists.infradead.org,
        steve.capper@arm.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v18 00/15] arm64: MMU enabled kexec relocation
Date:   Fri,  1 Oct 2021 15:01:31 +0100
Message-Id: <163309146157.2070475.7111592087053001525.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 14:30:58 +0000, Pasha Tatashin wrote:
> Changelog:
> v18:
> 	- Addressed comments from Will Deacon
> 	- Added Acks from Catalin Marinas
> v17:
> 	- Merged with 5.15-rc1 as requested by Catalin Marinas
> 	- Added Tested-by: Pingfan Liu <piliu@redhat.com>
> v16:
> 	- Merged with 5.14-rc4
> v15:
> 	- Changed trans_pgd_copy_el2_vectors() to use vector table that
> 	  only shared by kexec and hibernate. This way sync does not have
> 	  dangling branch that was recently introduced. (Reported by Marc
> 	  Zyngier)
> 	- Renamed is_hyp_callable() to is_hyp_nvhe() as requested by Marc
> 	  Zyngier
> 	- Clean-ups, comment fixes.
> 	- Sync with upstream 368094df48e680fa51cedb68537408cfa64b788e
> v14:
> 	- Fixed a bug in "arm64: hyp-stub: Move elx_sync into the vectors"
> 	  that was noticed by Marc Zyngier
> 	- Merged with upstream
> v13:
> 	- Fixed a hang on ThunderX2, thank you Pingfan Liu for reporting
> 	  the problem. In relocation function we need civac not ivac, we
> 	  need to clean data in addition to invalidating it.
> 	  Since I was using ThunderX2 machine I also measured the new
> 	  performance data on this large ARM64 server. The MMU improves
> 	  kexec relocation 190 times on this machine! (see below for
> 	  raw data). Saves 7.5s during CentOS kexec reboot.
> v12:
> 	- A major change compared to previous version. Instead of using
> 	  contiguous VA range a copy of linear map is now used to perform
> 	  copying of segments during relocation as it was agreed in the
> 	  discussion of version 11 of this project.
> 	- In addition to using linear map, I also took several ideas from
> 	  James Morse to better organize the kexec relocation:
> 	  	1. skip relocation function entirely if that is not needed
> 		2. remove the PoC flushing function since it is not needed
> 		   anymore with MMU enabled.
> v11:
> 	- Fixed missing KEXEC_CORE dependency for trans_pgd.c
> 	- Removed useless "if(rc) return rc" statement (thank you Tyler Hicks)
> 	- Another 12 patches were accepted into maintainer's get.
> 	  Re-based patches against:
> 	  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> 	  Branch: for-next/kexec
> v10:
> 	- Addressed a lot of comments form James Morse and from  Marc Zyngier
> 	- Added review-by's
> 	- Synchronized with mainline
> 
> [...]

Applied to arm64 (for-next/kexec), thanks!

[01/15] arm64: kernel: add helper for booted at EL2 and not VHE
        https://git.kernel.org/arm64/c/094a3684b9b6
[02/15] arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
        https://git.kernel.org/arm64/c/788bfdd97434
[03/15] arm64: hibernate: abstract ttrb0 setup function
        https://git.kernel.org/arm64/c/a347f601452f
[04/15] arm64: kexec: flush image and lists during kexec load time
        https://git.kernel.org/arm64/c/0d8732e461d6
[05/15] arm64: kexec: skip relocation code for inplace kexec
        https://git.kernel.org/arm64/c/5bb6834fc290
[06/15] arm64: kexec: Use dcache ops macros instead of open-coding
        https://git.kernel.org/arm64/c/3036ec599332
[07/15] arm64: kexec: pass kimage as the only argument to relocation function
        https://git.kernel.org/arm64/c/878fdbd70486
[08/15] arm64: kexec: configure EL2 vectors for kexec
        https://git.kernel.org/arm64/c/08eae0ef618f
[09/15] arm64: kexec: relocate in EL1 mode
        https://git.kernel.org/arm64/c/ba959fe96a1b
[10/15] arm64: kexec: use ld script for relocation function
        https://git.kernel.org/arm64/c/19a046f07ce5
[11/15] arm64: kexec: install a copy of the linear-map
        https://git.kernel.org/arm64/c/3744b5280e67
[12/15] arm64: kexec: keep MMU enabled during kexec relocation
        https://git.kernel.org/arm64/c/efc2d0f20a9d
[13/15] arm64: kexec: remove the pre-kexec PoC maintenance
        https://git.kernel.org/arm64/c/939f1b9564c6
[14/15] arm64: kexec: remove cpu-reset.h
        https://git.kernel.org/arm64/c/7a2512fa6493
[15/15] arm64: trans_pgd: remove trans_pgd_map_page()
        https://git.kernel.org/arm64/c/6091dd9eaf8e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
