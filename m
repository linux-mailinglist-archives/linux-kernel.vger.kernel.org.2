Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88F3D3140
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhGWAoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhGWAoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:44:06 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CAFF60EBA;
        Fri, 23 Jul 2021 01:24:40 +0000 (UTC)
Date:   Thu, 22 Jul 2021 21:24:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-ID: <20210722212438.5933e714@rorschach.local.home>
In-Reply-To: <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 10:11:33 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> I understand. As far as I can see the code, it looks a bit complicated.
> To simplify it, I need to understand the spec for "hist_field"
> for keys and for vars. And maybe need to split both case.

I'll give you a hint that took me a bit to figure out.

1) The execname is saved at the start of the histogram and not by one
of the ->fn() functions.

It's saved by hist_trigger_elt_data_init() if the elt_data->comm is
allocated. That function is part of the "tracing_map_ops" which gets
assigned by tracing_map_create() (in tracing_map.c) as the "elt_init"
function, which is called when getting a new elt element by
get_free_elt().

2) That elt_data->comm is only allocated if it finds a "hist_field"
that has HIST_FIELD_FL_EXECNAME flag set. It currently only looks for
that flag in the "keys" fields, which means that .execname is useless
for everything else. This patch changed it to search all hist_fields so
that it can find that flag if a variable has it set (which I added).

> 
> > I found this to be the least intrusive solution.
> > 
> > Maybe Tom has a better idea, but I don't have any more time to work on
> > it, and I really want this feature for the next merge window.
> > 
> > If you can make it work, and have time to play with it, I'm happy to
> > take an alternative :-)  
> 
> Me neither at least this moment, need more investigation. Let me try.

Great! I can hold off on adding this. Or I can add it, and if you come
up with a better solution, we can just swap it.

-- Steve
