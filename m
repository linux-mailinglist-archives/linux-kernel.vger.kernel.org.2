Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98081390956
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhEYTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232525AbhEYTAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:00:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D13DB6142D;
        Tue, 25 May 2021 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621969148;
        bh=is/NGrmgsSzX2OxAjXwabrq6tmqBczLOM6+ytnZaq9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTwbgM7yrNRfSQi86uyKVGe2O6dP1qQ4E70U0dncrDDVD9nOU/o0bvREJq/Y/z3M+
         rn5CYfaaXld8tqL4GMxcVZTQX1W4Dpax3M6mcWtBh0xgZO7MAtlYqYgHaDg/dLfjZM
         DvUNV/JXJydmZU1HpNSwRQTXQivTcmP9830FgFueAzyxGzOJxA7qYyLhhSsDPkK9xb
         uNoW0azgD+AQYhhl2smUYVDKxqs1beZr3MxwrVcu31aXvQZ3bZfjLIIWYpWuTeSyvt
         kcm1Kw8UCr7zSSFWJIG44khFHG458/asUQRAGONMdc7dj1PLdcT5m/N6IESvFNtiOF
         jgqy6ZuB4ITqQ==
From:   Will Deacon <will@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5] kasan: speed up mte_set_mem_tag_range
Date:   Tue, 25 May 2021 19:58:47 +0100
Message-Id: <162196691854.2317985.15060469643983512129.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210521010023.3244784-1-eugenis@google.com>
References: <20210521010023.3244784-1-eugenis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 18:00:23 -0700, Evgenii Stepanov wrote:
> Use DC GVA / DC GZVA to speed up KASan memory tagging in HW tags mode.
> 
> The first cacheline is always tagged using STG/STZG even if the address is
> cacheline-aligned, as benchmarks show it is faster than a conditional
> branch.

Applied to arm64 (for-next/mte), thanks!

[1/1] kasan: speed up mte_set_mem_tag_range
      https://git.kernel.org/arm64/c/3d0cca0b02ac

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
