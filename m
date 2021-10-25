Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB8439980
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhJYPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233735AbhJYPC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:02:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2851360E05;
        Mon, 25 Oct 2021 15:00:04 +0000 (UTC)
Date:   Mon, 25 Oct 2021 11:00:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20211025110002.1f109a9f@gandalf.local.home>
In-Reply-To: <d0d5d491-41f5-09a4-ac3d-ebefa37a741b@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20210911135043.16014-2-yinan@linux.alibaba.com>
        <20210911095937.5a298619@rorschach.local.home>
        <0b783c9e-c129-6907-0637-5c7638158a65@linux.alibaba.com>
        <20211008194821.3b6a18a4@oasis.local.home>
        <1d069626-1aed-6244-b932-7853e832eb70@linux.alibaba.com>
        <d0d5d491-41f5-09a4-ac3d-ebefa37a741b@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 21:20:47 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> At present, it seems that the processing of compile-time sorting is only 
> suitable for vmlinux but not suitable for modules. Please review the 
> code of mcount sorting in vmlinux, thank you.

Agreed that only the vmlinux compile time sorting makes sense, and leave
the sorting of modules to the module load time.

I'll see if I can review your patches this week.

-- Steve
