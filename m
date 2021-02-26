Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B949432638D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZNvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:51:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA50C061574;
        Fri, 26 Feb 2021 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xb9xtwpTL4lk5rD+hInHkQNlk5EbdNVRWlBW9PFOfl0=; b=T0Z0vG6F9aHvwy4kj3atsTdhqV
        KFg6314YV9TaMGSUrji3QGOC0oKV0rHxoHD+545kEGbcaN+guF9qBd8kx0gVnJhCaFutVDZ+Lhnri
        Aqng3m0F3mVoPrGJ17KuEtFIY2KMkkEgP1SsK9iSG3r8gwopy4hJEnv+6U0V3LA77AXOHd5sCyZ/x
        FeAQPIZQdLveDh3tlFOTcC7B8JO3WcQ/60T/fMMDyYyTOLweF7nq1dsD2eN2cvNMj/ssreUON4Wlm
        beJ7MO3qUakhfLgQ5jB0ZfT7+AjsTMEZPOco4AREGntD5Z5dArEqKx0TwwgoilP9FyPK+Sa+wlDun
        E9lKYbPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFdVy-00C5aQ-7k; Fri, 26 Feb 2021 13:50:43 +0000
Date:   Fri, 26 Feb 2021 13:50:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ia64: Depend on non-static printk for cmpxchg debug
Message-ID: <20210226135042.GD2723601@casper.infradead.org>
References: <YCflN5zTvo5mxvKY@chrisdown.name>
 <YDjt/lI82VzZcCgq@chrisdown.name>
 <20210226130029.GC2723601@casper.infradead.org>
 <YDj0T7H4ZbuEAYwK@chrisdown.name>
 <YDj76FjQCL7YgQq+@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDj76FjQCL7YgQq+@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 01:47:20PM +0000, Chris Down wrote:
> Chris Down writes:
> > I must confess I have no idea of the history of why it was `extern int`
> > in the first place -- my fear was somehow we use cmpxchg.h from a
> > different context.  Do you have any idea? :-)
> 
> Ok, found where it's introduced in the pre-git archives: "New file
> asm-ia64/intrinsics.h." from David Mosberger <davidm@tiger.hpl.hp.com>, Dec
> 9 2002. No indication why it's extern, but it's been there since the dawn of
> ia64.

It's just a quirk of C.  'extern' is only meaningful when applied to
variables.  In the context of functions,

extern int printk(char *fmt);
int printk(char *fmt);

are completely equivalent.  Unless (as you've seen) there's then a
static definition following the extern declaration.
