Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D330A3E17F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbhHEP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241906AbhHEPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:24:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08CD60E53;
        Thu,  5 Aug 2021 15:24:38 +0000 (UTC)
Date:   Thu, 5 Aug 2021 11:24:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rahul Gopakumar <gopakumarr@vmware.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Rajender M <manir@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Linux Kernel 5.13 GA] ESXi Performance regression
Message-ID: <20210805112437.17604e2d@oasis.local.home>
In-Reply-To: <YQv+HHwrMmiUYZ4+@hirez.programming.kicks-ass.net>
References: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
        <87a6m4kk4f.mognet@arm.com>
        <BYAPR05MB520669C6C1A8A522B1DE0EAAA4F29@BYAPR05MB5206.namprd05.prod.outlook.com>
        <20210805105853.66425074@oasis.local.home>
        <YQv+HHwrMmiUYZ4+@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 17:05:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Hmm, is this a user space breakage?  
> 
> All those files were under CONFIG_SCHED_DEBUG and a !DEBUG build would
> not have them to begin with.

But you can have a config with CONFIG_DEBUG_FS disabled, and DEBUG and
SCHED_DEBUG enabled, which means that there's now configs where this
value is no longer available.

-- Steve

