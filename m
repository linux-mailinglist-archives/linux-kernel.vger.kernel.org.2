Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D77411885
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhITPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234184AbhITPnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:43:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5330A60F58;
        Mon, 20 Sep 2021 15:41:49 +0000 (UTC)
Date:   Mon, 20 Sep 2021 16:41:46 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Add pud_sect_supported()
Message-ID: <YUirurhvmBPCOsS+@arm.com>
References: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:59:31PM +0530, Anshuman Khandual wrote:
> Section mapping at PUD level is supported only on 4K pages and currently it
> gets verified with explicit #ifdef or IS_ENABLED() constructs. This adds a
> new helper pud_sect_supported() for this purpose, which particularly cleans
> up the HugeTLB code path. It updates relevant switch statements with checks
> for __PAGETABLE_PMD_FOLDED in order to avoid build failures caused with two
> identical switch case values in those code blocks.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Assuming that you tested the corresponding configurations,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
