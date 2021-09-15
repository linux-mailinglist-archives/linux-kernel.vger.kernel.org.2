Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC540BEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 06:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhIOELs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 00:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhIOELq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9045260E74;
        Wed, 15 Sep 2021 04:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631679027;
        bh=ZOLv9LtY30tSZai91s3Z+6sLPL5sOEycDB8UHDM+dXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lo/2zCrWRyCnKbpX+cCAP3SyT8q6BnwIG9t4mdApLxg1PWcsSdxLSZF7MlvLLDhV6
         dRy2jbObw2LgGJUNaD/V94Wju23pwnMVNQh+NFJ63QRN9jpJKnTbF4AZLLjwq7NhNo
         jRkJdY6znaIN7Qa+y7NOMm/DzxkX6/dE0AiZTz0A=
Date:   Tue, 14 Sep 2021 21:10:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmstat: annotate data race for
 zone->free_area[order].nr_free
Message-Id: <20210914211027.0d612d99a94b085112ba0969@linux-foundation.org>
In-Reply-To: <20210908015606.3999871-1-liushixin2@huawei.com>
References: <20210908015606.3999871-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 09:56:06 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> KCSAN reports a data-race on v5.10 which also exists on mainline:
> 
> ==================================================================
> BUG: KCSAN: data-race in extfrag_for_order+0x33/0x2d0
> 
> race at unknown origin, with read to 0xffff9ee9bfffab48 of 8 bytes by task 34 on cpu 1:
>  extfrag_for_order+0x33/0x2d0
>  kcompactd+0x5f0/0xce0
>  kthread+0x1f9/0x220
>  ret_from_fork+0x22/0x30
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 34 Comm: kcompactd0 Not tainted 5.10.0+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> ==================================================================
> 
> Access to zone->free_area[order].nr_free in extfrag_for_order()/frag_show_print()
> is lockless. That's intentional and the stats are a rough estimate anyway.
> Annotate them with data_race().

checkpatch helpfully says

WARNING: data_race without comment
#40: FILE: mm/vmstat.c:1074:
+               blocks = data_race(zone->free_area[order].nr_free);


can we please add a comment ;)
