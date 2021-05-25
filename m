Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0339094F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEYTAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhEYTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:00:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 961A06140F;
        Tue, 25 May 2021 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621969138;
        bh=KzKnoImOLNccv4mlMLsCqgSTZzzfpkJ4SZQgCF6lEwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rya4BE3muXcmPcZPPxxgdt8sV6pjoHlRXycLLtO4nJDahzzL104sp8sDXUJX1hmWk
         /4KwfS/+/8YnyvV1gYsxX2d9Rl5YgtilWrxNonvHtXD/fXLlqBqPDQNcHS14CsobCg
         SVQ8ccX4NIvyWK8nQBNSpSQ0QVpa6NA6JMZT9RSJEvKrB1YCmqOdBEvq2tjdKAZmLh
         Avoi2Mjr4IT2mPhKaslpK9JZuQ0vr8DFc2uqRFi/15YTzgE4LY4iOWLF+DZBCxJcmq
         J2p9VnufJE74nI3SHj/yzh1MTe1Y27Pw/zMvVkvcMGd+NAbCvTovcxU0G9hIgqqLgz
         COFO41AR24iMg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Remove [PUD|PMD]_TABLE_BIT from [pud|pmd]_bad()
Date:   Tue, 25 May 2021 19:58:42 +0100
Message-Id: <162196589876.2316489.9040188054395172704.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620644871-26280-1-git-send-email-anshuman.khandual@arm.com>
References: <1620644871-26280-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 16:37:51 +0530, Anshuman Khandual wrote:
> Semantics wise, [pud|pmd]_bad() have always implied that a given [PUD|PMD]
> entry does not have a pointer to the next level page table. This had been
> made clear in the commit a1c76574f345 ("arm64: mm: use *_sect to check for
> section maps"). Hence explicitly check for a table entry rather than just
> testing a single bit. This basically redefines [pud|pmd]_bad() in terms of
> [pud|pmd]_table() making the semantics clear.

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Remove [PUD|PMD]_TABLE_BIT from [pud|pmd]_bad()
      https://git.kernel.org/arm64/c/e377ab82311a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
