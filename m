Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4EF41C461
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbhI2MPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343566AbhI2MPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 912516138E;
        Wed, 29 Sep 2021 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632917624;
        bh=Xbtbg+mivL4Gh8sTI2cm/XRW1HEdKhYPFMoHfjA9G28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVThRYjz74LKPeRkGCHK1GgyAxTVXkLxGJgnGB08o3ctLNMMcschwUpw1sWl+YHKT
         H4F3IFXpr00Cdbu6HCXQwu/ZoybEKYaxtEvxnqCpGcZ0CqrPBKkKf9Ova9X8glwfWw
         4Nx2pUOCb/5qx/sD84U+A0P24heAwBY1igJw44dymW2nNLculvmHA0orXV0FUdXCUc
         yCFeRr4X6U6+HjfRnNhXaoLCquYRUlJRUcud9yqb8wzN/Z3NkPdbA5vR9fV5z9rfKJ
         04aA6vjRur+13bBY41DXUIzJMVu/m7863H4N/1sT6AekB2JwxL9gPnTk/xgbkEy6GM
         K2NcYURfh0XfQ==
Date:   Wed, 29 Sep 2021 13:13:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v17 05/15] arm64: kexec: skip relocation code for inplace
 kexec
Message-ID: <20210929121336.GB21631@willie-the-truck>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916231325.125533-6-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:13:15PM -0400, Pasha Tatashin wrote:
> In case of kdump or when segments are already in place the relocation
> is not needed, therefore the setup of relocation function and call to
> it can be skipped.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/machine_kexec.c   | 34 ++++++++++++++++++-----------
>  arch/arm64/kernel/relocate_kernel.S |  3 ---
>  2 files changed, 21 insertions(+), 16 deletions(-)

[...]

> @@ -188,19 +190,25 @@ void machine_kexec(struct kimage *kimage)
>  	local_daif_mask();
>  
>  	/*
> -	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
> -	 * transfer control to the kern_reloc which contains a copy of
> -	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
> -	 * uses physical addressing to relocate the new image to its final
> -	 * position and transfers control to the image entry point when the
> -	 * relocation is complete.
> +	 * Both restart and cpu_soft_restart will shutdown the MMU, disable data
> +	 * caches. However, restart will start new kernel or purgatory directly,
> +	 * cpu_soft_restart will transfer control to arm64_relocate_new_kernel
>  	 * In kexec case, kimage->start points to purgatory assuming that
>  	 * kernel entry and dtb address are embedded in purgatory by
>  	 * userspace (kexec-tools).
>  	 * In kexec_file case, the kernel starts directly without purgatory.
>  	 */
> -	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
> -			 kimage->arch.dtb_mem);
> +	if (kimage->head & IND_DONE) {
> +		typeof(__cpu_soft_restart) *restart;
> +
> +		cpu_install_idmap();
> +		restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
> +		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
> +			0, 0);

Why can't you call:

	cpu_soft_restart(kimage->start, kimage->arch.dtb_mem, 0, 0);

here instead of open-coding it?

Will
