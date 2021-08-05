Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185553E193F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhHEQMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhHEQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:12:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9929661050;
        Thu,  5 Aug 2021 16:12:07 +0000 (UTC)
Date:   Thu, 5 Aug 2021 12:12:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     "Qin\, Chao" <chao.qin@intel.com>, Joe Perches <joe@perches.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users\@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy\@linutronix.de" <bigeasy@linutronix.de>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mgross\@linux.intel.com" <mgross@linux.intel.com>,
        "Mei\, Paul" <paul.mei@intel.com>, "Li\, Lili" <lili.li@intel.com>
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Message-ID: <20210805121200.59db2104@oasis.local.home>
In-Reply-To: <87eeb8w08q.fsf@jogness.linutronix.de>
References: <20210719022649.3444072-1-chao.qin@intel.com>
        <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
        <87o8axm6ae.fsf@jogness.linutronix.de>
        <DM6PR11MB380275B5125531E8EB9D019B92F29@DM6PR11MB3802.namprd11.prod.outlook.com>
        <87eeb8w08q.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 14:27:25 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> Hello Steven,
> 
> Could you please cherry-pick 83e9288d9c42("printk: Enhance the condition
> check of msleep in pr_flush()") from linux-rt-devel.git (branch
> linux-5.14.y-rt-rebase) for the next stable v5.10-rt release?
> 
> The commit is provided below as well.
> 

I'll add it to my queue for tomorrow.

Thanks!

-- Steve

