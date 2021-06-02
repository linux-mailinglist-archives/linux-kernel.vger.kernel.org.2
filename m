Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1513397F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFBC1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFBC1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:27:10 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6116C61008;
        Wed,  2 Jun 2021 02:25:27 +0000 (UTC)
Date:   Tue, 1 Jun 2021 22:25:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Haocheng Xie <xiehaocheng.cn@gmail.com>, mingo@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Fix typos in Documentation/trace/ftrace.rst
Message-ID: <20210601222527.7cea98c6@rorschach.local.home>
In-Reply-To: <87a6o98adq.fsf@meer.lwn.net>
References: <20210531083905.25763-1-xiehaocheng.cn@gmail.com>
        <87a6o98adq.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021 16:53:37 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Haocheng Xie <xiehaocheng.cn@gmail.com> writes:
> 
> > Fix the usage of "a/the" and improve the readability.
> >
> > Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
> > ---
> >  Documentation/trace/ftrace.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 62c98e9..11cc1c2 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -354,8 +354,8 @@ of ftrace. Here is a list of some of the key files:
> >  	is being directly called by the function. If the count is greater
> >  	than 1 it most likely will be ftrace_ops_list_func().
> >  
> > -	If the callback of the function jumps to a trampoline that is
> > -	specific to a the callback and not the standard trampoline,
> > +	If the callback of a function jumps to a trampoline which is
> > +	specific to the callback and which is not the standard trampoline,  
> 
> The "that" in the first line was actually correct and best left
> unchanged.  I've applied the patch, but took the liberty of putting
> "that" back.

Right. And if it is modifying the "the" here, it should be modifying
the "the function" in the previous paragraph as well.

-- Steve
