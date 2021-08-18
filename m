Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDC3F0BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHRThd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhHRTh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:37:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A31966108D;
        Wed, 18 Aug 2021 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629315412;
        bh=VSqULppL4HoKddIgJNCboD09FTRpJSRbKPm/5gbsthc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gENa2lgMl/VNZHbcDucJOwzGEOxtYDVzrpUg/IqgsRMYbnujq7SDfz0gSQuQqn4pP
         qMWKKZPlkJb1oWb64iM99u283/lmgiOxz4eW6KWVQZva1cIMKzB/uasJD4AmqT6wVx
         kqyo9crHowLbhmmjK/fFwQUza867huQczqxTNveE=
Date:   Wed, 18 Aug 2021 12:36:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] lib/vsprintf: don't increment buf in bitmap_list_string
Message-Id: <20210818123651.61e2dfb55aea3b8340ab10c6@linux-foundation.org>
In-Reply-To: <YRzQHkF8inFrdfQM@smile.fi.intel.com>
References: <20210817193735.269942-1-yury.norov@gmail.com>
        <YRzQHkF8inFrdfQM@smile.fi.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 12:17:18 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Aug 17, 2021 at 12:37:35PM -0700, Yury Norov wrote:
> 
> Thanks!
> 
> > Increment is confusing as the buf is overritten at the same line.
> 
> > Fixes: b1c4af4d3d6b (vsprintf: rework bitmap_list_string) (next-20210817)
> 
> Fixes tag has its special format. I don't think we need it here, just to ask
> Andrew in comments that it needs to be folded.

I'm assuming that Sergey will be handling this one?
