Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0A360EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDOPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOPXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:23:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A7B60FDA;
        Thu, 15 Apr 2021 15:22:54 +0000 (UTC)
Date:   Thu, 15 Apr 2021 11:22:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] tracing/hwlat: Implement the per-cpu mode
Message-ID: <20210415112252.65499986@gandalf.local.home>
In-Reply-To: <bce142fc-4b1d-9924-e0d7-c02b0bd38405@redhat.com>
References: <cover.1617889883.git.bristot@redhat.com>
        <1c99ca2d7403474508aa7b025869c0673238400a.1617889883.git.bristot@redhat.com>
        <20210414104102.7589626c@gandalf.local.home>
        <bce142fc-4b1d-9924-e0d7-c02b0bd38405@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 15:22:52 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> >> --- a/kernel/trace/trace_hwlat.c
> >> +++ b/kernel/trace/trace_hwlat.c
> >> @@ -34,7 +34,7 @@
> >>   * Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
> >>   * Copyright (C) 2013-2016 Steven Rostedt, Red Hat, Inc. <srostedt@redhat.com>
> >>   *
> >> - * Includes useful feedback from Clark Williams <clark@redhat.com>
> >> + * Includes useful feedback from Clark Williams <williams@redhat.com>  
> > 
> > Interesting update ;-)  
> 
> Should I make it a separated patch? :-)

Yeah, probably.

-- Steve
