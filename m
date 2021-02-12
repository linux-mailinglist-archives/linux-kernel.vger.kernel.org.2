Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10131A5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBLURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:17:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhBLUQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:16:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB1764E8A;
        Fri, 12 Feb 2021 20:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613160971;
        bh=Z6BeODGzyRx31VY22FuktGBOIe3w+i59UrY0eDPk1GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZc0O/AHZdME36mBlSpuJdaTY86T1zGR/Y8O1geqGr3tJc8lInivmvBY/iG5gMK/1
         NpxE17zhrMoPpLnCDQrfGi3aBw0mAUQxTyUBpmxB5OaQlm4tSPchaNe/Srul9UUh+4
         lp+bEV3E7OyO9/FkAgl3yJXmPMw3I3BAfrWesAGk=
Date:   Fri, 12 Feb 2021 12:16:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] kasan: export HW_TAGS symbols for KUnit tests
Message-Id: <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
In-Reply-To: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
References: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 21:08:52 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> Currently, building KASAN-KUnit tests as a module fails with:
> 
> ERROR: modpost: "mte_enable_kernel" [lib/test_kasan.ko] undefined!
> ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!
> 
> This change adds KASAN wrappers for mte_enable_kernel() and
> mte_set_report_once() and only defines and exports them when KASAN-KUnit
> tests are enabled.
> 
> The wrappers aren't defined when tests aren't enabled to avoid misuse.
> The mte_() functions aren't exported directly to avoid having low-level
> KASAN ifdefs in the arch code.
> 

Please confirm that this is applicable to current Linus mainline?

Today is pretty much the last day for getting material into 5.11, and
this patch has been churning somewhat.

So I think it would be better to merge this into 5.12-rc1, with a
cc:stable so it goes into 5.11.1.

For which we'll need a Fixes:, please?
