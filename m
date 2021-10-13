Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CE42C359
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbhJMOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237317AbhJMOev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:34:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7DBE610EA;
        Wed, 13 Oct 2021 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634135567;
        bh=/IYYQ6t4x2X79DDkecjqQGNrs8u2qn3Gv95Pj9dSHtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cwm3xbXp0VcoIlCC3JTu3F3yWKP8JnOlfs/jucY9KXVFKZ9YKXxK1SYRlz+ip1Cx/
         yfPVEmXHUaQJKVF2b41m/oArlC4ISkFjyl1LlLpe+tGfNVNWlO/aVlaaBhXUQM6HYv
         lcx1kVOjVn1prwMh10uz5W7zClFiu9AasuESs9kbe4aWC2tPycavgqowVVEYmmxNzB
         Hfz83CZ3GWpbo3JAK4yKXooZvqX/E85JDtin6bu75ICcCgETrHzIh2hKZj2WVpcsTL
         PEaAIpXInojvtsGfqKlXL/5qg03vh2y6zOd0ZA9aecBCQovd1P+Im9rAs/nVTiEbhD
         BeXgZ+h65ebpw==
Date:   Wed, 13 Oct 2021 23:32:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-Id: <20211013233244.46341468a06ba43895b99c0e@kernel.org>
In-Reply-To: <20211012201559.5f0ad249@gandalf.local.home>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211013074611.ea157d4ed04d3c33290361f5@kernel.org>
        <20211012201559.5f0ad249@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 20:15:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 Oct 2021 07:46:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > The first argument check should be optional. If the event name matches and
> > the system name is NULL but argc == 0, it should return true.
> > (please consider it is a wild card like "-:*/EVENT *")
> > So if the argc == 0 please skip below and check the event name and
> > the system name.
> 
> OK, so I'll make them all optional, but at least, if they are supplied,
> they will be checked.
> 
> That is, you can't add the options if you don't add the event as well. But
> if you do add the event, then it should work.
> 
> Basically, we have the following:
> 
>  # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
>  # cat dynamic_events
> eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8
> 
> Then the following should work:
> 
>   # echo '-:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
>   # echo '-:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
>   # echo '-:eprobes/hrstate timer.hrtimer_cancel' >> dynamic_events
>   # echo '-:eprobes/hrstate' >> dynamic_events

Agreed.

> 
> But the following will not work:
> 
>   # echo '-:hrstate state=+0x38($hrtimer):u8' >> dynamic_events
>   # echo '-:hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
>   # echo '-:hrstate timer.hrtimer_cancel' >> dynamic_events

The first one is agreed. But the rest 2 cases should work because it just omits the
group name. At least {k,u}probe events work.

> Should this work?
> 
>   # echo '-:hrstate' >> dynamic_events

Yes. In this case, all dynamic events which have "hrstate" event name are removed.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
