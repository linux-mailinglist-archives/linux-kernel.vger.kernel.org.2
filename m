Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E973E0C37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhHECBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237415AbhHECBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:01:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75BFD60724;
        Thu,  5 Aug 2021 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628128856;
        bh=0/LJbZOSET6Tm34ypJIUrrO1FVVoPHDm0WYxiO39aBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgpQMURwEX3dUeoc12vUI+KlxNt3URNlDgz6YG2QxsjxiFlSJRO0/6t1pnCaPR5FS
         KqNQU/FslgxN5cUiD5guGwV+V64x4lNMgXNGJHxBXNB84h2Ydbxvaz/nsKl9nIc+TX
         1M5ISNDyWfQ38jLqdu2leOp3GmEDO+Fwz8BOx/kM=
Date:   Wed, 4 Aug 2021 19:00:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhangkui <zhangkui@oppo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: add MADV_WILLNEED to process_madvise()
Message-Id: <20210804190055.b484ab15587cc891683eafea@linux-foundation.org>
In-Reply-To: <20210804082010.12482-1-zhangkui@oppo.com>
References: <20210804082010.12482-1-zhangkui@oppo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Aug 2021 16:20:10 +0800 zhangkui <zhangkui@oppo.com> wrote:

> There is a usecase in Android that an app process's memory is swapped out
> by process_madvise() with MADV_PAGEOUT, such as the memory is swapped to
> zram or a backing device. When the process is scheduled to running, like
> switch to foreground, multiple page faults may cause the app dropped
> frames.
> To reduce the problem, SMS can read-ahead memory of the process immediately
> when the app switches to forground.
> Calling process_madvise() with MADV_WILLNEED can meet this need.
> 

What is SMS?
