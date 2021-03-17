Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9583F33FB02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCQWXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhCQWXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:23:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD7264DE7;
        Wed, 17 Mar 2021 22:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616019794;
        bh=73XvZj92wTv5ZQxPf5DIjS3QKL6XBRR6zTcruA3a6WY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VACpmxCCk2UQqM1AlhvoMUq+diWMo8zS+IpRfgc0dSTGJ0bjvu3okx6ZMalKy0Y+N
         6lOH96jZPQ9w5fYnD1mUxQuvAUnvspM2xWwGo5AcmfCYF0NWwxIkyAQhHhm3wyap5d
         Lc0YCVJgd+dg1s+K5Nnd61ijZoGBrfXgcUUVaZSo=
Date:   Wed, 17 Mar 2021 15:23:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rui.xiang@huawei.com>
Subject: Re: [PATCH 0/2] Fix page_owner broken on arm64
Message-Id: <20210317152312.32e6fc7dd469cd7df57ed2e5@linux-foundation.org>
In-Reply-To: <20210317142050.57712-1-chenjun102@huawei.com>
References: <20210317142050.57712-1-chenjun102@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 14:20:48 +0000 Chen Jun <chenjun102@huawei.com> wrote:

> On arm64, cat /sys/kernel/debug/page_owner
> All pages return the same stack
>  stack_trace_save+0x4c/0x78
>  register_early_stack+0x34/0x70
>  init_page_owner+0x34/0x230
>  page_ext_init+0x1bc/0x1dc
> 
> The reason is arch_stack_walk save 2 more entries than before.
> 
> To fix it, add skip in arch_stack_walk
> 
> *** BLURB HERE ***
> 
> 1. Prepare for 2, move stacktrace_cookie to .h
> 2. Fix the problem
> 

5fc57df2f6fd was September 2020, so I assume we'll be needing cc:stable
on these?

(I'll also assume that the arm folks will be handling these)
