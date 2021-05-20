Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C774638B92E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhETVuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhETVuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:50:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11FF26135C;
        Thu, 20 May 2021 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621547326;
        bh=HIExzJDeCTXLxAodEv2a/lCkkoLfv2aYG3GY3liZUeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WjJdBLSXjbXTglZrurGg0bUgGIiezJ4smkTavKCQw9SxCn4eXmEiu3T2qrD8mptWk
         a30RhQWYvdNaUDBVoh03MJF6jtrTHOsldeDRCIfziyCh1jSBmmTiN+5LCi0qus/x4o
         viis11AavwpZz14MK7H/wO8fc7hOB4P2Vf738ZCw=
Date:   Thu, 20 May 2021 14:48:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Martin Liu <liumartin@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        minchan@google.com, www@google.com, davidchao@google.com,
        jenhaochen@google.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kthread: Fix kthread_mod_delayed_work vs
 kthread_cancel_delayed_work_sync race
Message-Id: <20210520144845.52755f3af700a902e07e2ee7@linux-foundation.org>
In-Reply-To: <20210513065458.941403-1-liumartin@google.com>
References: <20210513065458.941403-1-liumartin@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 14:54:57 +0800 Martin Liu <liumartin@google.com> wrote:

> We encountered a system hang issue while doing the tests. The callstack
> is as following
>
> ...
>
> Fixes: 37be45d49dec2 ("kthread: allow to cancel kthread work")

Thanks.  I added a cc:stable to this and shall hold it in -mm for a
couple of weeks to get exposure and testing before sending it to Linus
for 5.13.

