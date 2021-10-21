Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE769435B63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhJUHLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhJUHLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:11:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F44860F5D;
        Thu, 21 Oct 2021 07:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634800175;
        bh=WahHG7+6RXOXTd5cHlv0M9Y1+G6DfOieSCDRmVXCyIA=;
        h=From:To:Cc:Subject:Date:From;
        b=eWjBh8zUKltk76y12P+nyZzRYcc2fXKUPWlEGeKgYOTEVt4+MoEIHF+U2iVQaIzHR
         50pirqvzlxGXVd2AMVKlqtysTKIAiMyhZQMwJT3daXJCVO1V3mWeIX+uizz4LOLLBB
         33Zcm6ZBapVUIXSTR0e1E1WeZMO92Bkvgm7FzR9MH+DYQKpay61IG86B9zcBbRi2BX
         nP3R8CLHklQlRpzSirmFUR/s3vsJegvgj6N+6ePrajIG0KI3fvwWhUmxtQSnu+nf1f
         8wcNgVsfRg6k1T+r2LK0yP0H/CqaC8kwgg43ONV5vtkYrrezlsshMU7SNpwAsyhW17
         360T2dUhi7jPg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] memblock: exclude MEMBLOCK_NOMAP regions from kmemleak 
Date:   Thu, 21 Oct 2021 10:09:27 +0300
Message-Id: <20211021070929.23272-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is take 2 to fix interaction between MEMBLOCK_NOMAP and kmemleak.

The previous version caused boot failures Qian Cai reported here:

https://lore.kernel.org/all/c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com

The failures happened because calling kmemleak_free_part_phys() (or any
kmemleak phys APIs for that matter) too early means it cannot use __va() on
arm64.

This late in the cycle I can only think of reverting kmemleak wavier from
memblock_mark_nomap() and putting it in the only two callers that set
MEMBLOCK_NOMAP to an allocated chunk rather than marking NOMAP "unusable"
memory reported by firmware.

The first patch here is the revert of v1 and the second patch is actual v2
implementation.

Vladimir and Qian, I'd appreciate if you could verify that v2 works for
you.

v2:
* move kmemleak waiver from memblock_mark_nomap() to callers that need it
* use kmemleak_ignore_phys() rather than kmemleak_free_part_phys() as
  Catalin suggested.

v1: https://lore.kernel.org/all/20211013054756.12177-1-rppt@kernel.org

Mike Rapoport (2):
  Revert "memblock: exclude NOMAP regions from kmemleak"
  memblock: exclude MEMBLOCK_NOMAP regions from kmemleak

 drivers/acpi/tables.c        |  3 +++
 drivers/of/of_reserved_mem.c |  2 ++
 mm/memblock.c                | 10 ++++------
 3 files changed, 9 insertions(+), 6 deletions(-)


base-commit: 519d81956ee277b4419c723adfb154603c2565ba
-- 
2.28.0

