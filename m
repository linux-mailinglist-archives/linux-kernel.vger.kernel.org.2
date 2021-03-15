Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE033C5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhCOSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhCOSl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:41:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E9DA601FE;
        Mon, 15 Mar 2021 18:41:56 +0000 (UTC)
Date:   Mon, 15 Mar 2021 18:41:53 +0000
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v16 6/9] arm64: mte: Conditionally compile
 mte_enable_kernel_*()
Message-ID: <20210315184152.GC22897@arm.com>
References: <20210315132019.33202-1-vincenzo.frascino@arm.com>
 <20210315132019.33202-7-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315132019.33202-7-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:20:16PM +0000, Vincenzo Frascino wrote:
> mte_enable_kernel_*() are not needed if KASAN_HW is disabled.
> 
> Add ash defines around the functions to conditionally compile the
> functions.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(BTW, Andrey now has a different email address; use the one in the
MAINTAINERS file)
