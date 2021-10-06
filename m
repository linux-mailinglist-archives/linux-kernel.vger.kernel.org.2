Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47887423BD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbhJFLAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237836AbhJFLA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:00:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5630D610C9;
        Wed,  6 Oct 2021 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633517917;
        bh=QpBWxfC+Pn0Cm9rVeo661RIoy4X8+jtKuy+8kvHqBHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3g23VuzCRk+PHXDLJ1+Fsuslmzm5EnVz6gzJk/3DZ63iXfHt3tqNWO4weXAsa6bE
         Xec/DjIhAkStJBZNGQt2jm8f+CC/TYzIVPHutBzoq+P5IYXorS2HxiLPX/9VbXGXYj
         SuhPQV6VAs7TkMOlpNXf9eot7a5jpiK4pkBSQeYEBt5ldeqj89uTiBOZz6LMbENOPT
         mwFa60Wtqlvw5o8e20OwxVdNquxmcpbMuxpCGEVlrrZklJ8HmNq+1zOcAkT41hFeqf
         JHsPK0NrFss8jXtAgnwpSoI8gUxLAhSKLxJmVXLII84x6AgIp9mmV7inHyUop0/ZCL
         BJHTPe1it3Y1w==
Date:   Wed, 6 Oct 2021 11:58:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 5/5] kasan: Extend KASAN mode kernel parameter
Message-ID: <20211006105831.GA30555@willie-the-truck>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
 <20211004202253.27857-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004202253.27857-6-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:22:53PM +0100, Vincenzo Frascino wrote:
> Architectures supported by KASAN_HW_TAGS can provide an asymmetric mode
> of execution. On an MTE enabled arm64 hw for example this can be
> identified with the asymmetric tagging mode of execution. In particular,
> when such a mode is present, the CPU triggers a fault on a tag mismatch
> during a load operation and asynchronously updates a register when a tag
> mismatch is detected during a store operation.
> 
> Extend the KASAN HW execution mode kernel command line parameter to
> support asymmetric mode.
> 
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/dev-tools/kasan.rst |  7 +++++--
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/hw_tags.c                | 27 ++++++++++++++++++++++-----
>  mm/kasan/kasan.h                  | 22 +++++++++++++++++++---
>  mm/kasan/report.c                 |  2 +-
>  5 files changed, 48 insertions(+), 12 deletions(-)

I'll wait for an Ack from Andrey or Marco before queueing this.

Will
