Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985EF3A69F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhFNPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233414AbhFNPXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93BE8613D3;
        Mon, 14 Jun 2021 15:21:16 +0000 (UTC)
Date:   Mon, 14 Jun 2021 16:21:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop SECTION_[SHIFT|SIZE|MASK]
Message-ID: <20210614152113.GE30667@arm.com>
References: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:48:26PM +0530, Anshuman Khandual wrote:
> SECTION_[SHIFT|SIZE|MASK] are essentially PMD_[SHIFT|SIZE|MASK]. But these
> create confusion being similar to generic sparsemem memory sections, which
> are derived from SECTION_SIZE_BITS. Section references have always implied
> PMD level block mapping. Instead just use all PMD level macros which would
> make it explicit and also remove confusion with sparsmem memory sections.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

The clean-up looks good to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
