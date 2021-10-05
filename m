Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD76A423373
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhJEW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhJEW1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:27:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC2566108F;
        Tue,  5 Oct 2021 22:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633472732;
        bh=smzxg6Waz9NwRXqFtPR8GCF7a2NpX81CiIFKqpxf0v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BfBcw3+Zsyp0pymJv6Wm2VTEn/3MNaxZrR85xMZWCDDi9RZeVvxbaCUIb4r/s5IUi
         g9GT9oHJH6zTIG8QfLUuHCqHtIt7EFs8yLQgf1NAtW3GaJ8rxLweJKriF2cIyYXKRJ
         CxCsfdfeU9XopBKZET8p72LyUYHvAW8DzuSN3RBY=
Date:   Tue, 5 Oct 2021 15:25:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/5] arm64: ARMv8.7-A: MTE: Add asymm in-kernel
 support
Message-Id: <20211005152531.9b1443e659f4200cd4d7182d@linux-foundation.org>
In-Reply-To: <20211004202253.27857-1-vincenzo.frascino@arm.com>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Oct 2021 21:22:48 +0100 Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

> This series implements the in-kernel asymmetric mode support for
> ARMv8.7-A Memory Tagging Extension (MTE), which is a debugging feature
> that allows to detect with the help of the architecture the C and C++
> programmatic memory errors like buffer overflow, use-after-free,
> use-after-return, etc.

I'm not sure which subsystem tree you were targeting here, so I grabbed
them.  I'll drop the -mm copy if this material pops up in a linux-next
via a different tree.
