Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF57358BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhDHSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232405AbhDHSAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:00:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25CB3610C8;
        Thu,  8 Apr 2021 18:00:23 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com
Cc:     Will Deacon <will@kernel.org>,
        Derrick McKee <derrick.mckee@gmail.com>
Subject: Re: [PATCH] arm64: mte: Remove unused mte_assign_mem_tag_range()
Date:   Thu,  8 Apr 2021 19:00:21 +0100
Message-Id: <161790479237.12189.16889750597145288261.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407133817.23053-1-vincenzo.frascino@arm.com>
References: <20210407133817.23053-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 14:38:17 +0100, Vincenzo Frascino wrote:
> mte_assign_mem_tag_range() was added in commit 85f49cae4dfc
> ("arm64: mte: add in-kernel MTE helpers") in 5.11 but moved out of
> mte.S by commit 2cb34276427a ("arm64: kasan: simplify and inline
> MTE functions") in 5.12 and renamed to mte_set_mem_tag_range().
> 2cb34276427a did not delete the old function prototypes in mte.h.
> 
> Remove the unused prototype from mte.h.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: mte: Remove unused mte_assign_mem_tag_range()
      https://git.kernel.org/arm64/c/df652a16a657

-- 
Catalin

