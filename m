Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B363375151
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhEFJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEFJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:13:58 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24423C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:12:59 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 25BCE379; Thu,  6 May 2021 11:12:57 +0200 (CEST)
Date:   Thu, 6 May 2021 11:12:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Init exception handling from cpu_init()
Message-ID: <YJOzFr1uanpaUFTe@8bytes.org>
References: <20210504171745.2249-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504171745.2249-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 07:17:45PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> SEV-ES guests require properly setup task register with which the TSS
> descriptor in the GDT can be located so that the IST-type #VC exception
> handler which they need to function properly, can be executed.
> 
> This setup needs to happen before attempting to load microcode in
> ucode_cpu_init() which can cause such #VC exceptions.
> 
> Simplify the machinery by running that exception setup from cpu_init()
> directly.
> 
> There should be no functional changes resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/processor.h |  1 -
>  arch/x86/kernel/cpu/common.c     | 14 +++-----------
>  arch/x86/kernel/smpboot.c        |  1 -
>  3 files changed, 3 insertions(+), 13 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>

