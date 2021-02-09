Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D07315C27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhBJBYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234657AbhBIW64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:58:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF9B64E3E;
        Tue,  9 Feb 2021 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612911494;
        bh=uqy909NFHjuNyS/LN4Ctg42SorG3pgKl7CZF8ihTw4U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n7nKtjoTtgIvFtu4vaYvYlTku43Osb+tTl9RONiKCCW6msvr95LLx9ONawLikMyAC
         CbQ27LCqqsfN/rfY9z6XZLOBArzIGhseW9lB4xRw83ZDlOlZZR2bPr8lNh18l8u3pP
         DmQz+xBgoSAFNoGVqiOrNj0VqqrR4rEhIGrBI5+8jQCtnVETMyP+txXCsggF4bKNZI
         8c8GJWZ3RbYjTh5ZDCvrC4eD9DFs8nRa3MsROqWAZjAGi1UWgML2mSPDthKCbgH2Yy
         muytiy9tFUD+2Hidq0B/Wq3WFxN1Vni17EWv97Josu7+nk01vqqcmbS67bVShMC1AA
         Sst9fK494Ku/g==
Message-ID: <c9ca97ed663c2f04d45734883f17833a6c6a6ff5.camel@kernel.org>
Subject: Re: [PATCH v7 0/6] tracing: More synthetic event error fixes
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Date:   Tue, 09 Feb 2021 16:58:12 -0600
In-Reply-To: <20210209160909.28cc8d3b@gandalf.local.home>
References: <cover.1612208610.git.zanussi@kernel.org>
         <20210209160909.28cc8d3b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2021-02-09 at 16:09 -0500, Steven Rostedt wrote:
> On Mon,  1 Feb 2021 13:48:10 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi,
> > 
> > This is v7 of the synthetic event error fix patchset.  This version
> > addresses the comments from v6:
> > 
> >   - moved check_command() from '[PATCH v6 3/6] tracing: Update
> > synth
> >     command errors' to '[PATCH v6 2/6] tracing: Rework synthetic
> > event
> >     command parsing'.
> > 
> >   - in __create_synth_event(), moved mutex_lock(&event_mutex) after
> >     is_good_name() check and changed related error handling.
> > 
> >   - simplified check_command() a bit by calling argv_free() sooner
> > as
> >     suggested by Steve.
> > 
> >   - added Steve's comment about check_field_version() into that
> >     function and added additional comments to the caller.
> > 
> 
> After applying these, the following test fails:
> 
>  test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
> 

Did you apply '[PATCH v7 5/6] selftests/ftrace: Update synthetic event
syntax errors' before you ran the test?  It actually removes the test
that failed.  Here's what I get with all patches applied:

  # ./ftracetest test.d/trigger/inter-event/
=== Ftrace unit tests ===
[1] event trigger - test inter-event histogram trigger expected fail
actions	[XFAIL]
[2] event trigger - test field variable support	[PASS]
[3] event trigger - test inter-event combined histogram trigger	[PASS]
[4] event trigger - test multiple actions on hist trigger	[PASS]
[5] event trigger - test inter-event histogram trigger onchange action	
[PASS]
[6] event trigger - test inter-event histogram trigger onmatch action	
[PASS]
[7] event trigger - test inter-event histogram trigger onmatch-onmax
action	[PASS]
[8] event trigger - test inter-event histogram trigger onmax action	
[PASS]
[9] event trigger - test inter-event histogram trigger snapshot action	
[PASS]
[10] event trigger - test synthetic event create remove	[PASS]
[11] event trigger - test inter-event histogram trigger trace action
with dynamic string param	[PASS]
[12] event trigger - test synthetic_events syntax parser errors	[PASS]
[13] event trigger - test synthetic_events syntax parser	[PASS]
[14] event trigger - test inter-event histogram trigger trace action	
[PASS]


# of passed:  13
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  1
# of undefined(test bug):  0

> It appears that:
> 
>   echo 'myevent char str[];; int v' > synthetic_events
> 
> doesn't error after these changes.
> 

Right, it shouldn't fail any more - that was one of the reasons for
reworking the parser, so things like that wouldn't fail.

My assumption, and the reason for adding '[PATCH v7 4/6] tracing: Add a
backward-compatibility check for synthetic event creation', was that we
didn't want previously-working things to suddenly start failing after
the rework, but not that things that used to fail would continue to 
backwards-compatibly fail.

Tom

> -- Steve

