Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7639333D349
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbhCPLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:43:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237403AbhCPLnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615894995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcbeDubQYizYjgE6shXG3hzU7La1wyi/suGmhWSBO+I=;
        b=POpT8cKtqdqeEdVmcB21LBVWPOI45CO4F2sTgJFtGEqkomDlhDmk1QlMmND0d4nEH6a7zC
        T9eAnpJNc7trcl3LfT2jBYH7g/7aVPBztJ7e8qTxBjyLJh66NUZH8eEn8RM+Xfx4tKwHMr
        3JPZpc+H6hKMBEDXb6ofXze/4muZhTI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58460AC5C;
        Tue, 16 Mar 2021 11:43:15 +0000 (UTC)
Date:   Tue, 16 Mar 2021 12:43:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: c928e9b143: BUG:soft_lockup-CPU##stuck_for#s![perf:#]
Message-ID: <YFCZ0mnrTUbVuV9l@alley>
References: <20210311122130.6788-8-pmladek@suse.com>
 <20210315140441.GA4401@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315140441.GA4401@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-15 22:04:41, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c928e9b1439de4d74b942abd30d5c838a40af777 ("[PATCH v2 7/7] Test softlockup")
> url: https://github.com/0day-ci/linux/commits/Petr-Mladek/watchdog-softlockup-Report-overall-time-and-some-cleanup/20210311-205501
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git a74e6a014c9d4d4161061f770c9b4f98372ac778

Just for record. Please, ignore this error. The patch is not intended
for upstream.

This patch was provided only for testing purposes. It causes
softlockup, so it works as expected.

Best Regards,
Petr
