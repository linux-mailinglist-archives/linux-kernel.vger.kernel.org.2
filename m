Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475C23A8429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFOPld convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Jun 2021 11:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhFOPlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:41:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDF061494;
        Tue, 15 Jun 2021 15:39:27 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:39:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
Subject: Re: [PATCH -next] tracing: Remove set but not used variable 'ret'
Message-ID: <20210615113925.27ad04ea@oasis.local.home>
In-Reply-To: <4ab45eeb-ad26-03e8-f2c5-2dc4582a2946@huawei.com>
References: <20210527091032.3878436-1-libaokun1@huawei.com>
        <4ab45eeb-ad26-03e8-f2c5-2dc4582a2946@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 09:59:10 +0800
"libaokun (A)" <libaokun1@huawei.com> wrote:

> ping
> 
> 在 2021/5/27 17:10, Baokun Li 写道:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > kernel/trace/trace_events_hist.c: In function 'unregister_field_var_hists':
> > kernel/trace/trace_events_hist.c:5228:6: warning:
> >   variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >
> > It never used since introduction.

Which was a bug.

> >
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> 

This was fixed differently:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6c610dba6e2beb1a16ac309672181d0090fb8d30

-- Steve
