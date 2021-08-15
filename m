Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE33EC82C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhHOImz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 04:42:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236425AbhHOImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 04:42:54 -0400
Received: from zn.tnic (p200300ec2f2631001e9549156c3f2463.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:3100:1e95:4915:6c3f:2463])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02FF01EC0505;
        Sun, 15 Aug 2021 10:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629016940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rUM4s7qJV2/J3gyH7O3mBn+MHJ5cWjAjy/+e2C+9wvw=;
        b=FNx7z7/3a5HjdpAbtaLkwzv3lRjTEtcmhEu79e3N6fPKKukPPzwAatIV1UtstaiyEV874I
        sw/eRzlHoJ4LapjpH8uyOYiizPdBgJCod3/ZxJsiG+luyH6m17GLkQ5fXAkuyIbb9FkHV2
        kx/6XQbREsvVeOrXrakmWQwS1fKVuNU=
Date:   Sun, 15 Aug 2021 10:42:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
Message-ID: <YRjTkkpDjaWxEpjb@zn.tnic>
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 15, 2021 at 04:36:40PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> branch HEAD: 064855a69003c24bd6b473b367d364e418c57625  x86/resctrl: Fix default monitoring groups reporting
> 
> possible Warning in current branch:
> 
> arch/x86/kernel/cpu/resctrl/monitor.c:310 __mon_event_count() error: uninitialized symbol 'm'.
> arch/x86/kernel/cpu/resctrl/monitor.c:315 __mon_event_count() error: potentially dereferencing uninitialized 'm'.
> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- i386-randconfig-m021-20210812
>     |-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:potentially-dereferencing-uninitialized-m-.
>     `-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:uninitialized-symbol-m-.

AFAIR, I had already asked you guys to make those reports more useful
as, for example, adding a link to that randconfig above or even
attaching it so that a person - not a machine - reading it, can
*actually* act upon it.

But that hasn't happened.

Until it happens, I'm going to ignore all those reports from you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
