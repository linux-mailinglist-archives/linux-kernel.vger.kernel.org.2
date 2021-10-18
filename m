Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C8431D78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhJRNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhJRNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:49:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B7E61882;
        Mon, 18 Oct 2021 13:37:32 +0000 (UTC)
Date:   Mon, 18 Oct 2021 09:37:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <tom.zanussi@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
Message-ID: <20211018093731.2dd5917f@gandalf.local.home>
In-Reply-To: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 11:23:14 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> Hi Tom and Steven,
> 
> commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
> on ARM64 machine, this commit causes performance degradation.
> 
> I test the number of instructions executed by invoking the 
> trace_sched_switch function once on an arm64 machine:
> 1. Use memcpy, the number of instructions executed is 850.
> 2. Use strncpy, the number of instructions executed 1100.
> That is, use strncpy is almost 250 more instructions than memcpy.
> 
> Has the impact on performance been considered in this commit? :)
> What is the impact of revert the patch?
>

It's a security issue. And like everything security, there's always going
to be a performance impact. Look at the performance impact due to spectre
and meltdown!

That said, although memcpy() may not be used, we don't need strncpy.
strncpy() will pad the rest of the string with nul bytes. But since the
memory the string is being recorded into is already initialized (or can be
if it isn't), we could use the faster strlcpy().

Have you tried testing it by switching strncpy() with strlcpy()?

-- Steve
