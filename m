Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB543B71D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhJZQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237672AbhJZQ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:28:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E467A603E9;
        Tue, 26 Oct 2021 16:26:15 +0000 (UTC)
Date:   Tue, 26 Oct 2021 12:26:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 08/20] rtla: Helper functions for rtla
Message-ID: <20211026122614.017844da@gandalf.local.home>
In-Reply-To: <YXgrLIiK8pwOVsBe@geo.homenetwork>
References: <cover.1635181938.git.bristot@kernel.org>
        <bc01018cef80ddb95fd0ccf1ec72963be7e4fc19.1635181938.git.bristot@kernel.org>
        <YXgrLIiK8pwOVsBe@geo.homenetwork>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 00:22:04 +0800
Tao Zhou <tao.zhou@linux.dev> wrote:

> > +	do {
> > +		retval = read(in_fd, buffer, sizeof(buffer));
> > +		if (read <= 0)  
> 
> check "retval" not read. Like:
> 
>   if (retval <= 0)

OUCH! Good check.

Daniel, did that not produce any warnings??

-- Steve


> 
> > +			goto out_close;
> > +
> > +		retval = write(out_fd, buffer, retval);
> > +		if (retval < 0)
> > +			goto out_close;
> > +	} while (retval > 0);
