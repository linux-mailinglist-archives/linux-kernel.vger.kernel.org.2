Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40A031106B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhBERLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233265AbhBERLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 12:11:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E576E64F0D;
        Fri,  5 Feb 2021 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612551181;
        bh=arhgr6HZwMx+KwiMC93iN9wOeWnIuRyleMpKIV7Zng0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S212N52uWmFWIN66TCZww6h6k3uqoLbsWDtrv5h5r7q1lfRYioskV1F5OZPp4sykl
         8me8HveCHgDu1fxB5zq6S9hov3/mWs2h+d78KpzVI5z/CRJWT3fw1q4OXLCZ0v4xjt
         ch3F3mqJvzlJdPz5dmeV1cBcejw3MjNdTc3e4G+CkViCWwrlMg04ytw1Mg6NJzMge0
         DiozwkadLkWL8/9IwieLvVT0nHYc9hWoT3s+bO43CKXO8/9+Z1PDFF1MvJy3/Unva0
         k+X0yG8bRIQBlHU7oXecRqDZmgXvR891LP6uDMP1IcEMvwE8GQSEnO8H/5zjer5gzd
         UGNhMBrElIXlw==
From:   Will Deacon <will@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, peterx@redhat.com,
        elver@google.com
Subject: Re: [PATCH] mm/arm64: Correct obsolete comment in do_page_fault()
Date:   Fri,  5 Feb 2021 18:52:51 +0000
Message-Id: <161255062810.1453555.15259323279738372740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205090919.63382-1-linmiaohe@huawei.com>
References: <20210205090919.63382-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 04:09:19 -0500, Miaohe Lin wrote:
> commit d8ed45c5dcd4 ("mmap locking API: use coccinelle to convert mmap_sem
> rwsem call sites") has convertd down_read_trylock() to mmap_read_trylock().
> But it forgot to update the relevant comment.

Applied to arm64 (for-next/cosmetic), thanks!

[1/1] mm/arm64: Correct obsolete comment in do_page_fault()
      https://git.kernel.org/arm64/c/abd4737f67d7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
