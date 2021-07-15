Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342103CA098
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGOO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:28:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:57633 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhGOO2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:28:50 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 16FEPkgI030534;
        Thu, 15 Jul 2021 16:25:46 +0200
Date:   Thu, 15 Jul 2021 16:25:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] auxdisplay: charlcd: Drop unneeded terminator
 entry
Message-ID: <20210715142546.GG27830@1wt.eu>
References: <20210715132310.31514-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715132310.31514-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jul 15, 2021 at 04:23:10PM +0300, Andy Shevchenko wrote:
> Besides 0 not being, strictly speaking, a pointer it's redundant after
> the actual terminator NULL entry. Drop the former for good.

It seems to me that there is confusion caused by the absence of
the field names:

>  static struct notifier_block panel_notifier = {
>  	panel_notify_sys,
=> this is notifier_fn_t notifier_call

> -	NULL,
=> this is struct notifier_block __rcu *next

> -	0
=> this is int priority

> +	NULL

So all values look OK, however they're terribly confusing. wouldn't you
prefer to propose a patch to name them instead ? This would be safer,
especially if the structure evolves in the future.

Thanks!
Willy
