Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E72441917
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhKAJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234569AbhKAJvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:51:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5E3960C40;
        Mon,  1 Nov 2021 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635759650;
        bh=SF7WKY1O6uumm2ECM8NsFAYbMFy4Hkjnwkn8xH3bmHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7UjP2MPnLxj2CKPa7Hrecp+CeBG3PNKKTdGOwRrAkLW3jJ12MCZab1EqVHlhCmif
         Wo0vNnJFdEt0DntnAingPDUAsuSQmLbgGG+KLagxI/4toDi0O+g/pSzktMM6tXRSPg
         GnLzgNRovPqCY1EyRQNc72++/h+KsxEj7e5P+Hk8GyJeAiTBgWeKtauaZ3AjyHaUSq
         xvKVad1AVREdo18u/QkbU0dgHDdrVKjyVdOSr8dUNTbTrA2d+t51JoAlhBgKzPFFmo
         iEG0huyK02qdBX0k1WQWbM/n3jgf2VxahvbdxseBGMbNn3+VYRbVTikCWCLhdPQoXO
         ynu1SmKs3ROuA==
Date:   Mon, 1 Nov 2021 09:40:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] [RFC] arm64: export this_cpu_has_cap
Message-ID: <20211101094045.GB27400@willie-the-truck>
References: <20211029113023.760421-1-arnd@kernel.org>
 <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
 <YXw4H2BNx85KnLDh@arm.com>
 <20211101090143.GA27181@willie-the-truck>
 <db9bb430-4502-0c46-d8d7-ddb236750499@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9bb430-4502-0c46-d8d7-ddb236750499@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 09:34:08AM +0000, Suzuki K Poulose wrote:
> On 01/11/2021 09:01, Will Deacon wrote:
> > On Fri, Oct 29, 2021 at 07:06:23PM +0100, Catalin Marinas wrote:
> > > On Fri, Oct 29, 2021 at 02:31:23PM +0100, Suzuki K Poulose wrote:
> > > > On 29/10/2021 12:30, Arnd Bergmann wrote:
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > > 
> > > > > It's now used in a coresight driver that can be a loadable module:
> > > > > 
> > > > > ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> > > > > 
> > > > > Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
> > > > 
> > > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > 
> > > > Will, Catalin, Mathieu,
> > > > 
> > > > Do you have a preference on how this fix can be pulled in ? This may
> > > > be safe to go via coresight tree if it is not too late. Otherwise,
> > > > it could go via the arm64 tree.
> > > 
> > > I think Will already closed/tagged the arm64 tree for the upcoming
> > > merging window, though he could take it as a fix afterwards.
> > > 
> > > If it doesn't conflict with the arm64 for-next/core, it's fine by me to
> > > go through the coresight tree.
> > > 
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > ---
> > > > > Not sure if we actually want this to be exported, this is my local
> > > > > workaround for the randconfig build bot.
> > > > > ---
> > > > >    arch/arm64/kernel/cpufeature.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > > > index ecbdff795f5e..beccbcfa7391 100644
> > > > > --- a/arch/arm64/kernel/cpufeature.c
> > > > > +++ b/arch/arm64/kernel/cpufeature.c
> > > > > @@ -2864,6 +2864,7 @@ bool this_cpu_has_cap(unsigned int n)
> > > > >    	return false;
> > > > >    }
> > > > > +EXPORT_SYMBOL(this_cpu_has_cap);
> > > 
> > > EXPORT_SYMBOL_GPL? I think this_cpu_has_cap() is a bit more more
> > > specialised than cpus_have_const_cap().
> > > 
> > > With that:
> > > 
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Yes, at this stage I think it's best for this to go via the Coresight tree.
> > So with the _GPL export:
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > If that doesn't work for some reason, I can take it next week after the
> > initial arm64 queue has been merged. Please just let me know.
> 
> As I understand correctly, this will now need to go via arm64 tree. The
> CoreSight tree changes are pulled into Greg's tree and the next it will
> happen is for the next release. Usually the fixes don't end up there
> during the -rc cycles. So, I believe it is better if this goes via
> arm64.

Hmm, are you saying that Coresight drivers don't receive fixes outside of
the merge window? That sounds sub-optimal...

But in any case, I'm happy to take this as long as it can wait until the
second half of the merge window.

Will
