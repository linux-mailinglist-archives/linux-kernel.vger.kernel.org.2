Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22683324840
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 02:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhBYBDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236708AbhBYBCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:02:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 560CD64EDD;
        Thu, 25 Feb 2021 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614214931;
        bh=zSaKKSiyZKraVWz5FbpVQIblGPLB0AVTulXPF08cecE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PI24cwjME1bYxLdzO4ZtC1uf4giWIR9zShuYVePhMi1Tf2WlkAfiWGphoUTC7z/yV
         sROM80OtycHY7h8X/HTU+S1YiAP/Js/4yYv2COTES6UxxMwu1RMTx0vcWlM32wpHKf
         MqvQQ3XPPl5IuZPQBXQQxRDDiARnn1/2CfFJr0aUbncdhvKH1c+v4YUwTP/K+ZEXOM
         hp19hJUUw+gKebluj4ZqWziLSeUxXlNzdQCNO/qpm7Bof6YyNH481tgSrNlG5pKwSm
         8q/Stk3GTm+MmRyhLds81X5fnwFOq3RWqM5GEiB2BKCUDXlx8StRezHoiw4eKGVZoy
         JvwtcxAmssDWQ==
Date:   Thu, 25 Feb 2021 03:01:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-sgx@vger.kernel.org, haitao.huang@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        bp@alien8.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/3] Introduce version array structure: sgx_va
Message-ID: <YDb3Atu0ZbOpPZf5@kernel.org>
References: <20210224222049.240754-1-jarkko@kernel.org>
 <64cac2aa-0c69-5438-1f0e-aa1386551198@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cac2aa-0c69-5438-1f0e-aa1386551198@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:48:50PM -0800, Dave Hansen wrote:
> On 2/24/21 2:20 PM, Jarkko Sakkinen wrote:
> > The use of sgx_va can be later on extended to the following use cases:
> > 
> > - A global VA for reclaimed SECS pages.
> > - A global VA for reclaimed VA pages.
> ...
> >  arch/x86/kernel/cpu/sgx/driver.c |   3 +-
> >  arch/x86/kernel/cpu/sgx/encl.c   | 180 ++++++++++++++++++++++---------
> >  arch/x86/kernel/cpu/sgx/encl.h   |  36 ++++---
> >  arch/x86/kernel/cpu/sgx/ioctl.c  |  77 +++++--------
> >  arch/x86/kernel/cpu/sgx/main.c   |  19 +---
> >  5 files changed, 184 insertions(+), 131 deletions(-)
> 
> It looks interesting.
> 
> Were you planning on keeping this on the back burner until we need it
> more acutely?  Or, were you thinking it should be merged immediately?

I think this can wait. Perhaps, this could be picked to some other patch
set, such as EDMM.

Let's just say that this should be part of anything that touches the page
reclaimer.

IDA might look odd. Mapping through IDA allocated ID's is for conserving
the amount of used EPC pages for the version array.

Alternative would be to linearly map enclave page offset to the VA page
index but that would introduce a sloppy allocation of EPC.

The selected approach, on the other hand, no matter how sparsely you create
enclave pages, that does not add to the amount of EPC VA page usage.

BTW, encl_page->va_page could be removed, and use sgx_va_get() to locate
the VA page, when needed. I'm open for opinions with this one: it's space
vs the cost of access question.

/Jarkko
