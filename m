Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696131BB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBOO25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:28:57 -0500
Received: from foss.arm.com ([217.140.110.172]:39788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhBOO2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:28:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91B9931B;
        Mon, 15 Feb 2021 06:28:07 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EE53F73B;
        Mon, 15 Feb 2021 06:28:06 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:28:03 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Damian Tometzki <linux@tometzki.de>
Subject: Re: [PATCH] docs: reporting-issues.rst: explain how to decode stack
 traces
Message-ID: <20210215142803.strbiszzmreusr36@e107158-lin.cambridge.arm.com>
References: <20210210054823.242262-1-linux@leemhuis.info>
 <20210214160009.lxonvxg4qyj6ygbk@e107158-lin.cambridge.arm.com>
 <7f75a923-7aab-5546-102b-a8a6eb882cc9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f75a923-7aab-5546-102b-a8a6eb882cc9@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten

On 02/15/21 06:55, Thorsten Leemhuis wrote:
> Hi! Many thx for looking into this, much appreciated!
> 
> Am 14.02.21 um 17:00 schrieb Qais Yousef:
> > On 02/10/21 06:48, Thorsten Leemhuis wrote:
> >
> >> - * If the failure includes a stack dump, like an Oops does, consider decoding
> >> -   it to find the offending line of code.
> >> + * If your failure involves a 'panic', 'oops', or 'warning', consider decoding
> > or 'BUG'? There are similar other places below that could benefit from this
> > addition too.
> 
> Good point. In fact there are other places in the document where this is
> needed as well. Will address those in another patch.
> 
> >> +   the kernel log to find the line of code that trigger the error.
> >>  
> >>   * If your problem is a regression, try to narrow down when the issue was
> >>     introduced as much as possible.
> >> @@ -869,6 +869,15 @@ pick up the configuration of your current kernel and then tries to adjust it
> >>  somewhat for your system. That does not make the resulting kernel any better,
> >>  but quicker to compile.
> >>  
> >> +Note: If you are dealing with a kernel panic, oops, or warning, please make
> >> +sure to enable CONFIG_KALLSYMS when configuring your kernel. Additionally,
> > 
> > s/make sure/try/
> 
> I did that, but ignored...
> 
> > s/kernel./kernel if you can./
> 
> ...this. Yes, you have a point with...
> 
> > Less demanding wording in case the user doesn't have the capability to rebuild
> > or deploy such a kernel where the problem happens. Maybe you can tweak it more
> > if you like too :-)
> 
> ...that, but that section in the document is about building your own
> kernel, so I'd say we don't have to be that careful here.

Cool. Works for me.

Thanks

--
Qais Yousef
