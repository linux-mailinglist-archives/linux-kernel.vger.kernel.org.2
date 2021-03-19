Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0289F341A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCSKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:33:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhCSKcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:32:54 -0400
Received: from zn.tnic (p200300ec2f091e0031f92e39b93e7933.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1e00:31f9:2e39:b93e:7933])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06D041EC0266;
        Fri, 19 Mar 2021 11:32:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616149973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NTRg+rGfZrkbyyeEmsy5RDP6Um4NPXGmA0B2ajCUK/o=;
        b=DP8VMe6veFsd4Bq6K5nmEjnWZBz+MWVvH9OElImL3Ig8C9ur/ztaPGo2roVK7GKrjxEBtP
        jT8DCuew+i9MQg8QC7UWx5XYdHMCbZ4ltGSpYXwq3NR8jI/poJ9fmdPLymLB5ZaW3HZRTK
        jY6IynoRFyQMr9IFozhqPXduRr6VlTg=
Date:   Fri, 19 Mar 2021 11:32:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 f15a0a732aefb46f999c2a8aa8f9f16e71cec5b2
Message-ID: <20210319103251.GD6251@zn.tnic>
References: <60547c67.LV3ZdWGiJYWHhzsC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60547c67.LV3ZdWGiJYWHhzsC%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 06:26:47PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/seves
> branch HEAD: f15a0a732aefb46f999c2a8aa8f9f16e71cec5b2  x86/sev-es: Replace open-coded hlt-loops with sev_es_terminate()
> 
> possible Warning in current branch:
> 
> arch/x86/kernel/sev-es.c:1377 safe_stack_exc_vmm_communication() warn: ignoring unreachable code.

That's probably something you trigger with clang-13 but I don't have
that report in my mbox.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
