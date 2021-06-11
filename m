Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6713A3964
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFKBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFKBwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0E2E61376;
        Fri, 11 Jun 2021 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623376213;
        bh=+zOOnC05XmYLvKaxVBU9rSumtsD4kOVLyyP3s2SFJFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gpU019KFcZ7f1KtnhTZ5j1tufNajv9wx9LXfHejrr+14lP2jt1R6u0IIVnJGvL+zr
         oN8dkp3XH5PybLWcYw9He7aUk1wSx8A7aGAh9H78Et2TQfYs9CdtGqs0sgMa0oWZ3l
         38BKjlsLo/0JkR2YGmluWMamLY2gHPy+AY4hwRwDC48HR/UDMnkjQY1HOIPSmYK9w2
         9LJ4XfP+lc6rmI9X7XDfmFH5x5ifWT5AZ8gnAd5vqvry5KRSkAjSiNXaNOaNrt/C29
         peOjoxp7NAv2EW/hnaWRvY1GckCH27a1qtXdE+rAcymjabNCK44hijgBdxcxkug75t
         DZEXerWkqXr/A==
Date:   Fri, 11 Jun 2021 10:50:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-Id: <20210611105011.092650f2b921ce36325eff79@kernel.org>
In-Reply-To: <20210610133346.4a55c60a@oasis.local.home>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <20210610133346.4a55c60a@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 13:33:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 10 Jun 2021 19:16:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hmm, Nack for this way, but I understand that is a problem.
> > If you got the error in perf probe, which uses ftrace dynamic-event interface.
> > In that case, the errors should not be output in the dmesg, but are reported
> > via error_log in tracefs.
> > And kprobes itself should return different error code to the caller, instead
> > of printing error in dmesg. See below.
> 
> We should update perf to use libtracefs that also has an interface to
> read the error_log file.

Hmm, it seems that libtracefs has no parser for the error_log file.

What we need is to parse error_log and find appropriate entry of
the error log. Thus, the interface will be;

int tracefs_add_dynamic_event(const char *command, char **error_log);

And the usage will be;

ret = tracefs_add_dynamic_event(command, &error_buf);
if (ret < 0) {
	pr_error("Failed to add dynamic event: %d\n", ret);
	pr_error("Error log:\n%s\n", error_buf);
	free(error_buf);
	return ret;
}
...
This is because error_log file keeps some previous error logs and
you need to find appropriate one from the actual command.

Maybe a part of perf probe (util/probe-file.c) should be shared with
libtracefs and finally it should moved on the libtracefs.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
