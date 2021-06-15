Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61D3A768F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFOFoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 01:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhFOFo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 01:44:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09B106140C;
        Tue, 15 Jun 2021 05:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623735745;
        bh=W6nJXbGyKFlPpe16ftnrzhJDjOUUwQ4jRCq5ZIlpKxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gu/dKIcCYGA3syEObcDkLEVGlLhjlSJ+vPtdgQ/fbD4+svJ92rpRujxvPW61tB0gg
         bVp+WQw90QmeeI1y4HrM7T6T2HjzIiMBwtHHNsJfbmgd0buvS/9sF2EGE+sYPLYE6n
         ItJrQ1jc/9RWQKblVV5+7oGerhqPTqgL4zcIRBONjoXQPB2MnhkA+VtPqGCk3TF4c9
         zz2m/4wvUzgah9tlm5TvXh0B6zlHB5ITy1oKri+NBUsHPGQWveDMPnHzBmsoIewWe/
         0Bpl4atRcQAQK4TMdrpSo/5ggmwKyoFI9FSCoWznKZNESGQhR07lvxhcTi9jHkuMs7
         pLcQfJBzOQAMw==
Date:   Tue, 15 Jun 2021 14:42:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-Id: <20210615144223.c4720bfdaff21ecb4d1e9101@kernel.org>
In-Reply-To: <1623684669.fagfzw6pyl.naveen@linux.ibm.com>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
        <20210612101347.a8e317344b0e6380d41f1cfe@kernel.org>
        <1623684669.fagfzw6pyl.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Mon, 14 Jun 2021 21:07:40 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> We also have perf_event_open() as an interface to add probes, and I 
> >> don't think it would be helpful to require all tools to utilize the 
> >> error log from tracefs for this purpose.
> > 
> > No, perf probe doesn't use perf-event interface to add probes. It uses
> > the tracefs for adding probes.
> 
> Yes, but I was referring to some of the bpf tools (bcc) that now use 
> perf_event_open() interface.

Yes, bpf chooses to use a special temporary perf_event, something like a
performance counter event. Those are hidden from tracefs and perf-tool.
The perf probe is the frontend of the trace event and perf event, which
will add dynamic events in tracefs, and perf will use it as same as
the other static events.

Thank you,




-- 
Masami Hiramatsu <mhiramat@kernel.org>
