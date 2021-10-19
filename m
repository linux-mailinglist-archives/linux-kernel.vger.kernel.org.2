Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC164334ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhJSLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:44:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3891F61359;
        Tue, 19 Oct 2021 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634643760;
        bh=yCv4VJtIrblP/kUogoAnKl6uE4BI+ilJPboUSNzpPIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mdx52gdOou/WFb+jdXIXu+7YQghz6kW8Gt4ePQb6IPdEmn8AoAUnIUDQuhZX+rArw
         oUACNuYHVA2T8Yop3YEQwsR3UX2azpMYkUZtX8w/Glb6Tf/2GoSVij/AYr+dbwfIez
         CJoI/48ye1XagYWoLx5ibxbbqAqrY9vzwIOgWxWWlgbCXCKSWZYwU3OSzv5owjCcm2
         Lr9LMonTTs34iD0ftmf0fGqc9Mml6YYDU1tc/0TKcL7GS7OVHl7g9ODo5OK3/Yk0I+
         ovahl3QTs7r5GZz0Gzw75wQBKeWlckWGzUlNDd3mVR7/f6V2lZ3+Nr+3Emgl8SdPnJ
         ZVweJWb0iGkcA==
Date:   Tue, 19 Oct 2021 12:42:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 03/15] arm64: errata: Add workaround for TSB flush
 failures
Message-ID: <20211019114234.GH13251@willie-the-truck>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-4-suzuki.poulose@arm.com>
 <20211019110233.GD13251@willie-the-truck>
 <850c67de-a656-7515-e575-d47d2af78200@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <850c67de-a656-7515-e575-d47d2af78200@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:36:48PM +0100, Suzuki K Poulose wrote:
> On 19/10/2021 12:02, Will Deacon wrote:
> > On Thu, Oct 14, 2021 at 11:31:13PM +0100, Suzuki K Poulose wrote:
> > > @@ -558,6 +570,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> > >   		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> > >   		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
> > >   	},
> > > +#endif
> > > +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
> > 
> > You still haven't fixed this typo...
> > 
> 
> Sorry about that. I thought it was about selecting the
> Kconfig entries, which was fixed. I will fix this.

Sorry, I thought it was such a howler that it would've jumped out ;)
That's what made me think we should make sure the series compiles without
the coresight changes, so we can catch these problems early.

> > Seriously, I get compile warnings from this -- are you not seeing them?
> 
> No, I don't get any warnings. Is there something that I am missing ?

Interesting. I see the warning below in my bisection testing, since the typo
means that the midr lookup table isn't used. Maybe you're only compiling the
end result?

Will

--->8

+arch/arm64/kernel/cpu_errata.c:356:32: warning: ‘tsb_flush_fail_cpus’ defined but not used [-Wunused-const-variable=]
+  356 | static const struct midr_range tsb_flush_fail_cpus[] = {
+      |                                ^~~~~~~~~~~~~~~~~~~
