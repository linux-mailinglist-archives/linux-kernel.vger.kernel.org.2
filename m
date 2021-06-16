Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6413A8E07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhFPBGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhFPBF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:05:59 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADD361246;
        Wed, 16 Jun 2021 01:03:53 +0000 (UTC)
Date:   Tue, 15 Jun 2021 21:03:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-ID: <20210615210351.602bc03e@rorschach.local.home>
In-Reply-To: <20210616094622.c8bd37840898c67dddde1053@kernel.org>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 09:46:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> To avoid such trouble, I had set the 4096 limitation for the maxactive
> parameter. Of course 4096 may not enough for some use-cases. I'm welcome
> to expand it (e.g. 32k, isn't it enough?), but removing the limitation
> may cause OOM trouble easily.

What if you just made the max as 10 * number of possible cpus, or 4096,
which ever is greater? Why would a user need more?

I'd still like to get a wrapper around function graph tracing so that
kretprobes could use it. I think that would get rid of the requirement
of maxactive, because isn't that just used to have a way to know the
original return value?

-- Steve
