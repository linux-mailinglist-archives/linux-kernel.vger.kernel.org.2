Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28293C362E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGJSs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 14:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhGJSs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 14:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD1D61279;
        Sat, 10 Jul 2021 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625942773;
        bh=ZjhoTSsw3XgjxOm9U7sZ17N78UcAMbUtdDRXWELDlCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ldgkQ1kfk2K3tXkAdSjnjdRjwMaXgO2kxxWxHtR0v5uEmqvU5I/mIUZVOxGtz3j1h
         Xh682rpOcp6cVumqy9dRRytEaTH+ZM6pVMIO9TEGB+vNnwa82vY7nLHijXLQCu9/2b
         EqLKz/ZLBbHR7ILZUN8u7orZUyaemLYKCSPze/iI=
Date:   Sat, 10 Jul 2021 11:46:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     qiang.zhang@windriver.com
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: avoid hard lockups in
 __alloc_pages_bulk()
Message-Id: <20210710114613.0db3ac139a7b3102a6ca3ad4@linux-foundation.org>
In-Reply-To: <20210710112929.232268-1-qiang.zhang@windriver.com>
References: <20210710112929.232268-1-qiang.zhang@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2021 19:29:29 +0800 qiang.zhang@windriver.com wrote:

> From: Zqiang <qiang.zhang@windriver.com>
> 
> The __alloc_pages_bulk() mainly used for batch allocation of
> order-0 pages, in the case of holding pagesets.lock, if too
> many pages are required, maybe trigger hard lockup watchdog.

Ouch.  Has this been observed in testing?  If so, can you please share
the kernel debug output from that event?

