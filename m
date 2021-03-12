Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DC3390F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhCLPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:14:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B3964DCC;
        Fri, 12 Mar 2021 15:14:09 +0000 (UTC)
Date:   Fri, 12 Mar 2021 15:14:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v15 0/8] arm64: ARMv8.5-A: MTE: Add async mode support
Message-ID: <20210312151406.GC24210@arm.com>
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312142210.21326-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 02:22:02PM +0000, Vincenzo Frascino wrote:
> Andrey Konovalov (1):
>   kasan, arm64: tests supports for HW_TAGS async mode
> 
> Vincenzo Frascino (7):
>   arm64: mte: Add asynchronous mode support
>   kasan: Add KASAN mode kernel parameter
>   arm64: mte: Drop arch_enable_tagging()
>   kasan: Add report for async mode
>   arm64: mte: Enable TCO in functions that can read beyond buffer limits
>   arm64: mte: Enable async tag check fault
>   arm64: mte: Report async tag faults before suspend

Other than the comments I gave already, feel free to add my ack on the
rest of the patches:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
