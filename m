Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1013A69E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhFNPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232809AbhFNPTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:19:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE646128B;
        Mon, 14 Jun 2021 15:17:01 +0000 (UTC)
Date:   Mon, 14 Jun 2021 16:16:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Use CONT_PMD_SHIFT for ARM64_MEMSTART_SHIFT
Message-ID: <20210614151658.GD30667@arm.com>
References: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 03:12:35PM +0530, Anshuman Khandual wrote:
> ARM64_MEMSTART_SIZE needs to be aligned with CONT_PMD_SIZE on 16K page size
> config. Hence just directly use CONT_PMD_SHIFT.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
