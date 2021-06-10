Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADC3A35F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFJVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhFJVc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:32:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE45761362;
        Thu, 10 Jun 2021 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623360631;
        bh=d3ZABJpePafWBbJIEJmNViKIIt91qTopm1f+g/4/zJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gMKJVJIKF/jHN1xnRkrePpASZrh43cGiWGWbKn6bLwD1hqNFT1ClUJ+7VQpSYrMFV
         vMTiEJWR7B/RR4Ztaxa/8D07w7ZaVyUOVmy/TqN/luWOagi0kYbOzdgLCOzS32eZY8
         zPS9BHlh6pA33DWImtDYebqQrHbqp5eb/aEZpeZU=
Date:   Thu, 10 Jun 2021 14:30:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Martin Liu <liumartin@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com,
        davidchao@google.com, jenhaochen@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kthread: Prevent deadlock when
 kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()
Message-Id: <20210610143030.f599946ec11e1eccde6af4f0@linux-foundation.org>
In-Reply-To: <20210610133051.15337-3-pmladek@suse.com>
References: <20210610133051.15337-1-pmladek@suse.com>
        <20210610133051.15337-3-pmladek@suse.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 15:30:50 +0200 Petr Mladek <pmladek@suse.com> wrote:

> The system might hang with the following backtrace:

Well that's not good.

> Fixes: 9a6b06c8d9a220860468a ("kthread: allow to modify delayed kthread work")
> Reported-by: Martin Liu <liumartin@google.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Was a -stable backport considered?
