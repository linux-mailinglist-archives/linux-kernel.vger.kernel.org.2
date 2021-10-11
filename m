Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3033A428A55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhJKKFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235602AbhJKKFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:05:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E80960F21;
        Mon, 11 Oct 2021 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633946581;
        bh=u6Ho+OxhDHAtodActOSMYjdYeifPsU+ZUBoJRxZfwYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJ/KMDlMFE3FjqLMyB0dhIgzK71QdTnLB/PaA3Y/8BoZQNO1vOJK+fqdyq4fV7TPa
         molQc76phmtvLuwuYFSmX8kft2O6Un13Iz3ZRyZoOW8gkIw+GEjNJJaUMcApv5mu79
         PbLA5qM0a0jraURiuFK5VYvzi+nI9jDxLWOkAU51QVwxwOHJcxjBstimunRmpnJ+84
         /0W7TGux9e2vY1KxAx8XpsKQsPHEwoqVmLh1YhfR8r7cigjOPZuCEYQhUQltTHWNRn
         Z/BR38c0WwMl/jSXiCZOS90Dbur4ybc05ERaEWgbNF+F/iwAx2SBhoYGyCSU9xdV2Q
         bc0ARLgO++04g==
Date:   Mon, 11 Oct 2021 11:02:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: asm: vdso: gettimeofday: export common variables
Message-ID: <20211011100256.GA3681@willie-the-truck>
References: <20211007195754.678124-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007195754.678124-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 09:57:54PM +0200, Anders Roxell wrote:
> When building the kernel with sparse enabled 'C=1' the following
> warnings can be seen:
> 
> arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: symbol '__kernel_clock_gettime' was not declared. Should it be static?
> arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: symbol '__kernel_gettimeofday' was not declared. Should it be static?
> arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: symbol '__kernel_clock_getres' was not declared. Should it be static?
> 
> Rework so the variables are exported, since these variables are
> created and used in vdso/vgettimeofday.c, also used in vdso.lds.S.

Hmm, these functions are part of the vDSO and shouldn't be called from the
kernel, so I don't think it makes sense to add prototypes for them to a
kernel header, to be honest.

Will
