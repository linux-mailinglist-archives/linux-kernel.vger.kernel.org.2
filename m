Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976DA31FF51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBSTR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhBSTRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:17:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA8464E15;
        Fri, 19 Feb 2021 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613762224;
        bh=SbP5z5RED5aMCvqUy41JS/GV5Sl/82hXtlQ7tyEMgmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uofvkiZjI0doDBgEpP7lElbS8zrXzI/XWBvAnk9VdL9xJNEePTRKyNAna9LDmBQ7/
         OXGTX5otycebcoL6tKaACO3rnyj0CFKRsJ7Gv+RT3l2HsLlulLnQtCoA0r22Mt2LxQ
         3PQ+SumYtck/a7/jsEvIlNXJsjahjIKpAB0F6EgAq+pbzC1hjbTMl233tCKgesiY9P
         ZgIsz3+r7RzmdUcBL/I8lgxLP3vakPt19HNpuG79i8+vMGYFMMmL9Ja7sp5vi8ej19
         anmjGwfRNTJejd8js2l6yvBu5lCf4bhEV/9D5XE22rBFTiLVq8mKHKwWHy8/a3H2o8
         Abc0FQmyw76Ww==
From:   Will Deacon <will@kernel.org>
To:     Shaoying Xu <shaoyi@amazon.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        benh@amazon.com, fllinden@amazon.com
Subject: Re: [PATCH] arm64 module: set plt* section addresses to 0x0
Date:   Fri, 19 Feb 2021 19:16:55 +0000
Message-Id: <161375760038.289768.8112572248042757757.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210216183234.GA23876@amazon.com>
References: <20210216183234.GA23876@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 18:32:34 +0000, Shaoying Xu wrote:
> These plt* and .text.ftrace_trampoline sections specified for arm64 have
> non-zero addressses. Non-zero section addresses in a relocatable ELF would
> confuse GDB when it tries to compute the section offsets and it ends up
> printing wrong symbol addresses. Therefore, set them to zero, which mirrors
> the change in commit 5d8591bc0fba ("module: set ksymtab/kcrctab* section
> addresses to 0x0").

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64 module: set plt* section addresses to 0x0
      https://git.kernel.org/arm64/c/f5c6d0fcf90c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
