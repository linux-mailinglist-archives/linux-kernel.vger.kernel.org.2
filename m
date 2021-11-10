Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1E44BDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKJJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKJJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:21:33 -0500
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Nov 2021 01:18:45 PST
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31ECC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:18:45 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4Hpzd858YdzGpGl;
        Wed, 10 Nov 2021 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=insiberia.net;
        s=stigmate; t=1636535532;
        bh=Im2XU5+r0lg7uNZI1OdjH4kWnkZFnr4vL5t3h3oqSUI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sY3RFBnVvU7VLNBDBihvapT/e9tt6I6lfbzCnYanRmVEj2qhCddN2a+PbCNdmJWFh
         yWZWDl69CrTzpLxxsZZA5RY0Vsxu229jLG2LVtgnQeO7ZIAUsxy4lhE94WsgieZUis
         n/sjTKVOP/94wQt5nKNH/CM2MRiokNU5BbvQTakc=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: stefano@distruzione.org) by localhost (Postfix) with ESMTPSA id 4Hpzd84CkQzGp4w;
        Wed, 10 Nov 2021 09:12:12 +0000 (UTC)
Message-ID: <700a92d942e3b9455d82a9833efd1f6db78dc500.camel@insiberia.net>
Subject: Re: [PATCH] Allow selecting amd-pstate without CPU_SUP_INTEL
From:   Stefano Picascia <stefano.picascia@insiberia.net>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Nov 2021 09:12:11 +0000
In-Reply-To: <YYqDhaXDIqJyjGjg@hr-amd>
References: <9932762ef184fe132acf176081f8893800c83800.camel@insiberia.net>
         <YYjqNaND8hLGsoXg@hr-amd>
         <6b30aaf57cec5b6a72cff1f32d4fe24e47e9754b.camel@insiberia.net>
         <YYqDhaXDIqJyjGjg@hr-amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-09 at 22:19 +0800, Huang Rui wrote:
> O Mon, Nov 08, 2021 at 06:01:51PM +0800, Stefano Picascia wrote:
> > On Mon, 2021-11-08 at 17:13 +0800, Huang Rui wrote:
> > > On Sat, Nov 06, 2021 at 07:55:29PM +0800, Stefano Picascia wrote:
> > > > Currently, even if selected, amd-pstate is not enabled unless
> > > > CPU_SUP_INTEL is also selected, due to ACPI_CPPC_LIB depending
> > > > on
> > > > SCHED_MC_PRIO, which in turn depends on CPU_SUP_INTEL
> > > 
> > > Actually, amd-pstate driver doesn't depend on SCHED_MC_PRIO. 
> > 
> > amd-pstate doesn't depend on SCHED_MC_PRIO, but ACPI_CPPC_LIB is
> > only
> > selected when SCHED_MC_PRIO is selected. I guess the issue can be
> > fixed
> > in a better way, but currently if one compiles the kernel with
> > CPU_SUP_AMD, but without CPU_SUP_INTEL, ends up with a non
> > functional
> > amd-pstate. 
> > 
> > Not a problem for distro kernels I guess, but I was puzzled as I
> > wasn't
> > getting amd-pstate even with a supported processor.
> > 
> 
> If I modify the Kconfig of amd-pstate like below:
> 
> config X86_AMD_PSTATE
>         bool "AMD Processor P-State driver"
>         depends on X86
>         select ACPI_PROCESSOR if ACPI
>         select ACPI_CPPC_LIB if X86_64 && ACPI
>         select CPU_FREQ_GOV_SCHEDUTIL if SMP
> 
> Then ACPI_CPPC_LIB can be selected by X86_AMD_PSTATE as well:
> 
> Symbol: ACPI_CPPC_LIB [=y]
> Type  : bool
> 
> Defined at drivers/acpi/Kconfig:268
>   Depends on: ACPI [=y] && ACPI_PROCESSOR [=y]
> Selects: MAILBOX [=y] && PCC [=y]
> Selected by [y]:
>   - X86_AMD_PSTATE [=y] && CPU_FREQ [=y] && X86 [=y] && X86_64 [=y]
> && ACPI [=y]
> Selected by [n]:
>   - X86_INTEL_PSTATE [=n] && CPU_FREQ [=y] && X86 [=y] && X86_64 [=y]
> && ACPI [=y] && SCHED_MC_PRIO [=n]
>   - ACPI_CPPC_CPUFREQ [=n] && CPU_FREQ [=y] && (ARM || ARM64) &&
> ACPI_PROCESSOR [=y]
> 
> Did I miss anything?


Works perfectly.
Thank you very much
