Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E423FD10D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbhIACHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241020AbhIACHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3632261074;
        Wed,  1 Sep 2021 02:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630462011;
        bh=DSCUQRSdragEEzlZKv869xq3IzlAEkU1nhp1bSUr5r8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IEHEE2e5stjF32aN0rgXnHZbll5zRjNjKXzo+H2Ai9Hv6TggYzRe24igtHwwmUlKS
         tIlBUHKY7hW6uUkYVbi1Tb3g6qPmqKxicVYLNNkuJntHCZyquFcG8s+K7PIk1RX5de
         1Y2N+tfBRaSCvlU8CS3rhjsiykmXOg63fOeGMEB5GxxMGZd++GxzvDJ4YLqzTkETy/
         ogR8qJ+d0BEA1scMB1pkfcN7gnsf48Fkq81hMyDkvFwP4JgFNkhDAFVWZ1+XOtwzr0
         o3THA+4wIgvCsXG61ioefTygWGq8TcxclUfIzLVCwOcbzkrVVM0JHD0gU74sFQinWA
         vr+cDZfLu3yCQ==
Message-ID: <bc4503dafe26269876057701ad6342bff73cbc45.camel@kernel.org>
Subject: Re: [PATCH v4 0/6] Basic recovery for machine checks inside SGX
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Sep 2021 05:06:49 +0300
In-Reply-To: <20210827195543.1667168-1-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 12:55 -0700, Tony Luck wrote:
> Here's version 4 (just 38 more to go if I want to meet the bar set by
> the base SGX series :-) )
>=20
> Changes since v3:
>=20
> Dave Hansen:
> 	1) Concerns about assigning a default value to the "owner"
> 	   pointer if the caller of sgx_alloc_epc_page() called with
> 	   a NULL value.
> 	Resolved: Sean provided a patch to fix the only caller that
> 	was using NULL. I merged it in here.
>=20
> 	2) Better commit message to explain why sgx_is_epc_page() is
> 	   exported.
> 	Done.
>=20
> 	3) Unhappy with "void *owner" in struct sgx_epc_page. Would
> 	   be better to use an anonymous union of all the types.
> 	Done.
>=20
> Sean Christopherson:
> 	1) Races updating bits in flags field.
> 	Resolved: "poison" is now a separate field.
>=20
> 	2) More races. When poison alert happens while moving
> 	   a page on/off a free/dirty list.
> 	Resolved: Well mostly. All the run time changes are now
> 	done while holding the node->lock. There's a gap while
> 	moving pages from dirty list to free list. But that's
> 	a short-ish window during boot, and the races are mostly
> 	harmless. Worst is that we might call __eremove() for a
> 	page that just got marked as poisoned. But then
> 	sgx_free_epc_page() will see the poison flag and do the
> 	right thing.
>=20
> Jarkko Sakkinen:
> 	1) Use xarray to keep track of which pages are the special
> 	   SGX EPC ones.
> 	This spawned a short discussion on whether it was overkill. But
> 	xarray makes the source much simpler, and there are improvements
> 	in the pipeline for xarray that will make it handle this use
> 	case more efficiently. So I made this change.
>=20
> 	2) Move the sgx debugfs directory under arch_debugfs_dir.
> 	Done.
>=20
> Tony Luck (6):
>   x86/sgx: Provide indication of life-cycle of EPC pages
>   x86/sgx: Add infrastructure to identify SGX EPC pages
>   x86/sgx: Initial poison handling for dirty and free pages
>   x86/sgx: Add SGX infrastructure to recover from poison
>   x86/sgx: Hook sgx_memory_failure() into mainline code
>   x86/sgx: Add hook to error injection address validation
>=20
>  .../firmware-guide/acpi/apei/einj.rst         |  19 +++
>  arch/x86/include/asm/set_memory.h             |   4 +
>  arch/x86/kernel/cpu/sgx/encl.c                |   5 +-
>  arch/x86/kernel/cpu/sgx/encl.h                |   2 +-
>  arch/x86/kernel/cpu/sgx/ioctl.c               |   2 +-
>  arch/x86/kernel/cpu/sgx/main.c                | 140 ++++++++++++++++--
>  arch/x86/kernel/cpu/sgx/sgx.h                 |  14 +-
>  drivers/acpi/apei/einj.c                      |   3 +-
>  include/linux/mm.h                            |  15 ++
>  mm/memory-failure.c                           |  19 ++-
>  10 files changed, 196 insertions(+), 27 deletions(-)
>=20
>=20
> base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93

Would be nice to get this also to linux-sgx@vger.kernel.org in
future.

/Jarkko
