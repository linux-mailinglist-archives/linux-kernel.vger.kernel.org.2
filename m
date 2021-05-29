Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA03949EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 04:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhE2CSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 22:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhE2CSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 22:18:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1440F61175;
        Sat, 29 May 2021 02:16:35 +0000 (UTC)
Date:   Fri, 28 May 2021 22:16:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 0/9] hwlat improvements and osnoise/timerlat tracers
Message-ID: <20210528221633.4d87dde5@oasis.local.home>
In-Reply-To: <YK+LiSdWQngXjior@localhost.localdomain>
References: <cover.1621024265.git.bristot@redhat.com>
        <YK+LiSdWQngXjior@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 14:07:37 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> FWIW, I've been using the new tracers extensively downstream for a while
> now and I find them very useful and quite more precise to detect
> problems than what we currently have available.
> 
> The fact that one can do almost everything needed to spot latency issues
> from entirely inside the kernel with a simple interface is a big plus to me
> as well.
> 
> I wouldn't mind if this gets accepted very soon! :)

Neither would I ;-)  But because of my extended vacation and other
immediate responsibilities I need to take care of, it may be a couple
of weeks before I can thoroughly look at this ;-)

Anyway, thanks for the vote of confidence.

-- Steve
