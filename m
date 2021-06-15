Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3ED3A7492
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFODDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:03:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:17186 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFODDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:03:43 -0400
IronPort-SDR: lnNlg34FW+HwZ5EmtZUEoYAzADRX7/RPy/1LuQN6+F4YVcZNYxrV0hBWa7uzLewPXpMEtMMOYd
 bR+lCSphEEwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="267061685"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="267061685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 20:01:39 -0700
IronPort-SDR: 2zxwgzIKUButR+cSc++48nHEBY5oAxhdeto+x8ckC1MS+0DOtEm4UzOxp/+y60zXfn8yi6A2RH
 zimvGzIb6bAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="484296028"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2021 20:01:38 -0700
Date:   Tue, 15 Jun 2021 10:55:03 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:tip] BUILD SUCCESS 3a1176a9af5a1b7d7a0a40b0975412008eb221c3
Message-ID: <20210615025503.GA507303@pl-dbox>
References: <60c3c723.X+QEHxMuTiZ6Pqj9%lkp@intel.com>
 <YMPMFUsmj0F8btKc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMPMFUsmj0F8btKc@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:48:21PM +0200, Borislav Petkov wrote:
> On Sat, Jun 12, 2021 at 04:27:15AM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip
> > branch HEAD: 3a1176a9af5a1b7d7a0a40b0975412008eb221c3  auto-x86-next: Rename x86/seves to x86/sev
> 
> 0day folks:
> 
> if you have a way to exclude the 0day bot from testing some branches,
> this branch is one of them as it doesn't get code but only tip internal
> tracking changes and thus doesn't need to get tested by you so that you
> can save some infra for the real branches.
Got it, Boris, we will disable the testing of this tip branch, any branch
else that you think we can ignore?

So far, the configuration is below

branch_denylist: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus|tip

Thanks

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
