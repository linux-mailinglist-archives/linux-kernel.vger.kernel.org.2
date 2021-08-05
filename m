Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2843E19FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhHERHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235799AbhHERHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:07:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6F9960F02;
        Thu,  5 Aug 2021 17:06:43 +0000 (UTC)
Date:   Thu, 5 Aug 2021 18:06:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
Subject: Re: [RFC V2 04/10] arm64/mm: Add FEAT_LPA2 specific
 ID_AA64MMFR0.TGRAN[2]
Message-ID: <20210805170636.GE6719@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627281445-12445-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:07:19PM +0530, Anshuman Khandual wrote:
> PAGE_SIZE support is tested against possible minimum and maximum values for
> its respective ID_AA64MMFR0.TGRAN field, depending on whether it is signed
> or unsigned. But then FEAT_LPA2 implementation needs to be validated for 4K
> and 16K page sizes via feature specific ID_AA64MMFR0.TGRAN values. Hence it
> adds FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2] values per ARM ARM (0487G.A).
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
