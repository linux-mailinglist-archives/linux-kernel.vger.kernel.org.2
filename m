Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93A63AC5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhFRIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhFRIZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:25:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 364F76128C;
        Fri, 18 Jun 2021 08:23:47 +0000 (UTC)
Date:   Fri, 18 Jun 2021 09:23:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Rename ARM64_SWAPPER_USES_SECTION_MAPS
Message-ID: <20210618082344.GA16116@arm.com>
References: <1623991622-24294-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623991622-24294-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:17:02AM +0530, Anshuman Khandual wrote:
> ARM64_SWAPPER_USES_SECTION_MAPS implies that a PMD level huge page mappings
> are used for swapper, idmap and vmemmap. Lets make it PMD explicit removing
> any possible confusion with generic memory sections and also bit generic as
> it's applicable for idmap and vmemmap mappings as well. Hence rename it as
> ARM64_KERNEL_USES_PMD_MAPS instead.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

With the removal of "section" naming in another patch, I think this
makes sense.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
