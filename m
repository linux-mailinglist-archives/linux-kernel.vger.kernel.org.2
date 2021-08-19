Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102E53F15AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhHSJAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:00:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57306 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237165AbhHSJAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:00:33 -0400
Received: from zn.tnic (p200300ec2f0f6a004ea6615b49afdf70.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:4ea6:615b:49af:df70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCFCB1EC0567;
        Thu, 19 Aug 2021 10:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629363592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0+JKF1lwu+PLHRGFSzSGCH1wd6wophpTqRo27x3+Lng=;
        b=eYtOtmfME6YKxVdklfQbCmFY7F3crNvRBuxHXrz4lv2SOuhgoU3qNK5Gam5/Y0YoC0TFmD
        fREmtRm7dQ4BZEmOuRkwMRSNGfdmGYh3ln73LpeuZ750c9EjN+ccyYfWGBMIqH9U6B5wO+
        0G6fPVGrW4cStLex2aBvEyM1Lbgnyr8=
Date:   Thu, 19 Aug 2021 11:00:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
Message-ID: <YR4dr079URttZRrg@zn.tnic>
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic>
 <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 02:15:16PM +0800, Chen, Rong A wrote:
> 
> 
> On 8/15/2021 4:42 PM, Borislav Petkov wrote:
> > Hi,
> > 
> > On Sun, Aug 15, 2021 at 04:36:40PM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> > > branch HEAD: 064855a69003c24bd6b473b367d364e418c57625  x86/resctrl: Fix default monitoring groups reporting
> > > 
> > > possible Warning in current branch:
> > > 
> > > arch/x86/kernel/cpu/resctrl/monitor.c:310 __mon_event_count() error: uninitialized symbol 'm'.
> > > arch/x86/kernel/cpu/resctrl/monitor.c:315 __mon_event_count() error: potentially dereferencing uninitialized 'm'.
> > > 
> > > Warning ids grouped by kconfigs:
> > > 
> > > gcc_recent_errors
> > > `-- i386-randconfig-m021-20210812
> > >      |-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:potentially-dereferencing-uninitialized-m-.
> > >      `-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:uninitialized-symbol-m-.
> > 
> > AFAIR, I had already asked you guys to make those reports more useful
> > as, for example, adding a link to that randconfig above or even
> > attaching it so that a person - not a machine - reading it, can
> > *actually* act upon it.
> > 
> > But that hasn't happened.
> > 
> > Until it happens, I'm going to ignore all those reports from you.
> > 
> 
> Hi Borislav,
> 
> Sorry about it, the actual link is at https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/PZVMY3VJU4QY4HQXHK3MLPQ2KZ5CNAYH/,
> and it's still an internal report that the robot don't know whether it's a
> false positive or not, we'll update the mail contents to avoid
> misunderstanding.

Aha, ok, smatch thinks that m might not be initialized because

064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")

removed the default case:

-       default:
-               /*
-                * Code would never reach here because
-                * an invalid event id would fail the __rmid_read.
-                */
-               return -EINVAL;

I'm guessing that comment which got removed too, explains why that's ok.

Adding folks to Cc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
