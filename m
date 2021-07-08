Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171473C1A67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGHUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 16:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhGHUOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 16:14:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B49961441;
        Thu,  8 Jul 2021 20:11:59 +0000 (UTC)
Date:   Thu, 8 Jul 2021 16:11:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/2 v3] tracing/histogram: Update the documentation for
 the buckets modifier
Message-ID: <20210708161158.7eaa6b13@gandalf.local.home>
In-Reply-To: <b0c64284cbba5613daaa5284a8dda1dcac60aead.camel@kernel.org>
References: <20210707213623.250212325@goodmis.org>
        <20210707213922.167218794@goodmis.org>
        <b0c64284cbba5613daaa5284a8dda1dcac60aead.camel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2021 15:05:16 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> > -    # echo 'hist:key=call_site:val=bytes_req' > \
> > +    # echo 'hist:key=call_site:val=bytes_req.buckets=32' > \
> >              /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger  
> 
> This just seems random, not sure why you changed it, and it doesn't
> make sense on a val anyway..

Good catch! I originally wrote this to explain the buckets in this
location, and then realized it did not match the flow, and moved my text
down. It appears that I missed putting back the original trigger. Will fix
and send a v4.

> 
> The rest looks good, though, thanks for doing this!
> 
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks!

-- Steve
