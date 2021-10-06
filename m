Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54454423961
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhJFIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237384AbhJFIH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 190C861040;
        Wed,  6 Oct 2021 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633507536;
        bh=m/bITbO+fnHxC6w2XqHsLQgPQuBKKPAKFZYbxDS68xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4v0iJvP23jjkwm2L/g7Duf52CfNnASEy7XPAgPGiwzdK/ekL6p7QZh4t4s0ZePqe
         A0iDrmzD3pT2yZopWhDgvP+76Bp7aXTemHmbm8tW0Y9wGUyG+ymFQj6cfqOTj5PLmV
         ZYAhJ3NnGuZ437dCvGfoKErauIdTrvX5f9Qi1g81A+Iqq0u6B5nGojqgUqpAmiG8IL
         QcNyeSTytt3QqmlbbjpvxaNs2vEcx9ToJFY7AJZ/m2y16KV0dMbegW6azdYgmyklnU
         9ME6f0WHtSnoPae/vrWwq5hcY6uqvDjR3vwCFfkxcHb0zT07ThJwSpNaVgB4YKixVC
         s+sFWPQdTBJ6g==
Date:   Wed, 6 Oct 2021 09:05:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/5] arm64: ARMv8.7-A: MTE: Add asymm in-kernel support
Message-ID: <20211006080530.GA30214@willie-the-truck>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
 <20211005152531.9b1443e659f4200cd4d7182d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005152531.9b1443e659f4200cd4d7182d@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Oct 05, 2021 at 03:25:31PM -0700, Andrew Morton wrote:
> On Mon,  4 Oct 2021 21:22:48 +0100 Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> 
> > This series implements the in-kernel asymmetric mode support for
> > ARMv8.7-A Memory Tagging Extension (MTE), which is a debugging feature
> > that allows to detect with the help of the architecture the C and C++
> > programmatic memory errors like buffer overflow, use-after-free,
> > use-after-return, etc.
> 
> I'm not sure which subsystem tree you were targeting here, so I grabbed
> them.  I'll drop the -mm copy if this material pops up in a linux-next
> via a different tree.

I'll queue 'em via the arm64 tree, as we already have some MTE work over
there and most of this series seems to be arch changes.

Cheers,

Will
