Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCC3A7DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFOMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhFOMJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D4B16145E;
        Tue, 15 Jun 2021 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758819;
        bh=orJOTzhBCbmbuuOScQHL/i0SUXTtlvGwIMVBYOY8e3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjfZw9ODdO1wgAHf5EtZDm1Obwe1ZpEaDEeuSohVsHHWhVlnU2qe8Lrt6YhaL1qJU
         MduOqFZ0BIIElWAZZ1wq3tEpvYnYi3FomKF02jsFESoHER4iG3dE5WTdU/+WYHz/lQ
         6loblFXjQMgpBI+1h3sKlfKneazrOdEA3v11ZzZ87UFDEWfSGtxN9CKNlNPPbUW2J0
         LlNRwMkOtuPEiFze2IWl/rCJ4dU+WiRizxwiqjVFOnIzAcni/3cyADpaqnvtlRS9Fo
         2BqcAyvDyjTtBgQf4zNagbVNO0aUKD8LnC0NP5Kj9s8hnu7k3vJmlFwTLC1HP5vUcb
         sCHcp9MjTiApg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop SECTION_[SHIFT|SIZE|MASK]
Date:   Tue, 15 Jun 2021 13:06:50 +0100
Message-Id: <162375532027.2680644.15267910410598209844.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
References: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 13:48:26 +0530, Anshuman Khandual wrote:
> SECTION_[SHIFT|SIZE|MASK] are essentially PMD_[SHIFT|SIZE|MASK]. But these
> create confusion being similar to generic sparsemem memory sections, which
> are derived from SECTION_SIZE_BITS. Section references have always implied
> PMD level block mapping. Instead just use all PMD level macros which would
> make it explicit and also remove confusion with sparsmem memory sections.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Drop SECTION_[SHIFT|SIZE|MASK]
      https://git.kernel.org/arm64/c/4aaa87ab3d2d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
