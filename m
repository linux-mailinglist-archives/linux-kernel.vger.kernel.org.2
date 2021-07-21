Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9561E3D0CED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhGUKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239929AbhGUKHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:07:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCED6138C;
        Wed, 21 Jul 2021 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626864482;
        bh=qR4EPIkAAUhsdXzNobnISSq8AvXs8KveVzIPRgC1ZSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ID6hrb0zF1vZAWTO/w64wkH49bmbmEGRBdhTkmz8CXH9ZQ5RF7SsBYyX6mXFyyASq
         f07Ztur3Q8lPzlkZAf/va0W1gLo9bnlyRHdsKrfjsu5sUGuqAvqSocHtj4yFnuL0cJ
         HiqjLARL7TjecLsxZuUzEPQkZx1WtlU6O3iMOLP74mxKJjN7PE3iMkNtcDR6HQfFGj
         XRT3R6bViCjK4K/kVOCKFpFBDjuL9BhP+zLL9tekrqcd4Umomaxh0EnxUYxWWnlo0R
         ld9xxHa8rszAKphlvt/IYjNPlhOofDAjcAFSKgUAqmggENwS95WZ2jZptkug0eO44b
         WhsgW3cGaup2Q==
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Paul Mackerras <paulus@samba.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
Date:   Wed, 21 Jul 2021 11:47:53 +0100
Message-Id: <162686329170.980657.905966885675716231.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r1fs1762.fsf@mpe.ellerman.id.au>
References: <20210720202627.Horde.vlszNhxkKrLIg0-3Sn2ucw5@messagerie.c-s.fr> <87r1fs1762.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 17:02:13 +1000, Michael Ellerman wrote:
> This reverts commit c742199a014de23ee92055c2473d91fe5561ffdf.
> 
> c742199a014d ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
> breaks arm64 in at least two ways for configurations where PUD or PMD
> folding occur:
> 
>   1. We no longer install huge-vmap mappings and silently fall back to
>      page-granular entries, despite being able to install block entries
>      at what is effectively the PGD level.
> 
> [...]

Thank you Michael! I owe you a beer next time I see you, if we don't go
extinct before then.

Applied to arm64 (for-next/fixes), thanks!

[1/1] Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
      https://git.kernel.org/arm64/c/d8a719059b9d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
