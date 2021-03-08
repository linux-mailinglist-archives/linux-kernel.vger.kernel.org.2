Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02429331112
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhCHOkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:40:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE67A61554;
        Mon,  8 Mar 2021 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615214409;
        bh=x8y6+9lwwLTA+7GaPGFNlBIo0hz4BU+rCUjIgessVy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/SHDVgBZWhL1Ulr3Y3WI9mfZ3ofx3/ell2Jx1w8P+7TRWU9H7O46t8mgaogo67FZ
         lCO9rNBVP7twjmf07fObhpqxYLmx++BH7lyq1QAYjxNW9Xk37AADt39Shx2bT5cc8K
         QPflgzzFgA8ZQU1F6wOqoR89Mlp57zlblJ0wFbRO271RlsBmhpxJEtb/4tyi8ZiZhq
         JH64u092Y380SQLtN/ZwMWxC4+KPub0eQWxozk8T03Ccv6luV3c94nt6zVRjJnnFtK
         PgLVHbWGs5/8e0FMpPm+/ZyhZ9FSWAGQRKcW+3LOCtYckXQ2WX98VRTME2GufLKsPt
         /MklIJ044kzyw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop redundant ARCH_WANT_HUGE_PMD_SHARE
Date:   Mon,  8 Mar 2021 14:40:02 +0000
Message-Id: <161520855522.989841.7413567124396873130.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614575192-21307-1-git-send-email-anshuman.khandual@arm.com>
References: <1614575192-21307-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 10:36:32 +0530, Anshuman Khandual wrote:
> There is already an ARCH_WANT_HUGE_PMD_SHARE which is being selected for
> applicable configurations. Hence just drop the other redundant entry.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Drop redundant ARCH_WANT_HUGE_PMD_SHARE
      https://git.kernel.org/arm64/c/07fb6dc327f1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
