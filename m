Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E13B7943
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhF2UZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233801AbhF2UZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84EE261D8C;
        Tue, 29 Jun 2021 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624998177;
        bh=tsoOj4FHpTgG9n3oYTCQ0vOW65Ii2XKzPal5jiN2p4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKDd7Z7+9X2kGG7UQFlL+hzU+/TRtWZZ1f/i7vUhHE27Pf0pRCxiA7bqyqqq4LkcD
         zLRDWxUulv8WXTVzt+/3Rn55kKbNH1yAsRl9uqkYHikoLdfRzEM2rhE4lUNM+sh5wU
         r1M1ok5jV3hTkG8wlewU8FY23ZLEzB348oHIk9NGVa/TUwpyNhRYDQZmWYY2wKELw1
         mRl85LSG2fkmGISh/egvALRDrhqM3Aq/bVJYzASbdqjmWm703mIWiNvf+zmix/x3D/
         G3TR528xUbdnjyjZPDRRMES6UOKGJUGaWu6UTip9u1I9JO7x9CoSwb6rc9fSr+ON2W
         kwMw/2yZSQIUg==
Date:   Tue, 29 Jun 2021 23:22:53 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86/SGX: drop spurious kernel-doc notation
Message-ID: <20210629202253.qwqpaqoauz4usgle@kernel.org>
References: <20210627223639.27714-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627223639.27714-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 03:36:39PM -0700, Randy Dunlap wrote:
> Drop mistaken kernel-doc notation where plain C comments
> should be used instead.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: linux-sgx@vger.kernel.org

"x86/SGX" -> "x86/sgx"

Anyway,

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

> ---
>  arch/x86/kernel/cpu/sgx/encl.h  |    2 +-
>  arch/x86/kernel/cpu/sgx/encls.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20210625.orig/arch/x86/kernel/cpu/sgx/encl.h
> +++ linux-next-20210625/arch/x86/kernel/cpu/sgx/encl.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * Copyright(c) 2016-20 Intel Corporation.
>   *
>   * Contains the software defined data structures for enclaves.
> --- linux-next-20210625.orig/arch/x86/kernel/cpu/sgx/encls.h
> +++ linux-next-20210625/arch/x86/kernel/cpu/sgx/encls.h
> @@ -11,7 +11,7 @@
>  #include <asm/traps.h>
>  #include "sgx.h"
>  
> -/**
> +/*
>   * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
>   *
>   * ENCLS has its own (positive value) error codes and also generates
> 

/Jarkko
