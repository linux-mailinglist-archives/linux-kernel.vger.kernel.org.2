Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9C30B2E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBAWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhBAWot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:44:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2619D64ECC;
        Mon,  1 Feb 2021 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612219448;
        bh=bY5TMOz0te68qLVeDd3OlEIhLNM0l3Gtrel8LOEYnS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hhq7UvD4wMRGOAqhcU/qsOVoDxHKVK4v+m5plQ3IOEyAVCqYZWoarIQ61bAGp2NDW
         AMCIZRU6gRuxKGLC0odOIFPLShjvVOdNBD1kgPCNR7otmV3AUuvuYF0ewt3n2llhfd
         KgyxYOikqbFtLbW479v5j5+9fDNqLOIzANLFubQE=
Date:   Mon, 1 Feb 2021 14:44:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] arm64: kasan: simplify and inline MTE functions
Message-Id: <20210201144407.dd603ec4edcd589643654057@linux-foundation.org>
In-Reply-To: <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
        <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Feb 2021 20:43:34 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> This change provides a simpler implementation of mte_get_mem_tag(),
> mte_get_random_tag(), and mte_set_mem_tag_range().
> 
> Simplifications include removing system_supports_mte() checks as these
> functions are onlye called from KASAN runtime that had already checked
> system_supports_mte(). Besides that, size and address alignment checks
> are removed from mte_set_mem_tag_range(), as KASAN now does those.
> 
> This change also moves these functions into the asm/mte-kasan.h header
> and implements mte_set_mem_tag_range() via inline assembly to avoid
> unnecessary functions calls.
> 
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Co-developed-by requires a Signed-off-by: as well.  Vincenzo, please
send us one?


