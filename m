Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B8E3DCDF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 00:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhHAWKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 18:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhHAWKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 18:10:15 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4A360EB5;
        Sun,  1 Aug 2021 22:10:05 +0000 (UTC)
Date:   Sun, 1 Aug 2021 18:10:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 01/17] libtracefs: Added new API tracefs_sql()
Message-ID: <20210801181004.0a0bb843@rorschach.local.home>
In-Reply-To: <YQY/72DgV7nBRQqw@lx-t490>
References: <20210730221824.595597-1-rostedt@goodmis.org>
        <20210730221824.595597-2-rostedt@goodmis.org>
        <YQY/72DgV7nBRQqw@lx-t490>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2021 08:32:15 +0200
"Ahmed S. Darwish" <a.darwish@linutronix.de> wrote:

> On Fri, Jul 30, 2021, Steven Rostedt wrote:
> >
> > Currently it only supports simple SQL of the type:
> >
> >   SELECT start.common_pid AS pid, end.common_timestamp.usecs AS usecs
> >     FROM sched_waking AS start on sched_switch AS end  
>                                  ^
>                                  JOIN
> >     ON start.pid = end.next_pid
> >  

Oops, thanks!

-- Steve


