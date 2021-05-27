Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BAF393502
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhE0Rk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235365AbhE0Rky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:40:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0730613BE;
        Thu, 27 May 2021 17:39:17 +0000 (UTC)
Date:   Thu, 27 May 2021 18:39:15 +0100
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
Subject: Re: [PATCH 0/4] arm64: Make kexec_file_load honor iomem reservations
Message-ID: <20210527173915.GH8661@arm.com>
References: <20210526190531.62751-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526190531.62751-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:05:27PM +0100, Marc Zyngier wrote:
> This series is a complete departure from the approach I initially sent
> almost a month ago[1]. Instead of trying to teach EFI, ACPI and other
> subsystem to use memblock, I've decided to stick with the iomem
> resource tree and use that exclusively for arm64.
> 
> This means that my current approach is (despite what I initially
> replied to both Dave and Catalin) to provide an arm64-specific
> implementation of arch_kexec_locate_mem_hole() which walks the
> resource tree and excludes ranges of RAM that have been registered for
> any odd purpose. This is exactly what the userspace implementation
> does, and I don't really see a good reason to diverge from it.
> 
> Again, this allows my Synquacer board to reliably use kexec_file_load
> with as little as 256M, something that would always fail before as it
> would overwrite most of the reserved tables.
> 
> Obviously, this is now at least 5.14 material. Given how broken
> kexec_file_load is for non-crash kernels on arm64 at the moment,
> should we at least disable it in 5.13 and all previous stable kernels?

I think it makes sense to disable it in the current and earlier kernels.

For this series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
