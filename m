Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3153CAE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhGOVMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhGOVMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:12:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E37561396;
        Thu, 15 Jul 2021 21:09:40 +0000 (UTC)
Date:   Thu, 15 Jul 2021 17:09:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] tracing: Do no reference char * as a string in
 histograms
Message-ID: <20210715170933.109b5809@oasis.local.home>
In-Reply-To: <ff91bab7a874ab134033d840100edd855e9c304e.camel@kernel.org>
References: <20210715000206.025df9d2@rorschach.local.home>
        <17b88fc429ddd354cff468849bc16de25086df2d.camel@kernel.org>
        <20210715155400.28f0dfd0@oasis.local.home>
        <ff91bab7a874ab134033d840100edd855e9c304e.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 15:39:33 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Very nice!  Really looking forward to playing around with this.

We should be posting an RFC in a week or two. Just working on some
other things at the moment.

> 
> Yeah, if it's needed to enable the eprobes and since it also fixes a
> crashing bug, I'm all for it.
> 
> But should it also have an additional 'Fixes:' line?:
> 
> Fixes: 5967bd5c4239 ("tracing: Let filter_assign_type() detect
> FILTER_PTR_STRING")

Added it.

> 
> Acked-by: Tom Zanussi <zanussi@kernel.org>

Thanks!

-- Steve
