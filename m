Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7634A84D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:42:09 -0400
Received: from foss.arm.com ([217.140.110.172]:59498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhCZNlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:41:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7649A143D;
        Fri, 26 Mar 2021 06:41:34 -0700 (PDT)
Received: from bogus (unknown [10.57.54.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6535E3F7D7;
        Fri, 26 Mar 2021 06:41:33 -0700 (PDT)
Date:   Fri, 26 Mar 2021 13:41:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: vexpress: spc: fix uniprocessor initialization
Message-ID: <20210326134131.bftspszcwixrkomt@bogus>
References: <20210323125649.1930186-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323125649.1930186-1-arnd@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Sorry for the delay

On Tue, Mar 23, 2021 at 01:56:38PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_SMP is disabled, topology_physical_package_id()
> returns -1 and gcc notices undefined behavior:
> 
> arch/arm/mach-versatile/spc.c: In function 've_spc_clk_init':
> arch/arm/mach-versatile/spc.c:583:21: error: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Werror=array-bounds]
>   583 |   if (init_opp_table[cluster])
>       |       ~~~~~~~~~~~~~~^~~~~~~~~
> arch/arm/mach-versatile/spc.c:556:7: note: while referencing 'init_opp_table'
>   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
>       |       ^~~~~~~~~~~~~~
> 
> It's not clear to me what the correct behavior should be, but
> it seems safe to just not continue with the initialization.
> 

I don't have any other patches for vexpress platform or driver support.
Can you apply this directly ? Assuming that,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
