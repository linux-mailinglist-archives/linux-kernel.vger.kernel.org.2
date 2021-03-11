Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11063373CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhCKNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbhCKNZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:25:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A17A264E22;
        Thu, 11 Mar 2021 13:25:13 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:25:10 +0000
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
Subject: Re: [PATCH v14 8/8] kselftest/arm64: Verify that TCO is enabled in
 load_unaligned_zeropad()
Message-ID: <20210311132509.GB30821@arm.com>
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
 <20210308161434.33424-9-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308161434.33424-9-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:14:34PM +0000, Vincenzo Frascino wrote:
> load_unaligned_zeropad() and __get/put_kernel_nofault() functions can
> read passed some buffer limits which may include some MTE granule with a
> different tag.
> 
> When MTE async mode is enable, the load operation crosses the boundaries
> and the next granule has a different tag the PE sets the TFSR_EL1.TF1
> bit as if an asynchronous tag fault is happened:
> 
>  ==================================================================
>  BUG: KASAN: invalid-access
>  Asynchronous mode enabled: no access details available
> 
>  CPU: 0 PID: 1 Comm: init Not tainted 5.12.0-rc1-ge1045c86620d-dirty #8
>  Hardware name: FVP Base RevC (DT)
>  Call trace:
>    dump_backtrace+0x0/0x1c0
>    show_stack+0x18/0x24
>    dump_stack+0xcc/0x14c
>    kasan_report_async+0x54/0x70
>    mte_check_tfsr_el1+0x48/0x4c
>    exit_to_user_mode+0x18/0x38
>    finish_ret_to_user+0x4/0x15c
>  ==================================================================
> 
> Verify that Tag Check Override (TCO) is enabled in these functions before
> the load and disable it afterwards to prevent this to happen.
> 
> Note: The issue has been observed only with an MTE enabled userspace.

The above bug is all about kernel buffers. While userspace can trigger
the relevant code paths, it should not matter whether the user has MTE
enabled or not. Can you please confirm that you can still triggered the
fault with kernel-mode MTE but non-MTE user-space? If not, we may have a
bug somewhere as the two are unrelated: load_unaligned_zeropad() only
acts on kernel buffers and are subject to the kernel MTE tag check fault
mode.

I don't think we should have a user-space selftest for this. The bug is
not about a user-kernel interface, so an in-kernel test is more
appropriate. Could we instead add this to the kasan tests and calling
load_unaligned_zeropad() and other functions directly?

-- 
Catalin
