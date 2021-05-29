Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF93949E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 04:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE2CMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 22:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhE2CMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 22:12:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434B461358;
        Sat, 29 May 2021 02:11:15 +0000 (UTC)
Date:   Fri, 28 May 2021 22:11:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tracing: fix spelling mistakes
Message-ID: <20210528221113.4f66aaea@oasis.local.home>
In-Reply-To: <93006372-8482-84af-52c0-1d6e7f66e187@huawei.com>
References: <20210525062047.8951-1-thunder.leizhen@huawei.com>
        <20210525062047.8951-2-thunder.leizhen@huawei.com>
        <20210528211314.5dba632a@oasis.local.home>
        <93006372-8482-84af-52c0-1d6e7f66e187@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 10:01:31 +0800
"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com> wrote:

> On 2021/5/29 9:13, Steven Rostedt wrote:
> > On Tue, 25 May 2021 14:20:47 +0800
> > Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >   
> >> Fix some spelling mistakes in comments:
> >> wont ==> won't  
> > 
> > I prefer not to fix that spelling. I sometimes purposely leave off
> > single quotes. It's no that big of a deal, and doesn't deserve the
> > churn.  
> 
> Yes, all people can get it right by their wits. "Wont" doesn't affect
> their reading speed. But most people might think it's best to add the
> missing single quote.
> 
> The minority obeys the majority?

I really don't care. In my opinion, it's unnecessary churn, that just
adds noise to the git logs.

-- Steve
