Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9430B3934E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhE0RjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhE0RjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9638610A5;
        Thu, 27 May 2021 17:37:39 +0000 (UTC)
Date:   Thu, 27 May 2021 18:37:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH 4/4] arm64: kexec_image: Implement
 arch_kexec_locate_mem_hole()
Message-ID: <20210527173736.GG8661@arm.com>
References: <20210526190531.62751-1-maz@kernel.org>
 <20210526190531.62751-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526190531.62751-5-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:05:31PM +0100, Marc Zyngier wrote:
> Provide an arm64-specific implementation for arch_kexec_locate_mem_hole(),
> using the resource tree instead of memblock, and respecting
> the reservations added by EFI.
> 
> This ensures that kexec_file is finally reliable.
> 
> Reported-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

It would have been clearer if __walk_iomem_res_desc() was able to do
such child res excluding callback (if asked via a new flag/arg) directly
but it's too late in the day to figure out if it's possible. It would
save us from another callback in the arch code. But if it's not possible
or you want to stick to this approach, fine by me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
