Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FE4548DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhKQOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhKQOgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:36:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1428F61B54;
        Wed, 17 Nov 2021 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637159601;
        bh=735Uhve6KdLFZo5kgNvIJM6tOjRJANQplXqPEZzGIio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VO4XvDovwjM2WuBHVcjCvYQoN8Lx6z/2BXkYKLjKHnKUE9IMx3d2k6NQFSUm8d8uu
         Zica5yGnfjAAY6Gu4Gu3Y3wWYL4LvjwXpL1+R0axdHLcRxVb/jAFOmBU0WovATIqGJ
         aWfQcL+7WJQ7wIxVco/QzsZ1snT0yFPJ0w+0utZ5dZtXBtYJhaKGzdkDnfNdoPokRm
         0wNsRPPKDZ1YnHPvoUQqWeWEJxRrCBhogWXBtO97hLjmCsdhUPZmekyS6E8RCWCOVA
         PhgTivxkmO0NoKHbqtzLXirYZnEZsTSn5jsNFN5qej5oGNPSWndm9lgsDY6MdYCqkF
         Rukk+smOIYDQA==
Date:   Wed, 17 Nov 2021 23:33:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] libtraceevent: Add __rel_loc relative location
 attribute support
Message-Id: <20211117233317.841b81fa8b709455b7df9da6@kernel.org>
In-Reply-To: <20211116172332.655bae77@gandalf.local.home>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
        <163697163637.131454.1385316505107139633.stgit@devnote2>
        <20211116172332.655bae77@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 16 Nov 2021 17:23:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 15 Nov 2021 19:20:36 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add '__rel_loc' new dynamic data location attribute which encodes
> > the data location from the next to the field itself. This is similar
> > to the '__data_loc' but the location offset is not from the event
> > entry but from the next of the field.
> > 
> > This patch adds '__rel_loc' decoding support in the libtraceevent.
> 
> Note, libtraceevent in the kernel is deprecated.

Ah, got it.

> 
> Care to send a patch against:
> 
>   https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> 
> And Cc linux-trace-devel@vger.kernel.org

Should I cc to LKML too?

Thank you,

> 
> Thanks!
> 
> -- Steve
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/lib/traceevent/event-parse.c  |   14 ++++++++++++++
> >  tools/lib/traceevent/event-parse.h  |    1 +
> >  tools/lib/traceevent/parse-filter.c |    5 ++++-
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
