Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38C42745C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbhJHXuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243797AbhJHXuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:50:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A97560F5E;
        Fri,  8 Oct 2021 23:48:23 +0000 (UTC)
Date:   Fri, 8 Oct 2021 19:48:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20211008194821.3b6a18a4@oasis.local.home>
In-Reply-To: <0b783c9e-c129-6907-0637-5c7638158a65@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20210911135043.16014-2-yinan@linux.alibaba.com>
        <20210911095937.5a298619@rorschach.local.home>
        <0b783c9e-c129-6907-0637-5c7638158a65@linux.alibaba.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2021 21:42:10 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> Sorry for my slow progress . I have encountered some problems with the 
> sorting
> of the module's mcount in compile time. The .ko file will be relocated 
> after insmod
> or modprobe, most of the mcount relocation is based on .text section, 
> but there are
> also a small part of mcount relocation based on .init.text section such 
> as module_init().
> The loading position of .init.text and .text does not seem to be in a 
> definite order.

Right, there's no guarantee that the .text portion of a module is
placed before or after the .init.text portion.

> 
> For example, when I insmod ip_tables.ko twice, the front and back 
> positions of init.text
> and .text are different, so we cannot sort the mcounts in the two 
> sections, which makes
> the mcount sorting in the module meaningless.
> 
> What is your opinion on this?

Probably just keep the sorting algorithm in the kernel and take place
on module load.

If you still want to sort at compile time, then do the sort for .init
functions separate from the .text ones, and have a way to extract this
information (shouldn't be too hard) in the kernel at module load, and
then just swap the init and text functions if they were added in the
reverse order that was expect.

The functions in .init will either be before all the functions in .text
or after. They wont be intermingled. Thus, if they are both sorted,
then they are placed correctly or the two groups of functions need to
be switched. No other sorting should be necessary.

-- Steve
