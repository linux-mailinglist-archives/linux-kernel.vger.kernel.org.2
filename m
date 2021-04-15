Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260E436087F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhDOLsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:48:08 -0400
Received: from foss.arm.com ([217.140.110.172]:44244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhDOLsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:48:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA3C106F;
        Thu, 15 Apr 2021 04:47:43 -0700 (PDT)
Received: from E107129.arm.com (E107129.Arm.com [10.50.68.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6473F73B;
        Thu, 15 Apr 2021 04:47:40 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:47:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, boqun.feng@gmail.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] kcsan: Add support for reporting observed value
 changes
Message-ID: <20210415114731.GA73625@E107129.arm.com>
References: <20210414112825.3008667-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:28:16PM +0200, Marco Elver wrote:
> This series adds support for showing observed value changes in reports.
> Several clean up and refactors of KCSAN reporting code are done as a
> pre-requisite.

> This series was originally prepared courtesy of Mark Rutland in
> September 2020.

For anyone looking for the original, it was never posted to a list, but
is sat on my kcsan/rework branch on kernel.org:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kcsan/rework

> Because KCSAN had a few minor changes since the original
> draft of the series, it required a rebase and re-test. To not be
> forgotten and get these changes in sooner than later, Mark kindly agreed
> to me adopting the series and doing the rebase, a few minor tweaks, and
> finally re-test.

Thanks for picking this up!

All your changes look good to me (along with the documentation patch),
so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> Marco Elver (1):
>   kcsan: Document "value changed" line
> 
> Mark Rutland (8):
>   kcsan: Simplify value change detection
>   kcsan: Distinguish kcsan_report() calls
>   kcsan: Refactor passing watchpoint/other_info
>   kcsan: Fold panic() call into print_report()
>   kcsan: Refactor access_info initialization
>   kcsan: Remove reporting indirection
>   kcsan: Remove kcsan_report_type
>   kcsan: Report observed value changes
> 
>  Documentation/dev-tools/kcsan.rst |  88 +++++++---------
>  kernel/kcsan/core.c               |  53 ++++------
>  kernel/kcsan/kcsan.h              |  39 ++++---
>  kernel/kcsan/report.c             | 169 ++++++++++++++++--------------
>  4 files changed, 162 insertions(+), 187 deletions(-)
> 
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
