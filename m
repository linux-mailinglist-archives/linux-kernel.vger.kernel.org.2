Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD543C6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhJ0Jq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:46:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:1592 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236282AbhJ0Jqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:46:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="316327046"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="316327046"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:44:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="447142485"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:44:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mffTd-001Qek-2N;
        Wed, 27 Oct 2021 12:44:09 +0300
Date:   Wed, 27 Oct 2021 12:44:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Message-ID: <YXkfaGlmbkXXJGih@smile.fi.intel.com>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad>
 <YXhVVvG9keoVWJyK@smile.fi.intel.com>
 <YXhW8K7DxadyVgx3@yury-ThinkPad>
 <YXhaMVTymVNzOlGT@smile.fi.intel.com>
 <031fe271-7fc3-0d95-3547-edbe0c975cbb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031fe271-7fc3-0d95-3547-edbe0c975cbb@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:54:26PM -0400, Qian Cai wrote:
> On 10/26/21 3:42 PM, Andy Shevchenko wrote:
> > Now, I have checked that email appearance in the upstream:
> > 
> > $ git log --oneline --author="quic_qiancai@quicinc.com"
> > 95cadae320be fortify: strlen: Avoid shadowing previous locals
> > 94560f6156fe Revert "arm pl011 serial: support multi-irq request"
> > 
> > While first one perhaps okay, although it also refers to W=2,
> > I have now doubts if the "Revert" was really thought through
> > and not just yet another UMN-like experiment.
> > 
> > Greg, what do you think is the best course of actions here?
> 
> Perhaps, a little sympathy towards a stranger might get us a better
> community.

Agree, but you see a problem here, W=2, for example, is high due to
a lot of non-sense (or very little sense) noise. The warning you got
is hidden on purpose. On top of that, the code has not been thought
through at all, despite missed test run. This is easy to catch.

What I expect from "a stranger" who is in doubt (obviously) how this
code works to ask and then decide how to act.

And on top of all these, we used to have UMN case which makes me
first think of bad experiments on the community (I really haven't
believed that this patch was sent consciously).

So, please be careful next time and better ask first before acting,
if in doubt.

> Feel free to audit my previous works.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Qian+Cai

Yes, after above patch these all in doubt (to me personally), but
I have no time to revisit all of them, esp. they do not touched my
area of interests in the Linux kernel.

-- 
With Best Regards,
Andy Shevchenko


