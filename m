Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E173D3AF4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhFUSRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhFUSQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:16:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 479026100B;
        Mon, 21 Jun 2021 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624299244;
        bh=2amx5P6XjgZYv0txanRSu5/7nAroLuy6zHvMNtRUxd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoChQ35isenL0ze3Uukbbg9TSM+pe+t0zfNUFOFJ93WophotAMVZHeEVBfiBsp9fV
         3X/r/xdL1LUfF7iqqGSZDidQTRnAtATDxuc5ecrc9YQbnFt6Gy1b2mYN4rPQTpzptI
         d6LlkkOAD+5yOtOQL7E5mRkdeq3BIFbE5VUyAuxdhTNnYkEHfidvwws9S3q+4gwUWG
         eaeSDIGFciAnd2OfxdopPBi/fSzxoSkK2035Jgzhxf3OsazNKIgU7sIGcK+5BzCjN6
         rlk4UIM64rzMIoDrz1BIWVqXNRsfuRJSROE7ZBZHXfKT7qCVauHGNN7A6f4FjXz+zE
         jQ0duHTiPEVQg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Rename ARM64_SWAPPER_USES_SECTION_MAPS
Date:   Mon, 21 Jun 2021 19:13:59 +0100
Message-Id: <162429614365.4116678.14416977840509312271.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623991622-24294-1-git-send-email-anshuman.khandual@arm.com>
References: <1623991622-24294-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 10:17:02 +0530, Anshuman Khandual wrote:
> ARM64_SWAPPER_USES_SECTION_MAPS implies that a PMD level huge page mappings
> are used for swapper, idmap and vmemmap. Lets make it PMD explicit removing
> any possible confusion with generic memory sections and also bit generic as
> it's applicable for idmap and vmemmap mappings as well. Hence rename it as
> ARM64_KERNEL_USES_PMD_MAPS instead.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Rename ARM64_SWAPPER_USES_SECTION_MAPS
      https://git.kernel.org/arm64/c/2062d44da349

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
